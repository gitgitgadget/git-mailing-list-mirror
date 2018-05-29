Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133221F42D
	for <e@80x24.org>; Tue, 29 May 2018 05:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeE2Fbq (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 01:31:46 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42333 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeE2Fbp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 01:31:45 -0400
Received: by mail-pg0-f67.google.com with SMTP id p9-v6so6066477pgc.9
        for <git@vger.kernel.org>; Mon, 28 May 2018 22:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rvog+tlCRN+ssK65X9jv58qtNWdfYdUn10pxEvQhVE8=;
        b=S4S78cCayB7aodwfv58A95lV7ISYUNjxGYV50wUqWJEBV5qaP/F6fusvW1H06n+Bv+
         hRvqS3MU4R+jl3uxxVSsjnwOYYX2Nqi6kZdI6s57KaegM7lx2mayPH0ccpfi7tMSuyp1
         VeGVxhAzADvJX0m60y661GrC2dEhpFodeovSASGqS4kM0ZKG7z8HAtX2Jq1j60NVaILj
         lmlgFr81rnwRIo+TI20eDcIHHFgHV7exsjgRVp3M6um59R/agUrfzEs1s7t8RleRIwa/
         bufBzGAu7zA51f9zAV24BoRAVVNSxu5uBB3Y8RqrCzfGVsyxuaWLYcRiGUO6kSJgW3Eb
         ZLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rvog+tlCRN+ssK65X9jv58qtNWdfYdUn10pxEvQhVE8=;
        b=U6dU+B/EGB4u+8zoeyXenHtZydP3Eq9HlaJ0AvQqUDVT6tO3jsHcaKoTBBgPUcyu6E
         PiIjkdQ/CB247CAmLtfCyDu1KskdeknotuD7dWmhlJuhYtKN6bUgZAXD6huNpc0Db+80
         VGO01qnh76q79KTAc5KwL2U8tf0gJZan/mPJjfYXEtTilhbUgAAcZVRcURzuzF48KO9o
         bBCk9257viIREhdTxcPTpgW5Nr6LGxRv0tdZ4xARBWhZaodp7+CKe5sK1OI4atQ529yu
         Y1XY3cUrbBBbnoGWH+MVJzIYCZdo8zRqi2tmiCBD10t/i6S3qjmQ4O3CoeAlcvIDkkI7
         wNLQ==
X-Gm-Message-State: ALKqPwfdggl0/oyBqIUHT4imkCSGzEm7stzRikvYPfDHwGxOA7CsRmy/
        ouaWw/VQ0Eqt7oxbpN75Y8JluA==
X-Google-Smtp-Source: AB8JxZoLHoMgsKFRBBd2rXbFpBDfUpnSVA6YZzgh8CBWvEPCtrSQvF3jbe6QCsuyFuGS+S7+Hoz+uw==
X-Received: by 2002:a63:7f4e:: with SMTP id p14-v6mr12520932pgn.27.1527571905348;
        Mon, 28 May 2018 22:31:45 -0700 (PDT)
Received: from C02VT0RZHTDG.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id 23-v6sm80866291pfs.147.2018.05.28.22.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 May 2018 22:31:44 -0700 (PDT)
From:   istephens@atlassian.com
To:     gitster@pobox.com
Cc:     szeder.dev@gmail.com, git@vger.kernel.org, peff@peff.net,
        bturner@atlassian.com, jacob.keller@gmail.com,
        Isabella Stephens <istephens@atlassian.com>
Subject: [PATCH] log: prevent error if line range ends past end of file
Date:   Tue, 29 May 2018 15:30:37 +1000
Message-Id: <20180529053037.38015-3-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180529053037.38015-1-istephens@atlassian.com>
References: <xmqqzi1iwz7l.fsf@gitster-ct.c.googlers.com>
 <20180529053037.38015-1-istephens@atlassian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Isabella Stephens <istephens@atlassian.com>

If the -L option is used to specify a line range in git log, and the end
of the range is past the end of the file, git will fail with a fatal
error. This commit prevents such behaviour - instead we perform the log
for existing lines within the specified range.

This commit also fixes a corner case where -L ,-n:file would be treated
as a log over the whole file. Now we treat this as -L 1,-n:file and
blame the first line of the file instead.

Signed-off-by: Isabella Stephens <istephens@atlassian.com>
---
 line-log.c          | 8 +++++---
 t/t4211-line-log.sh | 8 +-------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/line-log.c b/line-log.c
index cdc2257db..4da40dec1 100644
--- a/line-log.c
+++ b/line-log.c
@@ -599,11 +599,13 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 				    lines, anchor, &begin, &end,
 				    full_name))
 			die("malformed -L argument '%s'", range_part);
-		if (lines < end || ((lines || begin) && lines < begin))
-			die("file %s has only %lu lines", name_part, lines);
+		if ((!lines && (begin || end)) || lines < begin)
+			die(Q_("file %s has only %lu line",
+				   "file %s has only %lu lines",
+				   lines), name_part, lines);
 		if (begin < 1)
 			begin = 1;
-		if (end < 1)
+		if (end < 1 || lines < end)
 			end = lines;
 		begin--;
 		line_log_data_insert(&ranges, full_name, begin, end);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index d0377fae5..c617347c4 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -60,7 +60,6 @@ test_bad_opts "-L 1:nonexistent" "There is no path"
 test_bad_opts "-L 1:simple" "There is no path"
 test_bad_opts "-L '/foo:b.c'" "argument not .start,end:file"
 test_bad_opts "-L 1000:b.c" "has only.*lines"
-test_bad_opts "-L 1,1000:b.c" "has only.*lines"
 test_bad_opts "-L :b.c" "argument not .start,end:file"
 test_bad_opts "-L :foo:b.c" "no match"
 
@@ -86,12 +85,7 @@ test_expect_success '-L ,Y (Y == nlines)' '
 
 test_expect_success '-L ,Y (Y == nlines + 1)' '
 	n=$(expr $(wc -l <b.c) + 1) &&
-	test_must_fail git log -L ,$n:b.c
-'
-
-test_expect_success '-L ,Y (Y == nlines + 2)' '
-	n=$(expr $(wc -l <b.c) + 2) &&
-	test_must_fail git log -L ,$n:b.c
+	git log -L ,$n:b.c
 '
 
 test_expect_success '-L with --first-parent and a merge' '
-- 
2.14.3 (Apple Git-98)

