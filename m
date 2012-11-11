From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] send-email: add series-cc-cmd option
Date: Sun, 11 Nov 2012 18:04:23 +0100
Message-ID: <1352653463-1923-3-git-send-email-felipe.contreras@gmail.com>
References: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Joe Perches <joe@perches.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Pascal Obry <pascal@obry.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 18:04:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXaxr-0007TJ-Ad
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab2KKREl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:04:41 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52685 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab2KKREk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:04:40 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2084867bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KU6i/QW6YzVvXYdmLol3UeEsMDIyRzjrpXN5Ypj57Ho=;
        b=vMdB4mzq4L4GkENgkKwu4446FYKaLOF+AfMgqWaXwCTUwztWcNc7ZJdWEYOkowfY6n
         dKLNick7boSTwt6cSv1N5240zs5fH9vbyo0DEoGB1Jc6/MEmuctSUAjhrP/Y+LW09fmq
         K3PyqSZ0Z0x3OU/UrLhBgNuxCewmmPzhnpt9OG9iA2F9Y+2YgS+zvU8pcXjXJ/6xRL2C
         dTTKdkwy/penAX9o8HrkrFOXxLKL1jF4luhSER8v/jpD+zQL2BvLe9jxDwmKXvJFME5I
         cbltw5RbLmMGpqw63ank7h+TWKJaQ9hRG8YZSLkZNd+A+UGa3i+UC+3jebwpwgZLK4YR
         dzGw==
Received: by 10.204.148.22 with SMTP id n22mr3005208bkv.6.1352653479341;
        Sun, 11 Nov 2012 09:04:39 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id k21sm1646569bkv.1.2012.11.11.09.04.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 09:04:38 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209417>

cc-cmd is only per-file, and many times receipients get lost without
seing the full patch series.

So, add an option for series-cc-cmd, which receives as an argument
rev-list options, just like format-patch.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-send-email.txt       | 7 +++++++
 contrib/completion/git-completion.bash | 2 +-
 git-send-email.perl                    | 9 ++++++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3241170..1161d3e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -218,6 +218,13 @@ Automating
 	Output of this command must be single email address per line.
 	Default is the value of 'sendemail.cccmd' configuration value.
 
+--series-cc-cmd=<command>::
+	Specify a command to execute to generate "Cc:" entries for the whole
+	patch series.
+	The arguments would be the same rev-list options the user specified.
+	Output of this command must be single email address per line.
+	Default is the value of 'sendemail.seriescccmd' configuration value.
+
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be800e0..0b04229 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1555,7 +1555,7 @@ _git_send_email ()
 		return
 		;;
 	--*)
-		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
+		__gitcomp "--annotate --bcc --cc --cc-cmd --series-cc-cmd --chain-reply-to
 			--compose --confirm= --dry-run --envelope-sender
 			--from --identity
 			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
diff --git a/git-send-email.perl b/git-send-email.perl
index 26d4477..da89ac6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -191,7 +191,7 @@ sub do_edit {
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
-my ($to_cmd, $cc_cmd);
+my ($to_cmd, $cc_cmd, $series_cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
@@ -224,6 +224,7 @@ my %config_settings = (
     "tocmd" => \$to_cmd,
     "cc" => \@initial_cc,
     "cccmd" => \$cc_cmd,
+    "seriescccmd" => \$series_cc_cmd,
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@bcclist,
     "suppresscc" => \@suppress_cc,
@@ -305,6 +306,7 @@ my $rc = GetOptions("h" => \$help,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
+		    "series-cc-cmd=s" => \$series_cc_cmd,
 		    "suppress-from!" => \$suppress_from,
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
@@ -766,6 +768,11 @@ if (!@initial_to && !defined $to_cmd) {
 	$prompting++;
 }
 
+if (@rev_list_opts) {
+	push @initial_cc, recipients_cmd("series-cc-cmd", "cc", $series_cc_cmd, @rev_list_opts)
+		if defined $series_cc_cmd;
+}
+
 sub expand_aliases {
 	return map { expand_one_alias($_) } @_;
 }
-- 
1.8.0
