From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 5/9] trace.c: add GIT_TRACE_INDEX_STATS for index  statistics
Date: Mon, 28 Jul 2014 19:03:11 +0700
Message-ID: <1406548995-28549-6-git-send-email-pclouds@gmail.com>
References: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 14:04:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjfD-000315-6u
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 14:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbaG1MER convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 08:04:17 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:50987 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaG1MEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 08:04:16 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so9788081pdj.40
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 05:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hJ0+vuyF94btTLLAAGFOGxCmvRnaMlge+QaCcVZig+I=;
        b=Xy2n3N8CxNHFfHSgO293fq1VIfesQp3j4ODOaP3VqAmdKlhPHcuZPrrXX98Uprz8/J
         MLSEpbzGreLm6g/ngP7imKW+ve6//KAtEnOkzyTUa6/Jr8LIw1ZPOXdo8lYLrXmEskvq
         lqB2UA/CI+LyZzq/0eHTTWQLWy1GXCB+3sPJVL+s165o3A8NKGLDcOSPJ7ol3Hkx/f0E
         FrQ6Ny6LBCWr25X2f73PixQ81ozJvth+2m7owdqe4Z6/fP4W4iQZ4t4J5cAnNwWJgD4e
         5Qd5E2J3Cx5hpUTKHcFaAPC6VUAZat8n5xQXcWhUbkF8O9ft+ng0PRLN/SRfSARQzzMP
         uj+A==
X-Received: by 10.66.102.70 with SMTP id fm6mr23009587pab.55.1406549056073;
        Mon, 28 Jul 2014 05:04:16 -0700 (PDT)
Received: from lanh ([115.73.211.176])
        by mx.google.com with ESMTPSA id ce13sm23985171pdb.76.2014.07.28.05.04.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 05:04:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Jul 2014 19:04:18 +0700
X-Mailer: git-send-email 2.1.0.rc0.66.gb9187ad
In-Reply-To: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254319>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt |  1 +
 cache.h               |  1 +
 read-cache.c          | 16 ++++++++++++++++
 trace.c               |  5 ++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index a124612..7077386 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -947,6 +947,7 @@ Unsetting the variable, or setting it to empty, "0"=
 or
 	See 'GIT_TRACE' for available trace output options.
=20
 'GIT_TRACE_PACK_STATS'::
+'GIT_TRACE_INDEX_STATS'::
 	Print various statistics.
=20
 'GIT_TRACE_SETUP'::
diff --git a/cache.h b/cache.h
index 29a0c53..4266771 100644
--- a/cache.h
+++ b/cache.h
@@ -1508,5 +1508,6 @@ void stat_validity_update(struct stat_validity *s=
v, int fd);
 int versioncmp(const char *s1, const char *s2);
=20
 void report_pack_stats(struct trace_key *key);
+void report_index_stats(struct trace_key *key);
=20
 #endif /* CACHE_H */
diff --git a/read-cache.c b/read-cache.c
index ff28142..4bd2abe 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -48,6 +48,10 @@ struct index_state the_index;
 static const char *alternate_index_output;
 int dont_poke_index_helper;
=20
+static unsigned int nr_read_index;
+static unsigned int nr_read_shm_index;
+static unsigned int nr_write_index;
+
 static void set_index_entry(struct index_state *istate, int nr, struct=
 cache_entry *ce)
 {
 	istate->cache[nr] =3D ce;
@@ -1523,6 +1527,7 @@ static int try_shm(struct index_state *istate)
 	istate->mmap =3D new_mmap;
 	istate->mmap_size =3D new_length;
 	poke_daemon(&st, 0);
+	nr_read_shm_index++;
 	return 0;
 }
=20
@@ -1619,6 +1624,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	}
 	if (!istate->keep_mmap)
 		munmap(mmap, mmap_size);
+	nr_read_index++;
 	return istate->cache_nr;
=20
 unmap:
@@ -2087,6 +2093,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd,
 		return -1;
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
+	nr_write_index++;
 	return 0;
 }
=20
@@ -2346,3 +2353,12 @@ void stat_validity_update(struct stat_validity *=
sv, int fd)
 		fill_stat_data(sv->sd, &st);
 	}
 }
+
+void report_index_stats(struct trace_key *key)
+{
+	trace_printf_key(key, "\n"
+			 "index stats: file reads        =3D %10u\n"
+			 "index stats: cache reads       =3D %10u\n"
+			 "index stats: file writes       =3D %10u\n",
+			 nr_read_index, nr_read_shm_index, nr_write_index);
+}
diff --git a/trace.c b/trace.c
index c52da0f..eb3a11a 100644
--- a/trace.c
+++ b/trace.c
@@ -428,14 +428,17 @@ void trace_command_performance(const char **argv)
 }
=20
 static struct trace_key trace_pack_stats =3D TRACE_KEY_INIT(PACK_STATS=
);
+static struct trace_key trace_index_stats =3D TRACE_KEY_INIT(INDEX_STA=
TS);
=20
 static void print_stats_atexit(void)
 {
 	report_pack_stats(&trace_pack_stats);
+	report_index_stats(&trace_index_stats);
 }
=20
 void trace_stats(void)
 {
-	if (trace_want(&trace_pack_stats))
+	if (trace_want(&trace_pack_stats) ||
+	    trace_want(&trace_index_stats))
 		atexit(print_stats_atexit);
 }
--=20
2.1.0.rc0.66.gb9187ad
