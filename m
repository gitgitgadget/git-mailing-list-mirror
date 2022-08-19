Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D50C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350200AbiHSSJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350216AbiHSSIw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:08:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C19766D
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:57:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z16so5990476wrh.12
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=bfOn+pTlXorTvpBekm+kVCA5sE3Gohas/D0vmhC1dwA=;
        b=Z85Pb97iY6Xa1XJod7JO4bCUuJ2qP+JceFX1MhSIZRiuAa9cNTAqK4b2sQvesQ8Yif
         ydNmuda+gd40bdzxIM2Pa7cZi2S28SJctVCHl7ZdGZyKf3UMxDOekVjbmYTwNu+tpL6R
         ZL/uxwFfuffCm2Zk60cq+AkVAKr66mm9O4UqtY4yLzHGGVK0rDyW/0pbQdki+tyZVnVA
         tAbsQgnRGrtswH0IZsOC40lE5J7ShGBSVXWF4zeMBGdqP8xy1/L2LKb/M6U1P1+Qpkqn
         ZJCTu9q9tlV9N338wIdmF6hgfpBc0kbE7j39hfzJx5oqlMQITZ6518qK0OQxXoKeV8b3
         ueTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=bfOn+pTlXorTvpBekm+kVCA5sE3Gohas/D0vmhC1dwA=;
        b=OUms6KBSQLkgQGL7Km3HRnaXKw2r63oWnTOR9NTKhT+pzSrPDRU+Q8YPIhMAuyHJrg
         JmpM8zR/eiLtpgKm+5PcS6qJevhlfYPNDFMbHnI8HdnGx7H1nMmSLWCHzjLKbIK0+2+X
         sgs7NdnW6vVL/GHo6JpI4fsIQXsZvTQBJIAXnK0Oqjdju8z8qePoDN4l1q5nQs6tTMOc
         J+hvtwzVucQv3PvoGH6DG8ysGGM/m1chxDCZOiQuMusPEJ8ta41wgyQb+Zmlmu1fdKD2
         okvh2ZUY6RhbHkYoYVnqGasnH0aA2drjXL76lG8KO+Pal0QwOvr6y56YWTBvz5RwITkK
         ZI9Q==
X-Gm-Message-State: ACgBeo3V0fvm9JmxjYVOa+GxZaxmIKzjfG97rDsiOmgpFtUDWaD3mj6o
        HRUl8uZjBukgp0p80AyvtmnLDULvpx5xSA==
X-Google-Smtp-Source: AA6agR5i6DiekirfidpluJbYdG+krwzqSSXqW2+kMd1OTHjdzwSmX8LPRC/Mzq9Q0Lh0qYeZJLZkuA==
X-Received: by 2002:a05:6000:1709:b0:225:1f99:2edc with SMTP id n9-20020a056000170900b002251f992edcmr5013392wrc.397.1660931871699;
        Fri, 19 Aug 2022 10:57:51 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b002211fc70174sm5328580wrq.99.2022.08.19.10.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:57:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP6Fi-000pth-0S;
        Fri, 19 Aug 2022 19:57:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/20] builtin/multi-pack-index.c: let parse-options
 parse subcommands
Date:   Fri, 19 Aug 2022 19:57:23 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-15-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220819160411.1791200-15-szeder.dev@gmail.com>
Message-ID: <220819.86tu685d5t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, SZEDER G=C3=A1bor wrote:

> +	argc =3D parse_options(argc, argv, prefix, options,
> +			     builtin_multi_pack_index_usage, 0);
> +	FREE_AND_NULL(options);

Ditto s/FREE_AND_NULL/free/g per a previous patch's comment.
