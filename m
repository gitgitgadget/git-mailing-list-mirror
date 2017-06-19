Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312521FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 19:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdFSTZN (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 15:25:13 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34379 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753096AbdFSTZK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 15:25:10 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so17737910pge.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r1Na7+XnRM4X5W9Gp2HUp69arj4tsQiOz6yAr/vgpyo=;
        b=UtcQzRYNzrdAzkrw+bJeguYt8vFNCZGePlzQ1Pz6Ghbu+SMsYt/cpCKacHKnCqnitv
         6+xQoNjpeCM37nD7Pql3KRPezngMOjF42mfUsljyvFhGqeGax6HwmRw0OpbvuLm2dwim
         KWklVRkz51NTStk6hIrSEj3Y/QSsy2qSAPa7ztIzFIqE8ES35DUAkFo7R7GraWtAKGjm
         Hf79cfn80olI74RkRqWoQVHJvDV6xddrlBo70khnV4p+EJsfSwoRsyPhBSuPyPz9r9MX
         lYpdBuZGrRqeWm53Ths4LlJ/QvgcWoNmJkb9gJKbgy0Yy37LpNtEu5NU4AHHo/4HEIIM
         xU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r1Na7+XnRM4X5W9Gp2HUp69arj4tsQiOz6yAr/vgpyo=;
        b=EwQEZlNbxiPxHAi97UzvEE74EmBSZEMbjbwzUBm90NY1kBabJ8m0IshS05ipS9uCLt
         YiP6GDDZ6Wasf87GQpXgll561DMk1VP6zLBT8h87JBFCeK6OA2PJmMLLLFcOGArR5C6K
         GvIslvOiDulXTjBUB4ubc4eX4uyFxOm6DBxYAXvpsCB9o4IBPXGbEXTNYGUch6Xc5Nrl
         l7p0ZffM7CbMPYKSwEPvvwQ/dBrbbbmEDTuUSJYpCZv1jpNuzRcjDiLMv0ZEaafUG5Zg
         UBsmOQV3HSRBtUdjboW523xAnEZYHBKnWusA8nRBSFuQKfZE33KkSr1VngrYteK734hA
         k7aQ==
X-Gm-Message-State: AKS2vOzBJDq4hrQMPwb4MJV8En3laZei5UnKnYqaBXmbmr2YmrnEyMml
        iiNWotlGB1QZrA==
X-Received: by 10.84.241.197 with SMTP id t5mr31031496plm.48.1497900309212;
        Mon, 19 Jun 2017 12:25:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id v21sm23925855pfk.75.2017.06.19.12.25.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 12:25:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/28] Create a reference backend for packed refs
References: <cover.1497534157.git.mhagger@alum.mit.edu>
        <xmqqzid3stdw.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 19 Jun 2017 12:25:07 -0700
In-Reply-To: <xmqqzid3stdw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 19 Jun 2017 11:51:39 -0700")
Message-ID: <xmqqvanrsru4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Is the iterator over packed-refs correctly skipping over what are
> covered by loose refs?  The entries in the packed-refs file that are
> superseded by loose refs should be allowed to point at an already
> expired object.

Here it is in a test form for easier diagnosis.

 t/t1408-packed-refs.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t1408-packed-refs.sh b/t/t1408-packed-refs.sh
new file mode 100755
index 0000000000..35533c8593
--- /dev/null
+++ b/t/t1408-packed-refs.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='packed-refs entries are covered by loose refs'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_tick &&
+	git commit --allow-empty -m one &&
+	one=$(git rev-parse HEAD) && 
+	git for-each-ref >actual &&
+	echo "$one commit	refs/heads/master" >expect &&
+	test_cmp expect actual &&
+
+	git pack-refs --all &&
+	git for-each-ref >actual &&
+	echo "$one commit	refs/heads/master" >expect &&
+	test_cmp expect actual &&
+
+	cat .git/packed-refs &&
+
+	git checkout --orphan another &&
+	test_tick &&
+	git commit --allow-empty -m two &&
+	two=$(git rev-parse HEAD) && 
+	git checkout -B master &&
+	git branch -D another &&
+
+	cat .git/packed-refs &&
+
+	git for-each-ref >actual &&
+	echo "$two commit	refs/heads/master" >expect &&
+	test_cmp expect actual &&
+
+	git reflog expire --expire=now --all &&
+	git prune &&
+	git tag -m v1.0 v1.0 master
+'
+
+test_expect_success 'no error from stale entry in packed-refs' '
+	git describe master >actual 2>&1 &&
+	echo "v1.0" >expect &&
+	test_cmp expect actual
+'
+
+test_done
