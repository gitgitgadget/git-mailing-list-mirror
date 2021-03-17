Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BA9C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E84564F0F
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhCQNdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhCQNc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:32:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A448C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:32:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ci14so2617961ejc.7
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=x9otVMyIs84Kz5mBlCx/iratPXFVUIiNEQKLqGHZzTo=;
        b=MNg4BcLgysFLI0U/HXm8NkvOYG9iqgwGbJUJwyEYByvNVTijtfNbeTAnymcEu/PUP4
         d8iI9THy0K7YAiAvPw5Xndm+ng1bqrjfJYw3aPeq6LCylW8D3vSHnMyQk3vTrkoI/xWT
         VIt8HH31XXgi0rAR3Hc0/CKrRnGAU5WxLtG9P/yanEeVtJuP2JxRZqrctNV7aRZ3GUDo
         BXPfpx6KmRkc43qP6VbwnQi5tGPZGlmz8oDNUHoonRZCGpYDDes4qu23BOulQ9DpYbVd
         g3jnkmWo3F5J4hwV2SDQZM24WxNs4k5KE7clBLoBbdWntbNvzz8KDfVEpWd58VAJAxtz
         PqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=x9otVMyIs84Kz5mBlCx/iratPXFVUIiNEQKLqGHZzTo=;
        b=uKBYJVX3ZjOkEINvelqk/73tD549sM5BjTzf6yllRivjESqn25jA3/ic/MqoqlSDQ1
         JfSsp25XkThgESxF7xNZY0GJQOluXaGv2J2cZPTpUtjMt548mNthY1OtDe/9qSOV8IO/
         Z/JB8CgLl/N91RahpwxKnazSx9mcx3ibQ3KfUi0MOSHZbpzzYGsLreSo7Spoo2d2aflH
         /hHtvmMCMcOzSbgcZiHyuD1hvznOIuehSQCHdyZUMzIQHMPBrU+Lq3N/OaEPoohXRWse
         s+pwu4a66rS5fMRkoaMyRrgodil6lxF/oBHv0gHmub+5uIWaays0fTvyYtslWaSUEKOK
         Kqpg==
X-Gm-Message-State: AOAM533g20ou3yTJYchBLkd0PNxo6Ohe6Nbwi70XHGu37eTg0IC7jMN3
        Fa1pI71vygEQRR0A/F38YXw6Gjw1DsGVxQ==
X-Google-Smtp-Source: ABdhPJwrYWCyb+5JwE50jM3+B86b6TyyMYxhcyXSyPo/pGh6Izsy5aFp9V+7KqIfJvi6K1+FKTPoVA==
X-Received: by 2002:a17:906:a413:: with SMTP id l19mr35583343ejz.421.1615987976339;
        Wed, 17 Mar 2021 06:32:56 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r19sm11373905ejr.55.2021.03.17.06.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:32:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        dstolee@microsoft.com
Subject: Re: [RFC/PATCH 5/5] test-tool: split up test-tool read-cache
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
 <20210317132814.30175-6-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210317132814.30175-6-avarab@gmail.com>
Date:   Wed, 17 Mar 2021 14:32:55 +0100
Message-ID: <8735wt29dk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 17 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> +	if (argc !=3D 2)
> +		die("usage: test-tool read-cache-again <count> <file>");
> +
> +	cnt =3D strtol(argv[0], NULL, 0);
> +	name =3D argv[2];

This is needed on top, the perils of sending out ad-hoc RFC patches from
the working tree..:

diff --git a/t/helper/test-read-cache-again.c b/t/helper/test-read-cache-ag=
ain.c
index 5e20ca1c8f..aa97b3aaf3 100644
--- a/t/helper/test-read-cache-again.c
+++ b/t/helper/test-read-cache-again.c
@@ -7,10 +7,9 @@ int cmd__read_cache_again(int argc, const char **argv)
 	int cnt;
 	const char *name;
=20
-	if (argc !=3D 2)
+	if (argc !=3D 3)
 		die("usage: test-tool read-cache-again <count> <file>");
-
-	cnt =3D strtol(argv[0], NULL, 0);
+	cnt =3D strtol(argv[1], NULL, 0);
 	name =3D argv[2];
=20
 	setup_git_directory();
