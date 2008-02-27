From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-remote: do not complain on multiple URLs for a remote
Date: Wed, 27 Feb 2008 13:55:30 -0800
Message-ID: <7v3arerrn1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 22:56:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUUGI-0006eA-Kp
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 22:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbYB0Vzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 16:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbYB0Vzt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 16:55:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYB0Vzt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 16:55:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C2C92B6B;
	Wed, 27 Feb 2008 16:55:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D18D52B69; Wed, 27 Feb 2008 16:55:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75305>

Having more than one URL for a remote is perfectly normal when
the remote is defined to push to multiple places.  Get rid of
the annoying "Warning" message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-remote.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 5cd6951..b30ed73 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -7,10 +7,10 @@ my $git = Git->repository();
 sub add_remote_config {
 	my ($hash, $name, $what, $value) = @_;
 	if ($what eq 'url') {
-		if (exists $hash->{$name}{'URL'}) {
-			print STDERR "Warning: more than one remote.$name.url\n";
+		# Having more than one is Ok -- it is used for push.
+		if (! exists $hash->{'URL'}) {
+			$hash->{$name}{'URL'} = $value;
 		}
-		$hash->{$name}{'URL'} = $value;
 	}
 	elsif ($what eq 'fetch') {
 		$hash->{$name}{'FETCH'} ||= [];
-- 
1.5.4.3.339.gad2d1
