From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 05/11] fast-import: switch crash-report date to iso8601
Date: Thu,  3 Sep 2015 22:48:55 +0100
Message-ID: <9094670ba26fe6a63fa4264f3564e877513ba1ec.1441316394.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
 <cover.1441316394.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 23:50:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcOm-0000mZ-H9
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510AbbICVuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 17:50:19 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:57543 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757469AbbICVuS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:50:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 05842CDA61E;
	Thu,  3 Sep 2015 22:50:18 +0100 (BST)
X-Quarantine-ID: <t1hz7iaQbE7W>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t1hz7iaQbE7W; Thu,  3 Sep 2015 22:50:17 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 401EACDA5F6;
	Thu,  3 Sep 2015 22:50:02 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
References: <cover.1441316394.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277266>

From: Jeff King <peff@peff.net>

When fast-import emits a crash report, it does so in the
user's local timezone. But because we omit the timezone
completely for DATE_LOCAL, a reader of the report does not
immediately know which time zone was used. Let's switch this
to ISO8601 instead, which includes the time zone.

This does mean we will show the time in UTC, but that's not
a big deal. A crash report like this will either be looked
at immediately (in which case nobody even looks at the
timestamp), or it will be passed along to a developer to
debug, in which case the original timezone is less likely to
be of interest.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 fast-import.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index 6c7c3c9..adcbfc6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -424,7 +424,7 @@ static void write_crash_report(const char *err)
 	fprintf(rpt, "fast-import crash report:\n");
 	fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t) getpid());
 	fprintf(rpt, "    parent process     : %"PRIuMAX"\n", (uintmax_t) getppid());
-	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_MODE(LOCAL)));
+	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_MODE(ISO8601)));
 	fputc('\n', rpt);
 
 	fputs("fatal: ", rpt);
-- 
2.5.0.466.g9af26fa
