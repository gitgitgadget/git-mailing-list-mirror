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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A90EC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B0D64F77
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhBBQZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbhBBQW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 11:22:56 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A02C0611C2
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 08:19:20 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l12so1956962wmq.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 08:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OlGDqfHJfMcZpZUqydihqUUw8xk/hGiogY19dE95aKU=;
        b=deS8O8wUCDtm04d70IPvAIumkPa95qQWWy7b0xL60PtmnHQ6QHQXkIbIhZszusV0iN
         2mS5+xgqlRDPEX5Y0iPeJft6KC4yWIX6FrND2PW2bm3s1Js23pmq+4f4mB9ilOs8+bgd
         +UrGqaG49paDuGRN/7ff/6iYlDWtqFN8LBBiFaSPfV2RruCCPTFvcNrrzi2GO8q6N4HT
         AdQUGy4bqZrod2WOXRBTLrgBF0Ascu4QfO4VtlhPt4CS6HeY60CEQ0qTU2FXkKEZjnE5
         vr+6AAxbmxufRggxKJlvgNC6CWygLqL09/pv5Cc6Z5Ryhjy2y+zy9VQghkBLrji+fO66
         DXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OlGDqfHJfMcZpZUqydihqUUw8xk/hGiogY19dE95aKU=;
        b=P8Q3Dhd83VvQc+WIu43Okhm6WcnxFtoHOIOnSrnRBrnn3Lmxn7ZBf2tg5/FLeKKm//
         re0sedpFHMP4pbINhWB0REhnsdV6nw+GKdxJuCQ3f7jGe9ej3moV0jjjjWRgE+l6gd3v
         r6AOQ1cUq0x8gAAnqYphIfsBJLLxnpgA9yHNs8Ixh1cJ3KhI3QvQ4fgCuhUCGUQ51Vrk
         RS0Srak0vorP56DxtePtHeRAagHrk61n4PI8tnmK5w/ZCWQwz0EP4UdJeRxi5S8fAwQ9
         lDl3mxUOSCpH/M9gdFyhPsTWeXONbrrFS0wYD7bd3iGBVajZQ3UjQdX5QtyUBOthBQQa
         lu/Q==
X-Gm-Message-State: AOAM531ZjytmBlXqJvdEu0o73yTS0CzK9qtvcHF7nef/E/7UvbhXQLYj
        AiQ7q4ASxHHsh4yOMGqUTZbFMKNE2sg=
X-Google-Smtp-Source: ABdhPJyAPbqnrtnC1+4FelSfKht+OruFJhiLWdJgEkzp+7qhNOlRG+j5O4cRD/tDkdjNztRSuTcjKg==
X-Received: by 2002:a1c:6384:: with SMTP id x126mr4418761wmb.52.1612282759080;
        Tue, 02 Feb 2021 08:19:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm3754245wmq.17.2021.02.02.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:19:18 -0800 (PST)
Message-Id: <d6041b7e9e87d8830b9774c6cba5df824c33d9df.1612282749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
        <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 16:19:09 +0000
Subject: [PATCH v2 6/6] doc: use https links
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Thomas Ackermann <th.acker@arcor.de>,
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
index 475f2f501a6..e7e6bd95ff9 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -759,7 +759,7 @@ Document History
 bmwill@google.com, jonathantanmy@google.com, jrnieder@gmail.com,
 sbeller@google.com
 
-* Initial version sent to http://lore.kernel.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com
+* Initial version sent to https://lore.kernel.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com
 
 2017-03-03 jrnieder@gmail.com
 Incorporated suggestions from jonathantanmy and sbeller:
@@ -801,8 +801,8 @@ Later history:
 
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
index e4c4de5c745..e828ee964c1 100755
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
