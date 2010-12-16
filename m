From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 3/3] gitweb: remove test when closing file descriptor
Date: Thu, 16 Dec 2010 22:43:21 +0100
Message-ID: <1292535801-7421-4-git-send-email-sylvain@abstraction.fr>
References: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 16 22:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTLbr-0005V0-Be
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 22:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757517Ab0LPVnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 16:43:33 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46412 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510Ab0LPVnc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 16:43:32 -0500
Received: by wyb28 with SMTP id 28so9200wyb.19
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 13:43:31 -0800 (PST)
Received: by 10.216.52.143 with SMTP id e15mr2938112wec.44.1292535810940;
        Thu, 16 Dec 2010 13:43:30 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id n11sm297651wej.43.2010.12.16.13.43.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 13:43:30 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163816>

it happens that closing file descriptor fails whereas
the blob is perfectly readable.

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9398475..9a885b1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3450,8 +3450,7 @@ sub run_highlighter {
 	my ($fd, $highlight, $syntax) = @_;
 	return $fd unless ($highlight && defined $syntax);
 
-	close $fd
-		or die_error(404, "Reading blob failed");
+	close $fd;
 	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
 	          quote_command($highlight_bin).
 	          " --xhtml --fragment --syntax $syntax |"
-- 
1.7.3.2
