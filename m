Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E117C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 21:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiCQVII (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 17:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiCQVH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 17:07:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2BE12A
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 14:06:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qx21so13223883ejb.13
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 14:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=yMuASkubODM3kteGh8jd76rrMYsyq1BESb14Kl694tY=;
        b=qSnpLeITO5Fw2FU/itGfwPvtN9uVcS9vy3EJ+g9GxZryU6oRfAc+ukjNrICPm4ZEz5
         +X2XXNzsgVcedkHkXUToWoOk2/3e9xPfGDa1Rte84eIj+PJLnzl+DWbUrOM9/mfbBivc
         CqhGUCQG6Z8Q5LjJbcrzJpb5S6suTsrHUJNp+rThr0Cl+4WEctQ1Nnu+Ef1lDS/SAlfC
         9Q9B5XdoJtzKpc5ZttsyVHBKfQJnY1eug865QHkMucLRrGwjnHlOx7p6PfyhxCeXysQB
         EcHKd2coTgSpw2upWXKz2jlpfy6qcR7cstMookY+0A08SvNqutRzHQJ8b7l4L2CdQleZ
         Sg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=yMuASkubODM3kteGh8jd76rrMYsyq1BESb14Kl694tY=;
        b=kalk3B1+38KPtCp7u4xHSVsupzoL53bQX1OffTT+lvGZjbk8gdBfnRt77SoTu0+U6m
         2K+8KE0TUgzw1XYzviu2B5kx97NWubOTnhiPURX3kJiY/Q0gbLq1KUWu+tpUBX2nGn66
         3nYykCYX6IFnQBCieY2HiLsfyz3XvbxOaKpj/kPR6W4s/BZqcqLMKl9HF4tZdcCOULqd
         Ok1g1aR/M/aTrFopdtqqYp5b+Yn49lhPCFxkZa2ZXwgG8p/uHPYCkQcUzKG0M5FksOCr
         VovV69Et2V9+PT9exJLviQ8X8KSWuAt4jsIvptzJ9EVHILSZQYDTSa7UC3rpIJGnijuw
         nhKA==
X-Gm-Message-State: AOAM530/mBrBjMsy6Yqsd87I0Iwj/h2R0nQ92rtm5R75sZ0ikNp+OmfD
        yNu1LFoZVeTSV6wh/MCaV+8=
X-Google-Smtp-Source: ABdhPJxw0mBqHnfS+eSHez90yZUUqcNKs9I8dNp2gNEdgOK5qa9BYZ7s+bCVocG0CghU4R0BJD/t1w==
X-Received: by 2002:a17:906:ce23:b0:6cf:7203:ded6 with SMTP id sd3-20020a170906ce2300b006cf7203ded6mr6181401ejb.170.1647551200588;
        Thu, 17 Mar 2022 14:06:40 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g26-20020a50ee1a000000b0041631c5b1f3sm3184219eds.30.2022.03.17.14.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 14:06:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nUxKQ-002EXS-GR;
        Thu, 17 Mar 2022 22:06:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/13] tests: add and use a "test_hook" wrapper +
 hook fixes
Date:   Thu, 17 Mar 2022 22:04:39 +0100
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
 <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
 <xmqqpmmkh77b.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqpmmkh77b.fsf@gitster.g>
Message-ID: <220317.86k0cscmqp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 17 2022, Junio C Hamano wrote:

> Just a quick update before I finish my first integration cycle of
> today.  t543 has a "test_hook" call inside a subshell, but because
> the helper runs test_when_finished, a sanity check kicks in and
> fails the test.
>
> I'll continue the integration cycle with this topic kicked out of
> 'seen' for now.

Pending a re-roll this fix-up for 11/13 should fix it.

I do test with /bin/bash before submitting to catch exactly this class
of issue, but for reasons I haven't looked into this one is odd in not
failing with --verbose-log, but I see the OSX CI (which I didn't wait
for) fails on the same issue. Sorry.

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 90676365471..70431122a40 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -162,13 +162,10 @@ test_expect_success 'atomic push obeys update hook preventing a branch to be pus
 		test_commit two &&
 		git push --mirror up
 	) &&
-	(
-		cd upstream &&
-		test_hook update <<-\EOF
-			# only allow update to main from now on
-			test "$1" = "refs/heads/main"
-		EOF
-	) &&
+	test_hook -C upstream update <<-\EOF &&
+	# only allow update to main from now on
+	test "$1" = "refs/heads/main"
+	EOF
 	(
 		cd workbench &&
 		git checkout main &&
