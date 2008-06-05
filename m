From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: log --graph --first-parent weirdness
Date: Thu, 5 Jun 2008 02:28:13 -0700
Message-ID: <20080605092812.GA14116@adamsimpkins.net>
References: <20080604150042.GA3038@mithlond.arda.local> <7vmym1xgy4.fsf@gitster.siamese.dyndns.org> <20080604173820.GA3038@mithlond.arda.local> <7v1w3dxeh9.fsf@gitster.siamese.dyndns.org>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 11:30:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4BmP-0007n6-96
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 11:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbYFEJ2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 05:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754981AbYFEJ2Q
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 05:28:16 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:55401 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbYFEJ2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 05:28:14 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 47E451B4093;
	Thu,  5 Jun 2008 05:28:14 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 21BF61B4036;
	Thu,  5 Jun 2008 05:28:14 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 9439C14100CC; Thu,  5 Jun 2008 02:28:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1w3dxeh9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83888>

On Wed, Jun 04, 2008 at 11:05:38AM -0700, Junio C Hamano wrote:
> 
> I'd really suggest changing the "M" and use "*" everywhere.

That's fine with me.  Here's a simple patch to change the behavior.


-- >8 --
"git log --graph": print '*' for all commits, including merges

Previously, merge commits were printed with 'M' instead of '*'.  This
had the potential to confuse users when not all parents of the merge
commit were included in the log output.

As Junio has pointed out, merge commits can almost always be easily
identified from the log message, anyway.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 graph.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/graph.c b/graph.c
index edfab2d..c50adcd 100644
--- a/graph.c
+++ b/graph.c
@@ -638,20 +638,6 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 	}
 
 	/*
-	 * Print 'M' for merge commits
-	 *
-	 * Note that we don't check graph->num_parents to determine if the
-	 * commit is a merge, since that only tracks the number of
-	 * "interesting" parents.  We want to print 'M' for merge commits
-	 * even if they have less than 2 interesting parents.
-	 */
-	if (graph->commit->parents != NULL &&
-	    graph->commit->parents->next != NULL) {
-		strbuf_addch(sb, 'M');
-		return;
-	}
-
-	/*
 	 * Print '*' in all other cases
 	 */
 	strbuf_addch(sb, '*');
-- 
1.5.6.rc1.13.g14be6
