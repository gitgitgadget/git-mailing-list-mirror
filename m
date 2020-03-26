Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B71C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 02:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BAD20719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 02:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdvN4/Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCZCRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:17:10 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43764 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgCZCRK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 22:17:10 -0400
Received: by mail-ot1-f46.google.com with SMTP id a6so4285869otb.10
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 19:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6i0CweXhm2PkIrVdMLUkQa+U8bXDT9fcIA78+vZzpoU=;
        b=TdvN4/ImN9e8KCJBleGIZVEzHARZoLyFqXYq42qtMjj7SQFDwDrqY4ebTsn6WRZQ/3
         smA7VJaE9Oru7PaMBx+nQyGcpFyfRS1xolXc1Cp4PNbPCvtMFHusungYarRZE6icMSb4
         7nvoI+yFeOjeX9+2MJlblTqi9C8YOALYQ2VNYH566d0xFeWKwq78zn/ZhfSBhz65nPgg
         BLM5pJLTcrvyDqRhpEBwSPHz3VDmz8vCBJGajuydABBRsQqcru9oKIK2cmo0Y/Eo4reC
         wbOfitTkvBMnqGBJCdBgrsj5xuYTj+KYSB+DdFmqSZWWyskZmhoVXeF2IRYceUvAOCGr
         84XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6i0CweXhm2PkIrVdMLUkQa+U8bXDT9fcIA78+vZzpoU=;
        b=EUrxCYQGu1LW2t0QNAH+c2+IQYqioMrk4Ig+P9WgXGTVS6CbGtdV8v5Xeu5hQ5gyS3
         uxw2VnSUQFSbNbNLOSx8OROrUEKs0f9IphCITiwfqVeY/AIbZs/hfeULvFIZDUevzlss
         gsg7klYfRfgTWl4YHPMUG7xHyulYMh0NtOFLWKFdHa8gWKv8yLTXUbgfTAAb5gk9exwS
         cH6vRhwiJQu+W/cDBlc3geYXJLtxkbKCl6JVBSR/FCxd5JfGhDQN+oiKwg8YyS/pE8pu
         W+5UWop9pEuucxeS1pLlV3doeLsqmD4mWS8AE0z1aGs0XWAd37Yx5ePaH/t+TzvdG1pU
         xjTg==
X-Gm-Message-State: ANhLgQ3cpXsjn4oCDNsmx6J87Mgv3zJHUCvft3hOGInz2F4zARVk+E8f
        FIJPf7IFq/V/hFRuXX/6N+nUN+rbgnY=
X-Google-Smtp-Source: ADFU+vsoQxpbtZLobLLjsHgkl+rJ1k85R10MOxo32x2+jL6gxwIwGvlNNDzY7AOKScy/PFLygAzfgg==
X-Received: by 2002:a05:6820:319:: with SMTP id l25mr3615873ooe.88.1585189028644;
        Wed, 25 Mar 2020 19:17:08 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l20sm273219oih.40.2020.03.25.19.17.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 19:17:08 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (March 25)
Message-ID: <beeb6aef-b633-7973-0c65-fe978efa00cc@gmail.com>
Date:   Wed, 25 Mar 2020 22:17:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
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

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-03-25.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-03-25.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-03-25-commits.txt

---

pu	73bef04fc484a62076e2cc30ade25097f7671b18
jch	86b61e1ca2ac29d9ee652958835e6e40a677f5b7
next	33ef6b2f381b0c2d6c1eba5609779d5de2162ad9
master	a7d14a44285d3ec4b25bf9e3b7df701221350661
master@{1}	076cbdcd739aeb33c1be87b73aebae5e43d7bcc5


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Denton Liu	92470920 rebase: use read_oneliner()
builtin/rebase.c
92470920 623) } else if (!read_oneliner(&buf, state_dir_path("head", opts),

Denton Liu	796ff68d rebase: generify reset_head()
builtin/rebase.c
796ff68d 878) reset_head(the_repository, &opts->orig_head, "checkout",
796ff68d 879)    opts->head_name, 0,

Denton Liu	dcf14833 rebase: use apply_autostash() from sequencer.c
builtin/rebase.c
dcf14833 1038) apply_autostash(state_dir_path("autostash", opts));

