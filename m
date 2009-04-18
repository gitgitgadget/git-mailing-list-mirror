From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 01/12] send-email: Cleanup the usage text and docs a bit
Date: Sat, 18 Apr 2009 12:01:57 -0500
Message-ID: <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:06:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDyc-0006Oc-8X
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbZDRRDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbZDRRC7
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:02:59 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:26077 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbZDRRC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:02:58 -0400
Received: by qw-out-2122.google.com with SMTP id 5so485416qwd.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cBzmQTNFU+hm0huk4NcKU0VNjS3Omcynf6GTp4Ms2Tw=;
        b=aKpVCPK0JYYOGNeDGxQsDiWhzrPuv7KvirNb8pHdLQSG/uv9wNmZTPMtUXDHx7Bo51
         8/yPQKG4sD6S+oeMxl7MEkJPylo1QLmqyPkvGz6ehAZqXOzLCW5LoFPWX0uDOQpjI3of
         q8bbu3Kw+ZL2gOB2hvw59KLQfofUPGzOVkiZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AuS6qODnnO7kb4t9ktQqn1RO2wpMHpDul2Dt+/OvYqJkyZzuJrPeqvkZicV8OZZR79
         OwqPQWKUD3zUJGaBjxQ/hL/0TKFKMj0vZunb4jsw8gPkrbaokzpI3aRzBTb4XtTR1K8p
         e6xJrls+tKMELUWtL2OsPc8NDL1U4gsqqQK9s=
Received: by 10.220.100.142 with SMTP id y14mr4197778vcn.73.1240074177626;
        Sat, 18 Apr 2009 10:02:57 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.02.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:02:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116846>

--chain-reply-to doesn't take an argument.

The here-document quotation that defines the usage
text is now a single-quote form, so that no interpolation
takes place.

All usage text lines should be < 80 characters.

The usage text's option arguments match those of the docs.

The 'host:port' form of argument for --smtp-server was only
working for SSL connections, because the SSL connection code
was relying on undocumented behavior of Net::SMTP::SSL (really,
undocumented behavior of Net::SMTP's new method). Because the
main documentation for send-email doesn't even list it as valid,
<str:int> has been replaced with just <server> and <host | command>
in the usage text; this is only temporary and for purity.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   21 ++++++++-------
 git-send-email.perl              |   49 +++++++++++++++++++++-----------------
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f7e428e..071e9bf 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -74,8 +74,9 @@ See the CONFIGURATION section for 'sendemail.multiedit'.
 	the value GIT_COMMITTER_IDENT, as returned by "git var -l".
 	The user will still be prompted to confirm this entry.
 
---in-reply-to=<identifier>::
-	Specify the contents of the first In-Reply-To header.
+--in-reply-to=<message-id>::
+	Specify the contents of the first In-Reply-To header;
+	include the angle brackets `<` and `>`.
 	Subsequent emails will refer to the previous email
 	instead of this if --chain-reply-to is set (the default)
 	Only necessary if --compose is also set.  If --compose
@@ -106,7 +107,7 @@ Sending
 	the 'sendemail.envelopesender' configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
 
---smtp-encryption=<encryption>::
+--smtp-encryption=<type>::
 	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
 	value reverts to plain SMTP.  Default is the value of
 	'sendemail.smtpencryption'.
@@ -123,20 +124,20 @@ or on the command line. If a username has been specified (with
 specified (with '--smtp-pass' or 'sendemail.smtppass'), then the
 user is prompted for a password while the input is masked for privacy.
 
---smtp-server=<host>::
+--smtp-server=<server>::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  Alternatively it can
 	specify a full pathname of a sendmail-like program instead;
 	the program must support the `-i` option.  Default value can
 	be specified by the 'sendemail.smtpserver' configuration
-	option; the built-in default is `/usr/sbin/sendmail` or
-	`/usr/lib/sendmail` if such program is available, or
+	variable; the built-in default is `/usr/sbin/sendmail` or
+	`/usr/lib/sendmail` if such a program is available, or
 	`localhost` otherwise.
 
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25 and ssmtp port
-	465); symbolic port names (e.g. "submission" instead of 465)
+	465); symbolic service names (e.g. "submission" instead of 587)
 	are also accepted. The port can also be set with the
 	'sendemail.smtpserverport' configuration variable.
 
