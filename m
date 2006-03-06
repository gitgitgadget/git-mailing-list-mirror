From: Mike McCormack <mike@codeweavers.com>
Subject: [PATCH] Allow adding arbitary lines in the mail header generated
 by format-patch.
Date: Mon, 06 Mar 2006 22:10:21 +0900
Organization: CodeWeavers
Message-ID: <440C34BD.9050703@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000302040606060503060905"
X-From: git-owner@vger.kernel.org Mon Mar 06 14:17:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGFXt-00023h-MV
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 14:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWCFNOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 08:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWCFNOj
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 08:14:39 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:58789 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932200AbWCFNOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 08:14:38 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1FGFXn-0000CI-T4
	for git@vger.kernel.org; Mon, 06 Mar 2006 07:14:37 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
To: git@vger.kernel.org
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17296>

This is a multi-part message in MIME format.
--------------000302040606060503060905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Entries may be added to the config file as follows:

[format]
         headers = "Organization: CodeWeavers\nTo: wine-patches 
<wine-patches@winehq.org>\n"

---

  git-format-patch.sh |    8 ++++++--
  1 files changed, 6 insertions(+), 2 deletions(-)


--------------000302040606060503060905
Content-Type: text/x-patch;
 name="cdd5602230adecce4a7dd274b4f81d52681410cb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdd5602230adecce4a7dd274b4f81d52681410cb.diff"

cdd5602230adecce4a7dd274b4f81d52681410cb
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 2bd2639..bbd2e55 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -149,6 +149,7 @@ do
 done >$series
 
 me=`git-var GIT_AUTHOR_IDENT | sed -e 's/>.*/>/'`
+headers=`git-repo-config --get format.headers`
 
 case "$outdir" in
 */) ;;
@@ -173,7 +174,7 @@ titleScript='
 
 process_one () {
 	perl -w -e '
-my ($keep_subject, $num, $signoff, $commsg) = @ARGV;
+my ($keep_subject, $num, $signoff, $headers, $commsg) = @ARGV;
 my ($signoff_pattern, $done_header, $done_subject, $done_separator, $signoff_seen,
     $last_was_signoff);
 
@@ -224,6 +225,9 @@ while (<FH>) {
 	    s/^\[PATCH[^]]*\]\s*//;
 	    s/^/[PATCH$num] /;
 	}
+	if ($headers) {
+	    print "$headers\n";
+	}
         print "Subject: $_";
 	$done_subject = 1;
 	next;
@@ -250,7 +254,7 @@ if (!$signoff_seen && $signoff ne "") {
 }
 print "\n---\n\n";
 close FH or die "close $commsg pipe";
-' "$keep_subject" "$num" "$signoff" $commsg
+' "$keep_subject" "$num" "$signoff" "$headers" $commsg
 
 	git-diff-tree -p $diff_opts "$commit" | git-apply --stat --summary
 	echo


--------------000302040606060503060905--