Denton Liu	54ab5233 sequencer: make apply_rebase() accept a path
sequencer.c
54ab5233 5165) apply_autostash(rebase_path_autostash());

Denton Liu	e743716a sequencer: use file strbuf for read_oneliner()
sequencer.c
e743716a 434) goto done;
e743716a 440) goto done;

Denton Liu	7cd76158 reset: extract reset_head() from rebase
reset.c
7cd76158 37) ret = -1;
7cd76158 38) goto leave_reset_head;
7cd76158 43) goto leave_reset_head;
7cd76158 66) goto leave_reset_head;
7cd76158 72) goto leave_reset_head;
7cd76158 77) goto leave_reset_head;
7cd76158 81) ret = -1;
7cd76158 82) goto leave_reset_head;
7cd76158 90) goto leave_reset_head;
7cd76158 109) } else if (old_orig)
7cd76158 110) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);

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

Denton Liu	9460fd48 Lib-ify prune-packed
prune-packed.c
9460fd48 26) printf("rm -f %s\n", path);
9460fd48 35) progress = start_delayed_progress(_("Removing duplicate objects"), 256);

Derrick Stolee	92667ee9 commit-graph: examine commits by generation number
commit-graph.c
92667ee9 89) else if (a->date > b->date)
92667ee9 90) return 1;
92667ee9 91) return 0;
92667ee9 1296) QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);

Derrick Stolee	3d2f906e diff: halt tree-diff early after max_changes
tree-diff.c
3d2f906e 438) break;

Emily Shaffer	f0b79bb2 bugreport: add uname info
bugreport.c
f0b79bb2 20) strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
f0b79bb2 22)     errno);

Emily Shaffer	dd763e68 help: move list_config_help to builtin/help
builtin/help.c
dd763e68 123) puts(var);
dd763e68 124) continue;

Emily Shaffer	765e8219 bugreport: gather git version and build info
help.c
765e8219 641) strbuf_addstr(buf, "no commit associated with this build\n");

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

Jeff King	dc9f0216 commit-graph: examine changed-path objects in pack order
commit-graph.c
dc9f0216 62) return; /* should never happen, but be lenient */
dc9f0216 67) static int commit_pos_cmp(const void *va, const void *vb)
dc9f0216 69) const struct commit *a = *(const struct commit **)va;
dc9f0216 70) const struct commit *b = *(const struct commit **)vb;
dc9f0216 71) return commit_pos_at(&commit_pos, a) -
dc9f0216 72)        commit_pos_at(&commit_pos, b);

Junio C Hamano	73bef04f Merge branch 'dl/libify-a-few' into pu
fmt-merge-msg.c
73bef04f 498) strbuf_addstr(&sig, "gpg verification failed.\n");



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Elijah Newren	5adb05c2 sparse-checkout: provide a new reapply subcommand
builtin/sparse-checkout.c
5adb05c2 557) static int sparse_checkout_reapply(int argc, const char **argv)
5adb05c2 559) repo_read_index(the_repository);
5adb05c2 560) return update_working_directory(NULL);
5adb05c2 613) return sparse_checkout_reapply(argc, argv);

Elijah Newren	479c5eed unpack-trees: add a new update_sparsity() function
unpack-trees.c
479c5eed 1848) ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;

Josh Steadmon	3d3adaad trace2: teach Git to log environment variables
trace2/tr2_cfg.c
3d3adaad 63) return tr2_cfg_env_vars_count;



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
brian m. carlson	13e7ed6a builtin/checkout: compute checkout metadata for checkouts
builtin/checkout.c
13e7ed6a 625)        is_null_oid(&info->oid) ? &tree->object.oid :

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

