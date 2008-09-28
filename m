From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] Docs: config: send-email config options included
Date: Sat, 27 Sep 2008 23:24:07 -0400
Message-ID: <20080928032407.GC15696@sigill.intra.peff.net>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <1222564196-84202-2-git-send-email-mfwitten@mit.edu> <1222564196-84202-3-git-send-email-mfwitten@mit.edu> <1222564196-84202-4-git-send-email-mfwitten@mit.edu> <1222564196-84202-5-git-send-email-mfwitten@mit.edu> <1222564196-84202-6-git-send-email-mfwitten@mit.edu> <1222564196-84202-7-git-send-email-mfwitten@mit.edu> <1222564196-84202-8-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 28 05:25:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjmuT-0006TJ-Iz
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 05:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbYI1DYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 23:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYI1DYK
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 23:24:10 -0400
Received: from peff.net ([208.65.91.99]:2585 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489AbYI1DYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 23:24:09 -0400
Received: (qmail 3018 invoked by uid 111); 28 Sep 2008 03:24:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 27 Sep 2008 23:24:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Sep 2008 23:24:07 -0400
Content-Disposition: inline
In-Reply-To: <1222564196-84202-8-git-send-email-mfwitten@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96940>

On Sat, Sep 27, 2008 at 08:09:56PM -0500, Michael Witten wrote:

> I just copied what is in the send-email man text.

NAK, this makes things much worse by creating two places which must be
updated with any changes. Shouldn't doing it the right way be as simple
as something like the patch below?

Though it looks like imap.* simply says "See git-imap-send(1)" in
config.txt, which would also be OK by me (and makes sense especially if
we drop most of the sendemail.* description in favor of just mentioning
the config option near the matching command-line option).

---
 Documentation/config.txt           |    2 +
 Documentation/git-send-email.txt   |   48 +-----------------------------------
 Documentation/sendemail-config.txt |   47 +++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c806749..0bb2621 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1173,6 +1173,8 @@ receive.denyNonFastForwards::
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
 
+include::sendemail-config.txt[]
+
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3c3e1b0..465cf56 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -195,53 +195,7 @@ The --to option must be repeated for each user you want on the to list.
 
 CONFIGURATION
 -------------
-sendemail.identity::
-	The default configuration identity. When specified,
-	'sendemail.<identity>.<item>' will have higher precedence than
-	'sendemail.<item>'. This is useful to declare multiple SMTP
-	identities and to hoist sensitive authentication information
-	out of the repository and into the global configuration file.
-
-sendemail.aliasesfile::
-	To avoid typing long email addresses, point this to one or more
-	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
-
-sendemail.aliasfiletype::
-	Format of the file(s) specified in sendemail.aliasesfile. Must be
-	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
-
-sendemail.to::
-	Email address (or alias) to always send to.
-
-sendemail.cccmd::
-	Command to execute to generate per patch file specific "Cc:"s.
-
-sendemail.bcc::
-	Email address (or alias) to always bcc.
-
-sendemail.chainreplyto::
-	Boolean value specifying the default to the '--chain_reply_to'
-	parameter.
-
-sendemail.smtpserver::
-	Default SMTP server to use.
-
-sendemail.smtpserverport::
-	Default SMTP server port to use.
-
-sendemail.smtpuser::
-	Default SMTP-AUTH username.
-
-sendemail.smtppass::
-	Default SMTP-AUTH password.
-
-sendemail.smtpencryption::
-	Default encryption method.  Use 'ssl' for SSL (and specify an
-	appropriate port), or 'tls' for TLS.  Takes precedence over
-	'smtpssl' if both are specified.
-
-sendemail.smtpssl::
-	Legacy boolean that sets 'smtpencryption=ssl' if enabled.
+include::sendemail-config.txt[]
 
 Author
 ------
diff --git a/Documentation/sendemail-config.txt b/Documentation/sendemail-config.txt
new file mode 100644
index 0000000..7409534
--- /dev/null
+++ b/Documentation/sendemail-config.txt
@@ -0,0 +1,47 @@
+sendemail.identity::
+	The default configuration identity. When specified,
+	'sendemail.<identity>.<item>' will have higher precedence than
+	'sendemail.<item>'. This is useful to declare multiple SMTP
+	identities and to hoist sensitive authentication information
+	out of the repository and into the global configuration file.
+
+sendemail.aliasesfile::
+	To avoid typing long email addresses, point this to one or more
+	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
+
+sendemail.aliasfiletype::
+	Format of the file(s) specified in sendemail.aliasesfile. Must be
+	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
+
+sendemail.to::
+	Email address (or alias) to always send to.
+
+sendemail.cccmd::
+	Command to execute to generate per patch file specific "Cc:"s.
+
+sendemail.bcc::
+	Email address (or alias) to always bcc.
+
+sendemail.chainreplyto::
+	Boolean value specifying the default to the '--chain_reply_to'
+	parameter.
+
+sendemail.smtpserver::
+	Default SMTP server to use.
+
+sendemail.smtpserverport::
+	Default SMTP server port to use.
+
+sendemail.smtpuser::
+	Default SMTP-AUTH username.
+
+sendemail.smtppass::
+	Default SMTP-AUTH password.
+
+sendemail.smtpencryption::
+	Default encryption method.  Use 'ssl' for SSL (and specify an
+	appropriate port), or 'tls' for TLS.  Takes precedence over
+	'smtpssl' if both are specified.
+
+sendemail.smtpssl::
+	Legacy boolean that sets 'smtpencryption=ssl' if enabled.
