From: David Turner <dturner@twopensource.com>
Subject: [PATCH 05/19] trace.c: add GIT_TRACE_INDEX_STATS for index statistics
Date: Wed,  9 Mar 2016 13:36:08 -0500
Message-ID: <1457548582-28302-6-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:36:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiyd-0007Hh-JW
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933840AbcCISgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:36:47 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33034 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932950AbcCISgi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:38 -0500
Received: by mail-qk0-f177.google.com with SMTP id s5so24029865qkd.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VjIhqduMmoJn5xPuLxk25+Z2FRZDudSRoIV9KHGCibk=;
        b=cOpRkC1uTq2XR0myWtXRvMCb7ZbxRhH2IfWj4SARwiog7apDichipfsF/qvy5EfI4w
         xkzSXwd96k4Y2VIb3z5t4PDjLyvuzRWj2f08e/IlIIWVq2zC2g575RiVKPiUBJFVy26O
         VMHHjLqMIILvBhkgsiJjXHVGFTdA1ljPASVtUjE5uOCc4HOlj3UqvlHMChulQGSLiEVi
         QorhR7z/JINPvZq09TebvV3X8s0pK3EC+CSiTWG3Xd13zLGhlQWi/n+uf3ntSZ8e41TK
         Wig20N3OAcYWVIKq9vlYEaaiy3JO1sSj2UR7IqAYY9Nvab0dN4mJ8GMuVlurm51D90Ba
         dTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjIhqduMmoJn5xPuLxk25+Z2FRZDudSRoIV9KHGCibk=;
        b=Wm/Vzpk7ptfnn3wGVEsxidUbkE5bhsZmBdgSJgWTlyY0p5+yNvFDr1wRhzeiU7D3Gj
         TpsMmI+RYCIDFFZ++J1zFnI3+IKYqrE+Tca3YQsUnQRCqppvMAkuyIlWR2zGpRxI3sgh
         G0fraLNu3nZI5gNXWI+sP8M5pEKqpr+dYRsQeMtqUUrLRMy1mysy0ODkyPZ8CIjdek2+
         AzMTR6IUJwYJOB/w0SpQkqXEg7EX1Awa6mFY2YznBJ2tlgVvP9PUzIXwErnpv56DzhEq
         sQJxDm7cTeND0pAdGhQt13wEt+K2pUZYT18L7pOBMGQ7l0EM4VwrM7SxTpe3rGXPtFg/
         s4kg==
X-Gm-Message-State: AD7BkJIG1URJ9gxzToJDwA1lUmKNzjtqvdwk7eK2I9TpyMzZSyLrNQNUg4qLvEqgfPUwjw==
X-Received: by 10.55.19.170 with SMTP id 42mr45468683qkt.21.1457548597808;
        Wed, 09 Mar 2016 10:36:37 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:37 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288551>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt |  1 +
 cache.h               |  1 +
 read-cache.c          | 16 ++++++++++++++++
 trace.c               |  5 ++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 794271e..71a88a8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1056,6 +1056,7 @@ of clones and fetches.
 	See 'GIT_TRACE' for available trace output options.
=20
 'GIT_TRACE_PACK_STATS'::
+'GIT_TRACE_INDEX_STATS'::
 	Print various statistics.
=20
 'GIT_TRACE_SETUP'::
diff --git a/cache.h b/cache.h
index bc2f529..e22296c 100644
--- a/cache.h
+++ b/cache.h
@@ -1835,5 +1835,6 @@ void sleep_millisec(int millisec);
 void safe_create_dir(const char *dir, int share);
=20
 void report_pack_stats(struct trace_key *key);
+void report_index_stats(struct trace_key *key);
=20
 #endif /* CACHE_H */
diff --git a/read-cache.c b/read-cache.c
index eb4b9b4..7bd3ce4 100644
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
@@ -1614,6 +1618,7 @@ static int try_shm(struct index_state *istate)
 	istate->mmap =3D new_mmap;
 	istate->mmap_size =3D new_size;
 	istate->from_shm =3D 1;
+	nr_read_shm_index++;
 	return 0;
 }
=20
@@ -1711,6 +1716,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	}
 	if (!istate->keep_mmap)
 		munmap(mmap, mmap_size);
+	nr_read_index++;
 	return istate->cache_nr;
=20
 unmap:
@@ -2197,6 +2203,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd,
 		return -1;
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
+	nr_write_index++;
 	return 0;
 }
=20
@@ -2423,3 +2430,12 @@ void stat_validity_update(struct stat_validity *=
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
2.4.2.767.g62658d5-twtrsrc
