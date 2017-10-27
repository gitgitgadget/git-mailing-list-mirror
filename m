Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6294A202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 00:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932398AbdJ0A5B (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 20:57:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:50033 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdJ0A5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 20:57:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id i5so3730102pfe.6
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 17:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Mft1sqGy2QLR4Gh+jGqtV3RKKLv0heVsQKHZVecyCU=;
        b=vJ9Yx3jk5cj00UjOD+DetSodTwP3tAa5EroIgAXyGRl+oqfe4nyqx3jXbP6I6qpXUR
         8+YoU5Of+L10NyDR3Seuejl5GiJjHCL2W4e5I5jl4dWpaM1iSLgsgkBYstcmqAPFzaPK
         +fU5HssQsw7GFNpPZtuS2fn7rX4vOTtPshpgVIpSiF3+jDAiXsCtuvme0/k0M1BYxyTR
         fZlfFVyyT7vOdxofcc/QOFmGGl1V1Qp4Ecsws/CnXx6tcSQe26/PZVU/7T2WzrPOKo6S
         ZWA3sVrGT9lCym0fNqLvuii0mNrXcZ37V6PgeVycylBbR98Ix9LcHTB0BHSsyClrSTlx
         Cfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Mft1sqGy2QLR4Gh+jGqtV3RKKLv0heVsQKHZVecyCU=;
        b=Y60eeh5izI11AOmFnzmn/QIA9kWvISojjxc86Gud1t8zopF3Phxdgrqt9igdEOMjXj
         HpkfK0GmKfCN08LCIbuv9/2NSnk6isBXdrm2BE062K1IeagEwmQwuhp/aN1frI3elXC9
         6yfQfpxiXBSSgBpGYEVKQYe+I1kswW0Ry6JH2DkBcJ9IeoNgv8ADOjLmOi32BPpyb/wG
         bX1VI/d6/tBztBEHBFIb8U24xNf3o47B+vZIxQp0gZY++XhpW9ri/1I7K8AOI0nG1Ihz
         EDOJtJKDMpANk9z+FxIrTO5GOwTGJ3tU5Z/JOnC9OAOGf0f1JDxiursWXAVSfRII12un
         83uw==
X-Gm-Message-State: AMCzsaUdGgkt+16L6NTzH0mSiP73xVTFOcE5kpFYKj8bRELbGeKovOY+
        fHCBHYrvU+E/ZlMXdsi329KGjg==
X-Google-Smtp-Source: ABhQp+RkWAa8tvFteceOZr+1h1tQMWraKuArlgn1QFNkxoPNejlSmKcUV1CGui5EcmugQb4TDX8Rqg==
X-Received: by 10.101.73.136 with SMTP id r8mr6558233pgs.411.1509065820108;
        Thu, 26 Oct 2017 17:57:00 -0700 (PDT)
Received: from CLI-30675.office.atlassian.com ([103.233.242.9])
        by smtp.gmail.com with ESMTPSA id h186sm11170205pfe.66.2017.10.26.17.56.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 26 Oct 2017 17:56:59 -0700 (PDT)
From:   Isabella Stephens <istephens@atlassian.com>
To:     szeder.dev@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
        bturner@atlassian.com, gitster@pobox.com, jacob.keller@gmail.com,
        Isabella Stephens <istephens@atlassian.com>
Subject: [PATCH v3] blame: prevent error if range ends past end of file
Date:   Fri, 27 Oct 2017 11:56:52 +1100
Message-Id: <20171027005652.7796-1-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20171026153111.21813-1-szeder.dev@gmail.com>
References: <20171026153111.21813-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the -L option is used to specify a line range in git blame, and the
end of the range is past the end of the file, at present git will fail
with a fatal error. This commit prevents such behavior - instead the
blame is displayed for existing lines within the specified range.
Blaming a range that is entirely outside the bounds of the file will
still fail.

This commit also ammends the relevant test and adds clarification to
the documentation.

Signed-off-by: Isabella Stephens <istephens@atlassian.com>
---
 Documentation/git-blame.txt   | 10 ++++++++++
 builtin/blame.c               |  4 ++--
 t/t8003-blame-corner-cases.sh |  7 +++----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index fdc3aea30..8a28b4114 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -154,6 +154,16 @@ Also you can use a regular expression to specify the line range:
 
 which limits the annotation to the body of the `hello` subroutine.
 
+A range that begins or ends outside the bounds of the file will
+blame the relevant lines. For example:
+
+	git blame -L 10,-20 foo
+	git blame -L 10,+20 foo
+
+will respectively blame the first 10 and last 11 lines of a
+20 line file. However, blaming a line range that is entirely
+outside the bounds of the file will fail.
+
 When you are not interested in changes older than version
 v2.6.18, or changes older than 3 weeks, you can use revision
 range specifiers  similar to 'git rev-list':
diff --git a/builtin/blame.c b/builtin/blame.c
index 67adaef4d..b5b9db147 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -878,13 +878,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				    nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path))
 			usage(blame_usage);
-		if (lno < top || ((lno || bottom) && lno < bottom))
+		if ((lno || bottom) && lno < bottom)
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
 			       lno), path, lno);
 		if (bottom < 1)
 			bottom = 1;
-		if (top < 1)
+		if (top < 1 || lno < top)
 			top = lno;
 		bottom--;
 		range_set_append_unsafe(&ranges, bottom, top);
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 661f9d430..728209fa3 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -216,14 +216,13 @@ test_expect_success 'blame -L with invalid start' '
 '
 
 test_expect_success 'blame -L with invalid end' '
-	test_must_fail git blame -L1,5 tres 2>errors &&
-	test_i18ngrep "has only 2 lines" errors
+	git blame -L1,5 tres >out &&
+	test_line_count = 2 out
 '
 
 test_expect_success 'blame parses <end> part of -L' '
 	git blame -L1,1 tres >out &&
-	cat out &&
-	test $(wc -l < out) -eq 1
+	test_line_count = 1 out
 '
 
 test_expect_success 'indent of line numbers, nine lines' '
-- 
2.14.1

