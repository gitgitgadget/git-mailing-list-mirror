From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] archive: Refuse to write the archive to a terminal.
Date: Wed, 16 Sep 2009 03:31:33 -0700
Message-ID: <20090916103129.GA21430@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 16 12:32:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnroO-0004xI-81
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 12:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbZIPKbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 06:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbZIPKbp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 06:31:45 -0400
Received: from relay3-v.mail.gandi.net ([217.70.178.77]:45262 "EHLO
	relay3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757566AbZIPKbo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 06:31:44 -0400
Received: from feather (65-122-183-162.dia.static.qwest.net [65.122.183.162])
	by relay3-v.mail.gandi.net (Postfix) with ESMTP id D21CFBA1B;
	Wed, 16 Sep 2009 12:31:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128638>

If not given the -o/--output option, git archive writes the archive to
stdout.  This proves unhelpful if not redirected or piped somewhere.
Rather than spewing binary at the user's terminal, die with an
appropriate message.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

I considered adding a -f/--force option, like gzip has, but writing an
archive to a tty seems like a sufficiently insane use case that I'll let
whoever actually needs that write the patch for it. ;)

 builtin-archive.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 12351e9..73accd0 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -101,6 +101,9 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 		create_output_file(output);
 		if (!format)
 			format = format_from_name(output);
+	} else if (isatty(1)) {
+		die("Archive not written to a terminal.\n"
+		    "Specify output filename or redirect output.");
 	}
 
 	if (format) {
-- 
1.6.3.3
