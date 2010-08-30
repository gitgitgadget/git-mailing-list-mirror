From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 08/17] gettext tests: test if $VERSION exists before using it
Date: Mon, 30 Aug 2010 21:28:14 +0000
Message-ID: <1283203703-26923-9-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBva-0000N5-4M
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751Ab0H3V3E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab0H3V3B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:01 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so7081766wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ELYtXJ9HyYzmA3e0AqmofXqwf6NUHcGMRhDRSA5D17I=;
        b=ejBjXJkIt7P9hGvkUoQZxwFP6N3fZ5jiWjHFCTqrZIcy8j8ecyt2pXV2jEtMW4tvml
         ltAZqZYvT3KP8um5RBE0IQwbxIHNjVWgbVI9zintqb2BrnK/SKky+m7LAMxmL0vVbwoK
         iT0ERyj7Z1vf3pTT89CQVeZcO1I0C0+gKgiWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rI2GdW1y3McMjqg9AsWEAQ1972eVzxSdPh+LhAhNQFZPx11g5MzbdvX8cq/UVKbTUj
         5KI1y4On1fJvF9P8kBQ2+xT3KH4s437QGjSONA+p1U99Lqlsl88EUhmNM+LLy1M82W5H
         Y+4o2jKYvDuGv7ZSEl7dCm0Y++/5LzihY+gDI=
Received: by 10.227.156.212 with SMTP id y20mr5549617wbw.142.1283203740538;
        Mon, 30 Aug 2010 14:29:00 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.28.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:28:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154854>

Versions of Locale::Messages before 1.17 didn't have a $VERSION
variable. This caused test failures on boxes that had this old version
installed, since the warnings pragma emits warnings on STDERR, which
fails the test.

Change the test to work around this by first checking if the $VERSION
variable is defined before using it.

Reported-by: Jens Lehmann <Jens.Lehmann@web.de>
Tested-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t0202/test.pl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index c2055fa..6b00603 100644
--- a/t/t0202/test.pl
+++ b/t/t0202/test.pl
@@ -11,7 +11,9 @@ my $has_gettext_library =3D $Git::I18N::__HAS_LIBRARY=
;
=20
 ok(1, "Testing Git::I18N version $Git::I18N::VERSION with " .
 	 ($has_gettext_library
-	  ? "Locale::Messages version $Locale::Messages::VERSION"
+	  ? (defined $Locale::Messages::VERSION
+		 ? "Locale::Messages version $Locale::Messages::VERSION"
+		 : "Locale::Messages version <1.17")
 	  : "NO Perl gettext library"));
 ok(1, "Git::I18N is located at $INC{'Git/I18N.pm'}");
=20
--=20
1.7.2.2.536.g3f548
