Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3EBC43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiK1Op2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiK1OpE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:45:04 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0A23E99
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:44:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so17637797lfb.13
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pv/0+snb/uV7GEIZg1lfSsVWx55qh2Yv9HHdgiIsWUw=;
        b=NEf2cPP2RTMETBbpnVanoEOFRg3oM4H524eciODGPZjFeg4AloSg5bnuRX+QZR1MVq
         bcodWiAepesCM650drP2CdDRTV/gZzK0rR69NhWrLQmPjeUsKcdPoD0KeHZqFJaJHWfZ
         dsBc4QwKPLhrSCeppA1ILRABTPvxlDc1GkNeMJ0IWD+yB+cRQlJJjOhylYCab1EBJfal
         MjYWDPvp0r86t16E8MTGLmQBghLh+8BcEZT0W+XWe3poSVBit4tH4IJht8pAxYJMImHu
         kWXaW3ffRl4kwxwKpNHaCNgKEwXQ0YJFwvaSQ1PXl27KvnsVPb9LbS3md2ChJeHxhc/x
         0FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pv/0+snb/uV7GEIZg1lfSsVWx55qh2Yv9HHdgiIsWUw=;
        b=slEjDCpzIstZHOOJoBjgsKdakriu8zS48wT+CBDIylZg+L9tQwqictQ+wQTcIMq8oD
         sf19pYLn09wmtyz02J0hGhPpeXj4cyfrZPEgH5SCSG/vtai0hEzQ4ZBREeb48E0vVE3P
         0f+r5N2o97kKJsDpTi7jkfHk7ygZxNoSfXjMGjbr5uOnn2tHR95OAlQuqsvkDZ4J2pk9
         QYQ6P3G/dKfwU/fK8Dnw1PKs5j5sCK+/XHslEZXt1FTpEzW3mc9Eo+cLy7SkxRUDAE9+
         9sOPjFKNwaR029k8bMA7UQzbPqEjNb5VV4STRm/2LCQ+o9Cy6hlrnAA0P9g4IMJs9McJ
         1VbQ==
X-Gm-Message-State: ANoB5pnNuMHeePqxmt6MUchJ8H8sQk9VgXIGeBVqSzLfgZQmQ2c59Xhx
        RE8IOCK7miFrD/8sTmIcRpq2JSPr9PM=
X-Google-Smtp-Source: AA0mqf6AHri7HErB4PasmOZCDaZoChpo+53kdNrOoEanp86wsVqlWJYGupYr9dfTNGeUKY5RUlgMlw==
X-Received: by 2002:a05:6512:3b82:b0:4a1:b3a9:7824 with SMTP id g2-20020a0565123b8200b004a1b3a97824mr10516549lfv.410.1669646671481;
        Mon, 28 Nov 2022 06:44:31 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h19-20020a056512055300b0049fbf5facf4sm1725037lfl.75.2022.11.28.06.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 06:44:30 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] diff-merges: implement log.diffMergesForce config
References: <20221127093721.31012-1-sorganov@gmail.com>
        <20221127093721.31012-4-sorganov@gmail.com>
        <xmqqedtn957j.fsf@gitster.g>
Date:   Mon, 28 Nov 2022 17:44:29 +0300
In-Reply-To: <xmqqedtn957j.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        28 Nov 2022 11:35:12 +0900")
Message-ID: <8735a3gmuq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> +	if (set_func != NULL) {
>
> Please write it like so:
>
> 	if (set_func) {

OK, will do.

>
> I am not reviewing any new feature topic during -rc period (yet),
> but this triggered CI failure at the tip of 'seen', so.

Thanks! Do we now have tool for auto-check for these issues? I still use
one from Linux kernel, and it didn't object to this form.

-- Sergey Organov
