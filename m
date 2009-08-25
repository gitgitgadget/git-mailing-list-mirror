From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH v2 1/3] gitweb: improve snapshot error handling
Date: Tue, 25 Aug 2009 00:59:48 -0400
Message-ID: <4A936FC4.1070001@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 07:00:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfo8c-0006x0-JS
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 07:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbZHYE7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 00:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbZHYE7y
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 00:59:54 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:59828 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751050AbZHYE7x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2009 00:59:53 -0400
Received: from karakura.local (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7P4xnWl016582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Aug 2009 00:59:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: 16eb82c8-f36c-4362-8c22-9fd712706063
X-Miltered: at mailchk-m05 with ID 4A936FC5.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Tue, 25 Aug 2009 00:59:51 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127000>

I reworded the message to be more specific about what code was
being changed.

-- 
Mark A Rada (ferrous26)
marada@uwaterloo.ca


--->8---
The last check in the second block of checks in the &git_snapshot
routine is never executed because the second last check is a superset
of the last check.

This change will switch the order of the last two checks. It has the
advantage of giving clients a more specific reason why they cannot get
a snapshot format if the format they have chosen is disabled.

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
1.6.4
