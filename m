Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1019C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 10:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLOKgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 05:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOKgd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 05:36:33 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EB2E099
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 02:36:31 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kw15so51200337ejc.10
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 02:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pyuhMYfgK58/ED3+HoIB1qNQ/Kb6Rv/GgWDf2ncA1Fo=;
        b=PznJGSm5wMSDpOFvn++j+SIFSWSIJTRKzayYl3STEGjD2OAOk91Uf1Dx9DGRUJDPlV
         tF3G0qVTjUKHduvErCtWLi8FcBvceYfh9JJlVBdf5xUJvamA9FiPRRM2qpxR0oIvY7eL
         iDIviWSt/njjANv6kZXKVexSQpDxCwlszwnka1g5XiGu9A/IvHJvoLyxVm9dvhkOCo6D
         SK1pCjfS1LDUg0FMVj1efyqgyEK3bpsLInspPyfk6kOV2xGHSDBJ0Un96syAUJ4NHKX9
         1TuDKmrshBmogLd8g/wVURDy/PLnDNtlmujaVEgcy9KSSTlIAuJpQkfUwcBnwZQIUlMO
         y9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyuhMYfgK58/ED3+HoIB1qNQ/Kb6Rv/GgWDf2ncA1Fo=;
        b=BCIYg+e1AlUzrt2OAZwk5x7i4sKqMpeW5BdvjNBGwXClgBGCsc8b2vLZAbCrGr9+yy
         6IAFWCoJY0JI7LY/laOnlEFyPPQSldfsIfuKWerEPc/VVG92voMI6BIehrx3EuX/ycxs
         aBBKw8a2BudlIoBWuoPSQCxHfYnNByY4V1I5e8BTSeOfrZAPf0QtCcDko0U1Jmt/AtPz
         1SXdKXdL5tf+XovojVHjho/jzJHme5JIt1xNB3+sGuUYPkFzNrGdDmshQM8S+Ck6zQ3B
         9ux7XIWlKmC3xts933kwywHs2M3rimqvrGfyPr1P0GGgG3A4OG1gi/d+nOLNpvCzDolE
         eKeg==
X-Gm-Message-State: ANoB5pnouY0cCld4hHJ+8kL1cnnkHluomBbmi6mQDJlByO+LMimJNKlB
        Q7t+rQirVUtjq+Ud6g/Ehpc=
X-Google-Smtp-Source: AA0mqf7uaoMr6CGGhJb06vNTGoEJmRbj54PdeP0ABW7VAy2AFILUCxHFuPHGFs3fG0VhNXfVf45jLg==
X-Received: by 2002:a17:906:8920:b0:7c0:dfbd:5a1a with SMTP id fr32-20020a170906892000b007c0dfbd5a1amr19899209ejc.33.1671100589941;
        Thu, 15 Dec 2022 02:36:29 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id um8-20020a170906cf8800b0078d3f96d293sm6965158ejb.30.2022.12.15.02.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 02:36:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5lbJ-006Cfc-0O;
        Thu, 15 Dec 2022 11:36:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] git: remove unneeded casts
Date:   Thu, 15 Dec 2022 11:07:24 +0100
References: <pull.1396.git.git.1671032126602.gitgitgadget@gmail.com>
 <Y5o9NNVx7dFLhIMd@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y5o9NNVx7dFLhIMd@coredump.intra.peff.net>
Message-ID: <221215.86edt12bte.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 14 2022, Jeff King wrote:

