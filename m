From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log
 --raw"
Date: Fri, 21 Feb 2014 12:09:47 +0700
Message-ID: <20140221050947.GA12510@duynguyen-vnpc.dek-tpc.internal>
References: <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org>
 <20140218155842.GA7855@google.com>
 <xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
 <CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
 <xmqq4n3warni.fsf@gitster.dls.corp.google.com>
 <CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
 <CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
 <xmqqd2ij9be1.fsf@gitster.dls.corp.google.com>
 <CACsJy8AeZWPz=39ySQr9MrSUiLyJDQbs02sumS9VjbbGWzP9pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 06:10:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGiNE-0002lF-N8
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 06:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbaBUFJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 00:09:59 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:35326 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbaBUFJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 00:09:57 -0500
Received: by mail-pb0-f42.google.com with SMTP id jt11so2943896pbb.29
        for <git@vger.kernel.org>; Thu, 20 Feb 2014 21:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9Cf3WuPsGpP0aurrUav0iJhlH4YgFbXzzWHmazQAl6Q=;
        b=YvbPI2QvRumU9pOyVu1snJxXAi9YJ1WWFjMV1ODPdoWP0r2Ju0pOu8qJ6wtW8h41LV
         7vDeDMV+EoZkqDjdhA/rmKxu2o3M8Dh4bS1RUi777YarhBY4pOwirMJ2VivfnZO2vqXA
         f2XTIzNG0cy8A3pPuvf+phNSh6wm/AUNS7rJOYU5hCcW0t4BFAfGWw9CVI/RHFKJtCCK
         L6KR/ouf6u8EY81VQtOZ6FFU2yMUj16n2XnKBLjPJ3VqIrnXnQoWbLVAyWlBeApP6g0f
         qSW4ojbKW0FECer5oOcckT6t2F7hmoF+uAU1xqXigUCqigfAJOcjKxruAgYKNf+q86Ww
         r5Tg==
X-Received: by 10.68.171.229 with SMTP id ax5mr6719016pbc.125.1392959396735;
        Thu, 20 Feb 2014 21:09:56 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id vg1sm16959316pbc.44.2014.02.20.21.09.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 20 Feb 2014 21:09:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 21 Feb 2014 12:09:47 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8AeZWPz=39ySQr9MrSUiLyJDQbs02sumS9VjbbGWzP9pw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242457>

On Fri, Feb 21, 2014 at 06:35:06AM +0700, Duy Nguyen wrote:
> On the other hand, the size reduction is really nice (320MB vs 500MB).
> I don't know if we can do this, but does it make sense to apply
> --depth=250 for old commits only and shallow depth for recent commits?
> 
> For old projects, commits older than 1-2 years is probably less often
> accessed and could use some aggressive packing. This still hits
> git-blame badly. We could even make sure all objects "on the blame
> surface" have short delta chain. But that may be pushing pack-objects
> too much.

We can have a "moderately aggressive" mode like this. With the patch
below, first you repack all and remove all loose objects. Then replay
your favourite use cases with GIT_LOOSE_THEM=1. For example, if I'm
most interested in commits from a yearq ago

$ GIT_LOOSE_THEM=1 ../git log --raw --since=1.year.ago >/dev/null

all relevant trees will be unpacked. Put --stat there too if you want
to unpack blobs. blame-heavy users may want to blame a few (or all)
files here too to unpack more. Now we can repack aggressively all
non-loose objects:

$ git repack -adf --exclude-loose --depth=250

and repack again, this time with normal depth, which would only affect
loose objects

$ git repack -ad

The end result is a pack with ancient history with potentially long
delta chains, tightly packed, and nearer history with shorter
chains. You will not notice any performance degradation (unless I run
past 1 year history in my case). And the result pack of git.git is 39M
rather than 64M with standard depth.

The use of loose objects to mark recent objects is not efficient (but
fast for this prototype). We could store an SHA-1 map instead.

