From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/14] upload-pack: make client capability parsing code a separate function
Date: Fri, 29 Apr 2016 16:34:34 -0700
Message-ID: <1461972887-22100-2-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHw5-0000kw-KM
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbcD2Xe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 19:34:58 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33244 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbcD2Xe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:34:56 -0400
Received: by mail-pf0-f178.google.com with SMTP id 206so54333527pfu.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmF/UYTUzmSFkLnu+hd0RXO8xkk7ZRuYlPcKzK9FxcU=;
        b=EsgynvGR6yHFPDrdajK79kws6Rv8wcI/AyDoZ0lWKGhgkHlqWyM1zS6PjM1AeWWdXH
         hLwGysyp3DK4mFJfu0B4i8y1aemrlunmXF27nAt12yqpkdqnZCU0mpUw9iCzGy7Jja49
         tkhkpBNycpmLBmHkqC9+Y947YAeJD2xyzrUzmLSPjUR+RrR4aBpLDWWrfrDEVQSkmR4P
         6u9Nh63T2HaOL33fGz68hwB97gndrErLYETEflzv4qldZwI0Q15NkrLYkPMyNga20tUk
         GheAR0JK6Ub6WMAiY4h3+0GZzR8+9a9IyTrOw8fJz0+NtX8z8pGMUBoECWsN2pBBd6gt
         mY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmF/UYTUzmSFkLnu+hd0RXO8xkk7ZRuYlPcKzK9FxcU=;
        b=OjWHInbAnTmLFG6RsEI6LY9GfZWcZTQsVB6+7//xf1cPDI/Onp9gou4YysvQgcQdbr
         rA4DDWLk6tqbyf3DimN4an3kGRjBI/aZ3Az22i3rUOU54iGfilhcqNb+4CP1t/bHuYCr
         AR8u4uSPj7T+nZYAgyvd6ISXteZOQTRp4WLB1lOE+5Ii4mYX8/EHkWxMaPYgplrvknBU
         Xxtg6azt3HjTxUGBND0IUNWVqYCGKNdEjYe6EcVaKDc6T6laiyMb+ki7Op8saawO146f
         e7xWRBeH4JtuHd/3wHuUZoGJzp4eggOwN5UToV8qr3wsjb7R52J6uc8+lLUH8ex6zF4B
         Z7gQ==
X-Gm-Message-State: AOPr4FXQE8TjmC79/b0qy+/2hFPn8cB7A1CJsrgxDoKXAaokn/BSyNQUZG1DdWE2mdRcwAVD
X-Received: by 10.98.15.142 with SMTP id 14mr33039742pfp.6.1461972895940;
        Fri, 29 Apr 2016 16:34:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id y2sm26201249pfi.39.2016.04.29.16.34.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:34:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293071>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 upload-pack.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index dc802a0..aaaf883 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -535,6 +535,28 @@ error:
 	}
 }
=20
+static void parse_features(const char *features)
+{
+	if (parse_feature_request(features, "multi_ack_detailed"))
+		multi_ack =3D 2;
+	else if (parse_feature_request(features, "multi_ack"))
+		multi_ack =3D 1;
+	if (parse_feature_request(features, "no-done"))
+		no_done =3D 1;
+	if (parse_feature_request(features, "thin-pack"))
+		use_thin_pack =3D 1;
+	if (parse_feature_request(features, "ofs-delta"))
+		use_ofs_delta =3D 1;
+	if (parse_feature_request(features, "side-band-64k"))
+		use_sideband =3D LARGE_PACKET_MAX;
+	else if (parse_feature_request(features, "side-band"))
+		use_sideband =3D DEFAULT_PACKET_MAX;
+	if (parse_feature_request(features, "no-progress"))
+		no_progress =3D 1;
+	if (parse_feature_request(features, "include-tag"))
+		use_include_tag =3D 1;
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
@@ -544,7 +566,6 @@ static void receive_needs(void)
 	shallow_nr =3D 0;
 	for (;;) {
 		struct object *o;
-		const char *features;
 		unsigned char sha1_buf[20];
 		char *line =3D packet_read_line(0, NULL);
 		reset_timeout();
@@ -579,26 +600,7 @@ static void receive_needs(void)
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
=20
-		features =3D line + 45;
-
-		if (parse_feature_request(features, "multi_ack_detailed"))
-			multi_ack =3D 2;
-		else if (parse_feature_request(features, "multi_ack"))
-			multi_ack =3D 1;
-		if (parse_feature_request(features, "no-done"))
-			no_done =3D 1;
-		if (parse_feature_request(features, "thin-pack"))
-			use_thin_pack =3D 1;
-		if (parse_feature_request(features, "ofs-delta"))
-			use_ofs_delta =3D 1;
-		if (parse_feature_request(features, "side-band-64k"))
-			use_sideband =3D LARGE_PACKET_MAX;
-		else if (parse_feature_request(features, "side-band"))
-			use_sideband =3D DEFAULT_PACKET_MAX;
-		if (parse_feature_request(features, "no-progress"))
-			no_progress =3D 1;
-		if (parse_feature_request(features, "include-tag"))
-			use_include_tag =3D 1;
+		parse_features(line + 45);
=20
 		o =3D parse_object(sha1_buf);
 		if (!o)
--=20
2.8.0.32.g71f8beb.dirty
