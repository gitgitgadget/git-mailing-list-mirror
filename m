From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 1/2] Add config_boolean() method to the Git perl module
Date: Tue, 20 Feb 2007 15:13:42 -0500
Message-ID: <11720024233629-git-send-email-tytso@mit.edu>
Cc: Theodore Ts'o <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 21:13:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJbN4-0001TE-9H
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 21:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbXBTUNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 15:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbXBTUNr
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 15:13:47 -0500
Received: from thunk.org ([69.25.196.29]:52686 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030413AbXBTUNq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 15:13:46 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HJbSF-0005KJ-Bs; Tue, 20 Feb 2007 15:19:15 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HJbMt-0003hG-BF; Tue, 20 Feb 2007 15:13:43 -0500
X-Mailer: git-send-email 1.5.0.1.38.g392d-dirty
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40258>

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 perl/Git.pm |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index f2c156c..51bd73e 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -516,6 +516,36 @@ sub config {
 }
 
 
+=item config_boolean ( VARIABLE )
+
+Retrieve the boolean configuration C<VARIABLE>.
+
+Must be called on a repository instance.
+
+This currently wraps command('config') so it is not so fast.
+
+=cut
+
+sub config_boolean {
+	my ($self, $var) = @_;
+	$self->repo_path()
+		or throw Error::Simple("not a repository");
+
+	try {
+		return $self->command_oneline('config', '--bool', '--get', 
+					      $var);
+	} catch Git::Error::Command with {
+		my $E = shift;
+		if ($E->value() == 1) {
+			# Key not found.
+			return undef;
+		} else {
+			throw $E;
+		}
+	};
+}
+
+
 =item ident ( TYPE | IDENTSTR )
 
 =item ident_person ( TYPE | IDENTSTR | IDENTARRAY )
-- 
1.5.0.1.38.g392d-dirty