> On Wed, Dec 14, 2022 at 03:35:26PM +0000, Rose via GitGitGadget wrote:
> [...]
>> diff --git a/oidmap.h b/oidmap.h
>> index c66a83ab1d6..9cefbba550d 100644
>> --- a/oidmap.h
>> +++ b/oidmap.h
>> @@ -87,7 +87,7 @@ static inline void *oidmap_iter_first(struct oidmap *map,
>>  {
>>  	oidmap_iter_init(map, iter);
>>  	/* TODO: this API could be reworked to do compile-time type checks */
>> -	return (void *)oidmap_iter_next(iter);
>> +	return oidmap_iter_next(iter);
>>  }
>
> This comes from 87571c3f71 (hashmap: use *_entry APIs for
> iteration, 2019-10-06), whose only change to this line is
> adding the cast. Maybe the intent was to flag the area to be
> handled later according to the comment? I'd think the
> comment itself suffices, there. But if not, then we're
> undoing it.
>
> There's an identical case (from the same commit) a few lines
> above. If we are changing this one, we should do both.
>
> I'll stop here for now. It's a fair bit of leg-work digging
> these up (though again, I do think there's value in
> understanding why the cast was there, even if we know it
> isn't _currently_ doing anything).

Thanks for doing all that leg-work. Whan I saw this patch earlier I was
going to point out the same.

I.e. we really should know why these are there in the first place, or
alterantively convince ourselves that e.g a wide-ranging coccinelle rule
we're applying is safe.

I wondered if we could find potential candidates with a brute-force
approach, this is very much a hack, but perhaps for something for Rose
to chew on (either for this topic, or as a follow-up):

	# Could adjust this regex to catch more types...
	perl -pi -e 's/\((void|const char|char)\s*\*\)\s*//g' $(git ls-files '*.[ch]')
        # Commit a hunk at a time...
	while true; do echo y | git add -p && git commit -m"bump"; done

This gives you around ~500 commits. It's also inaccurate, e.g. it ruined
some function-prototypes, edited comments etc. But let's look past that
for now.

Then, as even further brute-forcing, let's get rid of those commits
generated above where the compiler doesn't like it:

	git rebase -i -x 'make objects || git reset --hard HEAD^1 && make objects'

Now, I'd never suggest that we actually apply the result of this
monkeypatching.

Even if the compiler could spot logic errors in this with 100%
accuratecy the above would still be broken, as it won't compile all
possible codepaths (e.g. in compat/*, which I should have left out to
begin with).

But it *is* useful to see common patterns that might serve as potential
candidates, and it even spots a case where e.g. the "mf.ptr" still has a
cast in diff.c, so that seems to be missed from the upthread patch.

Rose: It's really much more useful to edit contrib/coccinelle/*.cocci to
add a rule saying "whenever we have a type X being assigned to, cast to
Y, that Y cast can be removed". The coccinelle engine is much better at
spotting those than human eyes, or grep/search & replace.

Those disclaimers aside, the above yields ~170 commits on top of the
above.

Excluding compat/ the diff is the below. Some of it's broken, but some
of it suggests things that are worth picking up, e.g. the return value
of xmalloc() being cast (a C++-ism), "(char *)NULL" (do we ever need to
cast NULL?)

 bisect.c                     |  2 +-
 block-sha1/sha1.c            |  6 +++---
 builtin/bisect.c             | 14 +++++++-------
 builtin/help.c               | 10 +++++-----
 builtin/receive-pack.c       |  2 +-
 builtin/replace.c            |  2 +-
 builtin/tag.c                |  2 +-
 bundle-uri.c                 |  2 +-
 connect.c                    |  2 +-
 diff.c                       |  6 +++---
 fsck.c                       |  2 +-
 git-compat-util.h            | 16 ++++++++--------
 grep.c                       |  2 +-
 hashmap.c                    |  2 +-
 http.c                       |  2 +-
 imap-send.c                  |  4 ++--
 khash.h                      |  4 ++--
 line-range.c                 |  4 ++--
 list.h                       |  2 +-
 notes.c                      |  2 +-
 object-name.c                |  2 +-
 oidmap.h                     |  2 +-
 pack-bitmap.c                |  2 +-
 pack-revindex.c              |  4 ++--
 read-cache.c                 |  6 +++---
 reftable/writer.c            |  4 ++--
 rerere.c                     |  6 +++---
 resolve-undo.c               |  2 +-
 revision.c                   |  2 +-
 sha1dc/sha1.c                |  2 +-
 t/helper/test-rot13-filter.c |  4 ++--
 t/helper/test-run-command.c  |  4 ++--
 t/helper/test-simple-ipc.c   |  4 ++--
 t/helper/test-string-list.c  |  2 +-
 thread-utils.c               |  2 +-
 thread-utils.h               |  4 ++--
 xdiff/xutils.c               |  2 +-
 37 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/bisect.c b/bisect.c
index ec7487e6836..440098991c3 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1179 +1179 @@ int bisect_clean_state(void)
-	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
+	for_each_ref_in("refs/bisect", mark_for_removal, &refs_for_removal);
diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 80cebd27564..9759febb120 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -196 +196 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, size_t len)
-		memcpy(lenW + (char *)ctx->W, data, left);
+		memcpy(lenW + ctx->W, data, left);
@@ -199 +199 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, size_t len)
-		data = ((const char *)data + left);
+		data = (data + left);
@@ -206 +206 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, size_t len)
-		data = ((const char *)data + 64);
+		data = (data + 64);
diff --git a/builtin/bisect.c b/builtin/bisect.c
index cc9483e8515..50e5275efaa 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -79 +79 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
-	free((void *)terms->term_good);
+	free(terms->term_good);
@@ -81 +81 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
-	free((void *)terms->term_bad);
+	free(terms->term_bad);
@@ -419 +419 @@ static void bisect_status(struct bisect_state *state,
-			     (void *) &state->nr_good);
+			     &state->nr_good);
@@ -723 +723 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
-			free((void *) terms->term_good);
+			free(terms->term_good);
@@ -728 +728 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
-			free((void *) terms->term_good);
+			free(terms->term_good);
@@ -736 +736 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
-			free((void *) terms->term_bad);
+			free(terms->term_bad);
@@ -741 +741 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
-			free((void *) terms->term_bad);
+			free(terms->term_bad);
diff --git a/builtin/help.c b/builtin/help.c
index 53f2812dfb1..c42d4763994 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -275 +275 @@ static void exec_woman_emacs(const char *path, const char *page)
-		execlp(path, "emacsclient", "-e", man_page.buf, (char *)NULL);
+		execlp(path, "emacsclient", "-e", man_page.buf, NULL);
@@ -307 +307 @@ static void exec_man_man(const char *path, const char *page)
-	execlp(path, "man", page, (char *)NULL);
+	execlp(path, "man", page, NULL);
@@ -315 +315 @@ static void exec_man_cmd(const char *cmd, const char *page)
-	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
+	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, NULL);
@@ -505 +505 @@ static void show_info_page(const char *page)
-	execlp("info", "info", "gitman", page, (char *)NULL);
+	execlp("info", "info", "gitman", page, NULL);
@@ -534 +534 @@ static void open_html(const char *path)
-	execl_git_cmd("web--browse", "-c", "help.browser", path, (char *)NULL);
+	execl_git_cmd("web--browse", "-c", "help.browser", path, NULL);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a90af303630..bc229f112e0 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1714 +1714 @@ static void check_aliased_updates(struct command *commands)
-		item->util = (void *)cmd;
+		item->util = cmd;
diff --git a/builtin/replace.c b/builtin/replace.c
index a29e911d309..3a3bbb49d6d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -94 +94 @@ static int list_replace_refs(const char *pattern, const char *format)
-	for_each_replace_ref(the_repository, show_reference, (void *)&data);
+	for_each_replace_ref(the_repository, show_reference, &data);
diff --git a/builtin/tag.c b/builtin/tag.c
index d428c45dc8d..8c0be18cb11 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -130 +130 @@ static int delete_tags(const char **argv)
-	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
+	result = for_each_tag_name(argv, collect_tags, &refs_to_delete);
diff --git a/bundle-uri.c b/bundle-uri.c
index 79a914f961b..3813935ec69 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -21 +21 @@ static int compare_bundles(const void *hashmap_cmp_fn_data,
-	return strcmp(e1->id, id ? (const char *)id : e2->id);
+	return strcmp(e1->id, id ? id : e2->id);
diff --git a/connect.c b/connect.c
index 5ea53deda23..52bf52f2f91 100644
--- a/connect.c
+++ b/connect.c
@@ -219 +219 @@ static void annotate_refs_with_symref_info(struct ref *ref)
-		ref->symref = xstrdup((char *)item->util);
+		ref->symref = xstrdup(item->util);
diff --git a/diff.c b/diff.c
index 2e58c9372b4..6f0951350bf 100644
--- a/diff.c
+++ b/diff.c
@@ -581 +581 @@ static int fill_mmfile(struct repository *r, mmfile_t *mf,
-		mf->ptr = (char *)""; /* does not matter */
+		mf->ptr = ""; /* does not matter */
@@ -4058 +4058 @@ int diff_populate_filespec(struct repository *r,
-			s->data = (char *)"";
+			s->data = "";
@@ -4201 +4201 @@ static void prep_temp_blob(struct index_state *istate,
-			(const char *)blob, (size_t)size, &buf, &meta)) {
+			blob, (size_t)size, &buf, &meta)) {
diff --git a/fsck.c b/fsck.c
index b3da1d68c0b..4183ca065c1 100644
--- a/fsck.c
+++ b/fsck.c
@@ -749 +749 @@ static int verify_headers(const void *data, unsigned long size,
-	const char *buffer = (const char *)data;
+	const char *buffer = data;
diff --git a/git-compat-util.h b/git-compat-util.h
index a76d0526f79..cf0e275621e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -89 +89 @@ struct strbuf;
- *		 ((char *)(foo)						\
+ *		 ((foo)						\
@@ -302 +302 @@ static inline int is_xplatform_dir_sep(int c)
- * Size needs to match (or exceed) 'sizeof(void *)'.
+ * Size needs to match (or exceed) 'sizeof'.
@@ -355 +355 @@ static inline int setitimer(int which UNUSED,
-char *gitbasename(char *);
+char *gitbasename;
@@ -357 +357 @@ char *gitbasename(char *);
-char *gitdirname(char *);
+char *gitdirname;
@@ -868 +868 @@ int gitsetenv(const char *, const char *, int);
-char *gitmkdtemp(char *);
+char *gitmkdtemp;
@@ -873 +873 @@ char *gitmkdtemp(char *);
-int gitunsetenv(const char *);
+int gitunsetenv;
@@ -963 +963 @@ static inline char *gitstrchrnul(const char *s, int c)
-	return (char *)s;
+	return s;
@@ -1573 +1573 @@ int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
-	((type *) ((char *)(ptr) - offsetof(type, member)))
+	((type *) ((ptr) - offsetof(type, member)))
diff --git a/grep.c b/grep.c
index 06eed694936..de7c28776fb 100644
--- a/grep.c
+++ b/grep.c
@@ -391 +391 @@ static void free_pcre2_pattern(struct grep_pat *p)
-	free((void *)p->pcre2_tables);
+	free(p->pcre2_tables);
diff --git a/hashmap.c b/hashmap.c
index cf5fea87eb0..4a6a0d6b14a 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -188 +188 @@ static void free_individual_entries(struct hashmap *map, ssize_t entry_offset)
-		free((char *)e - entry_offset);
+		free(e - entry_offset);
diff --git a/http.c b/http.c
index 32db5d76a7c..3a8ece892ed 100644
--- a/http.c
+++ b/http.c
@@ -550 +550 @@ static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
-	rc = setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, (void *)&ka, len);
+	rc = setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, &ka, len);
diff --git a/imap-send.c b/imap-send.c
index e67dbfc5567..a73471300d2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -777 +777 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
-			cmdp = (struct imap_cmd *)((char *)imap->in_progress_append -
+			cmdp = (struct imap_cmd *)(imap->in_progress_append -
@@ -903 +903 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
-	return (char *)response_64;
+	return response_64;
diff --git a/khash.h b/khash.h
index cb79bf88567..95ac4f4d9ab 100644
--- a/khash.h
+++ b/khash.h
@@ -88,2 +88,2 @@ static const double __ac_HASH_UPPER = 0.77;
-		free((void *)h->keys);											\
-		free((void *)h->vals);											\
+		free(h->keys);											\
+		free(h->vals);											\
diff --git a/line-range.c b/line-range.c
index 955a8a95355..8ab64d95e7b 100644
--- a/line-range.c
+++ b/line-range.c
@@ -160 +160 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
-		if (match_funcname(xecfg, (char*) bol, (char*) eol))
+		if (match_funcname(xecfg, bol, eol))
@@ -216 +216 @@ static const char *parse_range_funcname(
-	p = find_funcname_matching_regexp(xecfg, (char*) start, &regexp);
+	p = find_funcname_matching_regexp(xecfg, start, &regexp);
diff --git a/list.h b/list.h
index 362a4cd7f5f..bab41d6aa64 100644
--- a/list.h
+++ b/list.h
@@ -122 +122 @@ static inline void list_splice(struct list_head *add, struct list_head *head)
-	((type *) ((char *) (ptr) - offsetof(type, member)))
+	((type *) ((ptr) - offsetof(type, member)))
diff --git a/notes.c b/notes.c
index f2805d51bb1..ffe2f030a56 100644
--- a/notes.c
+++ b/notes.c
@@ -830 +830 @@ int combine_notes_concatenate(struct object_id *cur_oid,
-	buf = (char *) xmalloc(buf_len);
+	buf = xmalloc(buf_len);
diff --git a/object-name.c b/object-name.c
index 2dd1a0f56e1..9908d65af17 100644
--- a/object-name.c
+++ b/object-name.c
@@ -808 +808 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
-	ds.cb_data = (void *)&mad;
+	ds.cb_data = &mad;
diff --git a/oidmap.h b/oidmap.h
index 9cefbba550d..c72e9c9c40e 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -82 +82 @@ static inline void *oidmap_iter_next(struct oidmap_iter *iter)
-	return (void *)hashmap_iter_next(&iter->h_iter);
+	return hashmap_iter_next(&iter->h_iter);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d2a42abf28c..3a3115ad105 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -202 +202 @@ static int load_bitmap_header(struct bitmap_index *index)
-				index->table_lookup = (void *)(index_end - table_size);
+				index->table_lookup = (index_end - table_size);
diff --git a/pack-revindex.c b/pack-revindex.c
index fa897b54584..ffe034957fc 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -278 +278 @@ static int load_pack_revindex_from_disk(struct packed_git *p)
-	p->revindex_data = (const uint32_t *)((const char *)p->revindex_map + RIDX_HEADER_SIZE);
+	p->revindex_data = (const uint32_t *)(p->revindex_map + RIDX_HEADER_SIZE);
@@ -333 +333 @@ int load_midx_revindex(struct multi_pack_index *m)
-	m->revindex_data = (const uint32_t *)((const char *)m->revindex_map + RIDX_HEADER_SIZE);
+	m->revindex_data = (const uint32_t *)(m->revindex_map + RIDX_HEADER_SIZE);
diff --git a/read-cache.c b/read-cache.c
index f4c4cc63dc4..0f1a18ecf02 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1920 +1920 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
-		name = (const char *)(flagsp + 2 * sizeof(uint16_t));
+		name = (flagsp + 2 * sizeof(uint16_t));
@@ -1923 +1923 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
-		name = (const char *)(flagsp + sizeof(uint16_t));
+		name = (flagsp + sizeof(uint16_t));
@@ -1980 +1980 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
-		*ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;
+		*ent_size = (name - (ondisk)) + len + 1 - copy_len;
diff --git a/reftable/writer.c b/reftable/writer.c
index 2e322a5683d..ee015525536 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -193 +193 @@ static void writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
-		tree_search((void *)key, &w->obj_index_tree,
+		tree_search(key, &w->obj_index_tree,
@@ -280 +280 @@ int reftable_writer_add_ref(struct reftable_writer *w,
-		strbuf_add(&h, (char *)reftable_ref_record_val1(ref),
+		strbuf_add(&h, reftable_ref_record_val1(ref),
diff --git a/rerere.c b/rerere.c
index 876ab435da9..9b59fa7940b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -556 +556 @@ static int find_conflict(struct repository *r, struct string_list *conflict)
-			string_list_insert(conflict, (const char *)e->name);
+			string_list_insert(conflict, e->name);
@@ -590 +590 @@ int rerere_remaining(struct repository *r, struct string_list *merge_rr)
-			string_list_insert(merge_rr, (const char *)e->name);
+			string_list_insert(merge_rr, e->name);
@@ -593 +593 @@ int rerere_remaining(struct repository *r, struct string_list *merge_rr)
-			it = string_list_lookup(merge_rr, (const char *)e->name);
+			it = string_list_lookup(merge_rr, e->name);
diff --git a/resolve-undo.c b/resolve-undo.c
index e81096e2d45..176186d7e9d 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -81 +81 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
-			len = (endptr + 1) - (char*)data;
+			len = (endptr + 1) - data;
diff --git a/revision.c b/revision.c
index c86e76e4716..93ef97e7e76 100644
--- a/revision.c
+++ b/revision.c
@@ -3909 +3909 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
-				     (char *)message, strlen(message));
+				     message, strlen(message));
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index dede2cbddf9..901aff46cfb 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -1873 +1873 @@ int SHA1DCFinal(unsigned char output[20], SHA1_CTX *ctx)
-	SHA1DCUpdate(ctx, (const char*)(sha1_padding), padn);
+	SHA1DCUpdate(ctx, (sha1_padding), padn);
diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
index f8d564c622a..43ae901fd2c 100644
--- a/t/helper/test-rot13-filter.c
+++ b/t/helper/test-rot13-filter.c
@@ -67,2 +67,2 @@ static char *get_value(char *buf, const char *key)
-	    !skip_prefix((const char *)buf, key, (const char **)&buf) ||
-	    !skip_prefix((const char *)buf, "=", (const char **)&buf) ||
+	    !skip_prefix(buf, key, (const char **)&buf) ||
+	    !skip_prefix(buf, "=", (const char **)&buf) ||
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index eadde7c47b1..0d93ee1bcd7 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -110 +110 @@ static int test_finished(int result, struct strbuf *err, void *cb,
-	const char *name = (const char *)task_cb;
+	const char *name = task_cb;
@@ -123 +123 @@ static int test_failed(struct strbuf *out, void *cb, void *task_cb)
-	const char *name = (const char *)task_cb;
+	const char *name = task_cb;
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 28365ff85b6..7830353e08d 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -181 +181 @@ static int test_app_cb(void *application_data,
-	if (application_data != (void*)&my_app_data)
+	if (application_data != &my_app_data)
@@ -269 +269 @@ static int daemon__run_server(void)
-	ret = ipc_server_run(cl_args.path, &opts, test_app_cb, (void*)&my_app_data);
+	ret = ipc_server_run(cl_args.path, &opts, test_app_cb, &my_app_data);
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 2123dda85bf..43bea3ba6b3 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -41 +41 @@ static int prefix_cb(struct string_list_item *item, void *cb_data)
-	const char *prefix = (const char *)cb_data;
+	const char *prefix = cb_data;
diff --git a/thread-utils.c b/thread-utils.c
index 6d3de821473..d00d018759b 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -89 +89 @@ int dummy_pthread_create(pthread_t *pthread, const void *attr,
-			 void *(*fn)(void *), void *data)
+			 void *(*fn), void *data)
diff --git a/thread-utils.h b/thread-utils.h
index 4961487ed91..e103cf82b0c 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -46 +46 @@ int dummy_pthread_create(pthread_t *pthread, const void *attr,
-			 void *(*fn)(void *), void *data);
+			 void *(*fn), void *data);
@@ -49 +49 @@ int dummy_pthread_join(pthread_t pthread, void **retval);
-int dummy_pthread_init(void *);
+int dummy_pthread_init;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 853f2260a1d..a6a6277fb52 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -115 +115 @@ void *xdl_cha_alloc(chastore_t *cha) {
-	data = (char *) ancur + sizeof(chanode_t) + ancur->icurr;
+	data = ancur + sizeof(chanode_t) + ancur->icurr;
