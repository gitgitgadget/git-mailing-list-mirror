Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB55C43219
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 21:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiKXVgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 16:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXVga (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 16:36:30 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987FBB8FBA
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 13:36:29 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ha10so6542707ejb.3
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 13:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I3PIMYAbiTxkGPUQtMU75WV0lHkkFraGWvFHvAOeso4=;
        b=NIHYaAl5PnM3XE9Kv0QXaP7sfCt9Pa54ORQxcwnpR4GlH5JLbFyzNkyPy8mONovoH6
         f54Ip8J3nZxlZ44rQ3s+p8FM8wFVGYkQZg1c9zIZ/7Z5BO672gAzl/SjP3eFXX30JBHs
         CrWt5QlxxemzoJPuKiCpJNjvmBc6mtf5wDK2D3SI1yvgjyyAyzGAtxnHwt/pSjPiHJKA
         7Z//w234Xhqf6hrJR7C+3T/0jVWWEG5KgXBysjTdHtXnTnNzHzBgjgu1K0m6DjXP+g9f
         5p8+wOJRz92bXBGJek+rYBruNiuU6KGhZq0bqZhSpO1ZXQZZOw/Cxa0gZuyeyysSJyJg
         q4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3PIMYAbiTxkGPUQtMU75WV0lHkkFraGWvFHvAOeso4=;
        b=Sf8kTd/aupJPa35hp77Hpm1kqPhaLpZaUj/HrOBYXb9h+XnAUU02hwCo+s6QTNkTb8
         1zMdloXGaoG424zl7hATU986mvRJsc9ewqoERs0RUJc0GE7LOqthqlGbZyj6HPnvYQta
         p2B1lYCO7G4NlsZfqxyM0d7VsPJr31VLPwQpBpxLr4hWCniphRpzFDlkkbPKJnonUqNg
         V814TVM/Qztg2nKygNh4xvtYGxYKM0UBWXpSldDY/teY/4MAD+J8Otj2+kMj7OvHNjVE
         XqWCDtC7JmQRCq983DAK+zKJEqCSdIyXX0uP6/maEeByQ8mmlV4+qRuMAxMPjp30sziR
         UUyA==
X-Gm-Message-State: ANoB5pllJ1Auk4/gxhhesecwvYiIbJzKJRb7e1C7MtRKNat4r0Z73uDY
        Ccxte7dlx0vBmuh4/OTb/vc=
X-Google-Smtp-Source: AA0mqf7e+Hsf8582L/ggoowUvEVRwSy6P5YSDOemG4Ea7Zt2GCdzgRbs8zLRRrKKfwB91PTP1uBL6A==
X-Received: by 2002:a17:906:a397:b0:7ae:5381:bd02 with SMTP id k23-20020a170906a39700b007ae5381bd02mr28423146ejz.286.1669325788003;
        Thu, 24 Nov 2022 13:36:28 -0800 (PST)
Received: from gmgdl ([213.143.127.178])
        by smtp.gmail.com with ESMTPSA id y4-20020a1709064b0400b0073c10031dc9sm833812eju.80.2022.11.24.13.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 13:36:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyJtS-000OyT-07;
        Thu, 24 Nov 2022 22:36:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org, 'Jeff Hostetler' <jeffhost@microsoft.com>
Subject: Re: [BUG} t2201.7+ Failure to Create Thread in 2.39.0-rc0
Date:   Thu, 24 Nov 2022 22:35:49 +0100
References: <010201d9002e$8e2f9940$aa8ecbc0$@nexbridge.com>
 <221124.86o7swnqc1.gmgdl@evledraar.gmail.com>
 <010c01d90039$938568b0$ba903a10$@nexbridge.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <010c01d90039$938568b0$ba903a10$@nexbridge.com>
Message-ID: <221124.86fse8nig6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 24 2022, rsbecker@nexbridge.com wrote:

> On November 24, 2022 1:41 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrot=
e:
>>[CC-ing Jeff, this is from the "stopwatch timers" topic]
>>
>>On Thu, Nov 24 2022, rsbecker@nexbridge.com wrote:
>>
>>> While running t2201.7 (and subsequent) for 2.39.0-rc0, I hit a
>>> condition
>>> where:
>>
>>Don't you mean t0211-trace2-perf.sh?
>>
>>> <snip>
>>> + test_when_finished rm trace.perf actual test_config_global
>>> + trace2.perfBrief 1 pwd test_config_global trace2.perfTarget
>>> /home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/t/trash
>>> directory.t0211-trace2-perf/trace.perf
>>> + test-tool trace2 101timer 5 10 3
>>> fatal: failed to create thread[0]
>>>
>>> was encountered, causing the test to fail. Pointers on resolving this
>>> would be helpful.
>>
>>Apparently we really could use a NO_PTHREADS=3DY CI setup, because that's=
 all
>>that's needed to reproduce this on linux & elsewhere. Running the test wi=
th that:
>>
>>	+ test-tool trace2 101timer 5 10 3
>>	fatal: failed to create thread[0]
>>	error: last command exited with $?=3D128
>>
>>For that all that's needed is this:
>>
>>	diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
>>	index 0b3436e8cac..cfba6861322 100755
>>	--- a/t/t0211-trace2-perf.sh
>>	+++ b/t/t0211-trace2-perf.sh
>>	@@ -203,7 +203,7 @@ test_expect_success 'stopwatch timer test/test1' '
>>	 	have_timer_event "main" "timer" "test" "test1" 5 actual
>>	 '
>>
>>	-test_expect_success 'stopwatch timer test/test2' '
>>	+test_expect_success PTHREADS 'stopwatch timer test/test2' '
>>	 	test_when_finished "rm trace.perf actual" &&
>>	 	test_config_global trace2.perfBrief 1 &&
>>	 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
>>	@@ -249,7 +249,7 @@ test_expect_success 'global counter test/test1' '
>>	 	have_counter_event "main" "counter" "test" "test1" 15 actual
>>	 '
>>
>>	-test_expect_success 'global counter test/test2' '
>>	+test_expect_success PTHREADS 'global counter test/test2' '
>>	 	test_when_finished "rm trace.perf actual" &&
>>	 	test_config_global trace2.perfBrief 1 &&
>>	 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
>>
>>I think that's the correct fix here, and it should go into rc1.
>
> I assume we do not have to modify the platform's entry in config.mak.unam=
e, which already has NO_PTHREADS=3DUnfortunatelyYes.

Yes, that's the part where you declare that the platform doesn't have
threading, this is where the tests are then guarded using that setting.
