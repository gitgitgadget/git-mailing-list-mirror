Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C4CC04A94
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 16:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGXQjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGXQjc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 12:39:32 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0FC10E7
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:39:24 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58419517920so3388017b3.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690216764; x=1690821564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0KiaF/CLP7zSv8Sfz2N3rqL/0xOaJKeZOnjfAPvMTv4=;
        b=TCnaEovoUKf7w3yHJOj34x7l/GSMTVGrDhOs114jdK0rcGnP/x/cl3zQ3qTKGSMHjl
         T1oQYb/714XejnzOZle49cjPW+U5lhpQDdln0oI5oE1s8FkBg/dsxsitxC0Ke5lnRIoH
         nKGKvLpqNvg3uGM65g8vwbck08egunGOoRSYp8y1MfMtD3bIydbqEDMzFCEGAOsoEWe5
         ElHve8jx/LXXnApE1d3SDz38vAqduF9y14vBxvw2ZRoZQwZyPj2TUhv5IV/dImbEA+EE
         Sa09OKddeMhSmalJrKikSVO7MmEcLaTnZ87kC0eA6vPQMcBuXlr7GN1HvmPs11U1Paon
         2Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216764; x=1690821564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KiaF/CLP7zSv8Sfz2N3rqL/0xOaJKeZOnjfAPvMTv4=;
        b=dclltnf4f3qRNuTp6kt/WpfzZ03tZ0HJ8RhPv+NaCh3EcpKfg/pQ1V/goXyDXkI6WM
         Wc8TYyqGP9GGrfFN6T/VDI589sBeAMuGmJ4vTtP/1k7N0MQupdU+OsGJUHwZ2sjg+4Vi
         sa471I1B+LPDt1tzTl0OtvM7mF87kUeFxJjZVJhEcc2Mcd3PEwg931xc1RSbRxCsxFpD
         U2aCSxhuLC+P9II+/wRiNnHvN1svtgbFt2tvwBw1RYfuIgLMoRZ0FvJ4AIwtIsySOKux
         fXJMIp3nPx0oVv2OPd/TWHQ+S91YVa6P/v8AGNRvlU5nWkQ+mp2wf9jBK1yYQJZsHuA7
         KUCA==
X-Gm-Message-State: ABy/qLb9CK+qf2+TIoxAyXeoJ2iB7RxPHoX47ZHoqfR5a9sNgANhL7ax
        c1XtPp+iBcknA27w4Ro/ldUOKveHkqGxCkL5zGqXng==
X-Google-Smtp-Source: APBJJlF4387dmRgmuWs07Tj1ODd2hpfUqdTxzQSjCzKXiC/+EKYv5zR+Up+Er4R8jgMcmaiZofkgUw==
X-Received: by 2002:a81:7385:0:b0:576:8dd5:8943 with SMTP id o127-20020a817385000000b005768dd58943mr7642131ywc.34.1690216763890;
        Mon, 24 Jul 2023 09:39:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a184-20020a8166c1000000b0057a4f54d390sm2891166ywc.79.2023.07.24.09.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:39:23 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:39:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/5] t/lib-commit-graph.sh: allow `graph_read_expect()` in
 sub-directories
Message-ID: <c81a059c1815a00fc0f5c7576814a830479483af.1690216758.git.me@ttaylorr.com>
References: <cover.1689960606.git.me@ttaylorr.com>
 <cover.1690216758.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1690216758.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `graph_read_expect()` function is used to ensure that the output of
the "read-graph" test helper matches certain parameters (e.g., how many
commits are in the graph, which chunks were written, etc.).

It expects the Git repository being tested to be at the current working
directory. However, a handful of t5318 tests use different repositories
stored in sub-directories. To work around this, several tests in t5318
change into the relevant repository outside of a sub-shell, altering the
context for the rest of the suite.

Prepare to remove these globally-scoped directory changes by teaching
`graph_read_expect()` to take an optional "-C dir" to specify where the
repository containing the commit-graph being tested is.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-commit-graph.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
index 5d79e1a4e96..4d3e7f0623e 100755
--- a/t/lib-commit-graph.sh
+++ b/t/lib-commit-graph.sh
@@ -32,6 +32,13 @@ graph_git_behavior() {
 graph_read_expect() {
 	OPTIONAL=""
 	NUM_CHUNKS=3
+	DIR="."
+	if test "$1" = -C
+	then
+		shift
+		DIR="$1"
+		shift
+	fi
 	if test -n "$2"
 	then
 		OPTIONAL=" $2"
@@ -47,12 +54,15 @@ graph_read_expect() {
 	then
 		OPTIONS=" read_generation_data"
 	fi
-	cat >expect <<- EOF
+	cat >"$DIR/expect" <<-EOF
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
 	options:$OPTIONS
 	EOF
-	test-tool read-graph >output &&
-	test_cmp expect output
+	(
+		cd "$DIR" &&
+		test-tool read-graph >output &&
+		test_cmp expect output
+	)
 }
-- 
2.41.0.399.g887006eab46

