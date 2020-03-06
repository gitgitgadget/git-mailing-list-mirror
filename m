Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64215C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 12:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F8920714
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 12:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt8b77B2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCFMGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:06:02 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:53085 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFMGB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 07:06:01 -0500
Received: by mail-pj1-f45.google.com with SMTP id lt1so981829pjb.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 04:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pPl7vq9e/SB10jOuGMTSBkqEtV/Iesf5LygEFBeMbpE=;
        b=Gt8b77B2n59+v0rUBHeWyuAxfWRruoYtWqSXEQGXqm1D0v7ApDB1mXjg0FHN5VQs2T
         pzhAbdV3jIhephq4Zhxd+cxzJo6XjOS/yu1sKvNh4M+bfr79+Aq8cO4po+B3kSb7DlR7
         tIPY1h8xB8IMmv7uApTZKI7slQHJFGb3RrAn4qDATLW+h1tlR3QyFfqEL1cj4koxHY+0
         rD5Ot78QDyJ7Tp2awhw13JA97r6RwTmZhgpdWO645QAv/K/8EABFJSBWQ8tk7JTqtBkB
         TiX4biDQgxrqiyMM+2Nnzz+JfMchZwhGfqabUvu/0OG3L2EbhRrg878Qy4kdFlq7sE3t
         1NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pPl7vq9e/SB10jOuGMTSBkqEtV/Iesf5LygEFBeMbpE=;
        b=oMhSLXR5nFGdoEKqQ91YJ3ast4+oDBA8k31NszQ0Bg4VXYef7P5ZPqkGDg11efQYm/
         iHjO8KsI2S3xodF+bd8BqSmntfqqkrE0SUXew0SqnwlGMF2s2mvZ7PcXqjt1/O9ohwws
         eMaOneeuodc+RwEGIOzNASWqsyMhElLRi9DdRhpJUS9PH9HAfnJls/hfGLCg9Z0+jDVU
         Lrdfp3BGSJM0VaCnWP2bMDCF04dqnHFoD6cFsqoG7RKC1aha07vksFR2zc7unRJkoKvs
         Iks3V5y9iM7x9pgb+WSDxwBoJytZElFVGe9Vc5/6urD0d4loaMPF6+TfCGozqJYp+Ogm
         7ydA==
X-Gm-Message-State: ANhLgQ2hMpL3mfBbPWg0mTmwtymLcwPVMMXTv77RJG3dHxquhYsHfU9H
        sxH85NpYOH2/MIx8DHJv86+/HbN0
X-Google-Smtp-Source: ADFU+vu3KrBM4GtjDCLPx7xaSuFHtA34T0x1bfUiQHbVu25oCYHNlLMlHlHqclrYbC3/anZB+NH4Ng==
X-Received: by 2002:a17:90a:1a51:: with SMTP id 17mr3297844pjl.118.1583496359568;
        Fri, 06 Mar 2020 04:05:59 -0800 (PST)
Received: from [10.1.2.155] ([38.126.33.187])
        by smtp.gmail.com with ESMTPSA id 15sm29719021pfp.125.2020.03.06.04.05.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 04:05:58 -0800 (PST)
To:     GIT Mailing-list <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (March 6, 2020)
Message-ID: <d9596fe8-eaae-c2b5-838b-d1bf8b44aa0a@gmail.com>
Date:   Fri, 6 Mar 2020 07:05:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-03-05-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-03-05.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-03-05.htm

---

pu	17d05ac612cfc7d76fd240b62dd67418207c1142
jch	a8a7972b910f0654ffe620b86f7f8330f52eaaaf
next	e46b2d99d2742df792ec4089722921bf939458c2
master	076cbdcd739aeb33c1be87b73aebae5e43d7bcc5
master@{1}	2d2118b814c11f509e1aa76cb07110f7231668dc


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
brian m. carlson	e02a7141 worktree: allow repository version 1
worktree.c
e02a7141 470) strbuf_release(&err);

brian m. carlson	1bdca816 fast-import: add options for rewriting submodules
fast-import.c
1bdca816 2183) return -1;
1bdca816 3058) return;
1bdca816 3316) die_errno("cannot read '%s'", f);

brian m. carlson	ddddf8d7 fast-import: permit reading multiple marks files
fast-import.c
ddddf8d7 1149) insert_mark(marks, mark, e);

