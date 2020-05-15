Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C086AC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981DF20758
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzMbIGO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgEORWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 13:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEORWd (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 13:22:33 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48456C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 10:22:32 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id c3so2469365otr.12
        for <git@vger.kernel.org>; Fri, 15 May 2020 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yOjko3+qP8VG48Vne5MK+RkJKCNCYqYGQ1+cbQ7opTY=;
        b=mzMbIGO4BtOOEFP9U2qUqCER8VbiYBWfpi8Np0ypw/zAzEGON5N9vFaNzRgTPqeZ/+
         Hx8+QnAGcl6JAkdLAvO8fONujnqhuu4vFEUr1fok7rPuAs6rm87OUCwbeNlRVmaWEGNX
         lpDqbRdj6UGxEJ9WE6wZAYauZU5v0ElAe5okIJR1dHjoOnnBNVW5zFRzpGEJIsVUxhLv
         F+FCfNJ1/wVIzA66cJq3a+LPC7f3qgb9SRuZnLJ5NIMOSLIGh7HCwbfc00hXr+c4VUkB
         4s+w6DwHPpuWCZwjHORvpiXufXMIZCpAg6Bz5oCRdV9nHz2TBLm2ErqXSr6Bi3Tmj58M
         ytyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yOjko3+qP8VG48Vne5MK+RkJKCNCYqYGQ1+cbQ7opTY=;
        b=ZUFaibseNhxxSxrEq7ExW4/yPU/0UJRKb3SuPlv8asXW4ndXZyuAf2teRTLzpO/ZSq
         iqUPYYQ5uWDCi+YQ7ndSAy+QamTspWftcMMQGBryReIDIxbz2vKCghMd2lz9we9OXuUi
         ziFXGGir5d7Wq4XOR3pvovsdTxdDXu5YJGyzHN0a94DjChsab+EkAQwywC8XdxFrLV7P
         dZxrsT35LONlcWE99F+Wv5mniIfT+Jbd5bdWkP7kJuStEQeFAOXxqgQl1kR7/BT3m869
         kbI0Tb+kbfpNU1ke3Ejrant2RtJK0FSX2edaYffvLWImWZhr3TGAkxKglhRbQ10kPWwp
         s26w==
X-Gm-Message-State: AOAM533liWlgZd8AeKv2aBqx1BoItqTerOfZBZK5Sx12Xrfszlwxbiv5
        Vpqj2nyIAbRf5BcGdfuIN0wCCppDKMU=
X-Google-Smtp-Source: ABdhPJwuzuEo8WYFWqNJ3HBVX72j2fDgpwZx8z8xXNcDQvRIsyBoSpSzlD7/wa9HDnbZ3k5zaZ81gg==
X-Received: by 2002:a9d:3637:: with SMTP id w52mr2718420otb.177.1589563350975;
        Fri, 15 May 2020 10:22:30 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u1sm790193oif.54.2020.05.15.10.22.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 10:22:30 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (v2.27.0-rc0)
Message-ID: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
Date:   Fri, 15 May 2020 13:22:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the test coverage report for the release candidate
v2.27.0-rc0. Please take close look at this report for code
that has been edited since the last release (v2.26.2) but is
not covered by the test suite. Bugs tend to hide in uncovered
code!

The full report also includes changes in 'next' and 'pu' [1].

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/v2.27.0-rc0-commits.txt

---

Uncovered code in 'v2.27.0-rc0' not in 'v2.26.2'
--------------------------------------------------------

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason	5cc044e0 get_short_oid: sort ambiguous objects by type, then SHA-1
oid-array.c
5cc044e0 56) return ret;

Alexandr Miloslavskiy	49d3c4b4 get_superproject_working_tree(): return strbuf
submodule.c
49d3c4b4 2188) return 0;
49d3c4b4 2191) return 0;
49d3c4b4 2245) return 0;

Alexandr Miloslavskiy	3d7747e3 real_path: remove unsafe API
editor.c
3d7747e3 87) strbuf_release(&realpath);

setup.c
3d7747e3 78) strbuf_release(&realpath);

brian m. carlson	8b8f7189 builtin/init-db: allow specifying hash algorithm on command line
builtin/init-db.c
8b8f7189 376) repo_fmt->hash_algo = hash;
8b8f7189 599) hash_algo = hash_algo_by_name(object_format);
8b8f7189 600) if (hash_algo == GIT_HASH_UNKNOWN)

brian m. carlson	e02a7141 worktree: allow repository version 1
worktree.c
e02a7141 476) strbuf_release(&err);

