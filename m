Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A5ECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 19:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiJ0TcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiJ0TcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 15:32:11 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C8062C6
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:32:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so2445712pji.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U02f2v1nEBHPzy/1LAtCApfEXJXUYDYEl8Rak1b4uGk=;
        b=R6DpcazW0r4N52qxTE6lmzJ7S/idoPadZJcVnSK8799QvPb9nPMHvTxOxsejtGtoIn
         uSH+/HoiwiNHqjxvGmovLRbd3b9dObh7PAZDO5TIyvhx4c7ESfBFy81H4DDA/A91BWLO
         efDhLaVPwIRWMIHug7havr4JAwGRT+uENL2YiVfo2NFTf+riKNyJsuJD6vZXG1jW/oNH
         DgsUXbXupo3LjFwBLClCCTvNbncNLwKCBP3eOvob2E5buGX+hfcA5ggi9oVm38XEjxbB
         ZrSTehvhKXywNk+P5vGkJeInE4TIA4xW51UUv1EhhJAfHTJ6Wk3krvBbu/uP+AdRSHDu
         hTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U02f2v1nEBHPzy/1LAtCApfEXJXUYDYEl8Rak1b4uGk=;
        b=BjfAiw4NgHOXgLB0SeXmai6izV+fLwvJzbqaSijcLcRoqPLdc0vj0uHv+v3CTrOWeN
         rV04g/c/dkS2Ja4cAuaL8sL+AMUX2MzsmdxD0Y8/MQKG4xQB0lrO4vIHdij7XBMdlako
         8Op3gxG1OSU4ENABnN1eLxBl0Mj2FnHsxgYBmx9bkzEjgIra3qkYGzutzEn04By8natA
         v40Cw7Qbl7xNfpRsZdyEISSO4X9FtLE282YdykJog4zeHM5gRIUPgCSWu+K6nAc5Kag3
         f/Vsg3ozjul3iy10fjzVpj+it/7stI6yQh149NMXUOMSgVlWz3sFdgj8oQNmudxWtyBr
         QTKw==
X-Gm-Message-State: ACrzQf1H+jHKFpYDZZsqxvGRBhbW/6S8C0aZl98QX9E8BAoJO7U66yo3
        OIaR8Q4YkUNJ98HZf2HxOOM=
X-Google-Smtp-Source: AMsMyM6oo0DQUDGPxxyOdkes4Q91QBqxX8oWQ5tKCjcF9tm7lDwswgCfslt2ShUWfbh6u+Nz4UhloA==
X-Received: by 2002:a17:903:2303:b0:186:ed93:fc46 with SMTP id d3-20020a170903230300b00186ed93fc46mr4001710plh.172.1666899130122;
        Thu, 27 Oct 2022 12:32:10 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902eb8c00b0017f5ad327casm1544492plg.103.2022.10.27.12.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:32:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 04/10] string-list API: mark "struct_string_list" to
 "for_each_string_list" const
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
        <patch-04.10-40b3cc9b8d4-20221026T151328Z-avarab@gmail.com>
Date:   Thu, 27 Oct 2022 12:32:09 -0700
In-Reply-To: <patch-04.10-40b3cc9b8d4-20221026T151328Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 26 Oct
 2022 17:35:17
        +0200")
Message-ID: <xmqqlep1kqpy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add a "const" to the "struct string_list *" passed to
> for_each_string_list().
>
> This is arguably abuse of the type system, as the
> "string_list_each_func_t fn" take a "struct string_list_item *",
> i.e. not one with a "const", and those functions *can* modify those
> items.
>
> But as we'll see in a subsequent commit we have other such iteration
> functions that could benefit from a "const", i.e. to declare that
> we're not altering the list itself, even though we might be calling
> functions that alter its values.

The callback functions are allowed to (by taking a non-const
pointer) modify the items, but are there ones that actually modify
them?