brian m. carlson	ab90ecae convert: permit passing additional metadata to filter processes
convert.c
ab90ecae 862) goto done;
ab90ecae 868) goto done;
ab90ecae 874) goto done;

brian m. carlson	ddddf8d7 fast-import: permit reading multiple marks files
fast-import.c
ddddf8d7 1149) insert_mark(marks, mark, e);

brian m. carlson	1bdca816 fast-import: add options for rewriting submodules
fast-import.c
1bdca816 2183) return -1;
1bdca816 3058) return;
1bdca816 3316) die_errno("cannot read '%s'", f);

brian m. carlson	768e30ea hash: implement and use a context cloning function
sha1-file.c
768e30ea 98) static void git_hash_sha256_clone(git_hash_ctx *dst, const git_hash_ctx *src)
768e30ea 100) git_SHA256_Clone(&dst->sha256, &src->sha256);
768e30ea 101) }
768e30ea 118) static void git_hash_unknown_clone(git_hash_ctx *dst, const git_hash_ctx *src)

brian m. carlson	e02a7141 worktree: allow repository version 1
worktree.c
e02a7141 476) strbuf_release(&err);

Hans Jerry Illikainen	67948981 gpg-interface: prefer check_signature() for GPG verification
builtin/fmt-merge-msg.c
67948981 508) strbuf_addstr(&sig, "gpg verification failed.\n");

gpg-interface.c
67948981 275) error_errno(_("failed writing detached signature to '%s'"),
67948981 277) delete_tempfile(&temp);
67948981 278) return -1;
67948981 293) gpg_status = &buf;

log-tree.c
67948981 461) show_sig_lines(opt, status, "No signature\n");

Taylor Blau	a599e2c9 builtin/commit-graph.c: introduce '--input=<source>'
builtin/commit-graph.c
a599e2c9 74) *to = 0;
a599e2c9 75) return 0;
a599e2c9 84) else if (!strcmp(arg, "append"))
a599e2c9 85) *to |= COMMIT_GRAPH_INPUT_APPEND;

Taylor Blau	5d5916fd builtin/commit-graph.c: support '--split[=<strategy>]'
commit-graph.c
5d5916fd 1556) break;



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Alexandr Miloslavskiy	3d7747e3 real_path: remove unsafe API
editor.c
3d7747e3 87) strbuf_release(&realpath);

setup.c
3d7747e3 78) strbuf_release(&realpath);

Alexandr Miloslavskiy	49d3c4b4 get_superproject_working_tree(): return strbuf
submodule.c
49d3c4b4 2188) return 0;
49d3c4b4 2191) return 0;
49d3c4b4 2245) return 0;

Elijah Newren	80205040 merge-recursive: apply collision handling unification to recursive case
merge-recursive.c
80205040 1739) return -1;
80205040 1746) return -1;
80205040 1750) return -1;
80205040 1761) return -1;
80205040 1768) return -1;
80205040 1772) return -1;

Emily Shaffer	5c203986 prefix_path: show gitdir if worktree unavailable
setup.c
5c203986 132) hint_path = get_git_dir();

Heba Waly	b3b18d16 advice: revamp advise API
advice.c
b3b18d16 178) return advice_setting[ADVICE_PUSH_UPDATE_REJECTED].enabled &&
b3b18d16 179)        advice_setting[ADVICE_PUSH_UPDATE_REJECTED_ALIAS].enabled;

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

Paolo Bonzini	e8ef1e8d am: convert "resume" variable to a struct
builtin/am.c
e8ef1e8d 2345) resume.mode = RESUME_APPLY;

Phillip Wood	430b75f7 commit: give correct advice for empty commit during a rebase
sequencer.c
430b75f7 1476)     return -1;

René Scharfe	7655b411 remote-curl: show progress for fetches over dumb HTTP
walker.c
7655b411 193) stop_progress(&progress);


