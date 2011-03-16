From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH] gitweb: highlight: replace tabs with spaces
Date: Wed, 16 Mar 2011 15:34:13 -0700
Message-ID: <6ac7d48cfdf4192c3240c1ecbd4e5522@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 23:44:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzzRz-0008LL-Nw
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 23:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab1CPWoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 18:44:16 -0400
Received: from [69.28.251.93] ([69.28.251.93]:43676 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752831Ab1CPWoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 18:44:14 -0400
Received: (qmail 18165 invoked from network); 16 Mar 2011 22:44:13 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Mar 2011 22:44:13 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Wed, 16 Mar 2011 15:44:12 -0700
User-Agent: vim 7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169205>

Consider the following code fragment:

        /*
         * test
         */

vim ":set list" mode shows that the first character on each line is a
tab:

^I/*$
^I * test$
^I */$

By default, the "highlight" program will retain the tabs in the HTML
output:

$ highlight --fragment --syntax c test.c
        <span class="hl com">/*</span>
<span class="hl com">    * test</span>
<span class="hl com">    */</span>

vim list mode:

^I<span class="hl com">/*</span>$
<span class="hl com">^I * test</span>$
<span class="hl com">^I */</span>$

In gitweb, this winds up looking something like:

   1         /*
   2     * test
   3     */

I tried both Firefox and Opera and saw the same behavior.

The desired output is:

   1         /*
   2          * test
   3          */

This can be accomplished by specifying "--replace-tabs=8" on the
highlight command line.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d171ad5..649e10a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3485,7 +3485,7 @@ sub run_highlighter {
 	close $fd;
 	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
 	          quote_command($highlight_bin).
-	          " --fragment --syntax $syntax |"
+	          " --replace-tabs=8 --fragment --syntax $syntax |"
 		or die_error(500, "Couldn't open file or run syntax highlighter");
 	return $fd;
 }
-- 
1.7.4.1
