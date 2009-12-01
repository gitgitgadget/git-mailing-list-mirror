From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Add link to other blame implementation in blame views
Date: Tue, 1 Dec 2009 17:54:26 +0100
Message-ID: <200912011754.27455.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <7v4oob8pap.fsf@alter.siamese.dyndns.org> <200912011751.12172.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:59:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFW4x-0006IS-Rw
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbZLAQ73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455AbZLAQ71
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:59:27 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:41194 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300AbZLAQ70 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:59:26 -0500
Received: by fxm5 with SMTP id 5so5124219fxm.28
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 08:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ycFLifMdAFf45ginpH2y+aE2Gz1I1yoa9yrCO1qAtVw=;
        b=EoOx83ypQVxry4GO+AXHASvMa6+cyWdmoUOLhsFOk/dsNZuQVy+rp9n5dk42QXzPl0
         IG18xyVuQ3f8gb1+yuRVPaVW+ETPIg/0tR1BcqUv9kxarfvP5iebE5VFPUdxEVZt5okw
         EQuVPVq4WoRsvG2VH1UPde6/GzjaQ3ibJzUTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pqq47G46lDmly+XIcBOUMMa4ytgDOcXz4w60Bnacwrg2DVFVwRsTCDCP0A+yNtzNMO
         TnE1I/t9F7THXZD3No2IHfRElHCtnPyKpuqPnOkg58UWHEj43Un8LcbN2DG+FUVy9CiN
         njlnMLMlHNvRYozfbkrOfWjwv7tuoRiwsBtww=
Received: by 10.86.233.20 with SMTP id f20mr5626258fgh.28.1259686772049;
        Tue, 01 Dec 2009 08:59:32 -0800 (PST)
Received: from ?192.168.1.13? (abwm69.neoplus.adsl.tpnet.pl [83.8.236.69])
        by mx.google.com with ESMTPS id l12sm2660703fgb.5.2009.12.01.08.59.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 08:59:31 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200912011751.12172.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134230>

Add link to 'blame_incremental' action (which requires JavaScript) in
'blame' view, and add link to 'blame' action in 'blame_incremental'
view.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bb2d29c..ca36761 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5006,6 +5006,17 @@ sub git_blame_common {
 	my $formats_nav =
 		$cgi->a({-href => href(action=>"blob", -replay=>1)},
 		        "blob") .
+		" | ";
+	if ($format eq 'incremental') {
+		$formats_nav .=
+			$cgi->a({-href => href(action=>"blame", javascript=>0, -replay=>1)},
+			        "blame") . " (non-incremental)";
+	} else {
+		$formats_nav .=
+			$cgi->a({-href => href(action=>"blame_incremental", -replay=>1)},
+			        "blame") . " (incremental)";
+	}
+	$formats_nav .=
 		" | " .
 		$cgi->a({-href => href(action=>"history", -replay=>1)},
 		        "history") .
-- 
1.6.5.3
