From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/17] test-lib.sh: add --packv4 for running the tests with pack v4 as default
Date: Sat, 21 Sep 2013 20:57:56 +0700
Message-ID: <1379771883-10278-11-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNey-00015L-I3
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab3IUNzl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:55:41 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:47421 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3IUNzk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:55:40 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so1482050pdj.31
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oKGBkMZOW9Z8HvqqmN62fT/bzq3ggEVa9zlJtdu3Br8=;
        b=L8sEBEQVVdMm+qy1RBlvKi6Kk1pblcBrRAxMf+AMz2CQxsxvwvZit88RiUsj0R9jzX
         vgI+D9VT/ithQ/jsNySYwy+JWDTfH5QIiK+SGzNzeGL/A6RGQD7veub+xebisFS7tfP9
         WIML9OXmDeO1kP692GaJrwy5qP9hP0Hvw2SS3vf7R/MiJdMVxgH9ESw9/37Gw2jm+tKL
         km0Fm6cEOTS461Que/Dv15aBgFmAUWlZdaNxgpfI2QraT1MggxCFvhbSVVd72C71Rvhc
         mzL7s+DxRozWXnqObDLWCe7uqZ0st+GvKIiCfRqxJwK1zzeFgMD1NDUveMs8AvBwX827
         cK/g==
X-Received: by 10.66.168.7 with SMTP id zs7mr1496214pab.152.1379771739659;
        Sat, 21 Sep 2013 06:55:39 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id ha10sm22177273pbc.23.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:55:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:59:02 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235110>

--packv4 also sets prerequisite PACKV4, which can be used to disable
v2-specific tests. You can run the test suite with

make test GIT_TEST_OPTS=3D--packv4

or just a specific test

=2E/t5300-*.sh --packv4 -v -i

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c |  4 ++++
 t/test-lib.sh          | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8e2e5e9..1e0c2e6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2735,6 +2735,10 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level =3D core_compression_level;
=20
+	/* GIT_TEST_PACKV4 does not override --version */
+	if (getenv("GIT_TEST_PACKV4"))
+		pack_version =3D 4;
+
 	progress =3D isatty(2);
 	argc =3D parse_options(argc, argv, prefix, pack_objects_options,
 			     pack_usage, 0);
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1aa27bd..931dd23 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -222,6 +222,9 @@ do
 	--statusprefix=3D*)
 		statusprefix=3D$(expr "z$1" : 'z[^=3D]*=3D\(.*\)')
 		shift ;;
+	--packv4)
+		packv4=3Dt
+		shift ;;
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
@@ -740,6 +743,13 @@ else
 	mkdir -p "$TRASH_DIRECTORY"
 fi
=20
+if test -n "$packv4"
+then
+	GIT_TEST_PACKV4=3Dt
+	export GIT_TEST_PACKV4
+	test_set_prereq PACKV4
+fi
+
 # Gross hack to spawn N sub-instances of the tests in parallel, and
 # summarize the results.  Note that if this is enabled, the script
 # terminates at the end of this 'if' block.
--=20
1.8.2.83.gc99314b