brian m. carlson	edc6dccf builtin/receive-pack: use constant-time comparison for HMAC value
builtin/receive-pack.c
edc6dccf 569) retval = NONCE_BAD;
edc6dccf 570) goto leave;

brian m. carlson	ab90ecae convert: permit passing additional metadata to filter processes
convert.c
ab90ecae 862) goto done;
ab90ecae 868) goto done;
ab90ecae 874) goto done;

brian m. carlson	768e30ea hash: implement and use a context cloning function
sha1-file.c
768e30ea 98) static void git_hash_sha256_clone(git_hash_ctx *dst, const git_hash_ctx *src)
768e30ea 100) git_SHA256_Clone(&dst->sha256, &src->sha256);
768e30ea 101) }
768e30ea 118) static void git_hash_unknown_clone(git_hash_ctx *dst, const git_hash_ctx *src)

brian m. carlson	3c9331a1 builtin/init-db: add environment variable for new repo hash
builtin/init-db.c
3c9331a1 378) int env_algo = hash_algo_by_name(env);
3c9331a1 379) if (env_algo == GIT_HASH_UNKNOWN)
3c9331a1 381) repo_fmt->hash_algo = env_algo;

brian m. carlson	910650d2 Rename sha1_array to oid_array
t/helper/test-oid-array.c
910650d2 29) oid_array_clear(&array);

brian m. carlson	ddddf8d7 fast-import: permit reading multiple marks files
fast-import.c
ddddf8d7 1158) insert_mark(marks, mark, e);

brian m. carlson	1bdca816 fast-import: add options for rewriting submodules
fast-import.c
1bdca816 2192) return -1;
1bdca816 3067) return;
1bdca816 3325) die_errno("cannot read '%s'", f);

brian m. carlson	13e7ed6a builtin/checkout: compute checkout metadata for checkouts
builtin/checkout.c
13e7ed6a 625)        is_null_oid(&info->oid) ? &tree->object.oid :

brian m. carlson	efa7ae36 init-db: move writing repo version into a function
builtin/init-db.c
efa7ae36 192) repo_version = GIT_REPO_VERSION_READ;
efa7ae36 200) git_config_set("extensions.objectformat",

Denton Liu	65c425a2 sequencer: stop leaking buf
sequencer.c
65c425a2 2557) goto done_rebase_i;

Denton Liu	be1bb600 sequencer: make apply_autostash() accept a path
sequencer.c
be1bb600 5203) apply_autostash(rebase_path_autostash());

Denton Liu	ce6521e4 Lib-ify fmt-merge-msg
fmt-merge-msg.c
ce6521e4 24) use_branch_desc = git_config_bool(key, value);
ce6521e4 75) continue;
ce6521e4 107) return 1;
ce6521e4 113) return 2;
ce6521e4 117) return 3;
ce6521e4 126) line[len - 1] = 0;
ce6521e4 167) origin = src;
ce6521e4 168) string_list_append(&src_data->generic, line);
ce6521e4 169) src_data->head_status |= 2;
ce6521e4 188) return;
ce6521e4 201) static void add_branch_desc(struct strbuf *out, const char *name)
ce6521e4 203) struct strbuf desc = STRBUF_INIT;
ce6521e4 205) if (!read_branch_desc(&desc, name)) {
ce6521e4 206) const char *bp = desc.buf;
ce6521e4 207) while (*bp) {
ce6521e4 208) const char *ep = strchrnul(bp, '\n');
ce6521e4 209) if (*ep)
ce6521e4 210) ep++;
ce6521e4 211) strbuf_addf(out, "  : %.*s", (int)(ep - bp), bp);
ce6521e4 212) bp = ep;
ce6521e4 214) strbuf_complete_line(out);
ce6521e4 216) strbuf_release(&desc);
ce6521e4 217) }
ce6521e4 231) return;
ce6521e4 239) return;
ce6521e4 276) else if (people->nr)
ce6521e4 277) strbuf_addf(out, "%s (%d) and others",
ce6521e4 278)     people->items[0].string,
ce6521e4 279)     (int)util_as_integral(&people->items[0]));
ce6521e4 342) return;
ce6521e4 355) if (opts->credit_people)
ce6521e4 356) record_person('c', &committers, commit);
ce6521e4 372) string_list_append(&subjects,
ce6521e4 373)    oid_to_hex(&commit->object.oid));
ce6521e4 387) add_branch_desc(out, name);
ce6521e4 425) subsep = ", ";
ce6521e4 426) strbuf_addstr(out, "HEAD");
ce6521e4 446) strbuf_addstr(out, subsep);
ce6521e4 447) print_joined("commit ", "commits ", &src_data->generic,
ce6521e4 507) if (tag_number == 2) {
ce6521e4 508) struct strbuf tagline = STRBUF_INIT;
ce6521e4 509) strbuf_addch(&tagline, '\n');
ce6521e4 510) strbuf_add_commented_lines(&tagline,
ce6521e4 511) origins.items[first_tag].string,
ce6521e4 512) strlen(origins.items[first_tag].string));
ce6521e4 513) strbuf_insert(&tagbuf, 0, tagline.buf,
ce6521e4 515) strbuf_release(&tagline);
ce6521e4 517) strbuf_addch(&tagbuf, '\n');
ce6521e4 518) strbuf_add_commented_lines(&tagbuf,
ce6521e4 519) origins.items[i].string,
ce6521e4 520) strlen(origins.items[i].string));
ce6521e4 521) fmt_tag_signature(&tagbuf, &sig, buf, len);
ce6521e4 566) continue;