brian m. carlson	768e30ea hash: implement and use a context cloning function
sha1-file.c
768e30ea 98) static void git_hash_sha256_clone(git_hash_ctx *dst, const git_hash_ctx *src)
768e30ea 100) git_SHA256_Clone(&dst->sha256, &src->sha256);
768e30ea 101) }
768e30ea 118) static void git_hash_unknown_clone(git_hash_ctx *dst, const git_hash_ctx *src)

brian m. carlson	efa7ae36 init-db: move writing repo version into a function
builtin/init-db.c
efa7ae36 192) repo_version = GIT_REPO_VERSION_READ;
efa7ae36 200) git_config_set("extensions.objectformat",

brian m. carlson	8b8f7189 builtin/init-db: allow specifying hash algorithm on command line
builtin/init-db.c
8b8f7189 376) repo_fmt->hash_algo = hash;
8b8f7189 599) hash_algo = hash_algo_by_name(object_format);
8b8f7189 600) if (hash_algo == GIT_HASH_UNKNOWN)

brian m. carlson	3c9331a1 builtin/init-db: add environment variable for new repo hash
builtin/init-db.c
3c9331a1 378) int env_algo = hash_algo_by_name(env);
3c9331a1 379) if (env_algo == GIT_HASH_UNKNOWN)
3c9331a1 381) repo_fmt->hash_algo = env_algo;

Denton Liu	b3137f2e reset: extract reset_head() from rebase
reset.c
b3137f2e 37) ret = -1;
b3137f2e 38) goto leave_reset_head;
b3137f2e 43) goto leave_reset_head;
b3137f2e 65) goto leave_reset_head;
b3137f2e 71) goto leave_reset_head;
b3137f2e 76) goto leave_reset_head;
b3137f2e 80) ret = -1;
b3137f2e 81) goto leave_reset_head;
b3137f2e 89) goto leave_reset_head;
b3137f2e 108) } else if (old_orig)
b3137f2e 109) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);

Denton Liu	fa717471 sequencer: use file strbuf for read_oneliner()
sequencer.c
fa717471 438) goto done;
fa717471 444) goto done;

Denton Liu	448bea61 sequencer: make apply_rebase() accept a path
sequencer.c
448bea61 5143) apply_autostash(rebase_path_autostash());

Denton Liu	e71223c6 rebase: use apply_autostash() from sequencer.c
builtin/rebase.c
e71223c6 1028) apply_autostash(state_dir_path("autostash", opts));

Denton Liu	186dbeed rebase: use read_oneliner()
builtin/rebase.c
186dbeed 618) } else if (!read_oneliner(&buf, state_dir_path("head", opts), 0, 1))

Denton Liu	06ebea5c rebase: generify reset_head()
builtin/rebase.c
06ebea5c 868) reset_head(the_repository, &opts->orig_head, "checkout",
06ebea5c 869)    opts->head_name, 0,

Derrick Stolee	92667ee9 commit-graph: examine commits by generation number
commit-graph.c
92667ee9 89) else if (a->date > b->date)
92667ee9 90) return 1;
92667ee9 91) return 0;
92667ee9 1296) QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);

Derrick Stolee	3d2f906e diff: halt tree-diff early after max_changes
tree-diff.c
3d2f906e 438) break;

Emily Shaffer	57166073 bugreport: gather git version and build info
help.c
57166073 641) strbuf_addstr(buf, "no commit associated with this build\n");

Emily Shaffer	dd763e68 help: move list_config_help to builtin/help
builtin/help.c
dd763e68 123) puts(var);
dd763e68 124) continue;

Emily Shaffer	d902ea4d bugreport: add uname info
bugreport.c
d902ea4d 20) strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
d902ea4d 22)     errno);

Garima Singh	282c08a9 commit-graph: write Bloom filters to commit graph file
commit-graph.c
282c08a9 328) chunk_repeated = 1;
282c08a9 335) chunk_repeated = 1;
282c08a9 342) break;
282c08a9 371) graph->chunk_bloom_indexes = NULL;
282c08a9 372) graph->chunk_bloom_data = NULL;
282c08a9 373) graph->bloom_filter_settings = NULL;
282c08a9 1087) progress = start_delayed_progress(
282c08a9 1089) ctx->commits.nr);
282c08a9 1112) progress = start_delayed_progress(
282c08a9 1114) ctx->commits.nr);
282c08a9 1288) progress = start_delayed_progress(

Garima Singh	6bdbf235 commit-graph: compute Bloom filters for changed paths
commit-graph.c
6bdbf235 1290) ctx->commits.nr);

