From: Jeff King <peff@peff.net>
Subject: [PATCH v2 4/5] avoid trailing whitespace in zero-change diffstat
	lines
Date: Sat, 14 Jun 2008 03:27:45 -0400
Message-ID: <20080614072745.GD17536@sigill.intra.peff.net>
References: <20080614072214.GA9975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 09:28:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7QBm-0008DB-O9
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYFNH1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYFNH1s
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:27:48 -0400
Received: from peff.net ([208.65.91.99]:2084 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbYFNH1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:27:48 -0400
Received: (qmail 31055 invoked by uid 111); 14 Jun 2008 07:27:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 03:27:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 03:27:45 -0400
Content-Disposition: inline
In-Reply-To: <20080614072214.GA9975@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84982>

In some cases, we produce a diffstat line even though no
lines have changed (e.g., because of an exact rename). In
this case, there is no +/- "graph" after the number of
changed lines. However, we output the space separator
unconditionally, meaning that these lines contained a
trailing space character.

This isn't a huge problem, but in cleaning up the output we
are able to eliminate some trailing whitespace from a test
vector.

Signed-off-by: Jeff King <peff@peff.net>
---
This is identical to the original 3/4.

 diff.c                |    3 ++-
 t/t4016-diff-quote.sh |   14 +++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 62fdc54..f77f9e9 100644
--- a/diff.c
+++ b/diff.c
@@ -922,7 +922,8 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 			total = add + del;
 		}
 		show_name(options->file, prefix, name, len, reset, set);
-		fprintf(options->file, "%5d ", added + deleted);
+		fprintf(options->file, "%5d%s", added + deleted,
+				added + deleted ? " " : "");
 		show_graph(options->file, '+', add, add_c, reset);
 		show_graph(options->file, '-', del, del_c, reset);
 		fprintf(options->file, "\n");
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 0950250..f07035a 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -53,13 +53,13 @@ test_expect_success 'git diff --summary -M HEAD' '
 '
 
 cat >expect <<\EOF
- pathname.1 => "Rpathname\twith HT.0"            |    0 
- pathname.3 => "Rpathname\nwith LF.0"            |    0 
- "pathname\twith HT.3" => "Rpathname\nwith LF.1" |    0 
- pathname.2 => Rpathname with SP.0               |    0 
- "pathname\twith HT.2" => Rpathname with SP.1    |    0 
- pathname.0 => Rpathname.0                       |    0 
- "pathname\twith HT.0" => Rpathname.1            |    0 
+ pathname.1 => "Rpathname\twith HT.0"            |    0
+ pathname.3 => "Rpathname\nwith LF.0"            |    0
+ "pathname\twith HT.3" => "Rpathname\nwith LF.1" |    0
+ pathname.2 => Rpathname with SP.0               |    0
+ "pathname\twith HT.2" => Rpathname with SP.1    |    0
+ pathname.0 => Rpathname.0                       |    0
+ "pathname\twith HT.0" => Rpathname.1            |    0
  7 files changed, 0 insertions(+), 0 deletions(-)
 EOF
 test_expect_success 'git diff --stat -M HEAD' '
-- 
1.5.6.rc2.183.g04614