Denton Liu	5b2f6d9c sequencer: make file exists check more efficient
sequencer.c
5b2f6d9c 431) warning_errno(_("could not read '%s'"), path);

Denton Liu	b309a971 reset: extract reset_head() from rebase
reset.c
b309a971 37) ret = -1;
b309a971 38) goto leave_reset_head;
b309a971 43) goto leave_reset_head;
b309a971 66) goto leave_reset_head;
b309a971 72) goto leave_reset_head;
b309a971 77) goto leave_reset_head;
b309a971 81) ret = -1;
b309a971 82) goto leave_reset_head;
b309a971 90) goto leave_reset_head;
b309a971 109) } else if (old_orig)
b309a971 110) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);

Denton Liu	9460fd48 Lib-ify prune-packed
prune-packed.c
9460fd48 26) printf("rm -f %s\n", path);
9460fd48 35) progress = start_delayed_progress(_("Removing duplicate objects"), 256);

Denton Liu	efcf6cf0 rebase: use read_oneliner()
builtin/rebase.c
efcf6cf0 625) } else if (!read_oneliner(&buf, state_dir_path("head", opts),

Denton Liu	7cd54d37 wrapper: indent with tabs
wrapper.c
7cd54d37 221) len = MAX_IO_SIZE;
7cd54d37 243) len = MAX_IO_SIZE;

Denton Liu	86ed00af rebase: use apply_autostash() from sequencer.c
builtin/rebase.c
86ed00af 1040) apply_autostash(state_dir_path("autostash", opts));

Denton Liu	f213f069 rebase: generify reset_head()
builtin/rebase.c
f213f069 879) reset_head(the_repository, &opts->orig_head, "checkout",
f213f069 880)    opts->head_name, 0,

Derrick Stolee	0906ac2b blame: use changed-path Bloom filters
blame.c
0906ac2b 1281) return 1;
0906ac2b 1302) bd->alloc *= 2;
0906ac2b 1303) REALLOC_ARRAY(bd->keys, bd->alloc);
0906ac2b 2899) return;

Derrick Stolee	3ce4ca0a multi-pack-index: respect repack.packKeptObjects=false
midx.c
3ce4ca0a 1307) continue;

Derrick Stolee	c9f7a793 log-tree: make ref_filter_match() a helper method
log-tree.c
c9f7a793 94)     (!*rest || *rest == '/'))

Derrick Stolee	8918e379 revision: complicated pathspecs disable filters
revision.c
8918e379 658) return 1;
8918e379 662) return 1;

Derrick Stolee	6c622f9f commit-graph: write commit-graph chains
commit-graph.c
6c622f9f 1586) return -1;

Derrick Stolee	e3696980 diff: halt tree-diff early after max_changes
tree-diff.c
e3696980 438) break;

Đoàn Trần Công Danh	c933b28d date.c: s/is_date/set_date/
date.c
c933b28d 521) return -1;
c933b28d 532) return -1;

Đoàn Trần Công Danh	4f89f4fc date.c: validate and set time in a helper function
date.c
4f89f4fc 553) return -1;

Elijah Newren	30e89c12 unpack-trees: pull sparse-checkout pattern reading into a new function
unpack-trees.c
30e89c12 1556) o->skip_sparse_checkout = 1;

Elijah Newren	16846444 dir: include DIR_KEEP_UNTRACKED_CONTENTS handling in treat_directory()
dir.c
16846444 1924) FREE_AND_NULL(dir->entries[i]);

