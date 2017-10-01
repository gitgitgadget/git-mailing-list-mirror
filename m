Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC6BD20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 16:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdJAQTB (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 12:19:01 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:52507 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdJAQS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 12:18:59 -0400
Received: by mail-pf0-f174.google.com with SMTP id p87so1845316pfj.9
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CzQaJqa5X96wm+8XIbvcj4u4AYRt7ySHPDeSn5r0FJM=;
        b=oiQZSQNcgo0SsH4RAydUKn+QKTzGz26TRMaxaW9f74oq+DFBe64fP8nupDnJGyE8dq
         3wLTvzPJImsG7BJq1nUqbFJvH2qcxDbbrBQRLqAuLFd1mk2gdY6mWzhut8zfhXMPsMKT
         G+4X747WRqJUv7YCymdn8WsmdgHciuRfLCNN4UJP2Xnpb7jt/mSNmITTDIpPSpv/NF8X
         HRYuOq0eZ1OoskkM5aEGR7y8V6BgSz8ljH14TZB6FlfEONsCxlGbefOyaNisN84NfBiZ
         5VsPHr2Yzkx0Ced2QMbfjXHxJ8SntdSWa6NWUtmgORJDFh41r0St+0VRMIUMdl/KHMfP
         C4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CzQaJqa5X96wm+8XIbvcj4u4AYRt7ySHPDeSn5r0FJM=;
        b=TiCQcVYTA210Un/RV9zh2v2lb1kvPBlzACgaokBUsoT/4ZHWYdSTV4uIdzi23T/zSu
         HXFEfJudZpPA994d9bi7G5xtNoDeskoILE9XCMLbwMNJbyhC54W180waPUpcFLTMXey6
         yKYKoE6O9OGr0CQUiz5doT+iwCO7NFwAuL7OLu0+37VsiJLyblkPzk3olttGOrd8DSME
         exu3Ktd59ftYF1u0pBXl9IdGM1H03biw0NwpNwotH9/4bBNw+oIxdCEDhV3191wi5MPS
         KEa+vaLzReJPYGJFauNO9NLhgoraH+QuQVXodaL+Q2nOZoN+CLCPiUw5DvQkRhIWMxnt
         u6LA==
X-Gm-Message-State: AHPjjUgCx/+D9FMMTzFCk27J1P0p4lDbYtAPXv/O5BnObvGkie5O61C1
        dC5E9MuqE+kZtspqacOiC4Rf94Q9BPk=
X-Google-Smtp-Source: AOwi7QB62I8Kyn6lFUkawOMwg87E7jwvc4d2WlGbvP9Cz43n0er7NVTS+g45aF8pieba01ULbcGRWQ==
X-Received: by 10.159.204.147 with SMTP id t19mr12086336plo.242.1506874738332;
        Sun, 01 Oct 2017 09:18:58 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id e13sm13565135pgt.14.2017.10.01.09.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 09:18:57 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 2/6] t6300: refactor %(trailers) tests
Date:   Sun,  1 Oct 2017 09:18:48 -0700
Message-Id: <20171001161852.84571-2-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171001161852.84571-1-me@ttaylorr.com>
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161852.84571-1-me@ttaylorr.com>
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

