From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 02/16] upload-pack: make client capability parsing code a separate function
Date: Mon,  1 Jun 2015 17:02:04 -0700
Message-ID: <1433203338-27493-3-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfH-0000iX-QM
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359AbbFBACj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 20:02:39 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38403 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbbFBACe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:34 -0400
Received: by igbjd9 with SMTP id jd9so74726249igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XWZHpmmOo3VylhHmGZQ1bSpm72QLx8RPJkcVFSsTk6w=;
        b=bMzi/1q3WKnb9JM0mqnxRMZ80slhJZllcac4yaVNRQ7+HrTI9D8dvbwa0HVmo5hQLO
         PnSJHd09e+OGq3+88g+EhgmAxHDQR6G0VBaHAFxQCT7TCx03a6TE8Zau2c2K5rLcguLr
         qMVDXhM/bsdeWTyOCWyQoF49M9H4BZXRPInGo7AdoYbOwIRXjC+/t4V9Qg+osquoVHbm
         N+EjL9LD78LdRxInIDxBkJxCoiv7whH1OBcKqaeiLwYJSW6KyX5kQ8XEQF/NbIuUqb31
         e2QInmzdN6LHMynPlMR32YaoKQ/AO2Q+Id/kwW/Ca3dk4qgO/SYQ8hr5ctKTSWOH3Dwd
         3lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=XWZHpmmOo3VylhHmGZQ1bSpm72QLx8RPJkcVFSsTk6w=;
        b=ioKPrklK33ceP35mfDOJEszPLM8RczVEyaM1McU0cS70KkgUhcDLAMN88nAC5NVUXB
         jH3KhazLX7vwTs+Db7nBM87xocHoXHupEFYu2tWd0cUguwEJ0l4s4iiGqnCs6p1fLQA4
         sRrSFXYIFWnOARPctHqSUXLTOrPYpt8UmYRe+Ic+X6nTzS+fPn4czQA4Enu4OHgjG6Cl
         ySxWWRC31YrTFdxgNhWF0R7fEh7yBm9ElzhxHiiMMNmYBMiR6VJj5GZc8TDPQ46bS/N9
         4NTCh7SFFpu6s7Mz1z+L8Psiw66WBZWCDYd+kZoSepCsbmoQVI1RmHig0jyeg+dvkYR3
         R+mw==
X-Gm-Message-State: ALoCoQmHPcWMZvK2AF0rvuQqUhs6snUsnUzn4rfEMwv5PvrrIM9O79whXk/aIhH3hMLuTX6DGbSF
X-Received: by 10.43.8.4 with SMTP id oq4mr18880109icb.64.1433203353784;
        Mon, 01 Jun 2015 17:02:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id d8sm8898975igl.19.2015.06.01.17.02.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270493>

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