Elijah Newren	7af7a258 unpack-trees: add a new update_sparsity() function
unpack-trees.c
7af7a258 1788) goto skip_sparse_checkout;
7af7a258 1815) ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;

Elijah Newren	b9cbd295 rebase: reinstate --no-keep-empty
sequencer.c
b9cbd295 4756) continue;

Emily Shaffer	709df95b help: move list_config_help to builtin/help
builtin/help.c
709df95b 123) puts(var);
709df95b 124) continue;

Emily Shaffer	1411914a bugreport: add uname info
bugreport.c
1411914a 20) strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
1411914a 22)     errno);

Emily Shaffer	617d5719 bugreport: gather git version and build info
help.c
617d5719 641) strbuf_addstr(buf, "no commit associated with this build\n");

Garima Singh	a56b9464 revision.c: use Bloom filters to speed up path based revision walks
bloom.c
a56b9464 286) return -1;

revision.c
a56b9464 721) return -1;

Garima Singh	3d112755 commit-graph: examine commits by generation number
commit-graph.c
3d112755 1307) QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);

Garima Singh	ed591feb bloom.c: core Bloom filter implementation for changed paths.
bloom.c
ed591feb 185) return NULL;
ed591feb 266) for (i = 0; i < diff_queued_diff.nr; i++)
ed591feb 267) diff_free_filepair(diff_queued_diff.queue[i]);
ed591feb 268) filter->data = NULL;
ed591feb 269) filter->len = 0;

Garima Singh	76ffbca7 commit-graph: write Bloom filters to commit graph file
commit-graph.c
76ffbca7 337) chunk_repeated = 1;
76ffbca7 344) chunk_repeated = 1;
76ffbca7 351) break;
76ffbca7 1095) progress = start_delayed_progress(
76ffbca7 1097) ctx->commits.nr);
76ffbca7 1120) progress = start_delayed_progress(
76ffbca7 1122) ctx->commits.nr);

Garima Singh	f1294eaf bloom.c: introduce core Bloom filter constructs
t/helper/test-bloom.c
f1294eaf 25) printf("No filter.\n");
f1294eaf 26) return;

Garima Singh	f97b9325 commit-graph: compute Bloom filters for changed paths
commit-graph.c
f97b9325 1299) progress = start_delayed_progress(
f97b9325 1301) ctx->commits.nr);

Hans Jerry Illikainen	67948981 gpg-interface: prefer check_signature() for GPG verification
gpg-interface.c
67948981 275) error_errno(_("failed writing detached signature to '%s'"),
67948981 277) delete_tempfile(&temp);
67948981 278) return -1;
67948981 293) gpg_status = &buf;

log-tree.c
67948981 512) show_sig_lines(opt, status, "No signature\n");

Heba Waly	b3b18d16 advice: revamp advise API
advice.c
b3b18d16 178) return advice_setting[ADVICE_PUSH_UPDATE_REJECTED].enabled &&
b3b18d16 179)        advice_setting[ADVICE_PUSH_UPDATE_REJECTED_ALIAS].enabled;

Jeff King	d21ee7d1 commit-graph: examine changed-path objects in pack order
commit-graph.c
d21ee7d1 77) return; /* should never happen, but be lenient */
d21ee7d1 82) static int commit_pos_cmp(const void *va, const void *vb)
d21ee7d1 84) const struct commit *a = *(const struct commit **)va;
d21ee7d1 85) const struct commit *b = *(const struct commit **)vb;
d21ee7d1 86) return commit_pos_at(&commit_pos, a) -
d21ee7d1 87)        commit_pos_at(&commit_pos, b);

Jeff King	16ddcd40 sha1_array: let callbacks interrupt iteration
oid-array.c
16ddcd40 76) return ret;

Jeff King	1b4c57fa test-bloom: check that we have expected arguments
t/helper/test-bloom.c
1b4c57fa 54) usage(bloom_usage);
1b4c57fa 59) usage(bloom_usage);
1b4c57fa 71) usage(bloom_usage);
1b4c57fa 85) usage(bloom_usage);

Jeff King	d8410a81 fast-import: replace custom hash with hashmap.c
fast-import.c
d8410a81 60) e2 = container_of(entry_or_key, const struct object_entry, ent);
d8410a81 61) return oidcmp(&e1->idx.oid, &e2->idx.oid);

Jeff King	348482de config: reject parsing of files over INT_MAX
config.c
348482de 537) cf->eof = 1;
348482de 538) return 0;

Johannes Schindelin	12294990 credential: handle `credential.<partial-URL>.<key>` again
urlmatch.c
12294990 581) retval = 0;

