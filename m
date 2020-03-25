Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE2FC54FCF
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C314420789
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRBBuwYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgCYPG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:06:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45856 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYPG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:06:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id j10so1143738pfi.12
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmWIKRsliB6qei1iFgIOmQDpdqR2nj9u0F+OOavpSw4=;
        b=gRBBuwYQMjmeETq2i1dlr2U6vDHNivx/rntWCn9RxHIEiGVxCZ6qEnyc0TsQnUeEPU
         RshqJ746HcRgeE/1QCDpKkA48VDWqNpNJUqq6FwETFHOegGUxedKWZvGH6MfX4a2PjDE
         8QtFxqHYl4roGWzbhtDngC59lHGyUG8eLA3j2g9snUuXNsDckdeTxkU+gELlSIAWhRNE
         pGN7OKlUWB9wd5iYoUfUrt4gU1gHbJm0YX+oG9FYPO9hEwUA4uoDUW74izMpo06aTLpK
         jXHoxjmpuZw2VyqPHdzLuv//7n1Qw+PoVUSRAUe0Mb28lhQumdRhesUDDe4pg9hvvRKG
         NtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmWIKRsliB6qei1iFgIOmQDpdqR2nj9u0F+OOavpSw4=;
        b=K3mea/13DQQ6DWQ7tTk0GfeFAtYSsEQoNN897TDKr7OVc/mTu3y7mh02D/z21l85aY
         epQDgOylGH9Ttu41vlNrn2z3N82BIt96zmRXenb+AWX+O4VFUEVel/SqsrWzTOBGNf4J
         Fe433ATbwfxo3GRzckeLS5sv8M3g596eAvAsvxYjohv+sO3SGvvSunqQn8Ewg/KKuazI
         35ZtKLi2AJiedlO5eN7AiHUm6dccY/9xNtByamsJauNqcN83SPzb7gPWhAvRg6jU+YDt
         iyCq4jhQPs0irB14dh7bdOvUf8M+js2yQ/HDBFqvMv2onVQdrKjHcq+FGz9pdiGkxmA7
         tRow==
X-Gm-Message-State: ANhLgQ0UfeHCrbodEnv3vx6k1VRVFmSe+Jle8ZeE5Kf8qJFg0FY5wkxP
        ubtiN8AebqgnBNgAG08ix0fEPfZK
X-Google-Smtp-Source: ADFU+vu+Nx1hT3Cjj/opA2X3f7JZuK+noXA+MXnqIuEbi1Lpt7QWU0a+HjwENS/6BGbhnIt9Guu4DQ==
X-Received: by 2002:a62:502:: with SMTP id 2mr3920395pff.324.1585148816685;
        Wed, 25 Mar 2020 08:06:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id f127sm18232538pfa.112.2020.03.25.08.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:06:56 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 2/8] test-lib-functions: test_cmp: eval $GIT_TEST_CMP
Date:   Wed, 25 Mar 2020 22:06:15 +0700
Message-Id: <691d9d47ba1495d68c9506cd6600267b38afdd85.1585148327.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585148327.git.congdanhqx@gmail.com>
References: <cover.1585148327.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shell recognises first non-assignment token as command name.
With /bin/sh linked to either /bin/bash or /bin/dash,
`cd t/perf && ./p0000-perf-lib-sanity.sh -d -i -v` reports:

> test_cmp:1: command not found: diff -u

Using `eval` to unquote $GIT_TEST_CMP as same as precedence in `git_editor`.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 352c213d52..ab0e47ae17 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -905,7 +905,7 @@ test_expect_code () {
 # - not all diff versions understand "-u"
 
 test_cmp() {
-	$GIT_TEST_CMP "$@"
+	eval "$GIT_TEST_CMP" '"$@"'
 }
 
 # Check that the given config key has the expected value.
-- 
2.26.0.rc2.357.g1e1ba0441d

