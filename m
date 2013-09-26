From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/10] config: add core.preferredPackVersion
Date: Thu, 26 Sep 2013 09:26:41 +0700
Message-ID: <1380162409-18224-3-git-send-email-pclouds@gmail.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:27:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1IV-0002XD-Bg
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab3IZC1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 22:27:15 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:53397 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787Ab3IZC1N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:27:13 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so490648pdj.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 19:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=csxYD3UhGC1kxHpkA/O5BO/Nxxamk38r+NBXkRPm4bE=;
        b=Vhfa99ilaZpGA2z2at/85ODISmR0fqASaqGHFyrCSGtcuO2WWM9Awc7yqMr2pAwiGp
         BTgWn+jj5sZjBgn5D1H2xlWSVuriDYowNPGNRAT3IHg2Yd3OaD/TLBR4WPrI3IFZ6yTJ
         agtkhShzI2iQot2cCQJgnp6/YNgoeM6iDnnzLZNOmlN7D65F5ICxOY6xuH0vuTEFactF
         OpZ2J2I7ykfSA9ZZyvMkNDwAg4QCaX6lAIFKBThexyH8RjKL4QR3h9X7Ra5CfT8bkyyh
         qtbALGbuFcpAQZMplhFGqep83pl6YWjnfEHqG/2Nxl6ZviSO3M1in0KlrvRVgFaryRDa
         VHKQ==
X-Received: by 10.68.171.193 with SMTP id aw1mr20635826pbc.131.1380162433147;
        Wed, 25 Sep 2013 19:27:13 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id nj9sm50834131pbc.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 19:27:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Sep 2013 09:27:07 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235389>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt | 5 +++++
 cache.h                  | 1 +
 config.c                 | 5 +++++
 environment.c            | 1 +
 4 files changed, 12 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..6e7037b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -644,6 +644,11 @@ core.abbrev::
 	for abbreviated object names to stay unique for sufficiently long
 	time.
=20
+core.preferredPackVersion::
+	This is the preferred pack format version for various operations
+	that may produce pack files such as clone, fetch, push or repack.
+	Valid values are 2 and 4. The default value is 2.
+
 add.ignore-errors::
 add.ignoreErrors::
 	Tells 'git add' to continue adding files when some files cannot be
diff --git a/cache.h b/cache.h
index b68ad5a..20c2d6d 100644
--- a/cache.h
+++ b/cache.h
@@ -597,6 +597,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
+extern int core_default_pack_version;
=20
 /*
  * The character that begins a commented line in user-editable file
diff --git a/config.c b/config.c
index e13a7b6..02af0d1 100644
--- a/config.c
+++ b/config.c
@@ -831,6 +831,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.preferredpackversion")) {
+		core_default_pack_version =3D git_config_int(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 5398c36..24c43ba 100644
--- a/environment.c
+++ b/environment.c
@@ -62,6 +62,7 @@ int merge_log_config =3D -1;
 int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition=
() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
+int core_default_pack_version =3D 2;
=20
 /*
  * The character that begins a commented line in user-editable file
--=20
1.8.2.82.gc24b958
