From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v2] send-email: more meaningful Message-ID
Date: Wed, 6 Apr 2016 20:07:14 +0000
Message-ID: <20160406200714.GA19315@dcvr.yhbt.net>
References: <20160405193952.5849-1-normalperson@yhbt.net>
 <xmqqinzv224x.fsf@gitster.mtv.corp.google.com>
 <20160405213607.GA15023@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 22:07:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1antjV-0004pn-PV
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 22:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbcDFUHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 16:07:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42087 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbcDFUHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 16:07:14 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29CA22044E;
	Wed,  6 Apr 2016 20:07:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160405213607.GA15023@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290866>

Using a YYYYmmddHHMMSS date representation is more meaningful to
humans, especially when used for lookups on NNTP servers or linking
to archive sites via Message-ID (e.g. mid.gmane.org or
mid.mail-archive.com).  This timestamp format more easily gives a
reader of the URL itself a rough date of a linked message compared
to having them calculate the seconds since the Unix epoch.

Furthermore, having the MUA name in the Message-ID seems to be a
rare oddity I haven't noticed outside of git-send-email.  We
already have an optional X-Mailer header field to advertise for
us, so extending the Message-ID by 15 characters can make for
unpleasant Message-ID-based URLs to archive sites.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  v2 - moved "use" to the top
  Thanks to Dscho for addressing Windows comments:
  http://mid.gmane.org/alpine.DEB.2.20.1604061505010.3371@virtualbox

 git-send-email.perl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d356901..52cf828 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -19,6 +19,7 @@
 use 5.008;
 use strict;
 use warnings;
+use POSIX qw/strftime/;
 use Term::ReadLine;
 use Getopt::Long;
 use Text::ParseWords;
@@ -949,7 +950,7 @@ my ($message_id_stamp, $message_id_serial);
 sub make_message_id {
 	my $uniq;
 	if (!defined $message_id_stamp) {
-		$message_id_stamp = sprintf("%s-%s", time, $$);
+		$message_id_stamp = strftime("%Y%m%d%H%M%S.$$", gmtime(time));
 		$message_id_serial = 0;
 	}
 	$message_id_serial++;
@@ -964,7 +965,7 @@ sub make_message_id {
 		require Sys::Hostname;
 		$du_part = 'user@' . Sys::Hostname::hostname();
 	}
-	my $message_id_template = "<%s-git-send-email-%s>";
+	my $message_id_template = "<%s-%s>";
 	$message_id = sprintf($message_id_template, $uniq, $du_part);
 	#print "new message id = $message_id\n"; # Was useful for debugging
 }
-- 
EW