Garima Singh	b6d925e7 bloom: core Bloom filter implementation for changed paths
bloom.c
b6d925e7 247) for (i = 0; i < diff_queued_diff.nr; i++)
b6d925e7 248) diff_free_filepair(diff_queued_diff.queue[i]);
b6d925e7 249) filter->data = NULL;
b6d925e7 250) filter->len = 0;
b6d925e7 267) return -1;

t/helper/test-bloom.c
b6d925e7 20) printf("No filter.\n");
b6d925e7 21) return;

Heba Waly	b3b18d16 advice: revamp advise API
advice.c
b3b18d16 178) return advice_setting[ADVICE_PUSH_UPDATE_REJECTED].enabled &&
b3b18d16 179)        advice_setting[ADVICE_PUSH_UPDATE_REJECTED_ALIAS].enabled;

Jeff King	dc9f0216 commit-graph: examine changed-path objects in pack order
commit-graph.c
dc9f0216 62) return; /* should never happen, but be lenient */
dc9f0216 67) static int commit_pos_cmp(const void *va, const void *vb)
dc9f0216 69) const struct commit *a = *(const struct commit **)va;
dc9f0216 70) const struct commit *b = *(const struct commit **)vb;
dc9f0216 71) return commit_pos_at(&commit_pos, a) -
dc9f0216 72)        commit_pos_at(&commit_pos, b);

Jorge Lopez Silva	88238e02 http: add client cert support for HTTPS proxies
http.c
88238e02 376) return git_config_string(&http_proxy_ssl_cert, var, value);
88238e02 379) return git_config_string(&http_proxy_ssl_key, var, value);
88238e02 382) return git_config_string(&http_proxy_ssl_ca_info, var, value);
88238e02 385) proxy_ssl_cert_password_required = git_config_bool(var, value);
88238e02 386) return 0;
88238e02 964) if (ssl_cainfo != NULL)
88238e02 965) curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
88238e02 1292) memset(proxy_cert_auth.password, 0, strlen(proxy_cert_auth.password));
88238e02 1293) FREE_AND_NULL(proxy_cert_auth.password);

Jorge Lopez Silva	af026519 http: add environment variable support for HTTPS proxies
http.c
af026519 1219) proxy_ssl_cert_password_required = 1;

Taylor Blau	5d5916fd builtin/commit-graph.c: support '--split[=<strategy>]'
commit-graph.c
5d5916fd 1751) break;

Taylor Blau	a599e2c9 builtin/commit-graph.c: introduce '--input=<source>'
builtin/commit-graph.c
a599e2c9 75) *to = 0;
a599e2c9 76) return 0;
a599e2c9 86) *to |= COMMIT_GRAPH_INPUT_APPEND;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Emily Shaffer	e6c57b49 prefix_path: show gitdir if worktree unavailable
pathspec.c
e6c57b49 444) hint_path = get_git_dir();

setup.c
e6c57b49 126) hint_path = get_git_dir();

Phillip Wood	430b75f7 commit: give correct advice for empty commit during a rebase
sequencer.c
430b75f7 1476)     return -1;



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
Elijah Newren	80205040 merge-recursive: apply collision handling unification to recursive case
merge-recursive.c
80205040 1739) return -1;
80205040 1746) return -1;
80205040 1750) return -1;
80205040 1761) return -1;
80205040 1768) return -1;
80205040 1772) return -1;

Paolo Bonzini	e8ef1e8d am: convert "resume" variable to a struct
builtin/am.c
e8ef1e8d 2345) resume.mode = RESUME_APPLY;

René Scharfe	7655b411 remote-curl: show progress for fetches over dumb HTTP
walker.c
7655b411 193) stop_progress(&progress);



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Benno Evers	30b1c7ad describe: don't abort too early when searching tags
builtin/describe.c
30b1c7ad 394) fprintf(stderr, _("finished search at %s\n"),
30b1c7ad 395) oid_to_hex(&c->object.oid));

