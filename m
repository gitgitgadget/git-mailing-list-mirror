From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 10/17] gettext tests: add detection for is_IS.ISO-8859-1 locale
Date: Mon, 30 Aug 2010 21:28:16 +0000
Message-ID: <1283203703-26923-11-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBve-0000N5-D4
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036Ab0H3V3e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35681 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756010Ab0H3V3b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:31 -0400
Received: by wwb28 with SMTP id 28so137117wwb.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=DYg1QVBGYI0lFO/4RY4I1H+FHKpDnsOeZgqtYn6/Lnk=;
        b=EFpNf+2sND+n3bT07P8rOw/+IxTlmGgOaIzBplSE3o+xH8A/eoNMDuTdTB/aWdQVa/
         MvAfHInZH7KU5uQY4EawB8LW9eKMN8U4pkl+UPZhP7nmOLqo9qnfi7rzHMLbDI76DsYN
         nNhEXUerXlmvGg52jwjWOYtoL0Z+GOLzlXlUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=irznat8+7vckFZOrk2Svp/LIhjqu51eDULmQqp5LZNGH1YN99EOozbLR1oY3+yI81S
         M2nFZkXdIBLhB8wK4yDyDWIDgKKfnsKdEYQIVl31hK1NdOeCerKIP7SBUWNQdF8/nJ4T
         K0eZDbSuDfnkV9TksTq7YArXpkitG40M7r/dI=
Received: by 10.227.141.141 with SMTP id m13mr5461486wbu.152.1283203745161;
        Mon, 30 Aug 2010 14:29:05 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.29.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:29:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154856>

Add a GETTEXT_ISO_LOCALE prerequisite to lib-gettext.sh, it'll be set
if we have an is_IS.ISO-8859-1 locale.

This is needed for an upcoming test that checks if our gettext library
can recode our UTF-8 po/is.po to is_IS.ISO-8859-1 on request.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/lib-gettext.sh |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index f0cdd3d..4570ead 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -18,9 +18,15 @@ then
 		p
 		q
 	}')
-	# Export it as an environmental variable so the t0202/test.pl Perl
-	# test can use it too
-	export is_IS_locale
+	# is_IS.ISO8859-1 on Solaris and FreeBSD, is_IS.iso88591 on Debian
+	is_IS_iso_locale=3D$(locale -a | sed -n '/^is_IS\.[iI][sS][oO]8859-*1=
$/{
+		p
+		q
+	}')
+
+	# Export them as an environmental variable so the t0202/test.pl
+	# Perl test can use it too
+	export is_IS_locale is_IS_iso_locale
=20
 	if test -n "$is_IS_locale" &&
 		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
@@ -35,6 +41,20 @@ then
 	else
 		say "# lib-gettext: No is_IS UTF-8 locale available"
 	fi
+
+	if test -n "$is_IS_iso_locale" &&
+		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
+	then
+		# Some of the tests need the reference Icelandic locale
+		test_set_prereq GETTEXT_ISO_LOCALE
+
+		# Exporting for t0202/test.pl
+		GETTEXT_ISO_LOCALE=3D1
+		export GETTEXT_ISO_LOCALE
+		say "# lib-gettext: Found '$is_IS_iso_locale' as a is_IS ISO-8859-1 =
locale"
+	else
+		say "# lib-gettext: No is_IS ISO-8859-1 locale available"
+	fi
 else
 	# Only run some tests when we don't have gettext support
 	test_set_prereq NO_GETTEXT
--=20
1.7.2.2.536.g3f548
