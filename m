From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 3/8] gitweb: Pass esc_html_hl_regions() options to esc_html()
Date: Wed,  4 Apr 2012 21:57:08 +0200
Message-ID: <1333569433-3245-4-git-send-email-michal.kiedrowicz@gmail.com>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 21:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWKl-0001cc-N1
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 21:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766Ab2DDT5b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 15:57:31 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53202 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932580Ab2DDT52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 15:57:28 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq7so630903wib.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JmgdJLZ2/sDOWqI9Dn+bTrN11ghq/Gaf+900mfIvy5A=;
        b=ntonNqUZT7KB45v1Da4tAt/rBvHrOxFO9vKCJQwYHVAAdalXocWPwZVfHFyz4J0BUq
         Xbek+Lg4QabaKrYx+4pAP9oLRJPdTVHWdO5UD84j30S3Ah1ipiu5IIaiYVWQKerOWlMU
         Joj+vOooqiZb+6cX+RI8wnWm3UQmGTNjZhFo8vD/NXXAt6cts4lTWfydEAuXWwpsT92/
         HsKRn328MzBPE5DAIlToKjUm6JwQ1hPGLuqWXCsyrNVRDFaMSW8IofYzGkeyZnYKODDM
         AL8DrN7DGiGeTth8rWpj5lRRvkELQhgQBrcEdCwALJcPD36zOIKIyHxizoh5vcKtMANI
         PZnA==
Received: by 10.216.132.222 with SMTP id o72mr2098658wei.95.1333569447485;
        Wed, 04 Apr 2012 12:57:27 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id l5sm7352949wia.11.2012.04.04.12.57.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 12:57:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194726>

=46rom: Jakub Nar=C4=99bski <jnareb@gmail.com>

With this change, esc_html_hl_regions() accepts options and passes them
down to esc_html().  This may be needed if a caller wants to pass
-nbsp=3D>1 to esc_html().

The idea and implementation example of this change was described in
337da8d2 (gitweb: Introduce esc_html_match_hl and esc_html_hl_regions,
2012-02-27).  While other suggestions may be more useful in some cases,
there is no need to implement them at the moment.  The
esc_html_hl_regions() interface may be changed later if it's needed.

[mk: extracted from larger patch and wrote commit message]

Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ca3058c..d5f802f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1732,7 +1732,9 @@ sub chop_and_escape_str {
 # '<span class=3D"mark">foo</span>bar'
 sub esc_html_hl_regions {
 	my ($str, $css_class, @sel) =3D @_;
-	return esc_html($str) unless @sel;
+	my %opts =3D grep { ref($_) ne 'ARRAY' } @sel;
+	@sel     =3D grep { ref($_) eq 'ARRAY' } @sel;
+	return esc_html($str, %opts) unless @sel;
=20
 	my $out =3D '';
 	my $pos =3D 0;
@@ -1743,14 +1745,14 @@ sub esc_html_hl_regions {
 		# Don't create empty <span> elements.
 		next if $end <=3D $beg;=20
=20
-		$out .=3D esc_html(substr($str, $pos, $beg - $pos))
+		$out .=3D esc_html(substr($str, $pos, $beg - $pos), %opts)
 			if ($beg - $pos > 0);
 		$out .=3D $cgi->span({-class =3D> $css_class},
-		                   esc_html(substr($str, $beg, $end - $beg)));
+		                   esc_html(substr($str, $beg, $end - $beg), %opts))=
;
=20
 		$pos =3D $end;
 	}
-	$out .=3D esc_html(substr($str, $pos))
+	$out .=3D esc_html(substr($str, $pos), %opts)
 		if ($pos < length($str));
=20
 	return $out;
--=20
1.7.8.4
