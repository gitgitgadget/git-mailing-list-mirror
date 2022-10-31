Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B8EECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 23:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJaXp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJaXp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 19:45:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1748EE02C
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:45:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kt23so33249913ejc.7
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=So5A5Bxuin7ReGDZj9LrespN4IJIXgAhOTgt8qhsN1Y=;
        b=eq0e/UiCu/i+yXXS4bB4iD5YTEsbZpN621EQAsR7sBdFYFjDtlFsw0f0LAdFIHjEIx
         zg4D+WTeegCBXZd41SmbRfOrywpLt4xkVbuN80rMixsoL0BgVL1wloN/vv5ya6vCrA1T
         knHZkoWjS9E/BSHjZi1wHMn/x4Bl34TB3mYXVPJ0UHDl7RXJwef0MFIcm/7KaMl/3IFD
         riE8KZZubjhXqilr/0AanelwsNJ1ghlIozfKti4xlrRoJIDVojsO15KrJWh+H15qFZQ4
         9sIXv7MNUSdLfe2Rnk2CFx9sfweqyaSB/X9ZDHNl6ZTmy/OVaFPtTy+nD6J+Rf0ua284
         ivpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So5A5Bxuin7ReGDZj9LrespN4IJIXgAhOTgt8qhsN1Y=;
        b=e+zkZTKKzEhh6k2WYFRjLmnLqLuHF/R1Y6QRl3C4DuZElA9WrggPVH0kD8NKoQ6fJR
         SsdE4J5k+5x4VbDM7CgPyUauvLSvKYTowWQCcpdOV7C70Ce5nVrrhF7cLCK3F9yXeYvo
         5kg934NT9a+Cqs6Vp1ebaAMt1dME8iCUc1jSAMB9R2MP97oqON7zU/rSiHmNNUOLFxZy
         A52FUidX9JlPdfjj+vZRxoGDD8jtZgQYgiBeyUbQkXP7WHZjW+K92nqnNmKl5zvpM7EM
         FKi6zPnUvOkP8pQ+ALRB91Dv5uYU/kBDNd7ei6clpZXoFyHGd8pnfPUWWYtPYnCDTkaZ
         iJEA==
X-Gm-Message-State: ACrzQf3t7pi0cM95n4X2hjtZTxvnvYTILhl9+owRDcLYX+JkbuOnQJ5Y
        qng2kx5dx6D1w1pA8WH0SURO6UUh/GqH0w==
X-Google-Smtp-Source: AMsMyM7Z2RJgIxE3YEfGq6nvU6ettuNicNCE8YxnUb1gptnnwPMRWn3XakfYlLzOPDvxNPKIhKy6lQ==
X-Received: by 2002:a17:907:845:b0:731:2f6c:6dbd with SMTP id ww5-20020a170907084500b007312f6c6dbdmr15356432ejb.551.1667259923373;
        Mon, 31 Oct 2022 16:45:23 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709063e4600b007abaff3a97asm3490230eji.221.2022.10.31.16.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:45:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opeT4-00Aux0-1J;
        Tue, 01 Nov 2022 00:45:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: ab/cmake-nix-and-ci (was: What's cooking in git.git (Oct 2022, #09;
 Mon, 31))
Date:   Tue, 01 Nov 2022 00:44:32 +0100
References: <Y19dnb2M+yObnftj@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y19dnb2M+yObnftj@nand.local>
Message-ID: <221101.86r0yn5zhp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Taylor Blau wrote:

> * ab/cmake-nix-and-ci (2022-10-30) 11 commits
>  - CI: add a "linux-cmake-test" to run cmake & ctest on linux
>  - cmake: copy over git-p4.py for t983[56] perforce test
>  - cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
>  - Makefile + cmake: use environment, not GIT-BUILD-DIR
>  - test-lib.sh: support a "GIT_TEST_BUILD_DIR"
>  - cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>  - cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>  - cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>  - cmake: don't copy chainlint.pl to build directory
>  - cmake: update instructions for portable CMakeLists.txt
>  - cmake: don't "mkdir -p" and "cd" in build instructions
>
>  Fix assorted issues with CTest on *nix machines.
>
>  Waiting for review.
>  source: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>

I'll send a v3 of this (currently waiting on CI to finish).
