From: jk@blackdown.de (=?utf-8?Q?J=C3=BCrgen?= Kreileder)
Subject: [PATCH 1/4] gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch
Date: Mon, 08 Apr 2013 22:08:20 +0200
Message-ID: <m2zjx8bxaj.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 22:09:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPINJ-0001RN-LL
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 22:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935935Ab3DHUIy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Apr 2013 16:08:54 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:36035 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935850Ab3DHUIx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Apr 2013 16:08:53 -0400
Received: by mail-bk0-f44.google.com with SMTP id jk13so3245977bkc.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 13:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=mqXMjyHp3DkRYFqZLijLI6LYojSVcAFA8Z48d5uWnUo=;
        b=Ku1uEVsMFhg+pY/uPhJSIAQI+jpkd9iwMEP82RzkivS2YRMMnQ6L1cc0ZZMfbRHYp5
         rK+1+9CZHXMiJu9Q2J3fzsP9agGgWBeaxChxxv7OhVensjTVId5ENOwV8X6i9aSYIkem
         TEysytPmDtWrkWw6m96bmt7sV+mjtJiEyHckk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=mqXMjyHp3DkRYFqZLijLI6LYojSVcAFA8Z48d5uWnUo=;
        b=O0Sz+5cKbA21faQkTqhjQVDfoTX74qgUS4gcXOu+W2BLX2YIQk232pC+qY5rFBDHD+
         MRZyox9FOU3j2PMiXAvEuqBJORexoLIDkG8RyqGwBpFixLqBaL/qYvdIvO9O/aT30S6I
         DYAiu7yAagvH6P8nugrjaa4IGRtG9rhmqLJtIxVK+8BtrfFMoeaYSabT1sCvKUHgN2Oy
         xfuLJe4D0tGgYnIxC6TTL5zeblCNyCuzIKybTsBZl5zKYydKyYdQ+6zBlX6kHwDqHVMR
         iKq2c2Psny52lt4JtQVZIcbfAJw+4ruuwZyynlfzews3Wykn1fR61hEm+IcE6MBYLt5K
         kZqw==
X-Received: by 10.204.195.133 with SMTP id ec5mr11707936bkb.32.1365451732159;
        Mon, 08 Apr 2013 13:08:52 -0700 (PDT)
Received: from zahir.local (p20030056CF2E81009227E4FFFEF3FF5E.dip.t-dialin.net. [2003:56:cf2e:8100:9227:e4ff:fef3:ff5e])
        by mx.google.com with ESMTPS id w6sm13093729bkz.17.2013.04.08.13.08.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 13:08:51 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
X-Gm-Message-State: ALoCoQmIi7NHE+w4PtWngJtrhsIE6J6jwkQw1fniFsfWxGiJsFiaKegCCqcvNEET3O/lffURizOg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220507>

=46ixes the encoding for several _plain actions and for text/* and */*+=
xml blobs.=20

Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1309196..9cfe5b5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3823,7 +3823,7 @@ sub blob_contenttype {
 	my ($fd, $file_name, $type) =3D @_;
=20
 	$type ||=3D blob_mimetype($fd, $file_name);
-	if ($type eq 'text/plain' && defined $default_text_plain_charset) {
+	if (($type =3D~ m!^text/\w[-\w]*$! || $type =3D~ m!^\w[-\w]*/\w[-\w]*=
\+xml$!) && defined $default_text_plain_charset) {
 		$type .=3D "; charset=3D$default_text_plain_charset";
 	}
=20
@@ -7637,7 +7637,9 @@ sub git_blobdiff {
 			last if $line =3D~ m!^\+\+\+!;
 		}
 		local $/ =3D undef;
+		binmode STDOUT, ':raw';
 		print <$fd>;
+		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
 		close $fd;
 	}
 }
@@ -7884,12 +7886,16 @@ sub git_commitdiff {
=20
 	} elsif ($format eq 'plain') {
 		local $/ =3D undef;
+		binmode STDOUT, ':raw';
 		print <$fd>;
+		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
 		close $fd
 			or print "Reading git-diff-tree failed\n";
 	} elsif ($format eq 'patch') {
 		local $/ =3D undef;
+		binmode STDOUT, ':raw';
 		print <$fd>;
+		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
 		close $fd
 			or print "Reading git-format-patch failed\n";
 	}
--=20
1.7.10.4
