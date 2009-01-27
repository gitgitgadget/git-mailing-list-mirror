From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3] gitweb: make static files accessible with PATH_INFO
Date: Tue, 27 Jan 2009 14:29:06 +0100
Message-ID: <1233062946-22395-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 14:31:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRo1X-0003zR-GG
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 14:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbZA0N3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 08:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbZA0N3M
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 08:29:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:4199 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbZA0N3L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 08:29:11 -0500
Received: by fg-out-1718.google.com with SMTP id 13so138547fge.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 05:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Fda4E0VJ0Z+Ry6TJ2Xp7SSGH93KsUVexaIy9l6vCmJI=;
        b=dM4ROEqowbWPcPHE+aZtmtC+QZ7AL3JCi15AZ/xBOkZCoQpMYJ8ic96D5N24SYnPT2
         dNMSvv+kn3fZCL/Hjv5O1Zv1gRcgmELHXiWMYp/erYldLXPSJTf+P9booh4RTNFSGWWi
         FdcZhBrnzpqTwhGde45FkNhPhEApmduR0FVtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eTv2pot26wsHOfAz/2EdsG5AbdKh57os3Dbj9X8akc4BLyar0OLl0zPY7kiuS5Nzw3
         WgdhFohDOT5KmMTGC73hcYZRWd4CRe09K7t4frIURp00nBFExtm0ipA1pQzkTUlbEoYD
         +MG/Ofk0zqReVmvuhqFxIVOasUhiWL2ySwg4o=
Received: by 10.86.93.17 with SMTP id q17mr74023fgb.46.1233062948333;
        Tue, 27 Jan 2009 05:29:08 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id e20sm156658fga.53.2009.01.27.05.29.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 05:29:07 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107344>

When PATH_INFO is defined, static files such as the defalt CSS or the
shortcut icon are not accessible beyond the summary page (e.g. in
shortlog or commit view).

Fix this by adding a <base> tag pointing to the script base URL.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
Of course, last time I forgot that the BASE href is supposed to be
absolute. While Opera apparently has no problem with it being relative,
other browsers such as Firefox are stricter about it.

 gitweb/gitweb.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 931db4f..411b1f6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2901,6 +2901,14 @@ sub git_header_html {
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 EOF
+# the stylesheet, favicon etc urls won't work correctly with path_info unless we set the appropriate base URL
+	if ($ENV{'PATH_INFO'}) {
+		my $base = $my_url;
+		my $sname = $ENV{'SCRIPT_NAME'};
+		$base =~ s,\Q$sname\E$,,;
+		$base .= "/";
+		print "<base href=\"$base\"/>\n";
+	}
 # print out each stylesheet that exist
 	if (defined $stylesheet) {
 #provides backwards capability for those people who define style sheet in a config file
-- 
1.5.6.5