Jonathan Tan	fbda77c6 commit-graph: avoid Memory Leaks
commit-graph.c
fbda77c6 296) goto free_and_return;
fbda77c6 363) goto free_and_return;

Jonathan Tan	95acf11a diff: restrict when prefetching occurs
diffcore-rename.c
95acf11a 137) static void prefetch(void *prefetch_options)
95acf11a 139) struct prefetch_options *options = prefetch_options;
95acf11a 141) struct oid_array to_fetch = OID_ARRAY_INIT;
95acf11a 143) for (i = 0; i < rename_dst_nr; i++) {
95acf11a 144) if (rename_dst[i].pair)
95acf11a 149) continue; /* already found exact match */
95acf11a 150) diff_add_if_missing(options->repo, &to_fetch,
95acf11a 151)     rename_dst[i].two);
95acf11a 153) for (i = 0; i < rename_src_nr; i++) {
95acf11a 154) if (options->skip_unmodified &&
95acf11a 155)     diff_unmodified_pair(rename_src[i].p))
95acf11a 160) continue;
95acf11a 161) diff_add_if_missing(options->repo, &to_fetch,
95acf11a 162)     rename_src[i].p->one);
95acf11a 164) promisor_remote_get_direct(options->repo, to_fetch.oid, to_fetch.nr);
95acf11a 165) oid_array_clear(&to_fetch);
95acf11a 166) }

Jorge Lopez Silva	af026519 http: add environment variable support for HTTPS proxies
http.c
af026519 1221) proxy_ssl_cert_password_required = 1;

Jorge Lopez Silva	88238e02 http: add client cert support for HTTPS proxies
http.c
88238e02 376) return git_config_string(&http_proxy_ssl_cert, var, value);
88238e02 379) return git_config_string(&http_proxy_ssl_key, var, value);
88238e02 382) return git_config_string(&http_proxy_ssl_ca_info, var, value);
88238e02 385) proxy_ssl_cert_password_required = git_config_bool(var, value);
88238e02 386) return 0;
88238e02 966) if (ssl_cainfo != NULL)
88238e02 967) curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
88238e02 1294) memset(proxy_cert_auth.password, 0, strlen(proxy_cert_auth.password));
88238e02 1295) FREE_AND_NULL(proxy_cert_auth.password);

Josh Steadmon	3d3adaad trace2: teach Git to log environment variables
trace2/tr2_cfg.c
3d3adaad 63) return tr2_cfg_env_vars_count;

Junio C Hamano	56a1d9ca Merge branch 'dl/libify-a-few'
fmt-merge-msg.c
56a1d9ca 498) strbuf_addstr(&sig, "gpg verification failed.\n");

Karsten Blees	defd7c7b dir.c: git-status --ignored: don't scan the work tree three times
dir.c
defd7c7b 2177) return path_none;

Patrick Steinhardt	edc30691 refs: fix segfault when aborting empty transaction
refs/files-backend.c
edc30691 2572) strbuf_release(&err);

Patrick Steinhardt	a65b8ac2 update-ref: organize commands in an array
builtin/update-ref.c
a65b8ac2 419) continue;

Phillip Wood	430b75f7 commit: give correct advice for empty commit during a rebase
sequencer.c
430b75f7 1469)     return -1;

René Scharfe	9068cfb2 fsck: report non-consecutive duplicate names in trees
fsck.c
9068cfb2 623) break;
9068cfb2 626) if (is_less_than_slash(*p)) {
9068cfb2 627) name_stack_push(candidates, f_name);
9068cfb2 628) break;
9068cfb2 630) }

Son Luong Ngoc	e11d86de midx: teach "git multi-pack-index repack" honor "git repack" configurations
midx.c
e11d86de 1420) argv_array_push(&cmd.args, "--delta-islands");

Taylor Blau	37b9dcab shallow.c: use '{commit,rollback}_shallow_file'
builtin/receive-pack.c
37b9dcab 897) rollback_shallow_file(the_repository, &shallow_lock);

Taylor Blau	fdbde82f builtin/commit-graph.c: introduce split strategy 'no-merge'
commit-graph.c
fdbde82f 1789) break;

Vasil Dimov	8cf51561 range-diff: fix a crash in parsing git-log output
range-diff.c
8cf51561 115) string_list_clear(list, 1);
8cf51561 116) strbuf_release(&buf);
8cf51561 117) strbuf_release(&contents);
8cf51561 118) finish_command(&cp);
8cf51561 119) return -1;

