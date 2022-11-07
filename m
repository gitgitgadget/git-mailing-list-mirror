Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0851DC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 17:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiKGRIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 12:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiKGRH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 12:07:59 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F722B16
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 09:07:59 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f5so31932871ejc.5
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 09:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mJi8NtC9YpTvtn+3oxkcVYiWCfk8toR2sdJmbj0S4z0=;
        b=K9o9ITTzbkev8zUxpkvjAEL47ItSpSmrK7S3FSe8HlBOqo6LCqDfv13t8gT4AfhSbx
         s2pgztNP8WE/BHckVuiF2qm8oA5sVvL/NJXyc/Cm5QJ97neDC5J9B1a53OJPAo6n2i3I
         8rqP33sAPTHjRr+Z7UVnh/5gjLcyg4qDjWxLGVx9IlenFBfA7KIlSk++O+8kwbHu3Muf
         RXuOsoRJ7D99c7iZZYhZAwZnaGFILnlghJKJ2CDgSNpWh4gfkN0CQc673PgwD9LJDq+q
         1oZOsOo08qjTZ6BpTiddp6g8qW9uR+fdudYYUzimDIWLFUJGASRFtvr1GKyGmFKKwu07
         Fm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJi8NtC9YpTvtn+3oxkcVYiWCfk8toR2sdJmbj0S4z0=;
        b=sYRs6Z4vDoncvbDCiETUKjFdgqcv/rZ9sUQcGf0fkdfuKe+fWUPb7s9sGHgU8OQfZU
         yJmAekp5USqRKIa453pI0xgTg7RExDd2vZVvkUpOI5+7kwtzOJZgVkLBWMop50uonD0e
         +us8+9EMIejcSUObnctvHAnwkoc4wgNgNYz3q3HASjkDmZUyxUIfUNid9V26q7uTts+n
         X6GA/4stLaEcD1SnBgDntosYL5EydBE5pLLVJ/8tPVDogzSq26cVY8RwO7jZ3amHCFRZ
         UnVVQQEU3xKW9DhHlI8zicSVtvqDzYLPDNKx3o737UbhJFXEGglDb4kMuJbwh12yMF2R
         a1mA==
X-Gm-Message-State: ACrzQf3+YS+yMeAwEs3dOPMPi03swdD5SwqJsGeHGHSFE8H7CVAf+OcK
        cMLr95tU62SnPvw9Xudyu0c=
X-Google-Smtp-Source: AMsMyM4dckP/4xwbr+7iEKz3dD5wyWurZ2E9CPq/AkBh6xwTTN95e5NtEmcYlzQdEIiXyhAFC8D9Eg==
X-Received: by 2002:a17:906:fe0b:b0:787:f1d3:2105 with SMTP id wy11-20020a170906fe0b00b00787f1d32105mr49126112ejb.83.1667840877478;
        Mon, 07 Nov 2022 09:07:57 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id vc12-20020a170907d08c00b0073d7b876621sm3587919ejc.205.2022.11.07.09.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:07:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os5bI-000Cjg-1O;
        Mon, 07 Nov 2022 18:07:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/6] revision: add new parameter to exclude hidden refs
Date:   Mon, 07 Nov 2022 18:07:01 +0100
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
 <de7c1aa210c2df9bdbbb6c19f44f72c37f56c5da.1667823042.git.ps@pks.im>
 <221107.86pmdyx4me.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <221107.86pmdyx4me.gmgdl@evledraar.gmail.com>
Message-ID: <221107.86eduevgk3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Nov 07 2022, Patrick Steinhardt wrote:

>> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>
> Thanks for adding this! :)

Hrm, I spoke too soon :) This series adds new leaks, so it'll fail with
the linux-leaks job. I have the following local monkeypatch on top,
which obviously doesn't address the root cause. The t6018 leak is new
due to the new tests you added.

diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index f92616de12d..54221588dd0 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -5,7 +5,6 @@ test_description=3D'rev-list/rev-parse --glob'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
-TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 commit () {
diff --git a/t/t6021-rev-list-exclude-hidden.sh b/t/t6021-rev-list-exclude-=
hidden.sh
index d08fc2da93d..908b9dba611 100755
--- a/t/t6021-rev-list-exclude-hidden.sh
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -2,7 +2,6 @@
=20
 test_description=3D'git rev-list --exclude-hidden test'
=20
-TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
