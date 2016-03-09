From: David Turner <dturner@twopensource.com>
Subject: [PATCH 01/19] trace.c: add GIT_TRACE_PACK_STATS for pack usage statistics
Date: Wed,  9 Mar 2016 13:36:04 -0500
Message-ID: <1457548582-28302-2-git-send-email-dturner@twopensource.com>
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
	id 1adiyR-0007AS-Pt
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933785AbcCISgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:36:37 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34213 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932950AbcCISgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:35 -0500
Received: by mail-qk0-f170.google.com with SMTP id x1so24102744qkc.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yJBQ9jWfOmhGb8+xOM9YNclgDA87+qUGWiVgvnEpIsE=;
        b=xCH8Q4zrbyobf4xf7DvzoNAYT0GPWQLHEVdHmUAaq49zE5m4lwi4TUCdAYuN6D3Cmn
         YRAVBzmIV+MRKoG1zh0AR9y5yZ0NfSFBFrC+X6uv+TzF3RlA8Wj/71y6lKd96Hl8Uw6R
         TJG71fMM0p5tsvOz2L24O0hgjndKZtTpbhV7ZxKn2Uo6vX/8DxLYOsht9yZxhja+E88p
         FDbwX4ZXjd5ih+3TsMcmHFxoPNlYa/oM+BUjqO7b6PPxjm6VksWCS5ckuY5t4uIvTY6a
         6bGHGjDnfTbiHGUavUDpGACLBDEG0d9jR4413NMw0wCNlV3Yp0eEEacYeZKf7go3lk4i
         jgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJBQ9jWfOmhGb8+xOM9YNclgDA87+qUGWiVgvnEpIsE=;
        b=O/BUZ8mQrJIEugcJsnhZ4isbnQDCqcchltaVUK/UjRt/WXLhNkPa6GTKDIAgxML0bP
         PLjfvA2syqvmgzgMVAeEqpwFeexgTG20qrfLuy/uqnTjSA9Y2SCJDerphl8JJZMcVcF+
         7AxUeJeJWmCorabzHfRSkZggIeGlU5m/8IVHUzlGmJpZz3rEucu0x8WUzdkVXf+k04JF
         46j9HdGxaIYeoKQr2ofJX41ZxpMsCg6JrQt0xzmQI7/Zd0U6BtkKcCUwuoQS/LbQ/azC
         QvamrW5Pxs4afT0Z8R7tIwyXx31meN7uYCQj5f4qoIwCSLxCJ7mwxFLVCo3sws/s3Nvo
         pAkw==
X-Gm-Message-State: AD7BkJKBfMeQmJyTMGJHx6fa+1f47Ng0lPWciUiXHJbK+EfM+CVYM2zdLO3jF7gwwbY2dw==
X-Received: by 10.55.73.85 with SMTP id w82mr45617465qka.52.1457548594077;
        Wed, 09 Mar 2016 10:36:34 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:33 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288552>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

trace_stats() is intended for GIT_TRACE_*_STATS variable group and
GIT_TRACE_PACK_STATS is more like an example how new vars can be added.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt |  3 +++
 cache.h               |  2 ++
 git.c                 |  1 +
 sha1_file.c           | 24 ++++++++++++++++++++++++
 trace.c               | 13 +++++++++++++
 trace.h               |  1 +
 6 files changed, 44 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2754af8..794271e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1055,6 +1055,9 @@ of clones and fetches.
 	time of each Git command.
 	See 'GIT_TRACE' for available trace output options.
=20
+'GIT_TRACE_PACK_STATS'::
+	Print various statistics.
+
 'GIT_TRACE_SETUP'::
 	Enables trace messages printing the .git, working tree and current
 	working directory after Git has completed its setup phase.
diff --git a/cache.h b/cache.h
index b829410..7e01403 100644
--- a/cache.h
+++ b/cache.h
@@ -1828,4 +1828,6 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
=20
+void report_pack_stats(struct trace_key *key);
+
 #endif /* CACHE_H */
diff --git a/git.c b/git.c
index 6cc0c07..a4f6f71 100644
--- a/git.c
+++ b/git.c
@@ -655,6 +655,7 @@ int main(int argc, char **av)
 	git_setup_gettext();
=20
 	trace_command_performance(argv);
+	trace_stats();
=20
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa0..14cebdf 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -518,6 +518,7 @@ static unsigned int peak_pack_open_windows;
 static unsigned int pack_open_windows;
 static unsigned int pack_open_fds;
 static unsigned int pack_max_fds;
+static unsigned int pack_access_nr;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
@@ -543,6 +544,28 @@ void pack_report(void)
 		sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped));
 }
=20
+void report_pack_stats(struct trace_key *key)
+{
+	trace_printf_key(key, "\n"
+			 "pack_report: getpagesize()            =3D %10" SZ_FMT "\n"
+			 "pack_report: core.packedGitWindowSize =3D %10" SZ_FMT "\n"
+			 "pack_report: core.packedGitLimit      =3D %10" SZ_FMT "\n"
+			 "pack_report: pack_used_ctr            =3D %10u\n"
+			 "pack_report: pack_mmap_calls          =3D %10u\n"
+			 "pack_report: pack_open_windows        =3D %10u / %10u\n"
+			 "pack_report: pack_mapped              =3D "
+			 "%10" SZ_FMT " / %10" SZ_FMT "\n"
+			 "pack_report: pack accesss             =3D %10u\n",
+			 sz_fmt(getpagesize()),
+			 sz_fmt(packed_git_window_size),
+			 sz_fmt(packed_git_limit),
+			 pack_used_ctr,
+			 pack_mmap_calls,
+			 pack_open_windows, peak_pack_open_windows,
+			 sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped),
+			 pack_access_nr);
+}
+
 /*
  * Open and mmap the index file at path, perform a couple of
  * consistency checks, then record its information to p.  Return 0 on
@@ -2238,6 +2261,7 @@ static void write_pack_access_log(struct packed_g=
it *p, off_t obj_offset)
 	static struct trace_key pack_access =3D TRACE_KEY_INIT(PACK_ACCESS);
 	trace_printf_key(&pack_access, "%s %"PRIuMAX"\n",
 			 p->pack_name, (uintmax_t)obj_offset);
+	pack_access_nr++;
 }
=20
 int do_check_packed_object_crc;
diff --git a/trace.c b/trace.c
index 4aeea60..b1d0885 100644
--- a/trace.c
+++ b/trace.c
@@ -432,3 +432,16 @@ void trace_command_performance(const char **argv)
 	sq_quote_argv(&command_line, argv, 0);
 	command_start_time =3D getnanotime();
 }
+
+static struct trace_key trace_pack_stats =3D TRACE_KEY_INIT(PACK_STATS=
);
+
+static void print_stats_atexit(void)
+{
+	report_pack_stats(&trace_pack_stats);
+}
+
+void trace_stats(void)
+{
+	if (trace_want(&trace_pack_stats))
+		atexit(print_stats_atexit);
+}
diff --git a/trace.h b/trace.h
index 179b249..52bda4e 100644
--- a/trace.h
+++ b/trace.h
@@ -19,6 +19,7 @@ extern void trace_disable(struct trace_key *key);
 extern uint64_t getnanotime(void);
 extern void trace_command_performance(const char **argv);
 extern void trace_verbatim(struct trace_key *key, const void *buf, uns=
igned len);
+extern void trace_stats(void);
=20
 #ifndef HAVE_VARIADIC_MACROS
=20
--=20
2.4.2.767.g62658d5-twtrsrc
