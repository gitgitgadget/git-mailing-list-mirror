From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Call to_utf8() on input string in chop_and_escape_str()
Date: Sat, 17 Dec 2011 10:15:22 +0100
Message-ID: <1324113324-21328-2-git-send-email-jnareb@gmail.com>
References: <1324113324-21328-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Juergen Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 10:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbqNn-0000v5-Ko
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 10:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418Ab1LQJQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 04:16:10 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35691 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab1LQJQG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 04:16:06 -0500
Received: by eaaj10 with SMTP id j10so3522742eaa.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 01:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xH/feiRIplu2CMcyUShQBs/vcGkSMPsqtAqaBRxSDzY=;
        b=k+vepO2VI+29SpW76HSaE9FUeCCLCeY37QoIdXnLrTA8ku8DiCCJFbXEp/PtHvZ2DC
         lOjb946jnDtyyz8lg929Y9lMsUz8LsfWASYGDfssLU+VKBlOSHXYxp2VUFeMLuRMK8mB
         YlP5v56xIe0Debhe9yAITJ7tFBmYCZDXuY0/A=
Received: by 10.213.28.135 with SMTP id m7mr3317150ebc.73.1324113364567;
        Sat, 17 Dec 2011 01:16:04 -0800 (PST)
Received: from localhost.localdomain (abrz159.neoplus.adsl.tpnet.pl. [83.8.119.159])
        by mx.google.com with ESMTPS id q28sm10728465eea.6.2011.12.17.01.16.03
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 01:16:04 -0800 (PST)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1324113324-21328-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187353>

=46rom: J=FCrgen Kreileder <jk@blackdown.de>

a) To fix the comparison with the chopped string,
   otherwise we compare bytes with characters, as
   chop_str() must run to_utf8() for correct operation
b) To give the title attribute correct encoding;
   we need to mark strings as UTF-8 before outpur

Signed-off-by: J=FCrgen Kreileder <jk@blackdown.de>
Acked-by: Jakub Nar=EAbski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f80f259..35126cd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1696,6 +1696,7 @@ sub chop_and_escape_str {
 	my ($str) =3D @_;
=20
 	my $chopped =3D chop_str(@_);
+	$str =3D to_utf8($str);
 	if ($chopped eq $str) {
 		return esc_html($chopped);
 	} else {
--=20
1.7.6
