Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9FCC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLOJfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLOJf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:35:29 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1638F2DDD
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:35:28 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bj12so50814919ejb.13
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqyhhraN3sbSFwI9bBgGYHvC7aPOd63DoiUSs/dqQr8=;
        b=nP4DT4EHiuWd3Q3G6ksLKEujAU6opbbv0jl0MxYZ5PI5CGM56EVcyxQuZmyha5nOOJ
         2/XYMbTytW9phVNxIUluy3oTVB2cGo7cEL4o5kVnXsDlRJvmNkulPG3+7hE4vl5BSRib
         TIUGNVboED4i9rPkdbM5FUn5nwFZaVbyOYD6TZPQcZBH3kyQU5/oOBXQBYeO5DvBhtaF
         ti3DB+g0ve7sdEnWZJKUKPPyZFnT7sPToFskUL3ACOreRRMDmisyXI2LEYorLUkCkhht
         LQgDAJFBpIqz9657bqRIHS65YdrE0otHv8n5jtqXd5BiZ7tdbNZbAm1iht+YAYTgNhvw
         yNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqyhhraN3sbSFwI9bBgGYHvC7aPOd63DoiUSs/dqQr8=;
        b=qiBn+g5SBOccqPZJ/81fQ13ZHvw7UnDXFuwA0xNnUBNvBTI3CsFIvSFTMKfRxqWtvk
         CP1755trVV1nCz/3eLIWxdisUN64PdX8b3mzKmWE2L7exs+yuZxARChBGHTwq8wWjExU
         ph7x7KncZ7pHSbFW9Zi/afYyAQ4/nimxzNlv5YS4poCRJWiqmFY/L9Qtq4r3/i1iEFJ4
         E7OV5W/FxKRmDsm6oHgY2ulpyIRbvX/oCknlernnFzH6tb2Mr+s6nALsvouPzSxJqDs1
         6HwronUT5NIShmrl3EIkPVMlGV1ShNB0jPNjB5NBH21WjhadqWxbAd18YelrQQ5QAxtI
         EC5w==
X-Gm-Message-State: ANoB5pnVrFAdUL5xxQLRBr7lhiq7lFGkyDLnuEYZ3aCev63ssunL7+VC
        sWFLrPJdipQcBhCEOHkk9/AGQCanF1VzZA==
X-Google-Smtp-Source: AA0mqf7WXPNlljaEgGdPkjODQd4oHu+Fzeq02a0vtrjsVz42GmT5tv6ozuwgDW5LnYgFgFRqHGs0Ag==
X-Received: by 2002:a17:906:f102:b0:78d:f456:1ef2 with SMTP id gv2-20020a170906f10200b0078df4561ef2mr22788405ejb.67.1671096926634;
        Thu, 15 Dec 2022 01:35:26 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906318100b007c0688a68cbsm7030181ejy.176.2022.12.15.01.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:35:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5keD-006AVT-2R;
        Thu, 15 Dec 2022 10:35:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: ab/remove--super-prefix & ab/submodule-no-abspath (was: What's
 cooking in git.git (Dec 2022, #05; Wed, 14))
Date:   Thu, 15 Dec 2022 10:33:40 +0100
References: <xmqqiliewbje.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqiliewbje.fsf@gitster.g>
Message-ID: <221215.86r0x12en6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 14 2022, Junio C Hamano wrote:

> * ab/remove--super-prefix (2022-11-21) 12 commits
>  . fetch: rename "--submodule-prefix" to "--super-prefix"
>  . read-tree: add "--super-prefix" option, eliminate global
>  . submodule--helper: convert "{update,clone}" to their own "--super-prefix"
>  . submodule--helper: convert "status" to its own "--super-prefix"
>  . submodule--helper: convert "sync" to its own "--super-prefix"
>  . submodule--helper: convert "foreach" to its own "--super-prefix"
>  . submodule--helper: don't use global --super-prefix in "absorbgitdirs"
>  . submodule.c & submodule--helper: pass along "super_prefix" param
>  . read-tree + fetch tests: test failing "--super-prefix" interaction
>  . Merge branch 'ab/submodule-no-abspath' into ab/remove--super-prefix
>  . submodule--helper absorbgitdirs: no abspaths in "Migrating git..."
>  . Merge branch 'ab/submodule-helper-prep-only' into ab/remove--super-prefix
>
>  Remove the top-level `--super-prefix` option.
>  Will discard.
>  cf. the thread leading to <xmqqmt86stm3.fsf@gitster.g>
>  source: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
>
>
> * ab/submodule-no-abspath (2022-11-23) 2 commits
>  . submodule absorbgitdirs: use relative <from> and <to> paths
>  . submodule--helper absorbgitdirs: no abspaths in "Migrating git..."
>
>  Remove an absolute path in the "Migrating git directory" message.
>
>  Revert out of 'next'.
>  cf. the thread leading to <xmqqmt86stm3.fsf@gitster.g>
>  source: <patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com>

This stranded on the question of whether the "absorbgitdirs" message
should show relative paths or not.

I've re-rolled this post-release just now at
https://lore.kernel.org/git/cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com/;
this time around there's no changes to the output.
