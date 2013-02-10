From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] fixup! graph: output padding for merge subsequent parents
Date: Sun, 10 Feb 2013 13:16:47 +0000
Message-ID: <20130210131647.GA2270@serenity.lan>
References: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 14:17:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4Wmj-0001HD-0T
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 14:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab3BJNQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 08:16:59 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:52245 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab3BJNQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 08:16:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 7574CCDA510;
	Sun, 10 Feb 2013 13:16:58 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9RRH05qE+Sv6; Sun, 10 Feb 2013 13:16:57 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id A4D4CCDA5A6;
	Sun, 10 Feb 2013 13:16:53 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215903>

---
On Sat, Feb 09, 2013 at 03:39:33PM -0800, Junio C Hamano wrote:
> * jk/diff-graph-cleanup (2013-02-07) 6 commits
>  - combine-diff.c: teach combined diffs about line prefix
>  - diff.c: use diff_line_prefix() where applicable
>  - diff: add diff_line_prefix function
>  - diff.c: make constant string arguments const
>  - diff: write prefix to the correct file
>  - graph: output padding for merge subsequent parents
> 
>  Refactors a lot of repetitive code sequence from the graph drawing
>  code and adds it to the combined diff output.
> 
>  Will merge to 'next'.

Can you squash this into the first commit before you do?

Matthieu is correct that the graph_is_commit_finished() check isn't
needed in the loop now that we've pulled it out to be checked first -
the value returned can't change during the loop.  I've left the early
return out.

 graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index 2a3fc5c..56f970f 100644
--- a/graph.c
+++ b/graph.c
@@ -1237,7 +1237,7 @@ void graph_show_commit(struct git_graph *graph)
 		shown_commit_line = 1;
 	}
 
-	while (!shown_commit_line && !graph_is_commit_finished(graph)) {
+	while (!shown_commit_line) {
 		shown_commit_line = graph_next_line(graph, &msgbuf);
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
 		if (!shown_commit_line)
-- 
1.8.1.2
