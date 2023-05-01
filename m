Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C07EC77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 21:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjEAV6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 17:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEAV6m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 17:58:42 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB01709
        for <git@vger.kernel.org>; Mon,  1 May 2023 14:58:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b60366047so2153069b3a.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682978320; x=1685570320;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IAdvLdZRJE7Se4kdVIANAhj59qFjngPzhNvMoJaOAE=;
        b=HinzQphzYxg64T6vBeLOtwD0wXB5ta4mv7rHehFreAT2qRDh+XiwkM72gVXdzBP+X9
         T0b32Hg4DStiL8z2BjF9G9/PL+nb8Wl5brc+/L6VFQhYzgMayzLkC+vGpqgKtn+LzuPo
         UtqQJRJi7vSCYljcYERdRyQtvN30vKoJncC81xY4IVo2ZFzSdxA6SQ5f6JjxJCoPPvYG
         Q+2X1qrBpPcq/LKc42EwbuPBw7HH2UnPA3DzLY02gDmMS/gvBLfFLUlkurIi9Q2RcxPG
         kofsH1Po8rVhHANltOBbaMKGa47H0FwlWXXooxhYWeIZWzSXhhX4nd+9sDExX4YrPrEj
         85dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682978320; x=1685570320;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3IAdvLdZRJE7Se4kdVIANAhj59qFjngPzhNvMoJaOAE=;
        b=g59az8CHCRvoajF8Igy/NM7pG5Kl6LdkdjKhl5qZ3CaZrZwB5tKyTZpBf4bSktZua4
         7xHoO4jI4/xOISNuPoChe3v+LA9XbJQxFtXuJONbwP/EiFcAWTKDkGLOEX0xd1RACP6X
         4XPDIgxN2zK42MC8+gjzxqzQLuL2KdsiKTQ1KPr6Zq5n5/0R1xSFD81beqKZnpCDOQlj
         kng0s5PliTU+oRhNAqUfoniqGErYxbG+wxquG23rIf/RZS8XGDWA23oFUQchNWainANK
         yeUZCnca+Ehnq9LAikQiU6O/WVt/MVccrez8Rh5Ta8OuiuDxxxjcCVPHMErwfCjQoNJt
         YgIg==
X-Gm-Message-State: AC+VfDwZZuF1ZeFBAUBjoNnA+bBhl7u07iJqNsByRdkUsf47rtO9fVR2
        uekT+Gy8x+R9e1TuEZ1mEn+KeXqOksU=
X-Google-Smtp-Source: ACHHUZ6GlalqQbEy5CqM2MgzIGkDWex+lrd2p5EqrdMKLWs4H2Uh1n9HfQdq7/mmIPeR5T9tBXPU3A==
X-Received: by 2002:a05:6a00:1145:b0:63b:3e:cbee with SMTP id b5-20020a056a00114500b0063b003ecbeemr19657838pfm.32.1682978320392;
        Mon, 01 May 2023 14:58:40 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id u26-20020a056a00099a00b0062e0c39977csm20411044pfg.139.2023.05.01.14.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 14:58:39 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>
Cc:     <git@vger.kernel.org>, Luben Tuikov <ltuikov@yahoo.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v10 0/2] Expose header information to git-send-email's
 sendemail-validate hook
References: <20230419202703.2911836-1-michael.strawbridge@amd.com>
Date:   Mon, 01 May 2023 14:58:39 -0700
In-Reply-To: <20230419202703.2911836-1-michael.strawbridge@amd.com> (Michael
        Strawbridge's message of "Wed, 19 Apr 2023 16:27:01 -0400")
Message-ID: <xmqq354f4sts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Strawbridge <michael.strawbridge@amd.com> writes:

> My appologies for taking a while to get back to this.  Here is a reroll
> with the latest suggestions from Luben.
>
> Michael Strawbridge (2):
>   send-email: refactor header generation functions
>   send-email: expose header information to git-send-email's
>     sendemail-validate hook

This round did not see any further comments.  Is everybody happy to
see us declare victory on this front and merge it down to 'next'?

The topic does not make itself a reply to previous iterations, and
the cover letter does not CC: anybody who gave reviews to earlier
rounds, so it is a bit hard to answer the above question myself,
unfortunately.  I manually picked off a few names after finding v9
and v8 from the list archive and added them to Cc: of this message.

Thanks.
