From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 3/4] log and rev-list: Fix --graph output with --pretty=email
Date: Mon,  7 Apr 2008 01:01:20 -0700
Message-ID: <1207555281-9362-3-git-send-email-adam@adamsimpkins.net>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-2-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 10:02:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JimIt-0007zd-FL
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbYDGIB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 04:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYDGIB1
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:01:27 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:55234 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbYDGIBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 04:01:25 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 551D71B40CB;
	Mon,  7 Apr 2008 04:01:23 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 34EB61B4049;
	Mon,  7 Apr 2008 04:01:23 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id C305214100BA; Mon,  7 Apr 2008 01:01:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207555281-9362-2-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78956>

As pointed out by Teemu Likonen, the initial line of
pretty_print_commit() output wasn't correctly prefixed by the graph
information.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 log-tree.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 0d7e521..d2cb26a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -166,11 +166,16 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 	}
 
 	printf("From %s Mon Sep 17 00:00:00 2001\n", name);
-	if (opt->message_id)
+	graph_show_oneline(opt->graph);
+	if (opt->message_id) {
 		printf("Message-Id: <%s>\n", opt->message_id);
-	if (opt->ref_message_id)
+		graph_show_oneline(opt->graph);
+	}
+	if (opt->ref_message_id) {
 		printf("In-Reply-To: <%s>\nReferences: <%s>\n",
 		       opt->ref_message_id, opt->ref_message_id);
+		graph_show_oneline(opt->graph);
+	}
 	if (opt->mime_boundary) {
 		static char subject_buffer[1024];
 		static char buffer[1024];
-- 
1.5.3.6
