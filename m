From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 1/5] upload-pack: only accept capabilities on the first "want" line
Date: Fri, 27 Feb 2015 17:01:54 -0800
Message-ID: <1425085318-30537-2-git-send-email-sbeller@google.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <1425085318-30537-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 02:02:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRVnF-0003Tr-1f
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 02:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbbB1BCE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2015 20:02:04 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37201 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbbB1BCD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 20:02:03 -0500
Received: by iecrl12 with SMTP id rl12so35315635iec.4
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 17:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1y1ewZYwmWIBgLcaiJPkPtSRPXiYKO0vd0FSAtKJOTQ=;
        b=EM1vZS7aU8BLSzdZ2HwjJzGalci43E8C1mPVRghOr4fNmoF/xBNUbYPG746ZgaIR2M
         GYywZA/Vizhg/3zXpOv5L20zt8orX13Nx9UmCaLRdrtGbSlqGWQXPA2kp10muqT49CLR
         rQwL8LuYQWUJhagQ/HEcz+hikZE4K0vTeXavFT58C6U/gyFHjCV6Z5YgMQM9/wM8Z6ub
         Tz+gDR88O6ZnNxJk7iLj0q3jZ3+s6P4kg9myfccorIBXEOuF+Q9h0OfUfRKF1ACTjK7U
         G+5dGmG4TkHVaf/KPvyW5Tc9UWJ6zy02BAlarmGquEupJoZgd838dQUZOxEfRaxW5ZW1
         Vb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=1y1ewZYwmWIBgLcaiJPkPtSRPXiYKO0vd0FSAtKJOTQ=;
        b=CPrRXB71haEFW4qv0VLj5BCYwBbPnARi0qhqkXXt32RlN5eT1S+fMt8I2KKApCHzZY
         YiAnZ7nd5gOeZej73cPGC/kWwKlANYng6DABujR9QQJOZTQon5hJn1RlvQyZrjck/azv
         OhdZNJKUT5MwdFG0CIq5mS7JacV5czSzWjHzK8VRUBvo8fdIvMnH58epI1ai8WJDPIya
         oKg6g573Yk3NJ7EmSII7d0XB2a1SxSFXeAnMqNY+Ix5rB1ak2l/8L/WYxjr23Xj0hBDv
         rS6MnGfglwDo4PDItNL8fYeFCAUzI479wDCnIB+O0R22pQ7j4clZ2tcjT4/iCibnuTCL
         hPtQ==
X-Gm-Message-State: ALoCoQmXPNzrjl6DIhhsb+5uznYM90w+8ZtAZhnd0d2JAcF/s8V5VGt7Air9nWJpQEOTEtfQhQDG
X-Received: by 10.107.25.72 with SMTP id 69mr23288056ioz.44.1425085322314;
        Fri, 27 Feb 2015 17:02:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:700c:d3d2:5834:b5cc])
        by mx.google.com with ESMTPSA id i16sm3335555ioe.17.2015.02.27.17.02.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Feb 2015 17:02:01 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1425085318-30537-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264518>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

pack-protocol.txt says so and fetch-pack also follows it even though
upload-pack is a bit lax. Fix it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 upload-pack.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index e0ce2bf..d9230ba 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -558,6 +558,7 @@ static void receive_needs(void)
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
 	int depth =3D 0;
 	int has_non_tip =3D 0;
+	int first_want =3D 1;
=20
 	shallow_nr =3D 0;
 	for (;;) {
@@ -596,7 +597,11 @@ static void receive_needs(void)
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
=20
-		parse_features(line + 45);
+		if (first_want) {
+			parse_features(line + 45);
+			first_want =3D 0;
+		} else if (line[45])
+			die("garbage at the end of 'want' line %s", line + 45);
=20
 		o =3D parse_object(sha1_buf);
 		if (!o)
--=20
2.3.0.81.gc37f363