Elijah Newren	10cdb9f3 rebase: rename the two primary rebase backends
builtin/rebase.c
10cdb9f3 1664) if (is_merge(&options))

Elijah Newren	8a997ed1 rebase, sequencer: remove the broken GIT_QUIET handling
builtin/rebase.c
8a997ed1 695) write_file(state_dir_path("quiet", opts), "%s", "");

Elijah Newren	e98c4269 rebase (interactive-backend): fix handling of commits that become empty
sequencer.c
e98c4269 2523) opts->keep_redundant_commits = 1;

Elijah Newren	d48e5e21 rebase (interactive-backend): make --keep-empty the default
sequencer.c
d48e5e21 1529) return originally_empty;

Hariom Verma	4ef34648 receive.denyCurrentBranch: respect all worktrees
builtin/receive-pack.c
4ef34648 998) else if (git_work_tree_cfg)
4ef34648 999) work_tree = git_work_tree_cfg;
4ef34648 1001) work_tree = "..";
4ef34648 1008) git_dir = get_git_dir();

Jeff King	2fecc48c packfile: drop nth_packed_object_sha1()
packfile.c
2fecc48c 1878) return -1;

Jeff King	b99b6bcc packed_object_info(): use object_id for returning delta base
sha1-file.c
b99b6bcc 1478) oidclr(oi->delta_base_oid);

Jeff King	4f3bd560 pack-bitmap: implement BLOB_NONE filtering
pack-bitmap.c
4f3bd560 732) continue;

Jeff King	4eb707eb rev-list: allow commit-only bitmap traversals
pack-bitmap.c
4eb707eb 626)     (obj->type == OBJ_TAG && !revs->tag_objects))
4eb707eb 627) continue;

Jeff King	6ac9760a packed_object_info(): use object_id internally for delta base
packfile.c
6ac9760a 1245) return -1;
6ac9760a 1249) return -1;
6ac9760a 1253) return -1;

Jeff King	608d9c93 rev-list: allow bitmaps when counting objects
builtin/rev-list.c
608d9c93 410) return -1;

Jeff King	792f8119 rev-list: factor out bitmap-optimized routines
builtin/rev-list.c
792f8119 401) return -1;
792f8119 444) return -1;

Jeff King	3f83fd5e pack-objects: read delta base oid into object_id struct
builtin/pack-objects.c
3f83fd5e 1647) if (!in_same_island(&delta->idx.oid, base_oid))

Junio C Hamano	e8e71848 Merge branch 'jk/nth-packed-object-id'
pack-bitmap.c
e8e71848 799) nth_packed_object_id(&oid, pack, entry->nr);

Junio C Hamano	0106b1d4 Revert "gpg-interface: prefer check_signature() for GPG verification"
builtin/fmt-merge-msg.c
0106b1d4 506) if (!sig.len)
0106b1d4 507) strbuf_addstr(&sig, "gpg verification failed.\n");

gpg-interface.c
0106b1d4 434) return error_errno(_("could not create temporary file"));
0106b1d4 437) error_errno(_("failed writing detached signature to '%s'"),
0106b1d4 439) delete_tempfile(&temp);
0106b1d4 440) return -1;

log-tree.c
0106b1d4 462) strbuf_addstr(&gpg_output, "No signature\n");
0106b1d4 534) else if (verify_message.len <= gpg_message_offset)

Pranit Bauva	6c69f222 bisect: libify `bisect_next_all`
bisect.c
6c69f222 1024) return BISECT_FAILED;

Pranit Bauva	45b63708 bisect: libify `check_good_are_ancestors_of_bad` and its dependents
bisect.c
45b63708 920) warning_errno(_("could not create file '%s'"),

René Scharfe	2ce6d075 use strpbrk(3) to search for characters from a given set
builtin/show-branch.c
2ce6d075 539) if (strpbrk(av, "*?[")) {

Tanushree Tumane	bfacfce7 bisect--helper: introduce new `decide_next()` function
builtin/bisect--helper.c
bfacfce7 320) return -1;
bfacfce7 321) return 0;

Tanushree Tumane	292731c4 bisect--helper: change `retval` to `res`
builtin/bisect--helper.c
292731c4 227) res = -1;
292731c4 233) res = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
292731c4 410) res = -1;
292731c4 416) res = -1;
292731c4 582) res = -1;
292731c4 594) res = -1;
292731c4 606) res = -1;



