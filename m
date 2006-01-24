From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] rev-{list,parse}: allow -<n> as shorthand for --max-count=<n>
Date: Mon, 23 Jan 2006 23:29:46 -0800
Message-ID: <20060124072946.GA9468@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 24 08:29:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1Ich-0003eK-RD
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 08:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWAXH3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 02:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWAXH3t
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 02:29:49 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39882 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932239AbWAXH3s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jan 2006 02:29:48 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id 6E8702DC035
	for <git@vger.kernel.org>; Mon, 23 Jan 2006 23:29:46 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Mon, 23 Jan 2006 23:29:46 -0800
To: git list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15096>

Some versions of head(1) and tail(1) allow their line limits to be
parsed this way.  I find --max-count to be a commonly used option,
and also similar in spirit to head/tail, so I decided to make life
easier on my worn out (and lazy :) fingers with this patch.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 rev-list.c  |    5 +++++
 rev-parse.c |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

68df4b28986a4642119373e18a63751be0e26366
diff --git a/rev-list.c b/rev-list.c
index d060966..2bbd699 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -732,6 +732,11 @@ int main(int argc, const char **argv)
 		struct commit *commit;
 		unsigned char sha1[20];
 
+		/* accept, -<digit>, like some versions of head/tail  */
+		if (*arg == '-' && isdigit(arg[1])) {
+			max_count = atoi(arg + 1);
+			continue;
+		}
 		if (!strncmp(arg, "--max-count=", 12)) {
 			max_count = atoi(arg + 12);
 			continue;
diff --git a/rev-parse.c b/rev-parse.c
index 0c951af..4dfc1a9 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -52,6 +52,10 @@ static int is_rev_argument(const char *a
 	};
 	const char **p = rev_args;
 
+	/* accept, -<digit>, like some versions of head/tail  */
+	if (*arg == '-' && isdigit(arg[1]))
+		return 1;
+
 	for (;;) {
 		const char *str = *p++;
 		int len;
-- 
1.1.4.g68df
