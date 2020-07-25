Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4627C433DF
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 17:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D729206D8
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9Ax1NDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgGYR2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jul 2020 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgGYR2C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jul 2020 13:28:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE27C08C5C0
        for <git@vger.kernel.org>; Sat, 25 Jul 2020 10:28:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m16so6102757pls.5
        for <git@vger.kernel.org>; Sat, 25 Jul 2020 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=HX1WB7i+imdaHd52UhZyf44MLkZxgpmNON/1C9b6pYw=;
        b=Y9Ax1NDOSsnbrbd1+X/ft3o0HjKv9nACLjb2kTDgyrISnsiASdUC1gB3nUnuZ4/BTH
         6ZbiXsZJ/T9hk9qUXPWLU6BkFHPt7p3va3XKRd9Sqg1MLKW33busqQEay7dcLeJnjB1p
         7mYDlHUhKA99hddL8dPift6uuc4VHyiO3ptN9AJFrp4hKdPhhfIIqwRH7bSXQkOr1pMP
         8UjQLyo903vxeMKQ+1G1HUj9N0/gII8qpXh5eLiI9H79J8KtEBzQwSuVdOfj7fUetL9a
         8AioktmzP8vFXg0g55U0D5GztdbvHnsYJ7tP2D3cJ9TblkVoEKnRjh/jfnjgJsk96PNC
         lI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=HX1WB7i+imdaHd52UhZyf44MLkZxgpmNON/1C9b6pYw=;
        b=r8EX4CE/CpEjykPL5jmMz/Hv1WH1Fhm4UFfCRg+W88xwBXWmncnVVjtQ/0P67OSwZg
         YoKhxhATG0z76Zb5xmukrcZk9AVuBgmn6JZQJgbltziKacrMiztNu7ra8mQmsqQ/FB7r
         kGE9gzNIxWv2zoUXT/Uqb2MnFpLRwo3mfq/ukIauIJHfZcwiHVGEvkBXTd36iRne2rf0
         P3yW4jjD/TUHJOAZV63fs1n0sk+ehcrtx/hYCCDKRXHJcDWrEMMmotN1zQpfZ+gVJls5
         DhoyPrkqvL3rf40XPY24XfURqN/0oOD/b/GrddPqL/RUqwRSoNOHpMyls3F/uXyco79e
         X8PA==
X-Gm-Message-State: AOAM533RfdgH/dWH0EFj7UVozt/anrFGIG/lkzWgU+L3F4tx/SDaQX16
        AaR4b15VvPdUC8MErLHDqTk=
X-Google-Smtp-Source: ABdhPJzKfSPYfT2X/tnuiYoWw9er/SRC0QIv3k7CoHQ5cJBs9Qqj3lYsY46fssDYnq+PFYEeZjL8iA==
X-Received: by 2002:a17:90a:cc0f:: with SMTP id b15mr10872956pju.83.1595698082208;
        Sat, 25 Jul 2020 10:28:02 -0700 (PDT)
Received: from konoha ([45.127.46.115])
        by smtp.gmail.com with ESMTPSA id v11sm9203012pgs.22.2020.07.25.10.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 10:28:01 -0700 (PDT)
Date:   Sat, 25 Jul 2020 22:57:56 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     mirucam@gmail.com
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        git@vger.kernel.org
Subject: Re: [PATCH v5 01/13] bisect--helper: BUG() in cmd_*() on invalid
 subcommand
Message-ID: <20200725172756.GA614052@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717105406.82226-2-mirucam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Miriam,

> In cmd_bisect__helper() function, there would be a bug
> if an invalid or no subcommand was passed.return error()
> should be replaced by BUG() in that case.

> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---

I think we can try for a better message. Maybe something like:

    One encounters a BUG when an invalid or no subcommand is passed to
    'cmd_bisect__helper()'. BUG() out instead of returning an error.

> -		return error("BUG: unknown subcommand '%d'", cmdmode);
> +		BUG("unknown subcommand %d", (int)cmdmode);

Do we need to typecast an integer to an integer here?

Regards,
Shourya Shukla

