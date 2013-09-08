From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/11] pack-objects: add --version to specify written pack version
Date: Sun,  8 Sep 2013 22:04:15 +0700
Message-ID: <1378652660-6731-7-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:02:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgV2-0003T8-21
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab3IHPB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:01:59 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38861 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab3IHPB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:01:58 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so5124156pbc.3
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Gz8RpHEQOHVtct5mYu6UkJLsLU1LXJwkyh98UNhSXbs=;
        b=n6o7DNLItDUhiEsw/EqftAE8/nnxN8KBecohKmd9ygsqn136kXfPS2/pfsi2CXN1oN
         Zxr7tpR23QPmYtnElHmHkx5nDfXdLW4YNIpKkwkQlqOj0DPrT1l570PoR/GTHtyk8Lox
         Ifr0N3ebvXeyhTls+gPSSBEhMTa8JztQ+x4nUTZS8bOWiU66dnoxhEKN6gLCUXQwLbNP
         WTyoK/QxF0ist9gKqImvlnJ8oKLMlAqGSYddy0B0nTW0ZmbeHyy9ZEcTXD8GVNb7By63
         HL2oMxofgJOfx74bmR9i0BNpz1MVT5/iX10CgDvebHAv1uTYFEt/rYG2pO6LSttN+Gtw
         4peQ==
X-Received: by 10.66.169.172 with SMTP id af12mr15267136pac.23.1378652518066;
        Sun, 08 Sep 2013 08:01:58 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id om2sm10463156pbc.30.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 08:01:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 22:05:06 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234245>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 33faea8..ef68fc5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -81,6 +81,7 @@ static int num_preferred_base;
 static struct progress *progress_state;
 static int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
+static int pack_version =3D 2;
=20
 static unsigned long delta_cache_size =3D 0;
 static unsigned long max_delta_cache_size =3D 256 * 1024 * 1024;
@@ -735,7 +736,7 @@ static void write_pack_file(void)
 		else
 			f =3D create_tmp_packfile(&pack_tmp_name);
=20
-		offset =3D write_pack_header(f, 2, nr_remaining);
+		offset =3D write_pack_header(f, pack_version, nr_remaining);
 		if (!offset)
 			die_errno("unable to write pack header");
 		nr_written =3D 0;
@@ -2455,6 +2456,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 		{ OPTION_CALLBACK, 0, "index-version", NULL, N_("version[,offset]"),
 		  N_("write the pack index file in the specified idx format version"=
),
 		  0, option_parse_index_version },
+		OPT_INTEGER(0, "version", &pack_version, N_("pack version")),
 		OPT_ULONG(0, "max-pack-size", &pack_size_limit,
 			  N_("maximum size of each output pack file")),
 		OPT_BOOL(0, "local", &local,
@@ -2525,6 +2527,8 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 	}
 	if (pack_to_stdout !=3D !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
+	if (pack_version !=3D 2)
+		die(_("pack version %d is not supported"), pack_version);
=20
 	rp_av[rp_ac++] =3D "pack-objects";
 	if (thin) {
--=20
1.8.2.83.gc99314b
