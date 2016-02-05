From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/8] upload-pack: new capability to pass --skip* to pack-objects
Date: Fri,  5 Feb 2016 15:57:53 +0700
Message-ID: <1454662677-15137-5-git-send-email-pclouds@gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 09:58:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRcDv-0007U9-3J
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 09:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbcBEI6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 03:58:34 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35741 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbcBEI6c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 03:58:32 -0500
Received: by mail-pf0-f172.google.com with SMTP id 65so65658403pfd.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 00:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=x6GunTNre/YRy/qRrfblv6faaMMVi/1ij7mE0YMv/h0=;
        b=HljRFCRBm47PFPrRdWs2SNexg8I3G4Q5z4dJqbOshE78e9vI+0z6OulgW8/1b0Xm3N
         j1K3MLnTd4QilJoVs0/n246QrPvDd8kvbySvk+zfW9uY68fEn7hPXfdaAIn7rRbRn3Uk
         2ZI4XlkuoNUNm55sEBFO1OW9J2ttS0t67+HhGxXpPLAocc70Vl7NwWYx651dsW+1/n3h
         XG398MclZtMTZ2AFLpOSurwAqOZZBIXTCBxKS7XjdhESHS6pjR4qEqvIiojSzzrTj7mt
         cGnxLh5vzXD9OpUU0Y7XyC1TPJL+srCCXlIru6vSkkIaq88saoSF4lhf+sGNbLFKP0Aa
         PdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=x6GunTNre/YRy/qRrfblv6faaMMVi/1ij7mE0YMv/h0=;
        b=AlIXIHIBo1MFzESGQd0vAmJVd+haUdwXjrIX1Nhzpgd3fye9hPll5exPddza75xaib
         RdR2mu0fipizu9gRljSx37MZvLGgjFnLVJAbGLYYb5w8pANDIYv5X1QKYwSlW7IBXU5V
         p847SwqseHMY/MqnjZQ3FZP3r8Fz5bK19GmXg5AwMxz7vkQrk0gDjJicNq4gBEtEtAEp
         GAiguXxQlvpvyMwbO+LqNwCiUOPMfm43kTtIVhUnM+bUTVJWVvA80j7f7PLFpozzSc7D
         moJLUimKjG5iaBnRQHac6Dh6EOWcl0+C0vtaqoDPn3eaYyCUNCWBuYTkaxwlGekyTfGs
         DP2Q==
X-Gm-Message-State: AG10YOQsoRCYper0rubphGj2ydTZf+WP+WTQRadByoQRoc2bYGir/oWBC5kRcDWtn4yhqw==
X-Received: by 10.98.10.65 with SMTP id s62mr18258062pfi.119.1454662711898;
        Fri, 05 Feb 2016 00:58:31 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id e79sm22659703pfb.76.2016.02.05.00.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 00:58:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 05 Feb 2016 15:58:45 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285558>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt         |  2 ++
 Documentation/technical/protocol-capabilities.txt |  9 +++++++
 upload-pack.c                                     | 30 +++++++++++++++=
++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index c6977bb..5207d08 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -167,6 +167,7 @@ MUST peel the ref if it's an annotated tag.
 ----
   advertised-refs  =3D  (no-refs / list-of-refs)
 		      *shallow
+		      skip
 		      flush-pkt
=20
   no-refs          =3D  PKT-LINE(zero-id SP "capabilities^{}"
@@ -181,6 +182,7 @@ MUST peel the ref if it's an annotated tag.
   other-peeled     =3D  obj-id SP refname "^{}"
=20
   shallow          =3D  PKT-LINE("shallow" SP obj-id)
+  skip             =3D  PKT-LINE("skip" SP obj-id SP 1*DIGIT)
=20
   capability-list  =3D  capability *(SP capability)
   capability       =3D  1*(LC_ALPHA / DIGIT / "-" / "_")
diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index eaab6b4..0567970 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -275,3 +275,12 @@ to accept a signed push certificate, and asks the =
<nonce> to be
 included in the push certificate.  A send-pack client MUST NOT
 send a push-cert packet unless the receive-pack server advertises
 this capability.
+
+partial
+------
+
+This capability adds "skip" line to the protocol, which passes --skip
+and --skip-hash to pack-objects. When "skip" line is present, given
+the same set of input from the client (e.g. have, want and shallow
+lines, "skip" line excluded), the exact same pack must be produced.
+
diff --git a/upload-pack.c b/upload-pack.c
index b3f6653..5565afe 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -53,6 +53,9 @@ static int use_sideband;
 static int advertise_refs;
 static int stateless_rpc;
=20
+static struct object_id skip_hash;
+static int skip_opt =3D -1;
+
 static void reset_timeout(void)
 {
 	alarm(timeout);
@@ -90,7 +93,7 @@ static void create_pack_file(void)
 		"corruption on the remote side.";
 	int buffered =3D -1;
 	ssize_t sz;
-	const char *argv[13];
+	const char *argv[17];
 	int i, arg =3D 0;
 	FILE *pipe_fd;
=20
@@ -112,6 +115,14 @@ static void create_pack_file(void)
 		argv[arg++] =3D "--delta-base-offset";
 	if (use_include_tag)
 		argv[arg++] =3D "--include-tag";
+	if (skip_opt >=3D 0) {
+		argv[arg++] =3D "--skip";
+		argv[arg++] =3D xstrfmt("%d", skip_opt);
+		if (skip_opt > 0) {
+			argv[arg++] =3D "--skip-hash";
+			argv[arg++] =3D xstrdup(oid_to_hex(&skip_hash));
+		}
+	}
 	argv[arg++] =3D NULL;
=20
 	pack_objects.in =3D -1;
@@ -550,6 +561,8 @@ static void receive_needs(void)
 		const char *features;
 		unsigned char sha1_buf[20];
 		char *line =3D packet_read_line(0, NULL);
+		const char *arg;
+
 		reset_timeout();
 		if (!line)
 			break;
@@ -577,6 +590,19 @@ static void receive_needs(void)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
+		if (skip_prefix(line, "skip ", &arg)) {
+			char *end =3D NULL;
+
+			if (get_oid_hex(arg, &skip_hash))
+				die("invalid skip line: %s", line);
+			arg +=3D 40;
+			if (*arg++ !=3D ' ')
+				die("invalid skip line: %s", line);
+			skip_opt =3D strtol(arg, &end, 0);
+			if (!end || *end || skip_opt < 0)
+				die("Invalid skip line: %s", line);
+			continue;
+		}
 		if (!starts_with(line, "want ") ||
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git upload-pack: protocol error, "
@@ -725,7 +751,7 @@ static int send_ref(const char *refname, const stru=
ct object_id *oid,
 {
 	static const char *capabilities =3D "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed partial";
 	const char *refname_nons =3D strip_namespace(refname);
 	struct object_id peeled;
=20
--=20
2.7.0.377.g4cd97dd
