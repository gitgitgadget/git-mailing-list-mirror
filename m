Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D03751F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeEaFC0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:02:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40390 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeEaFCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:02:25 -0400
Received: by mail-pg0-f65.google.com with SMTP id l2-v6so9142583pgc.7
        for <git@vger.kernel.org>; Wed, 30 May 2018 22:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hpSIl/c0oqnnF9c5LTKjyn/K1Tehrm4x2KJ7vUp8emI=;
        b=LRQP4oYUmBxvowRqQpa2KjhgeA/UWXygt3eQNoSf7CPnEUbb2IqMJw7xHeYX9QEmcF
         e7RbSzXDhRm9BqswBY4kxwADidccJG0cjcl2tLthfPAQE+V7mUdjPSpy8uh9qfFLuAxM
         TjQMAPC5iYwooblMs71M+TlgPmar9ZdOKcQeWx5lLZ+RYpoJt5DIS4El6laaMpo5nSeI
         fptxRGXY2693tUBTPylBuexv084oRlzI82PB/SSvB48z/t94aJE1WaQ3ya3LcRNeeq/k
         wQ0aBPyngOEHJ3C5sSN5oPHJFAiYo2k0cGaDkdTu9xGFk2KmoKPCKaP5406u0Hqbr6yq
         vDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hpSIl/c0oqnnF9c5LTKjyn/K1Tehrm4x2KJ7vUp8emI=;
        b=pdwCA111DhcE2E913EtosIRGoX/nFGE5OITqjlj+hQMHqHpyENhleY2XH1i/N0D9Pr
         NS07JMMhlrFECh2u2JVuTfbQiZXorG3FKabIwU1kSwd5OyoH0bpoRQhHzJVVycGG94ru
         y4/XY1/uGQZYNVE8nwB4wxxTncKa2t2SaugT/64tARZL95vjDBJW/v7TVH/7cpOH36GH
         jqwv0QEFlzdtthnUEExB2RxpAQ2v2TpihWqBQpmr3vFXjfHnuvQoAhPxz4mvyhvCB2ux
         SXGnYhvs9vgQ9pFUcsrUMx6jFCPKRFJIlZ6MHIde2Ljh5esWUcK1H+dLkpL+PwIQ9+sL
         5M7g==
X-Gm-Message-State: ALKqPwcPKbRzdbKQP9QSgICddk7tGd17q7VslvfxUuM2tatYTRu5BO4v
        YBnaWdCl9tBHjcHE0++U7h3Pt+sjPzk=
X-Google-Smtp-Source: ADUXVKK20OQ8u7fsqHyFRINVP/SqBgTiTh2QAlbsuwCGgltYbM+CV9GnKqzJ4rXoAf8MULFDsenAYQ==
X-Received: by 2002:a62:2281:: with SMTP id p1-v6mr5458567pfj.53.1527742944512;
        Wed, 30 May 2018 22:02:24 -0700 (PDT)
Received: from C02VT0RZHTDG.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id m18-v6sm47885687pgu.67.2018.05.30.22.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 22:02:23 -0700 (PDT)
From:   istephens@atlassian.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com, peff@peff.net,
        bturner@atlassian.com, jacob.keller@gmail.com,
        sunshine@sunshineco.com,
        Isabella Stephens <istephens@atlassian.com>
Subject: [PATCH v6 2/2] log: prevent error if line range ends past end of file
Date:   Thu, 31 May 2018 15:00:30 +1000
Message-Id: <20180531050030.43364-2-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180531050030.43364-1-istephens@atlassian.com>
References: <20180531050030.43364-1-istephens@atlassian.com>
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
 t/t4211-line-log.sh | 5 ++---
 2 files changed, 7 insertions(+), 6 deletions(-)

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
index d0377fae5..436b13ad2 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -60,7 +60,6 @@ test_bad_opts "-L 1:nonexistent" "There is no path"
 test_bad_opts "-L 1:simple" "There is no path"
 test_bad_opts "-L '/foo:b.c'" "argument not .start,end:file"
 test_bad_opts "-L 1000:b.c" "has only.*lines"
-test_bad_opts "-L 1,1000:b.c" "has only.*lines"
 test_bad_opts "-L :b.c" "argument not .start,end:file"
 test_bad_opts "-L :foo:b.c" "no match"
 
@@ -86,12 +85,12 @@ test_expect_success '-L ,Y (Y == nlines)' '
 
 test_expect_success '-L ,Y (Y == nlines + 1)' '
 	n=$(expr $(wc -l <b.c) + 1) &&
-	test_must_fail git log -L ,$n:b.c
+	git log -L ,$n:b.c
 '
 
 test_expect_success '-L ,Y (Y == nlines + 2)' '
 	n=$(expr $(wc -l <b.c) + 2) &&
-	test_must_fail git log -L ,$n:b.c
+	git log -L ,$n:b.c
 '
 
 test_expect_success '-L with --first-parent and a merge' '
-- 
2.14.3 (Apple Git-98)

