From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v2 1/8] gitweb: esc_html_hl_regions(): Don't create empty <span> elements
Date: Fri, 23 Mar 2012 23:56:50 +0100
Message-ID: <1332543417-19664-2-git-send-email-michal.kiedrowicz@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 23:57:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBDQL-0006K1-3g
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 23:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254Ab2CWW5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 18:57:08 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41012 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab2CWW5E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 18:57:04 -0400
Received: by wibhq7 with SMTP id hq7so2508665wib.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 15:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GaNS5BGjFbVt1+QjiHNSB689LfOSZ/9Nl5oHlFSMnZo=;
        b=kaPF2FOickRKbtSii6dgey9Re/JwdtbazINb83JrJclvEEkBfSPpeAwvHjqRjlP0Pl
         JPg1EUe5vXCZof3kN34Kd9dgd7d6rcZXnIyV0Tm/WrkwMMflwHBy0yR1TFmy3nCdEty9
         BQWCiK1tVCvge1uwgdwhiDSQFhvrmvpRift0Zmtoo3QR0SKF+uXN7AyqZuhG0hGJL1xQ
         kMihAG5Rw9WNkO8JPhPUKQJYHbnuQYhY9FSUn/fKiJAxVOq7BGhZyFTGmvxGNEIVdz1n
         L+6OFV24Vwo67yvFGjPMDSX3MsBldVMYIk+eOIrYardOvHOqpAYI2pO48b23Cn01AlAZ
         WvYg==
Received: by 10.180.105.194 with SMTP id go2mr680730wib.22.1332543422962;
        Fri, 23 Mar 2012 15:57:02 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id ex2sm28908101wib.8.2012.03.23.15.57.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:57:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193806>

if $s->[1] is equal to or less than $s->[0], esc_html_hl_regions()
generates an empty <span> element.  It normally shouldn't be visible in
the web broweser, but it doesn't look good when looking at page source.
It also minimally increases generated page size for no special reason.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---

I don't know if any code currently can produce empty <span> elements,
but diff refinement highlighning does it.

 gitweb/gitweb.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a8b5fad..af645e5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1738,6 +1738,9 @@ sub esc_html_hl_regions {
 	my $pos =3D 0;
=20
 	for my $s (@sel) {
+		# Don't craete empty <span> elements.
+		next if $s->[1] <=3D $s->[0];
+
 		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos))
 			if ($s->[0] - $pos > 0);
 		$out .=3D $cgi->span({-class =3D> $css_class},
--=20
1.7.8.4
