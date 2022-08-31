Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B82ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiHaIgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiHaIgT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:36:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3CEC277C
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:36:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id og21so26913516ejc.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=aMwVrm00ruCO/H6tfqeSgxhjuYIx9yR/lHUKhvKlIMg=;
        b=mhsQCVr5WL63cYuRSXTXrG9VgJic6/PlhoACYT5lsuqyDYEGxqucxA1MftHjVsPehe
         FVdx2f+NQpJRtRPE1fOSaSo1fqObkPsxumoU6LDoQ/5xiHi/oscoYSoJvPT44AhRnm+M
         Z3RRHaq/Yt0svXpvRLPlSVGBSN/6THNUYqCinNClXJs3K+yucE2e9h6BSNfs/BGyu/rL
         C59GH34TzHWaamQdTsEUDv3ac78k2kbV8XFwrxz0NPx33tXV1uKtoPh6hgM0MnGr/OZJ
         q5aA65Q/2L41U8WoUeK1FOKp2Sz7A1mFGauJGqH26GK6OtGIH8iGWa43+L3eSl6Hcf9l
         hZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=aMwVrm00ruCO/H6tfqeSgxhjuYIx9yR/lHUKhvKlIMg=;
        b=lO8DtqSXasgVBT6JDlORnO4UXSdK/vFvh+NjtQAxGOdBNyRdMSuHGEr9VnDpQFHOH/
         9xAAmtHjMvTmdacEcYvxVkU6njBU4riJGuu5pOzYEwfqAbaRfxSVd1p1p3IEXWWgKAwZ
         gnLkoJXOh8/EGMuQcALotKwCYMc9cQ37kswHFxghPZGDsPzLLpmsgV+qQhJreQ1v+flu
         bssXnDn6LDl+jJxf9SWYuWjb28aiGWlY6uY8VzU4348rsI34jzDjAAVjnrxObcQhCRQH
         fd7Q/E0EyQXHxHtBmump3j83TWpifgaXXmbZrooiOdYMPAnYHOvI5rZpTE5LWjbDpZVa
         LDhg==
X-Gm-Message-State: ACgBeo3xiEZ3g44RXlXj4uSDKNhMkJWs8A3AhuQtvaOjY3PoaOFKlviH
        1WCs6vSFbxg4PK4Ktb98gB8=
X-Google-Smtp-Source: AA6agR5J0GibhHf0kAlq303UkVsxzoK6E4DuHVCyRNAXhVV/EOtPp2KcICmg44e/+VAarCd3Zx7sVg==
X-Received: by 2002:a17:907:762c:b0:73d:e163:70cf with SMTP id jy12-20020a170907762c00b0073de16370cfmr15635298ejc.694.1661934977332;
        Wed, 31 Aug 2022 01:36:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709063b4700b0073db59e4267sm6759922ejf.184.2022.08.31.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:36:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTJCq-0006HY-0O;
        Wed, 31 Aug 2022 10:36:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: js/add-p-diff-parsing-fix (was: What's cooking in git.git (Aug
 2022, #10; Tue, 30))
Date:   Wed, 31 Aug 2022 10:29:46 +0200
References: <xmqqilm9k0bc.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqilm9k0bc.fsf@gitster.g>
Message-ID: <220831.86bks0ajy7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 30 2022, Junio C Hamano wrote:

> * js/add-p-diff-parsing-fix (2022-08-29) 5 commits
>  - add -p: ignore dirty submodules
>  - add -p: handle `diff-so-fancy`'s hunk headers better
>  - add -p: insert space in colored hunk header as needed
>  - add -p: gracefully ignore unparseable hunk headers in colored diffs
>  - t3701: redefine what is "bogus" output of a diff filter
>
>  Those who use diff-so-fancy as the diff-filter noticed a regression
>  or two in the reimplemented "add -p", which has been corrected.
>
>  Will merge to 'next'?
>  source: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>

This LGTM.

For the release notes you might want to tweak this. While this series
fixes an issue that some users ran into with "diff-so-fancy" it's really
just a generic set of fixes for "git add -p". The issue just happens to
have been discovered with that tool.

E.g. on master now you can try this in git.git:

	echo hi >README.mda
	./git -c interactive.diffFilter=tac add -p
	error: could not parse colored hunk header '?[31m-[Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt?[m'

I.e. just reversing the output with tac(1) is enough to trigger the
failure fixed in this series.

Maybe?:

	'git-add -p' can now parse diffs that don't contain the line
	information that "git diff" itself would emit within "@@
	... @@". As a result the reimplemented "add -p" can now be used
	with the popular "diff-so-fancy" utility.

