From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v2 2/8] gitweb: Pass esc_html_hl_regions() options to esc_html()
Date: Fri, 23 Mar 2012 23:56:51 +0100
Message-ID: <1332543417-19664-3-git-send-email-michal.kiedrowicz@gmail.com>
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
	id 1SBDQK-0006K1-Gv
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 23:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757220Ab2CWW5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 18:57:07 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:34174 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab2CWW5F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 18:57:05 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so2998508wej.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 15:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zt6Q9JEARBuCdyTUOOoYjrhhGLJ4MD7O4amsltaP3P8=;
        b=jOP2BVNcZX+cahG4AqYEwxbxJQif9kgehv//e7LWZGhUUMnohwblI3nKuOT2N+xjN7
         AECn4stNWJm594IvwRQ0gXtohicGNlOnCKcind6PeNPLXxxMFmREakGcbES361vRUD6R
         yVcFw1jDJs8xHVX/9Me42xYiO2ijF8YPvli1JNK8i6bnC3jfPTZMi3E0T7pZs9+y+bmx
         ptT0eNrtFDn+Gp/0vTf0f7mwHHQn+NLodDA519DH0aG/nJwKeJf1Qn4Rf30Fo6ZO5zss
         Yp3RJE4w4L8f4TiScAGF46Xj2nu+I4BRg2UelNhhIqYonS20wjZ6frPyy/617R4hpFEG
         IREQ==
Received: by 10.180.81.37 with SMTP id w5mr711490wix.16.1332543424726;
        Fri, 23 Mar 2012 15:57:04 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id n15sm17645985wiw.6.2012.03.23.15.57.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:57:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193805>

With this change, esc_html_hl_regions() accepts options and passes them
down to esc_html().  This may be needed if a caller wants to pass
-nbsp=3D>1 to esc_html().

The idea and implementation example of this change was described in
337da8d2 (gitweb: Introduce esc_html_match_hl and esc_html_hl_regions,
2012-02-27).  While other suggestions may be more useful in some cases,
there is no need to implement them at the moment.  The
esc_html_hl_regions() interface may be changed later if it's needed.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---

Jakub, The code was in fact stolen from a yours patch posted to the
list (gitweb: Use esc_html_match_hl() in 'grep' search) that wasn't
merged so maybe I should pass the authorship to you?

 gitweb/gitweb.perl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index af645e5..1744c40 100755
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
@@ -1741,14 +1743,14 @@ sub esc_html_hl_regions {
 		# Don't craete empty <span> elements.
 		next if $s->[1] <=3D $s->[0];
=20
-		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos))
+		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos), %opts)
 			if ($s->[0] - $pos > 0);
 		$out .=3D $cgi->span({-class =3D> $css_class},
-		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0])=
));
+		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0])=
, %opts));
=20
 		$pos =3D $s->[1];
 	}
-	$out .=3D esc_html(substr($str, $pos))
+	$out .=3D esc_html(substr($str, $pos), %opts)
 		if ($pos < length($str));
=20
 	return $out;
--=20
1.7.8.4
