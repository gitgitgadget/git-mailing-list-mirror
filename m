Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A2BC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A3C61584
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhELEJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 00:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhELEJH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 00:09:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A0EC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 21:08:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m37so17256946pgb.8
        for <git@vger.kernel.org>; Tue, 11 May 2021 21:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o/PkrytE80lf23HaK63hnVCO0lDGk6BlR/8Sj24ohnc=;
        b=Of5tYdONcJMNdjeTwrU9o7BRmYxnxv/WHz23orTE/hwlfW+sRKQckUmUhYE8NeSUoL
         yzmHUyMk9RytvZHEL1ylWKnEQOk4oglZspd0sJR1kVmFSiqqPyBHqGNHlBRiziP2TA/Z
         VwkG/VNkLxZe0JesxPwsVyr7beszgkI5eMODNp4xy8N0mG9ps2pdlNNszPKZmuw7jHjn
         lr/F7B5YDv/KxmnexBBcVcF3vLOnpqTx7kcWWR6S7Zb1QAXOUsJILFAE9yE6VGM/F3sQ
         CSz33Ru3uyt00KEMPNzYWg4paCgdFbNvm7hHUrR0PfDCbnPiuxhaokAP86clPTiRaGac
         9U3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o/PkrytE80lf23HaK63hnVCO0lDGk6BlR/8Sj24ohnc=;
        b=i1qiyJ3lOKjUKUCHoRCoG2Xt+1MXjgYdEqNZsWVgjt+Y83qY6tfqfrslBssfbnvII2
         xk1vTlCX/gZoPaUrfG3ddA1auqAUbQR6x215ZckZUZuLkyq4DRcfGAk9gSDpsuRcJJRE
         jOQh9dD586MqPfjEfqFwPQkeE5XobBi0+HFnaaSZfX4oNN6wWIMROnqHnLpCYlrUR2+M
         Lj6wqIQQGQlMJNTLMw37sl9s4AfwUeB0pLHMaDmlmUO1QGdBDdPzOuhVCIjMy85zUWCP
         1xV1d6CqRGoG2y7lbN4HCXPh61a/L4UNv6d1aAxTgFUmVBLDimp8qioq+aKUWMVrh4FV
         /Bsw==
X-Gm-Message-State: AOAM532mbLUOTC5zh9ZcerHG+rOqWAAHVXcyk1te5/F7WNXihoWztmvy
        GMVClUu2EJUGmzNyPJ1x7RA=
X-Google-Smtp-Source: ABdhPJw2feMbbzWnqXBFI+1ZgnQr3+8pn8+TKuonWut5sIIydXVPcpBy8ZGXKmBGL6OlFiI3Y6cgIw==
X-Received: by 2002:a63:4a0b:: with SMTP id x11mr34655898pga.8.1620792479684;
        Tue, 11 May 2021 21:07:59 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-52.three.co.id. [116.206.12.52])
        by smtp.gmail.com with ESMTPSA id z18sm14690438pfa.39.2021.05.11.21.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 21:07:59 -0700 (PDT)
Subject: Re: [PATCH v2] Writing down mail list etiquette.
To:     Dave Huseby <dwh@linuxprogrammer.org>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, felipe.contreras@gmail.com,
        gitster@pobox.com, stefanmoch@mail.de
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
 <20210512031821.6498-1-dwh@linuxprogrammer.org>
 <20210512031821.6498-2-dwh@linuxprogrammer.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <80e0215a-cd00-57f9-afb6-b85b33dba91d@gmail.com>
Date:   Wed, 12 May 2021 11:07:55 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210512031821.6498-2-dwh@linuxprogrammer.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05/21 10.18, Dave Huseby wrote:
> After violating a few unspoken etiquette rules that were spotted by
> Christian Couder <christian.couder@gmail.com>, Filipe Contreras
> <felipe.contreras@gmail.com> suggested that somebody write a guide.
> Since I was the latest cause of this perenial discussion, I took it upon
> myself to learn from my mistakes and document the fixes.
> 
> Thanks to Junio <gitster@pobox.com> for providing links to similar
> discussions in the past and Stefan Moch <stefanmoch@mail.de> for
> pointing out where the related documentation already existed in the
> tree.
> 
> Signed-off-by: Dave Huseby <dwh@linuxprogrammer.org>
> ---
>   Documentation/MailingListEtiquette.txt | 125 +++++++++++++++++++++++++
>   1 file changed, 125 insertions(+)
>   create mode 100644 Documentation/MailingListEtiquette.txt
> 
> diff --git a/Documentation/MailingListEtiquette.txt b/Documentation/MailingListEtiquette.txt
> new file mode 100644
> index 0000000000..9da2d490aa
> --- /dev/null
> +++ b/Documentation/MailingListEtiquette.txt
> @@ -0,0 +1,125 @@
> +Mailing List Etiquette
> +======================
> +
> +[[introduction]]
> +== Introduction
> +
> +Open source, community projects such as Git use a mailing list and email to
> +coordinate development and to submit patches for review. This article documents
> +the unspoken rules and etiquette for the proper way to send email to the
> +mailing list. What follows are considered best practices to follow.
> +

But not all open source projects use mailing lists. Most (but not all, also
excluding Git) projects use Pull Requests (PR) as a way to submit patches and
for review.

Of course, some projects that use PR also coordinate their development using
mailing lists, patches submissions are done the other way.

