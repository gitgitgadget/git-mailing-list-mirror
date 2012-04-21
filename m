From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Sat, 21 Apr 2012 12:46:36 +0700
Message-ID: <20120421054636.GA6849@do>
References: <4F8F1BC1.3030607@ramsay1.demon.co.uk>
 <4F8FADCF.5000006@viscovery.net>
 <4F8FB4A0.7090403@viscovery.net>
 <20120419093608.GA19391@duynguyen-vnpc.dek-tpc.internal>
 <CABPQNSZ6VdyoLcVUUJ4z5A2A7KGP8qBZAkzdx8zAtAs2mZN25w@mail.gmail.com>
 <CACsJy8DDLmKkBMW_P8RyGTRw=i6OKWZNf-SHoGkVWnJgfK7cVQ@mail.gmail.com>
 <CABPQNSb9BSfmGu2bYtZUndgkTom=r+Ho_CKsDr7wo=jfxiXEjA@mail.gmail.com>
 <4F9017BF.90702@viscovery.net>
 <CABPQNSa7NiK=baYbDBENt-An0mFGn1i+GPnN_=LpqAVScXrG2w@mail.gmail.com>
 <20120421030018.GA32687@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 07:50:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLTDV-0004fy-HT
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 07:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab2DUFtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 01:49:52 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:62948 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab2DUFtv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 01:49:51 -0400
Received: by dake40 with SMTP id e40so13832666dak.11
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 22:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mfD1QDaEmNYNxXvVcAh9Ue+oYhRg971eisI/4YnHWZU=;
        b=gkOlAjBPHS9jJYy//Hx3W1+/1B6kGMWvrthsT9VqmFrSzX9D3xaCOgO9GRIaEpA4PL
         nyMiQ5NWGYE8W0Hopu3hNc4dnPZc7SgcAEJcCetCVeLtBxZtlQq8ew3HVn5XrEA6cYrz
         oJDZBumPVS3Vals74iLAgzSoqBucrWsyryWbRdXwydkWRfwyLzvkeT76RgP7hE18fB7C
         ulAHn+lGCiTY5BZuupYg4dYWALx/wV+PH33oGAdfZ0ggDRmSVxPgSgzVEKkMYTZz9s9Z
         hVNGuRXcxr43d/NjDW+Aib3yigmv1saCPacvdawuCRaG7gY9DqM6J0DINHfWsaqi2sMg
         R9vQ==
Received: by 10.68.232.231 with SMTP id tr7mr3087439pbc.63.1334987391157;
        Fri, 20 Apr 2012 22:49:51 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.45.28])
        by mx.google.com with ESMTPS id b10sm7477146pbr.46.2012.04.20.22.49.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Apr 2012 22:49:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 21 Apr 2012 12:46:36 +0700
Content-Disposition: inline
In-Reply-To: <20120421030018.GA32687@do>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196042>

On Sat, Apr 21, 2012 at 10:00:18AM +0700, Nguyen Thai Ngoc Duy wrote:
> > I don't know our use-cases, but I'd be a lot happier if I could find a
> > safe way to have it not update the file-pointer. Just reading it and
> > setting it back again would be racy.
> 
> Replace pread() in index-pack to pread_weak() because we know we don't
> care about file offset in index-pack. Define pread_weak as pread
> normally. Windows port can provide its own pread_weak version, which
> can freely move file offset.

Or we could avoid sharing pack_fd file handle, making pread's
thread-safety irrelevant. This does not give any performance
improvements on linux (I guess linux vfs does not hold per-file
locks), so I'm not interested. If you guys want multithread index-pack
on Windows, go for it.

-- 8< --
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c1c3c81..051325a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -50,6 +50,7 @@ struct thread_local {
 #endif
 	struct base_data *base_cache;
 	size_t base_cache_used;
+	int pack_fd;
 };
 
 /*
@@ -89,7 +90,8 @@ static off_t consumed_bytes;
 static unsigned deepest_delta;
 static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
-static int input_fd, output_fd, pack_fd;
+static const char *curr_pack;
+static int input_fd, output_fd;
 
 #ifndef NO_PTHREADS
 
@@ -126,16 +128,23 @@ static inline void unlock_mutex(pthread_mutex_t *mutex)
  */
 static void init_thread(void)
 {
+	int i;
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
 	pthread_key_create(&key, NULL);
 	thread_data = xcalloc(nr_threads, sizeof(*thread_data));
+	for (i = 0; i < nr_threads; i++) {
+		thread_data[i].pack_fd = open(curr_pack, O_RDONLY);
+		if (thread_data[i].pack_fd == -1)
+			die_errno("unable to open %s", curr_pack);
+	}
 	threads_active = 1;
 }
 
 static void cleanup_thread(void)
 {
+	int i;
 	if (!threads_active)
 		return;
 	threads_active = 0;
@@ -143,6 +152,8 @@ static void cleanup_thread(void)
 	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
 	pthread_key_delete(key);
+	for (i = 0; i < nr_threads; i++)
+		close(thread_data[i].pack_fd);
 	free(thread_data);
 }
 
@@ -267,13 +278,13 @@ static const char *open_pack_file(const char *pack_name)
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 		if (output_fd < 0)
 			die_errno("unable to create '%s'", pack_name);
-		pack_fd = output_fd;
+		nothread_data.pack_fd = output_fd;
 	} else {
 		input_fd = open(pack_name, O_RDONLY);
 		if (input_fd < 0)
 			die_errno("cannot open packfile '%s'", pack_name);
 		output_fd = -1;
-		pack_fd = input_fd;
+		nothread_data.pack_fd = input_fd;
 	}
 	git_SHA1_Init(&input_ctx);
 	return pack_name;
@@ -479,7 +490,7 @@ static void *get_data_from_pack(struct object_entry *obj)
 
 	do {
 		ssize_t n = (len < 64*1024) ? len : 64*1024;
-		n = pread(pack_fd, inbuf, n, from);
+		n = pread(get_thread_data()->pack_fd, inbuf, n, from);
 		if (n < 0)
 			die_errno("cannot pread pack file");
 		if (!n)
@@ -1237,7 +1248,7 @@ static void show_pack_info(int stat_only)
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, stat = 0;
-	const char *curr_pack, *curr_index;
+	const char *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
 	const char *keep_name = NULL, *keep_msg = NULL;
 	char *index_name_buf = NULL, *keep_name_buf = NULL;
-- 8< --
-- 
Duy
