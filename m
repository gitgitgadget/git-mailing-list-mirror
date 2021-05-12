Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F776C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACCE61421
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhELGWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 02:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhELGWN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 02:22:13 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD34C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 23:21:05 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so19653451otp.11
        for <git@vger.kernel.org>; Tue, 11 May 2021 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=XUgKZrEYc0xV31vUF5BvKaJH9A5tPtywvQqhuEhyauU=;
        b=S5KofPgr7QxGcW9XASXYqFgCM/JAxG2S3Ms/9H9fHgJGsLRtMd/mMInupyqpu/Dp53
         8mcb+BrumepxCzLJQ94flZ4w6t9Wr82UVZMAMfYpBV/K9D1oXjiHaw7ZQb4mkufwVvKe
         xy/dhXm1OnB6gM1tMhtelGhinrO0kSy1nE4G9NYt3wTfWH1MyZ8FTKeY3/5nQ+QI4aBb
         4rNZC9Bk/MnI8a8kjYXEkAhdt9932h4qre8Iu+nmJbOwXaX/X7jwiq+kwHINvI51K+MF
         CR+zQvrKCELSgWPrzy/gEr1WffQmOew6ZF7q1GBoH6kdEviyjfO6dYGSrehGzYGf8zm5
         pPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=XUgKZrEYc0xV31vUF5BvKaJH9A5tPtywvQqhuEhyauU=;
        b=AsrJBFH/s84AJHypCWvf7M/GFh7PMk5RAPw6eeQECCyQ5fH6nbAF3kE8jj6X69PGLW
         jQ0BbvJBlan10pm+zmAIPPipvpS00MySdQUn7+m4ColD6MXLzLgIMOrDEFuPAGmCR/rx
         Hlnm32KNfjijq07ZeqritTPaEBpCCzst2L006SE+1mX3NakCot/XLKiQVCYwye2B85TU
         YiVMsp9+TgUdGPjmzOvNXhDGqG4lfkfHQuHThj8EQm+2QpjalsiqJvuakm7jOtQxWoqG
         oqmR1+CLi7Ac90TJI88eB422ZXh2S0BWBPflZLFk0+g7RLjluA+6TnvehYensol/yAE3
         KGJQ==
X-Gm-Message-State: AOAM533Ra0Ft3paknduKYwg8oHJZn4shs/+Bi63c6wiC/TJR5LTkSLJE
        0UnDX7Jpj9xhHCgztVQrUafyWwNzNtP1EA==
X-Google-Smtp-Source: ABdhPJxa405LTtZ3vP3/a/vp2k1vosrTMlENOKhZasngysIj1z0ncDTWrlztBYBdCkMOyzok3JI1VA==
X-Received: by 2002:a9d:51c7:: with SMTP id d7mr20667272oth.51.1620800464745;
        Tue, 11 May 2021 23:21:04 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x5sm1848929otg.76.2021.05.11.23.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 23:21:04 -0700 (PDT)
Date:   Wed, 12 May 2021 01:21:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>, git@vger.kernel.org
Message-ID: <609b73cbf39ab_6d897208a8@natae.notmuch>
In-Reply-To: <20210512025447.6068-1-dwh@linuxprogrammer.org>
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
Subject: RE: [PATCH v1] Writing down mail list etiquette.
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby wrote:
> After violating a few unspoken etiquette rules that were spotted by
> Christian Couder <christian.couder@gmail.com>, Filipe Contreras
> <felipe.contreras@gmail.com> suggested that somebody write a guide.

Thanks for doing this. It's hard for seasoned developers to spot the
gaps in documentation, and that's why it's so important for newcomers to
fill them before they themselve get too accustomed with the project.

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

  Some open source projects--such as Git--use email to...

Some open source projects do, certainly not all.

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

Although all this is OK, I don't think it matters much who you put in
Cc, and who in the To fields.

As long as everyone involved--including the mailing list--is in both
fields, you are fine.

> +[[do-not-use-mail-followup-to]]
> +== Do Not Use Mail-Followup-To

Er, this is improtant, but it shouldn't be #2.

There's a lot of things more important than this, for example something
I encountered recently...

  Do not top-post [1], and try to remove as much context as possible.
  Only leave the context that is important for your reply.

In fact, this opens the possiblity for some much needed levity...

  A: Because it messes up the order in which people normally read text.
  Q: Why is top-posting such a bad thing?
  A: Top-posting.
  Q: What is the most annoying thing in e-mail?

This is especially important for people coming from corporate
environments where top-posting is the norm, and no context is ever
deleted.

[1] https://en.wikipedia.org/wiki/Posting_style#Interleaved_style

> +[[enable-plain-text-mode]]
> +== Enable Plain Text Mode
> +
> +Most email clients automatically reject mailing list email if it is not a
> +text/plain formatted email.

It's not the email clients, it's the mailing list software itself.

Either way this is important.

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

This is important for other mails, like bug reports, and questions, not
just patches.


Another very general aspect of the git mailing list (and others
similar), is that you should never be afraid of simply sending a
point-blank mail to the mailinsg list.

You don't need to subscribe, and you don't need to look for people to
Cc... Just send the mail.

It's generally better to just send the mail than not send it (even if
people like Dave are bitten by their configuration).

Cheers.

-- 
Felipe Contreras
