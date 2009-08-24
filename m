From: Mark Rada <marada@uwaterloo.ca>
Subject: [RFC/PATCH 1/3] gitweb: improve snapshot error handling
Date: Sun, 23 Aug 2009 23:09:36 -0400
Message-ID: <4A920470.1090709@mailservices.uwaterloo.ca>
References: <4A91BA66.5050108@mailservices.uwaterloo.ca> <4A91BE50.7070103@vilain.net> <4A91C512.7000707@mailservices.uwaterloo.ca> <4A91C74D.1080908@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Rada <marada@uwaterloo.ca>, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Aug 24 05:09:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfPwS-0005ih-DD
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 05:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbZHXDJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 23:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbZHXDJp
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 23:09:45 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:39023 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751152AbZHXDJo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 23:09:44 -0400
Received: from karakura.local (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7O39aIG018810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Aug 2009 23:09:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
In-Reply-To: <4A91C74D.1080908@vilain.net>
X-UUID: de328b2f-82f7-44cb-8818-e1a8c03ff64b
X-Miltered: at mailchk-m05 with ID 4A920470.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Sun, 23 Aug 2009 23:09:44 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126899>

Ok, this is just a resend of the first patch in my set from
earlier, but with some of the commit message reworded, namely
the subject (as suggested by Sam Vilain).

--
Mark Rada (ferrous26)
marada@uwaterloo.ca


--->8---
In the second block of checks to validate a snapshot request, the last
check is never executed because the second last check is a superset of
the last check.

This change will switch the order of the last two checks, it has the
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
