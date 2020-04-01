Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCABC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 01:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6986B20CC7
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 01:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4mZkC9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbgDAB6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:58:22 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:33136 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbgDAB6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 21:58:22 -0400
Received: by mail-qk1-f169.google.com with SMTP id v7so25554332qkc.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 18:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Yyswuwcxz+PSV0D+lqTz9t3vOqieDxeGswVTlXbGeAM=;
        b=G4mZkC9qB975ePhQfmUCugxaQEKlzIzBJeiNXK8XxZpNPrXDSx2+iRr+ZekxKX87/G
         HrLl5oQKv+idnMlPxE84HNXls/qB14h4ygtnlHBrXk/a7Of35pUelHUUfuyyVr1FzH1E
         vzeo8Z6hf62geQ/MzGdRuAB5teOun42Pa58Rrtlf3PPOEgmGsWUeQHl7dkNp78zzUou7
         b5i0pMyVQv2yE0l03gQd3OVOJRR0T5db5RRM51lbL+WsXaNs42roZY7v0PdsfSloXLxO
         EtDbChJTMpseqfCp6amIH30TPqNkj0AwjZwi0PMK1KNt8OiLIjbsb3l++9FAuoNCEws5
         UPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Yyswuwcxz+PSV0D+lqTz9t3vOqieDxeGswVTlXbGeAM=;
        b=Ecqo7rnX+ky4z9qLYplhPY0y5FshHsZLa1d1YTePIbbFdwdXD5T15ocqs24hx5/c0U
         hLjFvKfMWwaWJaKWTG51kmxMklpsvXAIDeLb8/b1AnAyMEoMdQpAmng+ewS5lCxbVFMo
         V8i3wILoy+bYcgRxdvNrn1bDor6LU3TOF384+LQVk/fxgq5EFY5PpqVQW/h9cMX+C6oD
         jJfXSr8UmmSO1jG7mRPOZrkv9/BWKtGdsYdB9U/xr6+RElrUYjAT2UX2CBb2h1DdqkOP
         VIICJpPoJseqlzHwf4ejqAf9b58hvUQYDmm1kuw/UNRs2MWKq1C2BzjhPbhoOAfVupCk
         ekrQ==
X-Gm-Message-State: ANhLgQ1sCkp8K3P/0joXtTS/XO0xC++bcVtn0r/6kOPf3z1u3iYVvZTI
        VEQvQcOff7qgpamQtq8V93/Or8G58qc=
X-Google-Smtp-Source: ADFU+vst0BlJ2lGa6VCEZBkAOcDoJcwunYA4EitrjrYRxKlipARhDJv884g+e98vY4JodaDJvmNW2A==
X-Received: by 2002:a05:620a:111a:: with SMTP id o26mr7892429qkk.328.1585706299425;
        Tue, 31 Mar 2020 18:58:19 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f127sm539722qkd.74.2020.03.31.18.58.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 18:58:18 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (March 31, 2020)
Message-ID: <e7e15fd8-01fa-61df-830d-04e4882adc38@gmail.com>
Date:   Tue, 31 Mar 2020 21:58:17 -0400
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

Here is today's test coverage report. Stay safe, everyone!

-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-03-31-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-03-31.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-03-31.htm

---

pu	ad1641bbcd3c56bafe85ff7e56606b8aa0169211
jch	a85ddbbb106edaaaeca34295a86aebd422479ed2
next	2183baf09cb5d1e1dd473e6d197893cd5e1c99ca
master	9fadedd637b312089337d73c3ed8447e9f0aa775
master@{1}	a7d14a44285d3ec4b25bf9e3b7df701221350661


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
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

Denton Liu	e743716a sequencer: use file strbuf for read_oneliner()
sequencer.c
e743716a 434) goto done;
e743716a 440) goto done;

Denton Liu	dcf14833 rebase: use apply_autostash() from sequencer.c
builtin/rebase.c
dcf14833 1038) apply_autostash(state_dir_path("autostash", opts));