So we can say "Several (but not all) open source, community projects such as
Git use a mailing list to coordinate development AND to submit patches for
review". Note the emphasized AND.

> +If you are looking for details on how to submit a patch, that is documented
> +elsewhere in:
> +
> +- `Documentation/SubmittingPatches`
> +- `Documentation/MyFirstContribution.txt`
> +
> +[[proper-use-of-to-and-cc]]
> +== Proper Use of To and Cc
> +
> +When starting a new email thread that is not directed at any specific person,
> +put the mailing list address in the "To:" field, otherwise address it to the
> +person and put the mailing list address in the "Cc:" field.
> +
> +When replying to an email on the mailing list, put the person you are replying
> +to in the "To:" field and all other people in the thread in the "Cc:" field,
> +including the mailing list address.
> +
> +Make sure to keep everyone involved in the "Cc:" field so that they do not have
> +to be subscribed to the mailing list to receive replies.
> +
> +[[do-not-use-mail-followup-to]]
> +== Do Not Use Mail-Followup-To
> +
> +When posting to the mailing list, your email client might add a
> +"Mail-Followup-To:" field which contains all of the recipients, including the
> +mailing list address, but not the sender's email address. This is intended to
> +prevent the sender from receiving replies twice, once from the replying person
> +and again from the mailing list.
> +
> +This goes directly against the desired "To:" and "Cc:" etiquette (see "Proper
> +Use of To and Cc" above). Most users want to use "group reply" or "Reply to
> +all" in their mail client and create a reply email that is sent directly to
> +author of the email they are replying to with all other recipients, as well as
> +the mailing list address, in the "Cc:" field.
> +
> +The proper thing to do is to never use the "Mail-Followup-To:" field as well as
> +disable honoring any "Mail-Followup-To:" fields in any emails you reply to.
> +Some email clients come with both enabled by default. Mutt is like this (see
> +Disable Mail-Followup-To in the Mutt section below).
> +

Better say "Some email clients, such as Mutt (see Disable Mail-Followup-To in
mutt-config section below) come with both enabled by default."

> +[[enable-plain-text-mode]]
> +== Enable Plain Text Mode
> +
> +Most email clients automatically reject mailing list email if it is not a
> +text/plain formatted email. For that reason, it is important that your email
> +client is set to create text/plain emails instead of text/enriched or
> +text/html email.
> +
> +[[patches-that-receive-no-response]]
> +
> +From Junio's notes from the maintainer:
> +
> +> If you sent a patch and you did not hear any response from anybody for
> +> several days, it could be that your patch was totally uninteresting,
> +> but it also is possible that it was simply lost in the noise.  Please
> +> do not hesitate to send a reminder message in such a case.  Messages
> +> getting lost in the noise may be a sign that those who can evaluate
> +> your patch don't have enough mental/time bandwidth to process them
> +> right at the moment, and it often helps to wait until the list traffic
> +> becomes calmer before sending such a reminder.
> +

Is "Review ping" enough for reminder purpose?

> +[[send-merge-ready-patches-to-the-maintainer]]
> +== Send Merge-Ready Patches to the Maintainer
> +
> +Once a patch has achieved consensus and all stakeholders are staisfied and
> +everything is ready for merging, then you send it to the maintainer: "To:
> +gitster@pobox.com".
> +

I see the typo. s/staisfied/satisfied/

Let's say that we had consented that my patch series was deemed ready at
v5 version. From the paragraph above, I interpreted it as "now my series
was consented ready, I need to send v6 to Junio (current Git maintainer)".
In practice, the maintainer could instead merged v5 (without having me to
send v6 [final]), because v5 is merge-ready in absence of maintainer's
email address in either To: or Cc:.

Oh yeah, should mailing list's address be also in To:/Cc: when sending
merge-ready patch series?

> +[[mutt-config]]
> +== Mutt Config
> +
> +This section has suggestions for how to set up Mutt to be polite.
> +

Better say "This section suggests how to set up Mutt to be conformant
to the etiquette above.".

> +[[known-mailing-lists]]
> +=== Known Mailing Lists
> +
> +Mutt has the ability to change its behavior when replying to a mailing list. For
> +Mutt to know when an address is a mailing list, use the `subscribe` keyword in
> +your Mutt configuration:
> +

Better say "... specify mailing list address on `subscribe` command in your Mutt
configuration:".

> +**~/.muttrc:**
> +```
> +# tell Mutt about the Git mailing list
> +subscribe git@vger.kernel.org
> +```
> +
> +[[reply-properly]]
> +=== Reply Properly
> +
> +By default, Mutt uses the 'g' and 'L' hotkeys to execute a "group reply" or
> +"list reply" respectively. A "group reply" creates an email addressed to the
> +sender with all other recipients in the "Cc". A "list reply" starts an email
> +addressed only to the mailing list without anybody else as "Cc".
> +
> +Per rule X, Y, and Z above, using "group reply" in Mutt is what you want to do.
> +
> +[[disable-mail-followup-to]]
> +=== Disable Mail-Followup-To
> +
> +By default, when replying to mailing lists, Mutt will automatically generate
> +"Mail-Followup-To" headers. To fix this, disable the generation of the header
> +in your Mutt configuration. It is also a good idea to disable honoring any
> +"Mail-Followup-To" headers so that any "group reply" operations are correctly
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
> +
> 

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
