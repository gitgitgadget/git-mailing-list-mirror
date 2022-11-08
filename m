Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB59C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiKHOOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbiKHOOP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:14:15 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2752A57B53
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:14:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f7so22650775edc.6
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NNv5egVDR6iYeLNPqLxVehwSICoTfgvjw3nhh3YwJy4=;
        b=TqU3Ypuaoe0fjW497SwdZPilG25CRgSqUryoCglWvvV6P0nsdUJ5ZmtHw5rk7mk0eS
         EkliFC2x7zP0U2oYgVlxg4BmuDJcu3kZfMd+WPyY6eUbCKIcm/ZNHFz59yRJPdQy8GUt
         bvJWJ5z9PtiHsIxpfEqaGgSmhuEC707XXYq6b5CYuWon7WfgI9WVz82dAxXtYj77LH1+
         gQMmQaZMDfWIHJRTDu9ODJuyZNVyPgafbXfGGORwVSn1XBbD0oudmpZsuRVxo8aV8qiA
         FY5bm6ZEYnKoymCE8v7u+8g7m6SQUWkSZvvM1Wv4Hft8G8uThaWH0A/qe/CoePRROn5o
         zULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNv5egVDR6iYeLNPqLxVehwSICoTfgvjw3nhh3YwJy4=;
        b=I2T52pncUzgWzAnoabuORtNzghKtQ9nwFUnLBdXhOlp0WepofiOTe4XnsepdSq+dBv
         ggaMPvkRu5J34gOkMab5fQqQCo+5JCguNu13PvsNLu2zgxlerS/j+HkeMzfdgHOcAZwg
         WtYD+nq9S6wj0s//srHRoLqjsjuwmleQtS0pdUd+U0NDgYXU7KavqwcPIk9eMw4XrRor
         b93vIp6ZQEuwqGO4sqtfvDYahJJ6gjNkekVId5wiLSPHCQzY6AJaQeAkPA5HyXy7FDmQ
         5K7IdRORNUZ6xRH3ZJ4Q3dqMNl8TH29eTvKnGOE515WnhML7TIOwvAUCV6WiNsPF79Vp
         wKqg==
X-Gm-Message-State: ACrzQf3LTcBRRiZ2+w+oW0LUXo9ML5NRbXAy4jrsL1KRoNA0vSkFNn1K
        jPyAYGm/vp28qLFOPJV212CRhEdp3Fd6ag==
X-Google-Smtp-Source: AMsMyM55V+oFz93HFsjRuzlkRgGRO0NH+SHND7LEsVDfuvRjMALzQaLjLiFI+ppsdGMURCFqvgOo2w==
X-Received: by 2002:a05:6402:2550:b0:462:38d7:a6e1 with SMTP id l16-20020a056402255000b0046238d7a6e1mr57387905edb.337.1667916852054;
        Tue, 08 Nov 2022 06:14:12 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709062b5200b00731582babcasm4772234ejg.71.2022.11.08.06.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:14:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osPMg-000ZeS-2h;
        Tue, 08 Nov 2022 15:14:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: ab/submodule-helper-prep-only (was: What's cooking in git.git (Nov
 2022, #01; Thu, 3))
Date:   Tue, 08 Nov 2022 15:13:23 +0100
References: <Y2RldUHTwNzmez73@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2RldUHTwNzmez73@nand.local>
Message-ID: <221108.86h6z9sfd9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Taylor Blau wrote:

> * ab/submodule-helper-prep-only (2022-11-02) 8 commits
>  - submodule--helper: use OPT_SUBCOMMAND() API
>  - submodule--helper: drop "update --prefix <pfx>" for "-C <pfx> update"
>  - submodule--helper: remove --prefix from "absorbgitdirs"
>  - submodule API & "absorbgitdirs": remove "----recursive" option
>  - submodule.c: refactor recursive block out of absorb function
>  - submodule tests: test for a "foreach" blind-spot
>  - submodule tests: add tests for top-level flag output
>  - submodule--helper: move "config" to a test-tool
>
>  Preparation to remove git-submodule.sh and replace it with a builtin.
>
>  Waiting for review?
>  source: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>

It was waiting on a small re-roll I just sent in:
https://lore.kernel.org/git/cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com/
