From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 01/11] upload-pack: make client capability parsing code a separate function
Date: Tue, 26 May 2015 15:01:05 -0700
Message-ID: <1432677675-5118-2-git-send-email-sbeller@google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:01:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMum-0001v1-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbbEZWBa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 18:01:30 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33907 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbEZWB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:27 -0400
Received: by ieczm2 with SMTP id zm2so51711iec.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XWZHpmmOo3VylhHmGZQ1bSpm72QLx8RPJkcVFSsTk6w=;
        b=gswrldm0u3WOjtpQPQvkZphbYj7u/iJP+axhIe66kwPm26wFmx8YxSZ8NX955e4nmm
         kdk4Pxr/z2jVziUosuiA+Nw4A/SuSg7tRMohRfYqHeLuWC8C3lKH/2V65vBb62hhIWgX
         AQ6TlSeu/vKMGraf3lWEWdLssRld5S15kjdmM4XGYIZP5J/E1uYQ9VqE2hK0QOUyBfKH
         6Mze9QobfZOJzRYDKFqEdxuW5nSmmDRWa+Mcsm4x2QcPgbbpuwRk5c0i3d0M0ludz0qy
         ZI2mZZl6dF9n4WjGCGlICvLqs6WyWH4b3PYiy0hWrTiWNGD6DFHBPSAeuYgBR21DkGos
         rSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=XWZHpmmOo3VylhHmGZQ1bSpm72QLx8RPJkcVFSsTk6w=;
        b=GbfiSBAy2D43Z2o1A46jF3xIZD+vnpyCCW+7r0/Ww470QhnBaojGtyr6IBgr+xXJUe
         BdmOKyUfYOu9YMDRoSuYP9NyA/g5lipgE4VFZq4uAhw5vjol15osxRdq9316fKFW2rcB
         H7rP/n2vU/Bib9jW1XlU4RV8R7NCJZTTceyUCLjX1uP+DuKNkGWkUDf3sqkgvampWuUv
         6E9p7eQvO/nsUczMO41fi1dgLyASU/16kn/GqX8lWA8JMbH14y9cjEiw0m2INf31x+sf
         ++eI+O4+yGK6jXsGEVOyo9nok0aCDT37hCnCsnhkDB338gDByiqzE1bcp6ScMyJoGp4d
         jA9A==
X-Gm-Message-State: ALoCoQmeuXvx/DfPtiwo9EtcIFDP0hNlcicuJ3dzbfHb0IPwW/hOk6hwgbahr52+N0OefrRgPqlC
X-Received: by 10.50.79.196 with SMTP id l4mr32916363igx.48.1432677686753;
        Tue, 26 May 2015 15:01:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id fs5sm9213361igb.0.2015.05.26.15.01.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269986>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 upload-pack.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 745fda8..5449ff7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -531,6 +531,28 @@ error:
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
@@ -540,7 +562,6 @@ static void receive_needs(void)
 	shallow_nr =3D 0;
 	for (;;) {
 		struct object *o;
-		const char *features;
 		unsigned char sha1_buf[20];
 		char *line =3D packet_read_line(0, NULL);
 		reset_timeout();
@@ -575,26 +596,7 @@ static void receive_needs(void)
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
2.4.1.345.gab207b6.dirty
