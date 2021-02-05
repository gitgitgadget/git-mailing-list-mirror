Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340F0C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5E164EE8
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhBEQnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 11:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhBEQk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 11:40:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA72BC061794
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 10:22:39 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f16so6737621wmq.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 10:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C6R78wCggJig/b9jMpwT9VHryu0qKW6zI6S7/k2ERS4=;
        b=PZprj07iqf6pTn6uscHDygKpNSPThfQunFbb1lq1QG8Y5GBLRmD/EpU7W8xlAvRKdU
         6vQSY+4OGXPHUdU3lmVpnQDLEzqYpTW3R/6DFqkWjokK8h+wkjtwVJ9Tgn0+G7LDJMPv
         Gh/5s8Tt6AR5OZpDPIOdUJISMJ3cWziQ2asvjmfJcOtwoCSONvsOXb8SldAiI7u+oRMZ
         /ZlupNjBM0hP6igor3glnCOo85RckQFdNxTRZymtOWBNrpVBIrWGAaIa2PJhRorJekL3
         knL4vR6ysyxQ3VLH1I6SBKjJVAuUeNaM5eWk1k2RFiVWH64v8HfwxgJ6LKwWj84QKUDp
         XBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C6R78wCggJig/b9jMpwT9VHryu0qKW6zI6S7/k2ERS4=;
        b=DcukTjN1z6sdwtnJsTbCBYaMN1mV5tczSZZ5plN2cbMZa7FitNrk9n1KlMmfXuYaVS
         Y3F2dTneQ69jMNKChInRNNpm1H6i43y5rUp8nZ6zAaYt6TAaEqeeW5S8HeSiEN5Ab992
         folGf8KAmFk0d+0Xn3PSkCt7l2y05nsjP9TJGHOMbyKgzy3KGtcfP+7O5dNvJfBSSPmM
         IU0uzLBgarll/2RQ15y5uAZv8DRZBjwuzov23YWVwGOd+5xp3/utlpUxkekjH6QfeeCY
         pk6I1atoUvww0nVR6LL2D3Lfale6CTFFTLuYLR7YF5b8Y4oVw8XMmQkyMcxvDhUkAwC1
         Mehw==
X-Gm-Message-State: AOAM5302p4ZsHkNxT0+/8Pg7IFABHCfYkZXmMKakrplBTzTwjVGs6xho
        cIh5MN4c64hBHZeI0rj9VT7KrhgjySc=
X-Google-Smtp-Source: ABdhPJyxWgkDQGhfQuy/shFUxpWR5F9cuwkSLN2PU3mnPPkSvGFEa2cMwFF7AC/VC4Xh/6DY31Lk9w==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr4663355wmc.100.1612549358245;
        Fri, 05 Feb 2021 10:22:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s64sm10054802wms.21.2021.02.05.10.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:22:37 -0800 (PST)
Message-Id: <c31d6e258fd06217326a899e74c5266c324e95dd.1612549349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
References: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
        <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 18:22:29 +0000
Subject: [PATCH v3 6/6] doc: use https links
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Ackermann <th.acker@arcor.de>,
        Thomas Ackermann <th.acker@arcor.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Ackermann <th.acker@arcor.de>

Use only https links for lore.kernel.org.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/technical/hash-function-transition.txt | 10 +++++-----
 t/t0021-conversion.sh                                |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 0c4cb98cd4e9..7c1630bf8324 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -781,7 +781,7 @@ Document History
 bmwill@google.com, jonathantanmy@google.com, jrnieder@gmail.com,
 sbeller@google.com
 
-* Initial version sent to http://lore.kernel.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com
+* Initial version sent to https://lore.kernel.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com
 
 2017-03-03 jrnieder@gmail.com
 Incorporated suggestions from jonathantanmy and sbeller:
@@ -823,8 +823,8 @@ Later history:
 
 References:
 
- [1] http://lore.kernel.org/git/CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com/
- [2] http://lore.kernel.org/git/CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com/
- [3] http://lore.kernel.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
- [4] http://lore.kernel.org/git/20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net
+ [1] https://lore.kernel.org/git/CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com/
+ [2] https://lore.kernel.org/git/CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com/
+ [3] https://lore.kernel.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
+ [4] https://lore.kernel.org/git/20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net
  [5] https://lore.kernel.org/git/CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com/
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index e4c4de5c7456..e828ee964c1b 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -34,7 +34,7 @@ filter_git () {
 # Compare two files and ensure that `clean` and `smudge` respectively are
 # called at least once if specified in the `expect` file. The actual
 # invocation count is not relevant because their number can vary.
-# c.f. http://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
+# c.f. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
 test_cmp_count () {
 	expect=$1
 	actual=$2
@@ -49,7 +49,7 @@ test_cmp_count () {
 
 # Compare two files but exclude all `clean` invocations because Git can
 # call `clean` zero or more times.
-# c.f. http://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
+# c.f. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
 test_cmp_exclude_clean () {
 	expect=$1
 	actual=$2
-- 
gitgitgadget
