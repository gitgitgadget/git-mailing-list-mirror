Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F044E207DF
	for <e@80x24.org>; Wed, 14 Sep 2016 06:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbcINGlA (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 02:41:00 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:45036
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752028AbcINGk7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Sep 2016 02:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1473835257;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=qlIUaNLF54t83gaQ0QjiViqgDU0gsOB/1W0IcFjKbnY=;
        b=RiUxD0S95PN2JG0bvKGMyKgJZcQrD3oE7SQRCwrpWAK+jnafrKdn+iy9n9V2+2Bc
        a/BlsnCxT7GAJz73v047hJZvt2h59LxBX9xSFxlVykb+kd1JbR05wACHrfdCvcWrjqu
        i/GiLHvnjVyUbr79aXFO7lj2l9c0sBkrVPbSIEhg=
From:   Mike Ralphson <mike.ralphson@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157276d4d1f-9c995462-4aea-4949-8d29-3dbdbec77dd7-000000@eu-west-1.amazonses.com>
Subject: [PATCH] vcs-svn/fast_export: fix timestamp fmt specifiers
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Sep 2016 06:40:57 +0000
X-SES-Outgoing: 2016.09.14-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two instances of %ld being used for unsigned longs

Signed-off-by: Mike Ralphson <mike.ralphson@gmail.com>
---
 vcs-svn/fast_export.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index bd0f2c2..97cba39 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -73,7 +73,7 @@ void fast_export_begin_note(uint32_t revision, const char *author,
 	static int firstnote = 1;
 	size_t loglen = strlen(log);
 	printf("commit %s\n", note_ref);
-	printf("committer %s <%s@%s> %ld +0000\n", author, author, "local", timestamp);
+	printf("committer %s <%s@%s> %lu +0000\n", author, author, "local", timestamp);
 	printf("data %"PRIuMAX"\n", (uintmax_t)loglen);
 	fwrite(log, loglen, 1, stdout);
 	if (firstnote) {
@@ -107,7 +107,7 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
 	}
 	printf("commit %s\n", local_ref);
 	printf("mark :%"PRIu32"\n", revision);
-	printf("committer %s <%s@%s> %ld +0000\n",
+	printf("committer %s <%s@%s> %lu +0000\n",
 		   *author ? author : "nobody",
 		   *author ? author : "nobody",
 		   *uuid ? uuid : "local", timestamp);

--
https://github.com/git/git/pull/293
