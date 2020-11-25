Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F55FC56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59052083E
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMGJbzy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbgKYVrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 16:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732807AbgKYVrF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 16:47:05 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAD8C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 13:47:05 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so3352930wrw.10
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 13:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3T/mbGFPlrycR2vIUQBsVyl+NJKQHojUy4gcwq/crg=;
        b=JMGJbzy9R9Pf/q/LWwToH32ZwAu6fSuSWyjzhFaZ5AWOU0pubztKQ4+jR2dspt0PA5
         OJ/fiQQftdDhzTj1Wuu8wetFO7vRadS1rdj/HDESaflQ06gMGEHXHygZeOls7QZhNMQF
         KZp/wslKkfoF7OldNywORrZfaV2cQVNcf4dkN3tx5R466IRtk8PyrhFf0071LeonNN+2
         tk9jH0QWhYbA6B6cG3I3mo50OH/7O9+T9/KwFBjPCbCHC8kt2efLM4yjkbkGVMRk8EAK
         vHlida4RAt+B94334klip5t1p/KdaQ5WRCueMjS8I+7Eyf0dwoEN/+QC3NS4aVcCH64y
         eEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3T/mbGFPlrycR2vIUQBsVyl+NJKQHojUy4gcwq/crg=;
        b=uOp74PaMhl7sl/uZo/qqEmdbr9o0qUpVruenSDS9naNBQFQaogLfKjGd+1ly5PDPF3
         qVNc8qcOi/W97b86e/HJ7TF+uzSCYKN9IxtBOr4Z2uMS2BieTMB1/KzYTvVgNWtjuUv0
         tPBxuOnhgm7pX4Bu90WHT5d8kaS9ZldJUuEh26J/ksug++4ug6pEjJyQ+Fir2rOCYhCM
         wLjb/doQJDZU8MiTyB1PSQSyNWutu6VPkUBSSBDxyRmZiHN02N0nsb+HdBoisWgggkAx
         IY2wW0yeIGIIY7jfi9mnf9kqrL7BED1L2VmKTYcMcqvRRalqM69172LSxfV9vbpe9zNA
         Khcw==
X-Gm-Message-State: AOAM533Z4iETv0PfacCosj3DScJmfNXYpfkIfOSvqo2LWpqw8J6u4DrW
        sRKCBGbeW8VBSxFtDP6SnKoJoXN44UvMqwJJybk=
X-Google-Smtp-Source: ABdhPJz7yVIEuL0CJ3ilYKxeoH5vGbgeUYyEp7GtMFbkPGGjLeWsXUm7ZXRf2pP5T8+KIJar0B8Mx/UtWtwKUo2xwNE=
X-Received: by 2002:adf:e788:: with SMTP id n8mr6324356wrm.84.1606340824240;
 Wed, 25 Nov 2020 13:47:04 -0800 (PST)
MIME-Version: 1.0
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
 <20201110212136.870769-2-felipe.contreras@gmail.com> <20201125084814.GE8396@szeder.dev>
 <xmqqr1ohdvfi.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1ohdvfi.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 25 Nov 2020 15:46:53 -0600
Message-ID: <CAMP44s3pSOrOYA+CG5Rd+Bu5UXK-4L=4JsHR0tMb7gV7nmbPEg@mail.gmail.com>
Subject: Re: [PATCH v2 01/26] completion: bash: fix prefix detection in branch.*
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 2:37 PM Junio C Hamano <gitster@pobox.com> wrote:

> Very much appreciated a review on this step, and it would be even
> more appreciated if the whole series gets some review, as we do not
> want to merge a series that has not been looked at.

Yes, but it would be better to review the important ones; the fixes, first.

https://lore.kernel.org/git/20201119015209.1155170-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
