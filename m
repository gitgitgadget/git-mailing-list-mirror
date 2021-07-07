Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C998C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 18:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5120D61CBB
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 18:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhGGS5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhGGS5V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 14:57:21 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166FBC061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 11:54:40 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id j4-20020a4ac5440000b029025992521cf0so748276ooq.7
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 11:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=LBQPmHR87VNJAibMQ9njsbi1wncXAyqtu1hEFeKe5UY=;
        b=FmWijlHxNuNSt10PGtKUeAgugZsSGPSLKhWLGOjh0jkywObbd17U6NbkXCwNgrulGQ
         CDsIegTXpSxyzILjSfJfUaWzN5sVEtWX21NhQIzniL1HDZIIfNSrKfhxzNqGsaSNvWDq
         N7geUdQxGsuSWdR7oi+rrFR2Nvd2mLLW/6hFLwfoa7tCJ9AjsBR8ercO/Y44OtgEnL8E
         kV5JThnGWYIbepmTNUXJNO6mZBsyd3yvzZb0NgNDHDCJgqsILnghiBrBmXvVGt3kKOj7
         AZ6pt6TJ3/tvOBuDJuFOvZEacD4b8dEotACWmhle4b/WBRNzbuBTM5chmdQslPe8BRdu
         HAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=LBQPmHR87VNJAibMQ9njsbi1wncXAyqtu1hEFeKe5UY=;
        b=NB1STMFmvTI30mF36bup+A1A4tczUGtqbnZOPfS+2+GBx/hzUN1/M2Aw+OHRJd2bpZ
         x8S/iL33lroqlw6ZkAAJ6F6y36Mk2SE7NyOx9xjzKe5FZUAXz56TrXPO3Zio4cH8GUi6
         +cViVmzuBB1MimnyrcWHeA1Ts9AwyatoImYdonVF1mHxMFvDevsn73aKjMQK3DXFCo6G
         jKWbJ98ZKlnFbSr42a0Hqpi29wRMgGrQcJnP71i1zhfjDrcapbDv2wnFRtB52rP3ZYEj
         zWa53rdRxhWDZIHQXdjqTxHawtK97ioLz0vQ1sJ2bfKdmIo0EPXku4k/tXxXAlVbcSBK
         i5qw==
X-Gm-Message-State: AOAM530V8I4noOxk++VR6DzxXgSxXLXQwMus5LZbMCQr/+GhN9pmfNuC
        XUQJyZUJmJHt/DfsVRvsByc=
X-Google-Smtp-Source: ABdhPJyCwedWkizdhj5OEznPIkskpiOUaR+7JaxkNhEj/9tX6FaxWZKdlxk/HK49dALAxd4ss7pGgw==
X-Received: by 2002:a4a:d6cc:: with SMTP id j12mr6926150oot.0.1625684079454;
        Wed, 07 Jul 2021 11:54:39 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id i133sm4396625oia.2.2021.07.07.11.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:54:38 -0700 (PDT)
Date:   Wed, 07 Jul 2021 13:54:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <60e5f86d8f907_30143720844@natae.notmuch>
In-Reply-To: <167b8fe6-0586-b980-dfb9-9fa3a29d48bb@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <xmqqh7hersgp.fsf@gitster.g>
 <167b8fe6-0586-b980-dfb9-9fa3a29d48bb@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> Sergey made an excellent point:
> > On 01/07/2021 13:27, Sergey Organov wrote:
> >> For example:
> >>
> >> "branch": a chain of commits
> >>
> >> "branch tip": the most recent commit in a branch
> >>
> >> "branch name": specific type of symbolic reference pointing to a bra=
nch tip
> =

> A lot of people think of the "chain of commits" when the word "branch" =

> is used.
> =

> If we take the sentence from the current doc:
>  =C2=A0=C2=A0 --force-create
>  =C2=A0 =C2=A0 Similar to |--create| except that if |<new-branch>| alre=
ady exists, =

> it will be reset to |<start-point>|
> and replace "branch" with "chain of commits"
>  =C2=A0 =C2=A0 Similar to |--create| except that if |<new-||"chain of c=
ommits">| =

> already exists, it will be reset to |<start-point>|
> =

> What would you expect to happen?
> I would think the "chain of commits" is created at the new <start-point=
>
> =

> What we want to say is
>  =C2=A0=C2=A0=C2=A0 The "branch name" will point to a new "branch tip" =
at <start-point>

Wouldn't this achieve everything we want?

  The branch head will now point the new <head>

-- =

Felipe Contreras=
