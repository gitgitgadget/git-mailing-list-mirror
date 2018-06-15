Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B451F403
	for <e@80x24.org>; Fri, 15 Jun 2018 06:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933597AbeFOG34 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 02:29:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34876 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932425AbeFOG3y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 02:29:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id 15-v6so3997171pge.2
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 23:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D4+2VTmBQOiybIOA/b8s+2YeswrpMRn6ToIaiRS/Pe0=;
        b=eJeV/l34sFarD8ht+CvNhXv6H3D7qujcMHMj9mUPns7sbdkl+An3wX6GRIKLTC3Sd2
         yw9DZSU+zmzX08gaCnuxevdZFxJ727Dp1ySy0XbUlR47Pji69CPhfLGPU4fYRItzqTvo
         oVBeryVVbGd8OK2etB4xVBf7TJmNVFA+iGnvErVGNYYaCmKNk6pko3a3aU12x5iij4H3
         vS/6ulJz9CENDZZhLv9QwM4+BRAPKxIemwGGgHKzRyByrSUXCf7epVpG28/jgNOmFQ7y
         KNYK4i4FS4vMQ6xUZXgKNtPA3xfKLGTrYgFA5QUQjgUD3CV39ii2JWsdCELavWweNwkk
         wiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D4+2VTmBQOiybIOA/b8s+2YeswrpMRn6ToIaiRS/Pe0=;
        b=BqrM2BC4ma3zgU7il7C3AILnw/z4MH3zXCu6JwG/WvYC47snIGiKN3o+N7kNaeOu8U
         M5/wIRj6M8Jnq2xB/ijJFVxlFXk1EfAEOQRtdglqF7sqqFAT2ZY7RrYsrVtoMxNG4WyU
         Dgapja1J0yLTRGOOF/KgzEJW14M3Dy3EBkL6eI2YSemXOGmaOFAW/U8p3GaDqSlU8cEo
         DY2MgFM5XP0DaMPeX3eumIeoZgIgXnLM9dpo8f848BghmPxRhE2ruPfpcPEXDJVw2xN9
         SGe4uxG9eUTNdEQE+RbuVpMe5ftSkAqaUhZEBCxbjvSSE6W7GGQ3OiNaPt5Npr/CXeZD
         NmmA==
X-Gm-Message-State: APt69E0+RZ0EIii/dd1TVYYo3GkYa7BuvhmaX3kZT8a6BueWqbNJ6PbV
        pvu8eTZZfI+M2NAJ4Ey7bwsy6w==
X-Google-Smtp-Source: ADUXVKJlz+OHr/3HxaRXcharkAv14ft89KiZxdIxxVPzaVSOeNvpvZuqOPURb9cSmilGsDdopMqeRA==
X-Received: by 2002:a65:6319:: with SMTP id g25-v6mr349171pgv.437.1529044194410;
        Thu, 14 Jun 2018 23:29:54 -0700 (PDT)
Received: from C02VT0RZHTDG.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id k12-v6sm8498419pgo.31.2018.06.14.23.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 23:29:53 -0700 (PDT)
From:   istephens@atlassian.com
To:     gitster@pobox.com
Cc:     szeder.dev@gmail.com, git@vger.kernel.org, peff@peff.net,
        bturner@atlassian.com, jacob.keller@gmail.com,
        sunshine@sunshineco.com,
        Isabella Stephens <istephens@atlassian.com>
Subject: [PATCH v7 2/2] log: prevent error if line range ends past end of file
Date:   Fri, 15 Jun 2018 16:29:28 +1000
Message-Id: <20180615062928.37165-2-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180615062928.37165-1-istephens@atlassian.com>
References: <xmqqh8mnb8j2.fsf@gitster-ct.c.googlers.com>
 <20180615062928.37165-1-istephens@atlassian.com>
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
 line-log.c          | 4 ++--
 t/t4211-line-log.sh | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/line-log.c b/line-log.c
index cdc2257db..8ad074e58 100644
--- a/line-log.c
+++ b/line-log.c
@@ -599,11 +599,11 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 				    lines, anchor, &begin, &end,
 				    full_name))
 			die("malformed -L argument '%s'", range_part);
-		if (lines < end || ((lines || begin) && lines < begin))
+		if ((!lines && (begin || end)) || lines < begin)
 			die("file %s has only %lu lines", name_part, lines);
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

