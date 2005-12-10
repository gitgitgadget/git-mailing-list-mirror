From: freku045@student.liu.se
Subject: [PATCH 21/25] git-send-email: Usage message clean-up.
Date: Sat, 10 Dec 2005 20:37:59 +0100
Message-ID: <11342434792231-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYZ-0002PO-Hx
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbVLJTiZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbVLJTiW
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:22 -0500
Received: from [85.8.31.11] ([85.8.31.11]:23501 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161050AbVLJTiK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:10 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id B33334127; Sat, 10 Dec 2005 20:48:16 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXf-000704-00; Sat, 10 Dec 2005 20:37:59 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13457>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-send-email.perl |   62 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 34 insertions(+), 28 deletions(-)

38fde073a59d00a19111a30e8f804c4e784835e7
diff --git a/git-send-email.perl b/git-send-email.perl
index ec1428d..5f6b729 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -27,6 +27,38 @@ use Email::Valid;
 sub unique_email_list(@);
 sub cleanup_compose_files();
 
+sub usage {
+	print <<EOT;
+$0 [options] <file | directory> [... file | directory ]
+Options:
+   --from         Specify the "From:" line of the email to be sent.
+
+   --to           Specify the primary "To:" line of the email.
+
+   --compose      Use \$EDITOR to edit an introductory message for the
+                  patch series.
+
+   --subject      Specify the initial "Subject:" line.
+                  Only necessary if --compose is also set.  If --compose
+		  is not set, this will be prompted for.
+
+   --in-reply-to  Specify the first "In-Reply-To:" header line.
+                  Only used if --compose is also set.  If --compose is not
+		  set, this will be prompted for.
+
+   --chain-reply-to If set, the replies will all be to the previous
+                  email sent, rather than to the first email sent.
+                  Defaults to on.
+
+   --smtp-server  If set, specifies the outgoing SMTP server to use.
+                  Defaults to localhost.
+EOT
+
+	print $_[0], "\n" if defined $_[0];
+
+	exit(1);
+}
+
 # Constants (essentially)
 my $compose_filename = ".msg.$$";
 
@@ -51,6 +83,7 @@ my $rc = GetOptions("from=s" => \$from,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
 		    "compose" => \$compose,
+		    "help|h" => sub { usage; },
 	 );
 
 # Now, let's fill any that aren't set in with defaults:
@@ -187,34 +220,7 @@ for my $f (@ARGV) {
 if (@files) {
 	print $_,"\n" for @files;
 } else {
-	print <<EOT;
-git-send-email [options] <file | directory> [... file | directory ]
-Options:
-   --from         Specify the "From:" line of the email to be sent.
-
-   --to           Specify the primary "To:" line of the email.
-
-   --compose      Use \$EDITOR to edit an introductory message for the
-                  patch series.
-
-   --subject      Specify the initial "Subject:" line.
-                  Only necessary if --compose is also set.  If --compose
-		  is not set, this will be prompted for.
-
-   --in-reply-to  Specify the first "In-Reply-To:" header line.
-                  Only used if --compose is also set.  If --compose is not
-		  set, this will be prompted for.
-
-   --chain-reply-to If set, the replies will all be to the previous
-                  email sent, rather than to the first email sent.
-                  Defaults to on.
-
-   --smtp-server  If set, specifies the outgoing SMTP server to use.
-                  Defaults to localhost.
-
-Error: Please specify a file or a directory on the command line.
-EOT
-	exit(1);
+	usage "Error: Please specify a file or a directory on the command line.";
 }
 
 # Variables we set as part of the loop over files
-- 
0.99.9.GIT
