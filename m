Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8913202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbdJBFZl (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:25:41 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:52371 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdJBFZj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:25:39 -0400
Received: by mail-pf0-f170.google.com with SMTP id p87so2392871pfj.9
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CzQaJqa5X96wm+8XIbvcj4u4AYRt7ySHPDeSn5r0FJM=;
        b=edUfbZprmDsHDISi6vu9fBl7nfhSPRkKgWB8xRsUV3lcAHBkCm51bz8lqeco2zERLY
         84S6SYY1BqsT7UL9tm5VRv3xXu4P673trJ5u9TvDZlGEhGa1enjlEz2WfJGd7S0ZflXl
         Reo2oKzCsNOZH5rFUfOZQC9Z1Rbk0BHitj7Hm3GOb5WpFVmHeJCzf6f9aZAF3vYqIqnq
         cVVE0PySq3OqMmCpyTu18brsDvay5Gt7OcqG4y4+jArNhJWTg40XKHja5tnd7RHOi1sS
         37FfWb44tYycLc1mzS6cYGqlJgV9WrFS7IXYzci8+ExyBzpiS9SynIkobdYNGGlg5wNE
         oTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CzQaJqa5X96wm+8XIbvcj4u4AYRt7ySHPDeSn5r0FJM=;
        b=jDu9LLXR9zpjChwxzoFSHimzycI1udCdx0kpYGTB9CaPVECofYuMOCZDNdOfxKFMXo
         GD0BeZcJdP/Helts7XZrkcNIyRnzra9BewDGw7OrNrtEQuvM6bhV88HS5ELFyT6F2n0/
         7WVoYGtwzVPRrLc7JROzF5C/+e50YQsavejjoEza9h0kbAZ1ppTda2uKPCtvYc2JJEGy
         CwtLeVOvj/TrOP/P3UAuC1GL6SABMoS9cv8NbkLN1AilnISdLxU+JkXkiR4oomQuvTOt
         WkstxdlsvM1s5U66v2ztjT+v/FRttJxA6EqMEB6kE2TTfdBc8oM9ZzcPqri35bW4/VXj
         IXug==
X-Gm-Message-State: AHPjjUg4fnMITbt011pwnFgnBc8oBC3akUDHvbz5WpsSikEG0ET8LODw
        A+KC+dyQZsW/HSCSznk6oBwGarJHAmA=
X-Google-Smtp-Source: AOwi7QB777guCsx0PPDHDY0bUBmA52AMeFGDVEUpZ92kyNAhSdtvDi0SzserAuWrogQvHqa9FI/JHQ==
X-Received: by 10.84.196.164 with SMTP id l33mr13212912pld.331.1506921937578;
        Sun, 01 Oct 2017 22:25:37 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id m7sm9127548pga.62.2017.10.01.22.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:25:36 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v6 5/7] t6300: refactor %(trailers) tests
Date:   Sun,  1 Oct 2017 22:25:22 -0700
Message-Id: <20171002052524.12627-5-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002052524.12627-1-me@ttaylorr.com>
References: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002052524.12627-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently have one test for %(trailers) in `git-for-each-ref(1)`,
through "%(contents:trailers)". In preparation for more, let's add a few
things:

  - Move the commit creation step to its own test so that it can be
  re-used.

  - Add a non-trailer to the commit's trailers to test that non-trailers
  aren't shown using "%(trailers:only)".

  - Add a multi-line trailer to ensure that trailers are unfolded
  correctly using "%(trailers:unfold)".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t6300-for-each-ref.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2274a4b73..39431908d 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -605,18 +605,25 @@ test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 cat >trailers <<EOF
 Reviewed-by: A U Thor <author@example.com>
 Signed-off-by: A U Thor <author@example.com>
+[ v2 updated patch description ]
+Acked-by: A U Thor
+  <author@example.com>
 EOF
 
-test_expect_success 'basic atom: head contents:trailers' '
+
+test_expect_success 'set up trailers for next test' '
 	echo "Some contents" > two &&
 	git add two &&
-	git commit -F - <<-EOF &&
+	git commit -F - <<-EOF
 	trailers: this commit message has trailers
 
 	Some message contents
 
 	$(cat trailers)
 	EOF
+'
+
+test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
 	# git for-each-ref ends with a blank line
-- 
2.14.1.145.gb3622a4ee