Denton Liu	54ab5233 sequencer: make apply_rebase() accept a path
sequencer.c
54ab5233 5168) apply_autostash(rebase_path_autostash());

Denton Liu	92470920 rebase: use read_oneliner()
builtin/rebase.c
92470920 623) } else if (!read_oneliner(&buf, state_dir_path("head", opts),

Denton Liu	796ff68d rebase: generify reset_head()
builtin/rebase.c
796ff68d 878) reset_head(the_repository, &opts->orig_head, "checkout",
796ff68d 879)    opts->head_name, 0,

Derrick Stolee	e3696980 diff: halt tree-diff early after max_changes
tree-diff.c
e3696980 438) break;

Elijah Newren	bb8f652e dir: replace exponential algorithm with a linear one
dir.c
bb8f652e 1863) state = excluded ? path_excluded : path_untracked;

Emily Shaffer	dd763e68 help: move list_config_help to builtin/help
builtin/help.c
dd763e68 123) puts(var);
dd763e68 124) continue;

Emily Shaffer	f0b79bb2 bugreport: add uname info
bugreport.c
f0b79bb2 20) strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
f0b79bb2 22)     errno);

Emily Shaffer	765e8219 bugreport: gather git version and build info
help.c
765e8219 641) strbuf_addstr(buf, "no commit associated with this build\n");

Garima Singh	749d958c revision.c: add trace2 stats around Bloom filter usage
revision.c
749d958c 717) count_bloom_filter_length_zero++;

Garima Singh	f1294eaf bloom.c: introduce core Bloom filter constructs
t/helper/test-bloom.c
f1294eaf 25) printf("No filter.\n");
f1294eaf 26) return;

Garima Singh	52480757 commit-graph: write Bloom filters to commit graph file
commit-graph.c
52480757 328) chunk_repeated = 1;
52480757 335) chunk_repeated = 1;
52480757 342) break;
52480757 1085) progress = start_delayed_progress(
52480757 1087) ctx->commits.nr);
52480757 1110) progress = start_delayed_progress(
52480757 1112) ctx->commits.nr);

Garima Singh	3d112755 commit-graph: examine commits by generation number
commit-graph.c
3d112755 88) return -1;
3d112755 91) return 0;
3d112755 1294) QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);

Garima Singh	fa63c5b3 revision.c: use Bloom filters to speed up path based revision walks
bloom.c
fa63c5b3 266) return -1;

revision.c
fa63c5b3 704) return -1;
fa63c5b3 707) return -1;
fa63c5b3 718) return -1;

Garima Singh	f97b9325 commit-graph: compute Bloom filters for changed paths
commit-graph.c
f97b9325 1286) progress = start_delayed_progress(
f97b9325 1288) ctx->commits.nr);

Garima Singh	ed591feb bloom.c: core Bloom filter implementation for changed paths.
bloom.c
ed591feb 172) return NULL;
ed591feb 246) for (i = 0; i < diff_queued_diff.nr; i++)
ed591feb 247) diff_free_filepair(diff_queued_diff.queue[i]);
ed591feb 248) filter->data = NULL;
ed591feb 249) filter->len = 0;

Jeff King	d21ee7d1 commit-graph: examine changed-path objects in pack order
commit-graph.c
d21ee7d1 62) return; /* should never happen, but be lenient */
d21ee7d1 67) static int commit_pos_cmp(const void *va, const void *vb)
d21ee7d1 69) const struct commit *a = *(const struct commit **)va;
d21ee7d1 70) const struct commit *b = *(const struct commit **)vb;
d21ee7d1 71) return commit_pos_at(&commit_pos, a) -
d21ee7d1 72)        commit_pos_at(&commit_pos, b);

Jiang Xin	c7ea37de receive-pack: add new proc-receive hook
builtin/receive-pack.c
c7ea37de 960) return code;
c7ea37de 963) proc.err = 0;
c7ea37de 968) if (use_sideband)
c7ea37de 969) finish_async(&muxer);
c7ea37de 970) return code;

