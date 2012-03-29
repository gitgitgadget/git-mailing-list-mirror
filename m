From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20gitweb=3A=20Use=20descriptive=20names=20in=20esc=5Fhtml=5Fhl=5Fregions=28=29?=
Date: Thu, 29 Mar 2012 20:04:20 +0200
Message-ID: <1333044260-31278-1-git-send-email-michal.kiedrowicz@gmail.com>
References: <201203241958.23835.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 20:04:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJiI-0001xL-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 20:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933537Ab2C2SEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 14:04:41 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:56108 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933285Ab2C2SEi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 14:04:38 -0400
Received: by wibhr17 with SMTP id hr17so44843wib.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yXaqbTzra3LE0QKw7AqrLRo52nKVB7/+qwLl13IiNnE=;
        b=PYXCUtt60esO/qdCVU+5KwfLaqYcM4jA3Padf5IW3SaLpbDHzYP2M4hqDFe0i158WP
         sMsBtOHpQsVnbBq6kj3b8032KX+M78Rt0b1eohmdsxVeNqbYcIAA6pfhHzg+RhZDzoLV
         zTnMewtd086siu4e76m0DcCz37HnbFU1RN3bNL153pI+B4NniLyzDyy/g5HDGvEe0sp6
         /bzlcLcedzvhDt0O6QYBWmcrONPheEd05ITCGQ19fiKI8LWCo28qhfKEPUWcTP0SXwA/
         fzdMTsvGE05BOLuh8JHisreBz5kTJ8CVSXVZjv+WvgeXvHWfzU9FDIyIeEw0XorGdZ6m
         1EhA==
Received: by 10.180.97.4 with SMTP id dw4mr7814795wib.18.1333044275651;
        Thu, 29 Mar 2012 11:04:35 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id n15sm68805731wiw.6.2012.03.29.11.04.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 11:04:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <201203241958.23835.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194281>

The $s->[0] and $s->[1] variables look a bit cryptic.  Let's rename the=
m
to $beg and $end so that it's clear what they do.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---

> P.S. I wonder if it wouldn't be better if we created and used loop-lo=
cal
> variables with descriptive names, e.g.
>=20
>   my ($beg, $end) =3D @$s;
>=20
> and use $beg in place of $s->[0] and $end in place of $s->[1], which =
are
> a bit cryptic.
>=20
> This of course doesn't affect this patch.

Something like this? (patch not based on this series, may be applied
independently).

 gitweb/gitweb.perl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a8b5fad..a3754ff 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1738,12 +1738,14 @@ sub esc_html_hl_regions {
 	my $pos =3D 0;
=20
 	for my $s (@sel) {
-		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos))
-			if ($s->[0] - $pos > 0);
+		my ($beg, $end) =3D @$s;
+
+		$out .=3D esc_html(substr($str, $pos, $beg - $pos))
+			if ($beg - $pos > 0);
 		$out .=3D $cgi->span({-class =3D> $css_class},
-		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0])=
));
+		                   esc_html(substr($str, $beg, $end - $beg)));
=20
-		$pos =3D $s->[1];
+		$pos =3D $end;
 	}
 	$out .=3D esc_html(substr($str, $pos))
 		if ($pos < length($str));
--=20
1.7.8.4
