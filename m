Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654EEC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E50611CC
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhEMHCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhEMHCm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:02:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CED3C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:01:30 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l70so5763320pga.1
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CqfpKk36tSc0ab/21p701hH0LiTH9yw+8/cL3y3U9+M=;
        b=WsATtKbd/eRvlynWk6+ppcla/lezCeitLzS8xGN4xJMIP3A8FvASvBg/EqqJ3+qjzE
         IDwhnRQLTsoeX1pR57ok7SZtqk81GnTpLvhHHS0PnGLBMdMauxh4WHU0TjgX3r8H5L5i
         NzjywP9dvgSxt8TeA9qhOFzcv+73Ed99wZ9Lksynwg961za+8tX8fnfMOnkabGuQ8m1m
         ufpeUepC2nMdtkndBGR/jVlC+Jtm7kIv5qxdLKrzO41YV8wf1Wtv8XQPGjUgIokzrfEG
         XQ35DApZG5gutfDnvF6N2nmCzQQDcDav5hPnOLrAr7pA7AFrXaW4C6fzM88n61UX3Z1T
         E40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CqfpKk36tSc0ab/21p701hH0LiTH9yw+8/cL3y3U9+M=;
        b=Jr7+nQUKFgHUntO05lwip0lMLtuzhbzYdRjPcG2xoUSDbbCVB2xYkfF78Jfk9XOquZ
         SvN7fHVA61hH6B0VSYocrml49TnPUegxE/kGxJdHH4uR1diuXyWMJMw7ilFxn6K55raP
         DZ3Dds4DJHP1jR3YMf5k8sPaDkk7/A5MyWczgyy8Mc3D97M5fPqjcmXH10fDV0SorTVK
         ICZoozWJRqMbuOgDYcX9WvVbGO6lqD1z0Ap7I8VHQBbn78GfVKXN3BiVn8Km65gj55Ns
         b36wDp2u9+IQsfJjNHRosEgSG7Wdd82PDZtK7rN0Cy554arAnJbEztwwpZCGTACMJqsa
         ncrw==
X-Gm-Message-State: AOAM533AF369FRo7h4yoki9nzXit8kX7bSeIEQispt1OEo6MHTvhXJuy
        Pzei7D99y3EFo2mootvMkoo=
X-Google-Smtp-Source: ABdhPJyIRbAP4hCJiEVGQ7hbR2USldSUML7XhQpXZYd/fMTN70odiTxU4rN8TRF1Zinw5SCDGL+RTQ==
X-Received: by 2002:a17:90a:690b:: with SMTP id r11mr44265171pjj.140.1620889289998;
        Thu, 13 May 2021 00:01:29 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-23.three.co.id. [180.214.233.23])
        by smtp.gmail.com with ESMTPSA id f12sm1319052pfv.155.2021.05.13.00.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 00:01:29 -0700 (PDT)
Subject: Re: [PATCH v3] doc: writing down Git mailing list etiquette
To:     Dave Huseby <dwh@linuxprogrammer.org>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, felipe.contreras@gmail.com,
        gitster@pobox.com, stefanmoch@mail.de, philipoak@iee.email,
        sunshine@sunshineco.com, avarab@gmail.com
References: <20210512031821.6498-2-dwh@linuxprogrammer.org>
 <20210512233412.10737-1-dwh@linuxprogrammer.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <d40d84f6-52b1-af46-859f-80e4b15f4db6@gmail.com>
Date:   Thu, 13 May 2021 14:01:25 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210512233412.10737-1-dwh@linuxprogrammer.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another review.

