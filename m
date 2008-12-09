From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Move 'lineno' id from link to row element in
	git_blame
Date: Tue, 09 Dec 2008 23:46:16 +0100
Message-ID: <20081209224330.28106.18301.stgit@localhost.localdomain>
References: <20081209223703.28106.29198.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 23:47:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LABMk-0002XR-2q
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 23:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbYLIWqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 17:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbYLIWqZ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 17:46:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:22348 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbYLIWqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 17:46:24 -0500
Received: by ug-out-1314.google.com with SMTP id 39so79422ugf.37
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 14:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=L2saSOyQVnrya+LolqA9/v7DXrwHz4M6Tr0t4nLME7E=;
        b=g2lQ0HhI+ve2p+yuJYsytDCrVv+BLGUrGcSdEZlaQXuCR4w/l48tQgUwx/qKBOMBBO
         we3shwsJhtx8yldUeRa59HWubhXDFTk/shxwoj4Hc0O85G47g24Ny4nYFWD8NPyY8BqH
         70Es30w73oCdTFwjFQ3S5f2Gb6HyjEI+CxL4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=u3T6d5Ru7fdLd98kV1GFx4hFp+lZy/zF8ZqUPHcs5CFuJVpdA/DgvZQACheJQ0SUmf
         sGqfu3Ivok/E3Sp01C7+/EQcRp+vZJe/7f4GmtXRAbz7+YCKYYqtNt+vJqbLut9At+wd
         aX/KZlgS3SSkv+1qvodt+tWOdZBf5Uees2fwA=
Received: by 10.86.49.13 with SMTP id w13mr300023fgw.54.1228862782046;
        Tue, 09 Dec 2008 14:46:22 -0800 (PST)
Received: from localhost.localdomain (absh60.neoplus.adsl.tpnet.pl [83.8.127.60])
        by mx.google.com with ESMTPS id e20sm53825fga.17.2008.12.09.14.46.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Dec 2008 14:46:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB9MkGFL028207;
	Tue, 9 Dec 2008 23:46:17 +0100
In-Reply-To: <20081209223703.28106.29198.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102658>

Move l<line number> ID from <a> link element inside table row (inside
cell element for column with line numbers), to encompassing <tr> table
row element.  It was done to make it easier to manipulate result HTML
with DOM, and to be able write 'blame_incremental' view with the same,
or nearly the same result.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
For blame_incremental I need easy way to manipulate rows of blame
table, to add information about blamed commits as it arrives.

So there it is.

 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6eb370d..1b800f4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4645,7 +4645,7 @@ HTML
 		if ($group_size) {
 			$current_color = ++$current_color % $num_colors;
 		}
-		print "<tr class=\"$rev_color[$current_color]\">\n";
+		print "<tr id=\"l$lineno\" class=\"$rev_color[$current_color]\">\n";
 		if ($group_size) {
 			print "<td class=\"sha1\"";
 			print " title=\"". esc_html($author) . ", $date\"";
@@ -4667,7 +4667,6 @@ HTML
 		                  hash_base => $parent_commit);
 		print "<td class=\"linenr\">";
 		print $cgi->a({ -href => "$blamed#l$orig_lineno",
-		                -id => "l$lineno",
 		                -class => "linenr" },
 		              esc_html($lineno));
 		print "</td>";
