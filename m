Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B82C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 04:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037FF61417
	for <git@archiver.kernel.org>; Thu, 13 May 2021 04:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhEMEHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 00:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhEMEHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 00:07:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A52C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 21:06:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id z4so2800476pgb.9
        for <git@vger.kernel.org>; Wed, 12 May 2021 21:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h2lJWqtpnMjB0ekYdSNzjQeCUfigvBALx/5tIsbdhDY=;
        b=d8/i1nrpHT/CWWAAqG16n6s7fh82cMDTaja6M8LSDwP0QzamvPQKr5q8q60EMIEpUD
         xJa4yYspkk5bae+7yUWSBhGHNM5u1AuMRqNzm+oyXLxiEitiqEcoGMHxbiMnjzd8itRB
         /UU0BcGz3PhkrnLSJKbuXGRhf5gzgKsFRAuF5Evae1fTgHCDcO7LdWflD1LcKmCWSdy4
         Knesq9Nw/gUPuyyYpC4SWf9gIHe0WL92lMZniQBifUFlXihyKe661j1SkGZk1MRqJtTE
         EfY/z6GE7YUCdlaNbGXe3sX3aVC9ZsTsHjS3BYgYB9RA/tHE8YDqR0k3hofsi42PYatf
         z+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h2lJWqtpnMjB0ekYdSNzjQeCUfigvBALx/5tIsbdhDY=;
        b=LXTYNIa5picsK44PNOEoIwvsgjpE2OY0KSdro2ebYcM0SijZ4Bo5Fh6qtGFVgNv6cM
         oAV0QysrZC1vMjbU/dV75AesaNcqvwA7t1yqcrDFdyEnhk2tmQY9iAn2fvi3GGKu3iVF
         byHhbwvwxTJLwZOKhkyNq/OZjeDMeeyaFlOjqJQtXlbmzrsAGv9urrrYOyTTNxdORVGS
         fN4peLXZi997+mtc/C20B9SwhLjvDEJy4WpfaQjfk5ZAjXS6JWVC7gJWRNBGzyjsupIS
         DsaMvsKp0YSdQOr+P5Ecb0a8u4DeaD9Z4Ir3r9FHP6rFF6R35oHu+O1NPBq2GD8x5V/P
         KJBw==
X-Gm-Message-State: AOAM533LSJ/AWdCmwkfQew88FKYP9hd9Yolm6JlIBINpxGtCxoxVWddZ
        k3kMIgfmy5XrJ+y73BPTOtw=
X-Google-Smtp-Source: ABdhPJwjLeTB8RxOJMDfSRjZJziaXsAH7vBEneWJsgDSaypJ+0xAa2TbJJeiihrHGkVZ2mIysyxfpw==
X-Received: by 2002:a63:4554:: with SMTP id u20mr4857933pgk.23.1620878768086;
        Wed, 12 May 2021 21:06:08 -0700 (PDT)
Received: from [192.168.43.80] (subs09b-223-255-225-228.three.co.id. [223.255.225.228])
        by smtp.gmail.com with ESMTPSA id c6sm952150pfo.192.2021.05.12.21.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 21:06:07 -0700 (PDT)
Subject: Re: [PATCH v3] doc: writing down Git mailing list etiquette
To:     Dave Huseby <dwh@linuxprogrammer.org>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, felipe.contreras@gmail.com,
        gitster@pobox.com, stefanmoch@mail.de, philipoak@iee.email,
        sunshine@sunshineco.com, avarab@gmail.com
References: <20210512031821.6498-2-dwh@linuxprogrammer.org>
 <20210512233412.10737-1-dwh@linuxprogrammer.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <d3c48e85-e8ac-60aa-0588-4ff891d38dbd@gmail.com>
Date:   Thu, 13 May 2021 11:06:03 +0700
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

On 13/05/21 06.34, Dave Huseby wrote:
> After violating a few unspoken etiquette rules while submitting patches
> to the Git mailing list, it was suggeted that somebody write a guide.
> Since I was the latest cause of this perenial discussion, I took it upon
> myself to learn from my mistakes and document the Git mailing list
> etiquette and the fixes I made to my email setup.
> 

The commit message looks too personal here. Anyways, better say:

```
Developers who are new to Git mailing list may not feel that they
violated unspoken etiquette rules in the list until someone point
out the discussions about such rules.

To avoid such perennial discussions, document the etiquette rules
applied to Git mailing list. Also add sections about submitting
final (merge-ready) patch, actions when a patch receives no
response, and hints for Mutt to Documentation/SubmittingPatches.
```

But anyway for SubmittingPatches changes, I think it's better
to send it as separate patch.

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

When you describe about interleaved style below, you also include example of
"top posting". This make newbies think that TP (like above) is interleaved
style, while both are actually different. So please also include example of
interleaved style.

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

The specific hints for Mutt is on Documentation/SubmittingPatches, included as
part of this patch, not on Documentation/MailingListEtiquette.txt that you
wrote.

> +[[enable-plain-text-mode]]
> +== Enable Plain Text Mode
> +
> +The Git mailing list software rejects email sent in text/html format. It is
> +important that your email client is set to create text/plain emails to ensure
> +delivery.

Don't you know that VGER (that hosts Git ML) rejects text/html emails because
these are very likely spam messages?

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

For this section, I expect that the paragraph that started with "After the list
reached a consensus that it is a good idea to apply the patch, re-send it with
"To:"..." be also deleted to avoid redundancy.

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
 From the context hunk for this Mutt subsection, I was thought that it was inside
"Travis hints" sub/section, but after seeing "Pine" subsection below the addition,
I recognized that subsection for Mutt was in "MUA specific" section.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
