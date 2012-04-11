From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v4 2/8] gitweb: esc_html_hl_regions(): Don't create empty <span> elements
Date: Wed, 11 Apr 2012 23:18:38 +0200
Message-ID: <1334179124-14258-3-git-send-email-michal.kiedrowicz@gmail.com>
References: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, michal.kiedrowicz@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 11 23:19:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4wV-00053U-G8
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933363Ab2DKVS5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 17:18:57 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43287 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351Ab2DKVS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:18:56 -0400
Received: by mail-wi0-f172.google.com with SMTP id hj6so4824587wib.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sQnC7oXU56H22URh1qq3OMg2WXzzhj/+n6ONxpZL6e8=;
        b=LQkV2XnRaXMKe1qYbhVJxy6mhhTMj+dSxAywsBn5kHDjZc7UA0SPscJiz8grusJOkn
         rzNMnSngvbMF65Zm9HxGKFhRuNfj2aRok7sO+OVBvGWq8afzUsncslHCGZkHgWOMPUvj
         gIX25MTP3/NxuSbxcYt1x2UJIddln9Pbvbt4xngWtWjHlXm5eRqwUoqUgjo+mPXu89bd
         Op+e7rsII2TsmC1EpvJ9yL6YlhMNA5Yc87h23PiMRVw43ekJqHue9oiqnKFiewEJlkU3
         s9mCKPSGxqcCdAvBCoBBjTl6G0kb/wT4yr2vq6sKlLN0lH00exTiXXd5Bepn6P6TJaE4
         zCgw==
Received: by 10.180.104.230 with SMTP id gh6mr19370921wib.22.1334179135841;
        Wed, 11 Apr 2012 14:18:55 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id gg2sm13734462wib.7.2012.04.11.14.18.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:18:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195258>

If $end is equal to or less than $begin, esc_html_hl_regions()
generates an empty <span> element.  It normally shouldn't be visible in
the web browser, but it doesn't look good when looking at page source.
It also minimally increases generated page size for no special reason.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1c54301..588b87d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1740,6 +1740,9 @@ sub esc_html_hl_regions {
 	for my $s (@sel) {
 		my ($begin, $end) =3D @$s;
=20
+		# Don't create empty <span> elements.
+		next if $end <=3D $begin;
+
 		my $escaped =3D esc_html(substr($str, $begin, $end - $begin));
=20
 		$out .=3D esc_html(substr($str, $pos, $begin - $pos))
--=20
1.7.8.4
