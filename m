From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 5/9] trace.c: add GIT_TRACE_INDEX_STATS for index  statistics
Date: Sun,  1 Nov 2015 14:42:45 +0100
Message-ID: <1446385369-8669-6-git-send-email-pclouds@gmail.com>
References: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:43:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zssv9-0008Lt-Dx
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbbKANnj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:43:39 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35438 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbbKANnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:43:35 -0500
Received: by wmll128 with SMTP id l128so41973295wml.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=olD5JxUjd90NwiB7NXDmmgXgsZye/K2k614hJgbPWgs=;
        b=kbPFfOmvk7VzJNA6BSPvZYQ68t0IfYM8N85DBQA2rlZCleyNWIreoN0xnXINCI2u4D
         hV/3nUT5/0ZmgEQhWxyW0zmIQqC27P1JQ2ChOpDIQcTS5MhPneuIDWKyzdcwHC1VTJHo
         rVgsRvu6FP40MBRWxVhvXd738pQACLK3V/o1ReLrR8788Wa9l6rKRKm5fuscR5XIywd6
         XJD4iZ7Vw7oVuGEStIZXyJB8HHOaLM/59rQIwb3oqajTXaCkjzjA1SVPYnT+TYxKUtJv
         sn4SrH83Y+jHhjYxz1WM6b9XXO1v2JShFBHFJppUBGxgpk16Q6DFibGcCwyQCG8WyFoJ
         rOHA==
X-Received: by 10.28.143.79 with SMTP id r76mr8862939wmd.102.1446385414722;
        Sun, 01 Nov 2015 05:43:34 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id gd10sm17058028wjb.47.2015.11.01.05.43.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:43:33 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280620>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt |  1 +
 cache.h               |  1 +
 read-cache.c          | 16 ++++++++++++++++
 trace.c               |  5 ++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1086ced..f2078aa 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1046,6 +1046,7 @@ of clones and fetches.
 	See 'GIT_TRACE' for available trace output options.
=20
 'GIT_TRACE_PACK_STATS'::
+'GIT_TRACE_INDEX_STATS'::
 	Print various statistics.
=20
 'GIT_TRACE_SETUP'::
diff --git a/cache.h b/cache.h
index 30a3a77..69c2365 100644
--- a/cache.h
+++ b/cache.h
@@ -1754,5 +1754,6 @@ int versioncmp(const char *s1, const char *s2);
 void sleep_millisec(int millisec);
=20
 void report_pack_stats(struct trace_key *key);
+void report_index_stats(struct trace_key *key);
=20
 #endif /* CACHE_H */
diff --git a/read-cache.c b/read-cache.c
index 6c98e98..6ae50c7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -50,6 +50,10 @@ static struct cache_entry *refresh_cache_entry(struc=
t cache_entry *ce,
 struct index_state the_index;
 static const char *alternate_index_output;
=20
+static unsigned int nr_read_index;
+static unsigned int nr_read_shm_index;
+static unsigned int nr_write_index;
+
 static void set_index_entry(struct index_state *istate, int nr, struct=
 cache_entry *ce)
 {
 	istate->cache[nr] =3D ce;
@@ -1592,6 +1596,7 @@ static int try_shm(struct index_state *istate)
 	istate->mmap =3D new_mmap;
 	istate->mmap_size =3D new_length;
 	istate->from_shm =3D 1;
+	nr_read_shm_index++;
 	return 0;
 }
=20
@@ -1689,6 +1694,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	}
 	if (!istate->keep_mmap)
 		munmap(mmap, mmap_size);
+	nr_read_index++;
 	return istate->cache_nr;
=20
 unmap:
@@ -2174,6 +2180,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd,
 		return -1;
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
+	nr_write_index++;
 	return 0;
 }
=20
@@ -2400,3 +2407,12 @@ void stat_validity_update(struct stat_validity *=
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
index b1d0885..eea1fa8 100644
--- a/trace.c
+++ b/trace.c
@@ -434,14 +434,17 @@ void trace_command_performance(const char **argv)
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
2.2.0.513.g477eb31
