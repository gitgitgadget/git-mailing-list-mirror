Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54502C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E0C22CA1
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgLUFKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgLUFKc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 00:10:32 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834DEC0613D3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:10:03 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z21so5657801pgj.4
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehU8XnrL0L62/aJROAL8CR76AuZ7UcEFZvkuwPcrqGs=;
        b=THAkGRXfz3tZhawNPFWVIo806bj8xFblvx9lDhc+QP6ZHpoqPZjQ84su/GthzF3z2L
         gDr61dbDYJ+oEvKgKIuRT2RwHuRlwxWQE+JDE0F711jqKi5BZ5/FKvslWF4XVD9X6+TB
         T9Dlo62Jyqzx2p/R93LzLEDGaEaLzC/deAaFrAYqZ9oZFN3cCGUwNVHLJdY2H9pcYf68
         NUC7uf0pqWkMNgDPNulyBJdawEmzF02BNLapKnRkcHOO4WjSIXwmakLCdPEymBoCJn+I
         xZVlnmTmK+RfAOko15tcm40oOhnrHJfv35qzWj5b8+H40ZIc88PzeU2gHihF07Wyeth5
         jOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ehU8XnrL0L62/aJROAL8CR76AuZ7UcEFZvkuwPcrqGs=;
        b=uC6NeIxLzFsvyJVCFSrE76QHXKYkbJCpZPzEJbsmMdGNdIZn8xP0ZSdN/jFWvIXpHy
         3acttAbxzkRFzykS5wMS2cxQvPTDWJxmxO+x+hMD940rUfnwbbF8JWqoQs48O32s8C6o
         n0H9xhLILGQXUp8bKExN4ngMaqw2owy2wFszwrT/xWgACGtcYIqBJDkZu7oZi/67eeDb
         m6l6kTCaEKGfOUTgeok3yp/n0DQ8hIIuAXOsaQKOU4ZbZuzS4722UoDvgrGjJhqJyeFR
         kD5xUYfHcbPQAubopcXNyw/u2QwjY8xW4QWmyjDjX9lYCctMQVnfzTjm9iL/aWmHcup+
         tBVQ==
X-Gm-Message-State: AOAM533xhnw1NVvVUzztQASJMx9PJrL3zAEajGJy/PkUWmibbHgta2H3
        nLSrjAnxMzrem83fiQrEdUedq8LZGvtCHQ==
X-Google-Smtp-Source: ABdhPJxfcafX+CHL9zybVev8dH2keTdE3yhGiWESEWpm1XjThg2xzvJ4w5K0+uEv5aDzCts2HLzr0Q==
X-Received: by 2002:a05:6e02:4ae:: with SMTP id e14mr13541972ils.132.1608499704869;
        Sun, 20 Dec 2020 13:28:24 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id g2sm11872575ilh.41.2020.12.20.13.28.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Dec 2020 13:28:24 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Sangeeta <sangunb09@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/1] t/perf: avoid unnecessary test_export() recursion
Date:   Sun, 20 Dec 2020 16:27:40 -0500
Message-Id: <20201220212740.44273-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.30.0.rc1.243.g5298b911bd
In-Reply-To: <20201216073907.62591-1-sunshine@sunshineco.com>
References: <20201216073907.62591-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test_export() has been self-recursive since its inception even though a
simple for-loop would have served just as well to append its arguments
to the `test_export_` variable separated by the pipe character "|".
Recently `test_export_` was changed instead to a space-separated list of
tokens to be exported, an operation which can be accomplished via a
single simple assignment, with no need for looping or recursion.
Therefore, simplify the implementation.

While at it, take advantage of the fact that variable names to be
exported are shell identifiers, thus won't be composed of special
characters or whitespace, thus simple a `$*` can be used rather than
magical `"$@"`.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is a follow-up to [1] as discussed in [2]. It applies cleanly atop
'es/perf-export-fix' and 'master'.

[1]: https://lore.kernel.org/git/20201216073907.62591-1-sunshine@sunshineco.com/
[2]: https://lore.kernel.org/git/CAPig+cR+4Wh4Sgk6UhUML4SHqaQsvYmw_77ih+oec2YmqQJCCg@mail.gmail.com/

t/perf/perf-lib.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 22d727cef8..e385c6896f 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -147,10 +147,7 @@ test_run_perf_ () {
 	"$GTIME" -f "%E %U %S" -o test_time.$i "$SHELL" -c '
 . '"$TEST_DIRECTORY"/test-lib-functions.sh'
 test_export () {
-	[ $# != 0 ] || return 0
-	test_export_="$test_export_ $1"
-	shift
-	test_export "$@"
+	test_export_="$test_export_ $*"
 }
 '"$1"'
 ret=$?
-- 
2.30.0.rc1.243.g5298b911bd