@@ -158,7 +159,7 @@ Automating
 	Output of this command must be single email address per line.
 	Default is the value of 'sendemail.cccmd' configuration value.
 
---[no-]chain-reply-to=<identifier>::
+--[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -170,7 +171,7 @@ Automating
 	A configuration identity. When given, causes values in the
 	'sendemail.<identity>' subsection to take precedence over
 	values in the 'sendemail' section. The default identity is
-	the value of 'sendemail.identity'.
+	the value of the 'sendemail.identity' configuration variable.
 
 --[no-]signed-off-by-cc::
 	If this is set, add emails found in Signed-off-by: or Cc: lines to the
@@ -214,7 +215,7 @@ specified, as well as 'body' if --no-signed-off-cc is specified.
 Administering
 ~~~~~~~~~~~~~
 
---confirm=<mode>::
+--confirm=<when>::
 	Confirm just before sending:
 +
 --
diff --git a/git-send-email.perl b/git-send-email.perl
index 04267c5..e43342e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -42,46 +42,51 @@ package main;
 
 
 sub usage {
-	print <<EOT;
+
+	# All printed lines should be less than 80 characters.
+
+	print <<'EOT';
 git send-email [options] <file | directory | rev-list options >
 
   Composing:
-    --from                  <str>  * Email From:
-    --to                    <str>  * Email To:
-    --cc                    <str>  * Email Cc:
-    --bcc                   <str>  * Email Bcc:
-    --subject               <str>  * Email "Subject:"
-    --in-reply-to           <str>  * Email "In-Reply-To:"
-    --annotate                     * Review each patch that will be sent in an editor.
+    --from              <address>  * Email From:
+    --to                <address>  * Email To:
+    --cc                <address>  * Email Cc:
+    --bcc               <address>  * Email Bcc:
+    --subject            <string>  * Email "Subject:"
+    --in-reply-to    <message-id>  * Email "In-Reply-To:"; include '<' and '>'.
+    --annotate                     * Review each patch that will be sent in
+                                     an editor.
     --compose                      * Open an editor for introduction.
 
   Sending:
-    --envelope-sender       <str>  * Email envelope sender.
-    --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
-                                     is optional. Default 'localhost'.
-    --smtp-server-port      <int>  * Outgoing SMTP server port.
-    --smtp-user             <str>  * Username for SMTP-AUTH.
-    --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
-    --smtp-encryption       <str>  * tls or ssl; anything else disables.
+    --envelope-sender   <address>  * Email envelope sender.
+    --smtp-server        <server>  * Outgoing SMTP server. <host | command>
+    --smtp-server-port     <port>  * Outgoing SMTP server port; symbolic too.
+    --smtp-user        <username>  * Username for SMTP-AUTH.
+    --smtp-pass       [<password>] * Password for SMTP-AUTH; not necessary.
+    --smtp-encryption      <type>  * tls or ssl; anything else disables.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
 
   Automating:
-    --identity              <str>  * Use the sendemail.<id> options.
-    --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
-    --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
+    --identity         <identity>  * Use the sendemail.<identity> options.
+    --cc-cmd            <command>  * Email Cc: via `<command> $patch_path`
+    --suppress-cc      <category>  * author, self, sob, cc, cccmd, body,
+                                     bodycc, all.
+    --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses.
+                                     Default on.
     --[no-]suppress-from           * Send to self. Default off.
     --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default on.
     --[no-]thread                  * Use In-Reply-To: field. Default on.
 
   Administering:
-    --confirm               <str>  * Confirm recipients before sending;
+    --confirm              <when>  * Confirm recipients before sending;
                                      auto, cc, compose, always, or never.
     --quiet                        * Output one line of info per email.
     --dry-run                      * Don't actually send the emails.
     --[no-]validate                * Perform patch sanity checks. Default on.
-    --[no-]format-patch            * understand any non optional arguments as
-                                     `git format-patch` ones.
+    --[no-]format-patch            * Understand any non-optional arguments as
+                                     `git format-patch' arguments.
 
 EOT
 	exit(1);
-- 
1.6.2.2.479.g2aec
