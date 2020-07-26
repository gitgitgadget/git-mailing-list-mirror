Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC93C433E4
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 14:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBEF20714
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 14:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhOsL4Wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgGZO0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGZO0V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 10:26:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED11C0619D2
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 07:26:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so7976707pgh.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whHTi2PgYuIlHWf9MWsZT104mUeL4Ulx6vg3RpDG9VI=;
        b=GhOsL4Wd92qb1d5q3m9LGo40VnDfdKPbY9+cqVZ6i6KWaj8PJbzvbOWeo5YjXlDBNs
         jHC99nx3SQHJ/E6xuoxk8xNr1puEysProGNWR1kJHLzBu52DJZUKIbGFG7CavmMHtT0u
         TcwsOLYeGphoowQt62i+Ks1SR06BvGmmdNY2/zKl9PJeLSD0a6OZ/O7T2zAVkX33x0zP
         D0YH+DfliKlQ58ATwFSVPkI6lVroNZtWnAr/PM5xADEiAbhVynAhU7PaC+9rZpW1zB1+
         t8cCpJaXf2FKEo07Jv4oeBJhJL9nKVXXY6A4tspn6h8xyTTEa4SiUXtq/nUJqgeTPcVY
         OZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whHTi2PgYuIlHWf9MWsZT104mUeL4Ulx6vg3RpDG9VI=;
        b=KZokROkpnNpByqsVSeFrmVhimDJW06D98UEykhTE3H6msItyCJ6M6reZJSmhwyiV7G
         JkSfCStyqbW4vyAJsbBGKf/rg02yZq32o0A/J6TxyNHH+8GIbKpR+h3HZkVSf8WARKqY
         xVjPTfuHwiDnUbFUY7N0iVl3D8b9YerLP0hEJO9xnkMdNr2kabu9KPqr5OhjqXSGcL0i
         zhfh+vWmZ4Vs0ssxGOYcMw1dqaMxE1jvUmcu0xM0RFIZKNHUln4q4vDmyLntI1OZh7Wj
         wUjGxYjCtzBcpcYEFTFz5nnFB5Xv8wLYsa3R9+vXdA89X9PF84NLLeqZu/I+2wdCwLdm
         no2w==
X-Gm-Message-State: AOAM532lO80ujKEhpY8rDhh3XoSc44i5a0xXoed5wEB+UFlMK18kAz3a
        g6D4qKr2+tVTsG1O+ACiU6wiQZNGfCY=
X-Google-Smtp-Source: ABdhPJyY1Jbfb+vFl1PncWI1WP4+yewLprKNDx0EKe8WK/o/D/1oQCv/u3vK658c/+l0ooUi/V9U6A==
X-Received: by 2002:aa7:93c3:: with SMTP id y3mr16488523pff.206.1595773580714;
        Sun, 26 Jul 2020 07:26:20 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.48])
        by smtp.gmail.com with ESMTPSA id p11sm11278908pjb.3.2020.07.26.07.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:26:19 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, peff@peff.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [PATCH 3/4] t7401: ensure uniformity in the '--for-status' test
Date:   Sun, 26 Jul 2020 19:55:52 +0530
Message-Id: <20200726142553.42545-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726142553.42545-1-shouryashukla.oo@gmail.com>
References: <20200726142553.42545-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '--for-status' test got its expected output from stdin. This is
inconsistent with the other tests in the test script which get their
expected output from a file named 'expected'.

So, change the syntax of the '--for-status' test for uniformity.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 18fefdb0ba..145914cd5a 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -285,13 +285,14 @@ EOF
 
 test_expect_success '--for-status' "
 	git submodule summary --for-status HEAD^ >actual &&
-	test_i18ncmp actual - <<EOF
+	cat >expected <<-EOF &&
 * sm1 $head6...0000000:
 
 * sm2 0000000...$head7 (2):
   > Add foo9
 
 EOF
+	test_i18ncmp expected actual
 "
 
 test_expect_success 'fail when using --files together with --cached' "
-- 
2.27.0