t/helper/test-proc-receive.c
c7ea37de 127) usage_msg_opt("Too many arguments.", proc_receive_usage, options);

Jiang Xin	9f699cce receive-pack: new config receive.procReceiveRefs
builtin/receive-pack.c
9f699cce 237) return config_error_nonbool(var);
9f699cce 1743) continue;

Jiang Xin	43feef4a receive-pack: refactor report for proc-receive
transport-helper.c
43feef4a 756) status = REF_STATUS_UPTODATE;
43feef4a 757) FREE_AND_NULL(msg);
43feef4a 764) status = REF_STATUS_REJECT_ALREADY_EXISTS;
43feef4a 765) FREE_AND_NULL(msg);
43feef4a 768) status = REF_STATUS_REJECT_FETCH_FIRST;
43feef4a 769) FREE_AND_NULL(msg);
43feef4a 772) status = REF_STATUS_REJECT_NEEDS_FORCE;
43feef4a 773) FREE_AND_NULL(msg);
43feef4a 776) status = REF_STATUS_REJECT_STALE;
43feef4a 777) FREE_AND_NULL(msg);
43feef4a 780) forced = 1;

transport.c
43feef4a 473) fprintf(stdout, "%c\t:%s\t", flag, target_refname);
43feef4a 556) print_ref_status('X', "[no match]", NULL, ref, NULL, NULL,
43feef4a 560) print_ref_status('!', "[rejected]", NULL, ref, NULL,
43feef4a 565) print_ref_status('=', "[up to date]", NULL, ref,
43feef4a 581) print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
43feef4a 589) print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
43feef4a 599) print_ref_status('!', "[remote failure]", NULL, ref,

Junio C Hamano	e261ddc5 Merge branch 'dl/libify-a-few' into pu
fmt-merge-msg.c
e261ddc5 498) strbuf_addstr(&sig, "gpg verification failed.\n");

Patrick Steinhardt	edc30691 refs: fix segfault when aborting empty transaction
refs/files-backend.c
edc30691 2572) strbuf_release(&err);

Patrick Steinhardt	1f2a79ad update-ref: organize commands in an array
builtin/update-ref.c
1f2a79ad 438) continue;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason	5cc044e0 get_short_oid: sort ambiguous objects by type, then SHA-1
oid-array.c
5cc044e0 56) return ret;

brian m. carlson	910650d2 Rename sha1_array to oid_array
t/helper/test-oid-array.c
910650d2 29) oid_array_clear(&array);

Damien Robert	a761fb70 remote.c: fix handling of %(push:remoteref)
remote.c
a761fb70 1649) return NULL;
a761fb70 1656) return branch->refname;
a761fb70 1671) return NULL;
a761fb70 1785) return NULL;

Denton Liu	7cd54d37 wrapper: indent with tabs
wrapper.c
7cd54d37 221) len = MAX_IO_SIZE;
7cd54d37 243) len = MAX_IO_SIZE;

Elijah Newren	7af7a258 unpack-trees: add a new update_sparsity() function
unpack-trees.c
7af7a258 1847) ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;

Jeff King	16ddcd40 sha1_array: let callbacks interrupt iteration
oid-array.c
16ddcd40 76) return ret;

Josh Steadmon	3d3adaad trace2: teach Git to log environment variables
trace2/tr2_cfg.c
3d3adaad 63) return tr2_cfg_env_vars_count;



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
Taylor Blau	a599e2c9 builtin/commit-graph.c: introduce '--input=<source>'
builtin/commit-graph.c
a599e2c9 75) *to = 0;
a599e2c9 76) return 0;
a599e2c9 86) *to |= COMMIT_GRAPH_INPUT_APPEND;

Taylor Blau	5d5916fd builtin/commit-graph.c: support '--split[=<strategy>]'
commit-graph.c
5d5916fd 1557) break;



Uncovered code in 'master' not in 'master@{1}'
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


