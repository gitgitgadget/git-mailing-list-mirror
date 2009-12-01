From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Make linking to actions requiring JavaScript a feature
Date: Tue, 1 Dec 2009 17:52:04 +0100
Message-ID: <200912011752.04986.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <7v4oob8pap.fsf@alter.siamese.dyndns.org> <200912011751.12172.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:59:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFW4x-0006IS-85
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457AbZLAQ71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754451AbZLAQ71
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:59:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:32725 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbZLAQ7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:59:25 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1462206fgg.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 08:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8M26yc6490Ke+Py3E7r8ToIpgJSy5iptD9U/8TnGKsU=;
        b=spmo8Vb0u9xkmbYdmoR8xZ4du5QKTo4yaT5bwPb4ePd7uhW5FMS7+6L4RNrpcnTWJx
         dx75I63ZyZFXdz+TpKuHlvFDPw3nOdFiNXrvlo+fbcnc9UoT5NnqfW7TkCn+xtiw5+OF
         ZALPcFtzc3PCIdSMZeqUT8KXw2CMP6ooyXdWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rP7FJfzxLNeGc4repGhpN7iKGvhbxbkZ+lME4tUR/4hiVhRYCIgY0rA6eyQ9SOLsu1
         YC7zX0WgxzTkuFtal/ng3WczSlnLEU7bBjFLsqBvj+jhrDvxcqaKd+FVyCcJqxXVH6Jd
         7rzBf1sEed0Py+hMNVO97HViSOTjVKvi9g2o8=
Received: by 10.87.64.6 with SMTP id r6mr5615095fgk.48.1259686770755;
        Tue, 01 Dec 2009 08:59:30 -0800 (PST)
Received: from ?192.168.1.13? (abwm69.neoplus.adsl.tpnet.pl [83.8.236.69])
        by mx.google.com with ESMTPS id l12sm2660703fgb.5.2009.12.01.08.59.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 08:59:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200912011751.12172.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134228>

Let gitweb turn some links (like 'blame' links) into linking to
actions which require JavaScript (like 'blame_incremental' action)
only if 'javascript-actions' feature is enabled.

This means that links to such actions would be present only if both
JavaScript is enabled, and 'javascript-actions' feature is enabled.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a80cbd3..bb2d29c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -432,6 +432,13 @@ our %feature = (
 	'timed' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# Enable turning some links into links to actions which require
+	# JavaScript to run (like 'blame_incremental').  Disabled by default.
+	# Project specific override is currently not supported.
+	'javascript-actions' => {
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -3326,7 +3333,7 @@ sub git_footer_html {
 		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
 		      qq!           "!. href() .qq!");\n!.
 		      qq!</script>\n!;
-	} else {
+	} elsif (gitweb_check_feature('javascript-actions')) {
 		print qq!<script type="text/javascript">\n!.
 		      qq!window.onload = fixLinks;\n!.
 		      qq!</script>\n!;
-- 
1.6.5.3
