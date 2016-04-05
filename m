From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] send-email: more meaningful Message-ID
Date: Tue,  5 Apr 2016 19:39:52 +0000
Message-ID: <20160405193952.5849-1-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 21:40:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anWpa-0002nw-Rl
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 21:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933373AbcDETkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 15:40:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42131 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933081AbcDETkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 15:40:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB4520437;
	Tue,  5 Apr 2016 19:39:59 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290805>

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
 git-send-email.perl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d356901..23141e7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -949,7 +949,8 @@ my ($message_id_stamp, $message_id_serial);
 sub make_message_id {
 	my $uniq;
 	if (!defined $message_id_stamp) {
-		$message_id_stamp = sprintf("%s-%s", time, $$);
+		use POSIX qw/strftime/;
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
