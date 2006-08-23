From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3] gitweb: Show information about incomplete lines in commitdiff
Date: Thu, 24 Aug 2006 01:58:49 +0200
Message-ID: <200608240158.49908.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 24 01:59:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG2cu-0001oe-JQ
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 01:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWHWX7M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 19:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbWHWX7M
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 19:59:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:27976 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965309AbWHWX7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 19:59:08 -0400
Received: by nf-out-0910.google.com with SMTP id o25so459787nfa
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 16:58:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gquSe8+RZfe1u6+K+rX8IWR4rMI3AW4TOnv9kfH/k8d8zONbM3l8jTqv8aTTQ2IdXYzB5nB7g3vg/Mr5IguIxE61Qkq6ufn2OifmDrCppdGE4mgFyOQNv5cvKQvwYtyUJ++AbRTuSOezxzbSXJuLtmy81HcikDplFRvLGtZ1BfY=
Received: by 10.49.8.10 with SMTP id l10mr2793524nfi;
        Wed, 23 Aug 2006 16:58:53 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id q28sm3271090nfc.2006.08.23.16.58.51;
        Wed, 23 Aug 2006 16:58:52 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25936>

In format_diff_line, instead of skipping errors/incomplete lines,
for example
  "\ No newline at end of file"
in HTML pretty-printing of diff, use "incomplete" class for div.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 4821022..5eaa24f 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -285,6 +285,10 @@ div.diff.chunk_header {
 	color: #990099;
 }
 
+div.diff.incomplete {
+	color: #cccccc;
+}
+
 div.diff_info {
 	font-family: monospace;
 	color: #000099;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c238824..42b8f93 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -539,7 +539,7 @@ sub format_diff_line {
 		$diff_class = " chunk_header";
 	} elsif ($char eq "\\") {
 		# skip errors (incomplete lines)
-		return "";
+		$diff_class = " incomplete";
 	}
 	$line = untabify($line);
 	return "<div class=\"diff$diff_class\">" . esc_html($line) . "</div>\n";
-- 
1.4.1.1