On 13/05/21 06.34, Dave Huseby wrote:
> After violating a few unspoken etiquette rules while submitting patches
> to the Git mailing list, it was suggeted that somebody write a guide.
> Since I was the latest cause of this perenial discussion, I took it upon
> myself to learn from my mistakes and document the Git mailing list
> etiquette and the fixes I made to my email setup.
> 
> * Add documentation specifically on Git mailing list etiquette
> * Add alternative actions for patches that receive no response.
> * Add section on submitting a final, merge-ready patch.
> * Add section on Mutt MUA settings.
> 
> Reported-by: Christian Couder <christian.couder@gmail.com>
> Reported-by: Filipe Contreras <felipe.contreras@gmail.com>
> Thanks-to: Junio C Hamano <gitster@pobox.com>
> Thanks-to: Philip Oakley <philipoakley@iee.email>
> Thanks-to: Bagas Sanjaya <bagasdotme@gmail.com>
> Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
> Thanks-to: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Dave Huseby <dwh@linuxprogrammer.org>
> ---
>   Documentation/MailingListEtiquette.txt | 93 ++++++++++++++++++++++++++
>   Documentation/SubmittingPatches        | 74 +++++++++++++++++++-
>   2 files changed, 166 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/MailingListEtiquette.txt
> 
> diff --git a/Documentation/MailingListEtiquette.txt b/Documentation/MailingListEtiquette.txt
> new file mode 100644
> index 0000000000..8a383f81a8
> --- /dev/null
> +++ b/Documentation/MailingListEtiquette.txt
> @@ -0,0 +1,93 @@
> +Mailing List Etiquette
> +======================
> +
> +[[introduction]]
> +== Introduction
> +
> +The Git project uses a mailing list and email to coordinate development and
> +submit patches. Many other open source projects use web-based forums and pull
> +requests (PRs) to achieve the same thing. This article focuses entirely on the
> +Git project and the etiquette and unspoken rules that have developed over the
> +years. What follows are best practices and suggestions for the "proper" way to
> +interact via email on the Git mailing list.
> +
> +If you are looking for details on how to submit a patch, that is documented
> +elsewhere in:
> +
> +- `Documentation/SubmittingPatches`
> +- `Documentation/MyFirstContribution.txt`
> +
> +[[proper-use-of-to-and-cc]]
> +== Proper Use of To and Cc
> +
> +The "To:" field is the place to list the people you want to directly interact
> +with and request responses from and the "Cc:" field is for other people that
> +you wish to inform of this conversation. Everybody is welcome to chime in on
> +the thread. When there is no particular person you wish to talk to, the mailing
> +list address is a good catch-all addres to reach everybody and should be put in
> +the "To:" field.
> +
> +When replying to an email on the mailing list, put the person you are replying
> +to in the "To:" field and all other people in the thread in the "Cc:" field,
> +including the mailing list address.
> +
> +The motivation for the above suggestions is to allow recipients to prioritize
> +their incoming messages; they can direct their immediate attention to those
> +messages with their names on the "To:" field and the ones with their names on
> +the "Cc:" field can wait.
> +
> +Make sure to keep everyone involved in the "Cc:" field so that they do not have
> +to be subscribed to the mailing list to receive replies.
> +
> +[[proper-use-of-subject]]
> +== Proper Use of the Subject
> +
> +When replying to an email on the list, make sure that the subject of the
> +original email is the subject of your email with "Re:" added to it. So if
> +you reply to an email with subject "first post", the subject of your email
> +should be "Re: first post".
> +
> +Sometimes email threads diverge into other threads about related, but distinct
> +topics. In those cases, the subject like should change to the new topic and
> +include in parenthesis "(Was: <original thread subject>)". So for instance,
> +if a side thread is created from the "first post" thread example, the subject
> +line should be something like "second post (was: first post)" with replies
> +having the subject "Re: second post (was: first post)".
> +
> +[[use-interleaved-style]]
> +== Use Interleaved Style in Replies
> +
> +> A: Because it messes up the order in which people normally read text.
> +> Q: Why is top-posting such a bad thing?
> +> A: Top-posting.
> +> Q: What is the most annoying thing in email?
> +
> +When replying to emails, use interleaved style which is also sometimes called
> +an "inline reply". This creates a natural flow for the reader of the reply. They
> +can easily see what the context for the reply is. Also leave only the context
> +that is important for your reply and delete the rest.
> +
> +[[do-not-use-mail-followup-to]]
> +== Do Not Use Mail-Followup-To
> +
> +When posting to the mailing list, your email client might add a
> +"Mail-Followup-To:" field containing all of the recipients, including the
> +mailing list address, but not the sender's email address. This is intended to
> +prevent the sender from receiving replies twice, once from the replying person
> +and again from the mailing list.
> +
> +This goes directly against the desired "To:" and "Cc:" etiquette (see "Proper
> +Use of To and Cc" above) because "Reply to all"/"group reply" will redirect the
> +response to all of the people in the original "Cc:" field instead of going to
> +the person who sent the message being responded to.
> +
> +Some email clients, such as Mutt (see Disable Mail-Followup-To in the Mutt
> +section below) are configured by default to add "Mail-Followup-To:" fields and
> +to honor existing "Mail-Followup-To:" fields. It is best to disable both.
> +
> +[[enable-plain-text-mode]]
> +== Enable Plain Text Mode
> +
> +The Git mailing list software rejects email sent in text/html format. It is
> +important that your email client is set to create text/plain emails to ensure
> +delivery.
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 55287d72e0..4f8b9f24ee 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -433,7 +433,7 @@ help you find out who they are.
>   
>   In any time between the (2)-(3) cycle, the maintainer may pick it up
>   from the list and queue it to `seen`, in order to make it easier for
> -people play with it without having to pick up and apply the patch to
> +people to play with it without having to pick up and apply the patch to
>   their trees themselves.
>   
>   [[patch-status]]
> @@ -450,6 +450,46 @@ their trees themselves.
>     entitled "What's cooking in git.git" and "What's in git.git" giving
>     the status of various proposed changes.
>   
> +[[patches-that-receive-no-response]]
> +== Patches that Receive No Response
> +
> +If you sent a patch and you did not hear any response from anybody for
> +several days, it could be that your patch was totally uninteresting,
> +but it also is possible that it was simply lost in the noise.  Please
> +do not hesitate to send a reminder message in such a case.  Messages
> +getting lost in the noise may be a sign that those who can evaluate
> +your patch don't have enough mental/time bandwidth to process them
> +right at the moment, and it often helps to wait until the list traffic
> +becomes calmer before sending such a reminder.
> +
> +Alternatives to sending direct reminders are:
> +
> +* Wait for the next "What's cooking in git.git" email to see if your patch
> +  series was mentioned and replying to that email with a note pointing out that
> +  your patch series has been overlooked.
> +
> +* Attend the weekly "stand-up" meeting held in the "#git-devel" channel on
> +  irc.freenode.net and bring it up then.
> +
> +[[send-merge-ready-patches-to-the-maintainer]]
> +== Send Merge-Ready Patches to the Maintainer
> +
> +Once a patch has achieved consensus and all stakeholders are satisfied and
> +everything is ready for merging, you have two main options for getting your
> +patch noticed by the maintainer.
> +
> +1. Submit a new, final, version of the patch with an accurate list of commit
> +   trailers. Make this submission "To:" the maintainer, "In-Reply-To:" the
> +   previous version of the patch, and add everybody concerned, including the
> +   mailing list address to the "Cc:" field. This is a nice way to reduce the
> +   amount of work the maintainer must do to merge the patch while also getting
> +   their attention.
> +
> +2. Creating a "group reply"/"Reply to all" email to the latest patch series
> +   with the maintainer in the "To:" field. This is sometimes referred to as a
> +   "review ping" email and is appropriate if the patch requires no more work
> +   and is in its final state with an accurate list of commit trailers.
> +
>   [[travis]]
>   == GitHub-Travis CI hints
>   
> @@ -510,6 +550,38 @@ first patch.\n", if you really want to put in the patch e-mail,
>   should come after the three-dash line that signals the end of the
>   commit message.
>   
> +=== Mutt
> +
> +[[known-mailing-lists]]
> +==== Known Mailing Lists
> +
> +Mutt has the ability to change its behavior when replying to a mailing list. You
> +must specify mailing list addresses using the `subscribe` keyword in your Mutt
> +configuration:
> +
> +**~/.muttrc:**
> +```
> +# tell Mutt about the Git mailing list
> +subscribe git@vger.kernel.org
> +```
> +
> +[[disable-mail-followup-to]]
> +==== Disable Mail-Followup-To
> +
> +By default, when replying to mailing lists, Mutt automatically generates
> +"Mail-Followup-To:" fields. To fix this, disable the generation of the field
> +in your Mutt configuration. It is also a good idea to disable honoring any
> +"Mail-Followup-To:" field so that your "group reply" operations are correctly
> +addressed.
> +
> +**~/.muttrc:**
> +```
> +# disable Mail-Followup-To header
> +unset followup_to
> +
> +# disable honoring Mail-Followup-To header
> +unset honor_followup_to
> +```
>   
>   === Pine
>   
> 

I think the patch title, according to diff body, should be
"doc: document mailing list etiquette and various updates to SubmittingPatches".
But anyway, it's better to split into two separate patches (one that document
etiquette and one that add updates to SubmittingPatches) because there are two
logical changes in single patch.

Regarding patch title, I proposed change above because we require that the title
use imperative language ("make something do one thing"). However, you use
present continuous tense (with gerund "-ing"), which implied that you do
something progressively ("making something do one thing"). This is not
imperative language, just descriptive.

-- 
An old man doll... just what I always wanted! - Clara
