From: Mark Rada <marada@uwaterloo.ca>
Subject: [RFC/PATCH 1/3] gitweb: make suspenders more useful
Date: Sun, 23 Aug 2009 17:53:42 -0400
Message-ID: <4A91BA66.5050108@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 23:54:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfL0h-0005za-Sf
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 23:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbZHWVxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbZHWVxs
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 17:53:48 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:43965 "EHLO
	mailchk-m03.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750792AbZHWVxr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 17:53:47 -0400
Received: from karakura.local (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by mailchk-m03.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7NLrgpH016815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Aug 2009 17:53:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: f1db57aa-c655-477f-8318-91692fe8902b
X-Miltered: at mailchk-m03 with ID 4A91BA66.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m03
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m03.uwaterloo.ca [129.97.128.141]); Sun, 23 Aug 2009 17:53:44 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126885>

In the first block of checks to validate a snapshot request, the last
check is never executed because the second last check is a superset of
the last check.

This change will switch the order of the last two checks, it has the
advantage of giving clients a more specific reason why they cannot get
a specific snapshot format instead of giving them the more generic
response.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4a42f61..7068db2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5174,10 +5174,10 @@ sub git_snapshot {
 		die_error(400, "Invalid snapshot format parameter");
 	} elsif (!exists($known_snapshot_formats{$format})) {
 		die_error(400, "Unknown snapshot format");
-	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
-		die_error(403, "Unsupported snapshot format");
 	} elsif ($known_snapshot_formats{$format}{'disabled'}) {
 		die_error(403, "Snapshot format not allowed");
+	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
+		die_error(403, "Unsupported snapshot format");
 	}
 
 	if (!defined $hash) {
-- 
Mark A Rada (ferrous26)
marada@uwaterloo.ca
