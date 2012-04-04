From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 2/8] gitweb: esc_html_hl_regions(): Don't create empty <span> elements
Date: Wed,  4 Apr 2012 21:57:07 +0200
Message-ID: <1333569433-3245-3-git-send-email-michal.kiedrowicz@gmail.com>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 21:57:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWKl-0001cc-4c
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 21:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623Ab2DDT53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 15:57:29 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59188 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932615Ab2DDT5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 15:57:25 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so409927wej.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KpX/N9FVIc93ioVq09GiRSZ5EVRvvejTjUQFc22IMuk=;
        b=I2xyGIEAMR+UGRSZayeRASu790hfXZdXCtI3R4TWuwjPSVfCoJkmwiI/Ud+Zpyqv5R
         gYLxM+FW5qU4fgCbQCpeqA3oUC5WakDDyzf3CjgTnwvh4xAgTEU4rfm5uKRRCxkD+G8J
         6yQlHpMh7aOMAOI4v0Po67Qg17V1zYvZ1Jtg/fk0a+PKkiJMNVUzWoZceWGLRUbXu+Xq
         4OJl9BYrwbKn/yrbIEmC8+xayHvEerK50Lc4SCRYw2iE53dRpOUi1rVGyE//5cCPuADD
         6EeNNaRaTQq3P2IAmOU2H48tDA7AgSkcIkIQ8Hz620L6MIauNiFoY5cDutFcOGSaPwD7
         ifbA==
Received: by 10.216.85.81 with SMTP id t59mr2263493wee.28.1333569444468;
        Wed, 04 Apr 2012 12:57:24 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id fn2sm6743684wib.0.2012.04.04.12.57.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 12:57:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194725>

If $end is equal to or less than $beg, esc_html_hl_regions()
generates an empty <span> element.  It normally shouldn't be visible in
the web browser, but it doesn't look good when looking at page source.
It also minimally increases generated page size for no special reason.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a3754ff..ca3058c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1740,6 +1740,9 @@ sub esc_html_hl_regions {
 	for my $s (@sel) {
 		my ($beg, $end) =3D @$s;
=20
+		# Don't create empty <span> elements.
+		next if $end <=3D $beg;=20
+
 		$out .=3D esc_html(substr($str, $pos, $beg - $pos))
 			if ($beg - $pos > 0);
 		$out .=3D $cgi->span({-class =3D> $css_class},
--=20
1.7.8.4
