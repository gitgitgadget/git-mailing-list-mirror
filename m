Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8911F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 20:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeK1HsZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 02:48:25 -0500
Received: from mout.web.de ([212.227.15.14]:57321 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeK1HsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 02:48:25 -0500
Received: from [192.168.178.36] ([79.237.241.17]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lwq0e-1fLSGg3MiG-016Na8; Tue, 27
 Nov 2018 21:48:58 +0100
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick existence
 check
To:     Jeff King <peff@peff.net>, Geert Jansen <gerardu@amazon.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145442.GH7400@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ec25f85c-4b8c-0b83-addb-074957de1e1c@web.de>
Date:   Tue, 27 Nov 2018 21:48:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181112145442.GH7400@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bbBKOx1NmSYatGuM9LiJiF61N6rNCmG08onsNWjnybgpP0YDW7v
 dOYYhhirb04bURakl9sxtUnDV2Q3t/5mQm0U/BLsBWp+vJC69NSYhc4bZAzU/DpKiGDv5M9
 JTapJNyFnW3SzQqk9+EeGOU6r0iO0O7j9l0JQIfAI1Dnat6/21itZVrooi8KsecsAUv0WHP
 J6fNIYEZIkYSiFQNNQfrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eHgxm8wqyzs=:04j1/Lwb15ZYAXeb8Ir8V0
 UQhOBTu6ClhVIDzPTdNOtq3Bb1jxf/acXdXYh/76mTjousgfAdaCMcRx9r/DzbMyUbnYpDLbu
 2KxapKajM/bp3dhaCLCrg6HiXzS0u0YTXwaGCJ6R+JFUfDiwfotw+EP1QFXd97Yj//vxDgi3o
 njH5y/yDCee2WQ/IhPJTrV/SItYGWOhsSp0ukSeg2RtHDQEQh7pdrKiM6dDkj/Lw1W999U8Ng
 WEMY33Jxtr+ee2kQL6y3jOy9OvZs+PrpE3HwAfYSPcDwW3Z9R8KyVbVw4x3h8JJy2hhrlQJWF
 /JgvmfwYGQrOnX++zBRWdhUXFouiH0Anv+GbJeyuQXVWVyx1Ps7YULom5QbGraDdYX5++GjPt
 Zs2ntgIBHcbUStyvXC89gOUnPKOwfFjB/8/ZDtRtHTIlcsoVmI25tGGqktpe/wm7KnlmadJQf
 mkJqDGgOcQC/yv9CD8mHu7TkJ0uRXjPYJpnHIThkNNn2P2qW1wDeMDbNi9YqoDSbOVw1gDOYt
 U9sHSb1nv4OhdMmbJPwKR6to9mGS5PZg8xhfabsDUxBmEFjdI6TgVIgohw+lRSg0vHXs9+nA9
 GWNB3iECjVB7+d+l/ivNOm0Xh6JqwzzhU/gGTJgqetaHzVGtRPdx8QlJkcFerJeODhNbhCc1Y
 4So/J9V8TYfsN+OWinse3Hh/4UItCo0VT4XhRz6ycidVszUjQhUaHBL9KVSNbFpM3MSNOmIk4
 M1LYFjNxzhGAtlCiSRx/TYZxm/9TVyN7Hp5O2YAwEKHjo2blXk2nWphWlHkEy4VVkO7FHbx3H
 mkdzRY14fsXTpEngEqCSEKW3KRE+9JQl2Knf5F0KRUPOZIQJO7kxxZbbuDYZ2mnsgf4cPAZdD
 n6TpnyU4wIfeWjQa+etdHUoQXt7vsSHCvtXRL+0u4kAGx6dLzHNEYWDutulLfo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.2018 um 15:54 schrieb Jeff King:
> diff --git a/sha1-file.c b/sha1-file.c
> index 4aae716a37..e53da0b701 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -921,6 +921,24 @@ static int open_sha1_file(struct repository *r,
>  	return -1;
>  }
>  
> +static int quick_has_loose(struct repository *r,
> +			   const unsigned char *sha1)
> +{
> +	int subdir_nr = sha1[0];
> +	struct object_id oid;
> +	struct object_directory *odb;
> +
> +	hashcpy(oid.hash, sha1);
> +
> +	prepare_alt_odb(r);
> +	for (odb = r->objects->odb; odb; odb = odb->next) {
> +		odb_load_loose_cache(odb, subdir_nr);

Is this thread-safe?  What happens if e.g. one index-pack thread resizes
the array while another one sorts it?

Loading the cache explicitly up-front would avoid that, and improves
performance a bit in my (very limited) tests on an SSD.  Demo patch for
next at the bottom.  How does it do against your test cases?

> +		if (oid_array_lookup(&odb->loose_objects_cache, &oid) >= 0)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Map the loose object at "path" if it is not NULL, or the path found by
>   * searching for a loose object named "sha1".
> @@ -1171,6 +1189,8 @@ static int sha1_loose_object_info(struct repository *r,
>  	if (!oi->typep && !oi->type_name && !oi->sizep && !oi->contentp) {
>  		const char *path;
>  		struct stat st;
> +		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
> +			return quick_has_loose(r, sha1) ? 0 : -1;
>  		if (stat_sha1_file(r, sha1, &st, &path) < 0)
>  			return -1;
>  		if (oi->disk_sizep)
> 

 builtin/fetch.c      |  2 ++
 builtin/index-pack.c |  2 ++
 fetch-pack.c         |  2 ++
 object-store.h       |  1 +
 sha1-file.c          | 30 +++++++++++++++++++++++++++---
 5 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e0140327aa..4b031f5da5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -301,6 +301,8 @@ static void find_non_local_tags(const struct ref *refs,
 	refname_hash_init(&existing_refs);
 	refname_hash_init(&remote_refs);
 
+	repo_load_loose_cache(the_repository);
+
 	for_each_ref(add_one_refname, &existing_refs);
 	for (ref = refs; ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ac1f4ea9a7..7fc6321c77 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1772,6 +1772,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (show_stat)
 		obj_stat = xcalloc(st_add(nr_objects, 1), sizeof(struct object_stat));
 	ofs_deltas = xcalloc(nr_objects, sizeof(struct ofs_delta_entry));
+	if (startup_info->have_repository)
+		repo_load_loose_cache(the_repository);
 	parse_pack_objects(pack_hash);
 	if (report_end_of_input)
 		write_in_full(2, "\0", 1);
diff --git a/fetch-pack.c b/fetch-pack.c
index dd6700bda9..96c4624d9e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -656,6 +656,8 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 
 	save_commit_buffer = 0;
 
+	repo_load_loose_cache(the_repository);
+
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
diff --git a/object-store.h b/object-store.h
index 8dceed0f31..f98dd3c857 100644
--- a/object-store.h
+++ b/object-store.h
@@ -53,6 +53,7 @@ void add_to_alternates_memory(const char *dir);
  * from 0 to 255 inclusive).
  */
 void odb_load_loose_cache(struct object_directory *odb, int subdir_nr);
+void repo_load_loose_cache(struct repository *r);
 
 struct packed_git {
 	struct packed_git *next;
diff --git a/sha1-file.c b/sha1-file.c
index 05f63dfd4e..ae12f0a198 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -921,10 +921,19 @@ static int open_sha1_file(struct repository *r,
 	return -1;
 }
 
+static int quick_has_loose_odb(struct object_directory *odb,
+			       const struct object_id *oid)
+{
+	int subdir_nr = oid->hash[0];
+
+	if (odb->loose_objects_subdir_seen[subdir_nr])
+		return oid_array_lookup(&odb->loose_objects_cache, oid) >= 0;
+	return check_and_freshen_odb(odb, oid, 0);
+}
+
 static int quick_has_loose(struct repository *r,
 			   const unsigned char *sha1)
 {
-	int subdir_nr = sha1[0];
 	struct object_id oid;
 	struct object_directory *odb;
 
@@ -932,8 +941,7 @@ static int quick_has_loose(struct repository *r,
 
 	prepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next) {
-		odb_load_loose_cache(odb, subdir_nr);
-		if (oid_array_lookup(&odb->loose_objects_cache, &oid) >= 0)
+		if (quick_has_loose_odb(odb, &oid))
 			return 1;
 	}
 	return 0;
@@ -2178,6 +2186,22 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
 	strbuf_release(&buf);
 }
 
+void repo_load_loose_cache(struct repository *r)
+{
+	struct object_directory *odb;
+
+	prepare_alt_odb(r);
+	for (odb = r->objects->odb; odb; odb = odb->next) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(odb->loose_objects_subdir_seen); i++)
+			odb_load_loose_cache(odb, i);
+
+		/* Sort as a side-effect, only read the cache from here on. */
+		oid_array_lookup(&odb->loose_objects_cache, &null_oid);
+	}
+}
+
 static int check_stream_sha1(git_zstream *stream,
 			     const char *hdr,
 			     unsigned long size,