-- 8< --
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 541667f..0e9dc8c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -82,6 +82,7 @@ static int num_preferred_base;
 static struct progress *progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
+static int no_loose;
 
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
@@ -2204,7 +2205,12 @@ static void show_object(struct object *obj,
 			const struct name_path *path, const char *last,
 			void *data)
 {
-	char *name = path_name(path, last);
+	char *name;
+
+	if (no_loose && has_loose_object(obj->sha1))
+		return;
+
+	name = path_name(path, last);
 
 	add_preferred_base_object(name);
 	add_object_entry(obj->sha1, obj->type, name, 0);
@@ -2487,6 +2493,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		{ OPTION_SET_INT, 0, "reflog", &rev_list_reflog, NULL,
 		  N_("include objects referred by reflog entries"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		OPT_BOOL(0, "exclude-loose", &no_loose, ""),
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
 			 N_("output pack to stdout")),
 		OPT_BOOL(0, "include-tag", &include_tag,
diff --git a/builtin/repack.c b/builtin/repack.c
index bb2314c..9b8bb35 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -137,6 +137,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int no_update_server_info = 0;
 	int quiet = 0;
 	int local = 0;
+	int no_loose = 0;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -152,6 +153,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("pass --no-reuse-object to git-pack-objects")),
 		OPT_BOOL('n', NULL, &no_update_server_info,
 				N_("do not run git-update-server-info")),
+		OPT_BOOL(0, "exclude-loose", &no_loose, ""),
 		OPT__QUIET(&quiet, N_("be quiet")),
 		OPT_BOOL('l', "local", &local,
 				N_("pass --local to git-pack-objects")),
@@ -184,6 +186,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd_args, "--non-empty");
 	argv_array_push(&cmd_args, "--all");
 	argv_array_push(&cmd_args, "--reflog");
+	if (no_loose)
+		argv_array_push(&cmd_args, "--exclude-loose");
 	if (window)
 		argv_array_pushf(&cmd_args, "--window=%s", window);
 	if (window_memory)
diff --git a/sha1_file.c b/sha1_file.c
index 6e8c05d..d0988f2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -454,7 +454,7 @@ int has_loose_object_nonlocal(const unsigned char *sha1)
 	return 0;
 }
 
-static int has_loose_object(const unsigned char *sha1)
+int has_loose_object(const unsigned char *sha1)
 {
 	return has_loose_object_local(sha1) ||
 	       has_loose_object_nonlocal(sha1);
@@ -2114,6 +2114,11 @@ struct unpack_entry_stack_ent {
 	unsigned long size;
 };
 
+static void write_sha1_file_prepare(const void *buf, unsigned long len,
+				    const char *type, unsigned char *sha1,
+				    char *hdr, int *hdrlen);
+static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
+			      const void *buf, unsigned long len, time_t mtime);
 void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		   enum object_type *final_type, unsigned long *final_size)
 {
@@ -2126,6 +2131,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
 	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
 	int base_from_cache = 0;
+	static int let_them_loose = -1;
 
 	if (log_pack_access != no_log_pack_access)
 		write_pack_access_log(p, obj_offset);
@@ -2288,6 +2294,17 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	*final_type = type;
 	*final_size = size;
 
+	if (let_them_loose == -1)
+		let_them_loose = getenv("GIT_LOOSE_THEM") != NULL;
+	if (let_them_loose && (type == OBJ_TREE || type == OBJ_BLOB)) {
+		unsigned char sha1[20];
+		char hdr[32];
+		int hdrlen;
+		write_sha1_file_prepare(data, size, typename(type), sha1, hdr, &hdrlen);
+		if (!has_loose_object(sha1))
+			write_loose_object(sha1, hdr, hdrlen, data, size, 0);
+	}
+
 	unuse_pack(&w_curs);
 	return data;
 }
-- 8< --

--
Duy
