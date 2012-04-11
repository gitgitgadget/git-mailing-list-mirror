From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v4 1/8] gitweb: Use descriptive names in esc_html_hl_regions()
Date: Wed, 11 Apr 2012 23:18:37 +0200
Message-ID: <1334179124-14258-2-git-send-email-michal.kiedrowicz@gmail.com>
References: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, michal.kiedrowicz@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 11 23:19:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4wU-00053U-UR
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933350Ab2DKVSz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 17:18:55 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59695 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab2DKVSy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:18:54 -0400
Received: by wejx9 with SMTP id x9so835082wej.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0128j2o9Pa2qwfsEbugoIOMpF8g8OIflgRjjcpOgMpI=;
        b=XacCF+7bHMEPihqB9QjUnDXOz9Gr9F18ZaxAtx/y9nTgwlZVanYK7Xd8dC9zbXE+VY
         DaRaaw9H3D/7TprJSz70ahGQ2O2efgaIj4P1eqr1xmuQIHJmi3iXHUqQGDfiT+W7kUAf
         pIjt9KENrmjZVxUYL6uo2ulzXW2cZM2lchniuW8eB19PxD8qs/I3a5qgahnDz9bBmcJi
         nIboOdYAnC3BLUqmTe9cg8P8Q3slUu6rN0SySRylj4hy3Kxz6OsHSjMhMFy/HkgOdqIm
         dvSzf6ptyPA46WLlqrshDA31fUjhBIpdTdjA395EmmDFuYiru/hVKEuREpJi7FrtUUsb
         YGOw==
Received: by 10.216.132.229 with SMTP id o79mr9437726wei.64.1334179132792;
        Wed, 11 Apr 2012 14:18:52 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id n8sm13723996wix.10.2012.04.11.14.18.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:18:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195257>

The $s->[0] and $s->[1] variables look a bit cryptic.  Let's rename the=
m
to $begin and $end so that it's clear what they do.

Suggested-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a8b5fad..1c54301 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1738,12 +1738,15 @@ sub esc_html_hl_regions {
 	my $pos =3D 0;
=20
 	for my $s (@sel) {
-		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos))
-			if ($s->[0] - $pos > 0);
-		$out .=3D $cgi->span({-class =3D> $css_class},
-		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0])=
));
+		my ($begin, $end) =3D @$s;
=20
-		$pos =3D $s->[1];
+		my $escaped =3D esc_html(substr($str, $begin, $end - $begin));
+
+		$out .=3D esc_html(substr($str, $pos, $begin - $pos))
+			if ($begin - $pos > 0);
+		$out .=3D $cgi->span({-class =3D> $css_class}, $escaped);
+
+		$pos =3D $end;
 	}
 	$out .=3D esc_html(substr($str, $pos))
 		if ($pos < length($str));
--=20
1.7.8.4
