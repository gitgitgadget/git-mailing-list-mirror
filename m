From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v3 2/7] Add output_prefix_length to diff_options
Date: Mon, 16 Apr 2012 03:44:50 -0700
Message-ID: <1334573095-32286-3-git-send-email-lucian.poston@gmail.com>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 12:46:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjSM-00006F-Qt
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab2DPKqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 06:46:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39828 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab2DPKqp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 06:46:45 -0400
Received: by pbcun15 with SMTP id un15so6191413pbc.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 03:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9pC2d3dW0B1YyTq+oivAoU7tErZJ7rv2EXFKrl4e/vo=;
        b=pOx9ueJtwnpSf638e/7aDNUfQSoWNNYVnzop8p4FFECAdt7efspPKATOH5UaZWjaj0
         BeUNdVqI/XSmL+/6KMGEP39rXZarowTk4oiVqevTU8KOduyDiVaYXLJfV0tiCARxAHXx
         PSf/YMHH05JeFIFlQWhtIoyJGGJls4bq345/iMQ3ewUQz3Te6vpgtjWibXUGMhvt/AyE
         AAADSAXayZe4aeV0GZal5Zl/S+VKVSd9JxqlsiTbdAAQararXnlsTEcHNSjRkp+GV69v
         c4KVEwkUdjZ5OXPFdMwGiU+83ww2sIhFY6jk+/kPBkMgyITr5nOZnt7aBciHFOSrIqq+
         8byA==
Received: by 10.68.221.136 with SMTP id qe8mr27500768pbc.108.1334573205275;
        Mon, 16 Apr 2012 03:46:45 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id oh2sm10793051pbb.45.2012.04.16.03.46.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 03:46:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195613>

Add output_prefix_length to diff_options. Initialize the value to 0 and only
set it when graph.c:diff_output_prefix_callback() is called.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 diff.h  |    1 +
 graph.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diff.h b/diff.h
index cb68743..19d762f 100644
--- a/diff.h
+++ b/diff.h
@@ -150,6 +150,7 @@ struct diff_options {
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
 	diff_prefix_fn_t output_prefix;
+	int output_prefix_length;
 	void *output_prefix_data;
 };
 
diff --git a/graph.c b/graph.c
index 7358416..7e0a099 100644
--- a/graph.c
+++ b/graph.c
@@ -194,8 +194,10 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 	struct git_graph *graph = data;
 	static struct strbuf msgbuf = STRBUF_INIT;
 
+	assert(opt);
 	assert(graph);
 
+	opt->output_prefix_length = graph->width;
 	strbuf_reset(&msgbuf);
 	graph_padding_line(graph, &msgbuf);
 	return &msgbuf;
@@ -245,6 +247,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	 */
 	opt->diffopt.output_prefix = diff_output_prefix_callback;
 	opt->diffopt.output_prefix_data = graph;
+	opt->diffopt.output_prefix_length = 0;
 
 	return graph;
 }
-- 
1.7.3.4
