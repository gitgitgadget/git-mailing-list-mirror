Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719BBC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 12:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3040F2173E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 12:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJO4ZaLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBRMqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:46:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40104 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgBRMqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 07:46:07 -0500
Received: by mail-qk1-f195.google.com with SMTP id b7so19290837qkl.7
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 04:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=uSMaSdzTpnHGSjANHjTGzfRVyrcavM3H8SXbenI/LKQ=;
        b=bJO4ZaLrrFSGZsJ0tgGv2cWjL4u+smmMbyy9ZT+UiXBSxqyPJKV4w1epXHFg4KfM6r
         ipDT6ropSRVujNVvTX2RrhNWxd74mzlRxtj3Wv0FzzvXEX3o3Othnc693rjyqyFYMe0Z
         A8BSvEC1RErLR7lJ3O8K9rLi4jTQxDE/8lDHc/heJGEChhQr48tntulqGL+WctS5qLgt
         AMRRyhhJ1H34/n0Ny3M9kAvf+bC5x8oJRbdT7PEBXWtamAnNInEVn4f5CZS8Twju2VwM
         UnErqN8OCZRt1ff8LQS0Akx1A7mNrfvhQ4+PCw+mrgrqVFnacVSnWYJDI4jW4suJNsXR
         pdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uSMaSdzTpnHGSjANHjTGzfRVyrcavM3H8SXbenI/LKQ=;
        b=f77kzhPFfp4Q2cesWNz7q7YdwECNp4IC8gOwspGuUi03H098cKggQ/aWKgwhWVkC0N
         N/Hg4FVGVwe8UaDULookDSMl5oMu+h2tgHdjVa3vblYCSPXuGSD/SwXGlwqQxlLcfJF6
         e++jEOMMYtczjmbEuOS7ehno6NSMcOWcpU/nOrF6IfW8xFcTA/cOA8LB83mqoY/xlMaJ
         Zvv28KjRlupd2n+C+anb8U6+HA3GjnEungUhag1LYXHsWfpAD4VILLVwFzw6wijOqnA9
         J4Ngb9V4im+wQYhyaiK0yB2aqvA4q/yUWxV9zJVez2hSMDdsZ9CUAsN5DkIcgAx/5Xam
         4M3w==
X-Gm-Message-State: APjAAAWU/nPP4blq0w38gQaOTSUNnx6R5uWR4z6J3AObyl5tzZklMEtn
        wWLWWLSfJLjn2T42f4AZUlaujDmawkY=
X-Google-Smtp-Source: APXvYqy4ZtF3SnpNYRONHntUvWbv8QN5UUhuc8lHga4bBoK0DOoZMSMb+IQpQDn9m+PsDndMDjgW0w==
X-Received: by 2002:a05:620a:4cc:: with SMTP id 12mr18099132qks.153.1582029965720;
        Tue, 18 Feb 2020 04:46:05 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:1879:5acd:5f30:6da2? ([2001:4898:a800:1012:c9ac:5acd:5f30:6da2])
        by smtp.gmail.com with ESMTPSA id x19sm1734765qtm.47.2020.02.18.04.46.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 04:46:04 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Feb. 18, 2020)
Message-ID: <2c97befe-9be8-9946-b643-91656fa3dcd8@gmail.com>
Date:   Tue, 18 Feb 2020 07:46:03 -0500
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

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-02-18.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-02-18.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-02-18-commits.txt

---

pu	0597994ff847422e35ac5b51151a6efd4d47429c
jch	94d54fbb911ec1d6ebb4ee0e0000ac8c7c139fce
next	3043dbfab8cba19275c80425d1436651d4be4a4a
master	51ebf55b9309824346a6589c9f3b130c6f371b8f
master@{1}	de93cc14ab7e8db7645d8dbe4fd2603f76d5851f


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Denton Liu	448bea61 sequencer: make apply_rebase() accept a path
sequencer.c
448bea61 5143) apply_autostash(rebase_path_autostash());

Denton Liu	fa717471 sequencer: use file strbuf for read_oneliner()
sequencer.c
fa717471 438) goto done;
fa717471 444) goto done;

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

Denton Liu	e71223c6 rebase: use apply_autostash() from sequencer.c
builtin/rebase.c
e71223c6 1028) apply_autostash(state_dir_path("autostash", opts));

Denton Liu	06ebea5c rebase: generify reset_head()
builtin/rebase.c
06ebea5c 868) reset_head(the_repository, &opts->orig_head, "checkout",
06ebea5c 869)    opts->head_name, 0,

Denton Liu	186dbeed rebase: use read_oneliner()
builtin/rebase.c
186dbeed 618) } else if (!read_oneliner(&buf, state_dir_path("head", opts), 0, 1))

Derrick Stolee	3d2f906e diff: halt tree-diff early after max_changes
tree-diff.c
3d2f906e 438) break;

Derrick Stolee	92667ee9 commit-graph: examine commits by generation number
commit-graph.c
92667ee9 89) else if (a->date > b->date)
92667ee9 90) return 1;
92667ee9 91) return 0;
92667ee9 1296) QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);

Emily Shaffer	5c29e1d9 bugreport: gather git version and build info
help.c
5c29e1d9 641) strbuf_addstr(buf, "no commit associated with this build\n");

Emily Shaffer	cdf7f95b bugreport: add tool to generate debugging info
bugreport.c
cdf7f95b 406) strbuf_release(&report_path);

Emily Shaffer	6bf7dba7 help: move list_config_help to builtin/help
builtin/help.c
6bf7dba7 123) puts(var);
6bf7dba7 124) continue;

Emily Shaffer	262042dc bugreport: add git-remote-https version
bugreport.c
262042dc 23)     strbuf_addstr(version_info, "'git-remote-https --build-info' not supported\n");

Emily Shaffer	211dfeff bugreport: add uname info
bugreport.c
211dfeff 39) strbuf_addf(sys_info, "uname() failed with code %d\n", errno);

Emily Shaffer	c86be76b bugreport: add config values from safelist
bugreport.c
c86be76b 73) strbuf_addf(config_info, "%s:\n", bugreport_config_safelist[idx]);
c86be76b 74) for_each_string_list_item(it, list) {
c86be76b 75) kv_info = it->util;
c86be76b 76) strbuf_addf(config_info, "  %s (%s)\n", it->string,
c86be76b 77)     kv_info ? config_scope_name(kv_info->scope)

Emily Shaffer	c61e416d bugreport: list contents of $OBJDIR/info
bugreport.c
c61e416d 216) return;
c61e416d 225) strbuf_addbuf(contents, dirpath);
c61e416d 226) strbuf_addstr(contents, d->d_name);
c61e416d 227) strbuf_complete_line(contents);
c61e416d 229) if (d->d_type == DT_DIR) {
c61e416d 230) strbuf_addstr(dirpath, d->d_name);
c61e416d 231) list_contents_of_dir_recursively(contents, dirpath);
c61e416d 233) strbuf_setlen(dirpath, path_len);

Emily Shaffer	e5daadc0 bugreport: add packed object summary
bugreport.c
e5daadc0 193) pack_count++;
e5daadc0 198) open_pack_index(pack);
e5daadc0 199) object_count += pack->num_objects;

Emily Shaffer	82e7f0b6 bugreport: count loose objects
bugreport.c
82e7f0b6 132) static int loose_object_cb(const struct object_id *oid, const char *path,
82e7f0b6 134) int *loose_object_count = data;
82e7f0b6 136) if (loose_object_count) {
82e7f0b6 137) (*loose_object_count)++;
82e7f0b6 138) return 0;
82e7f0b6 141) return 1;

Emily Shaffer	0ae9bf16 bugreport: collect list of populated hooks
bugreport.c
0ae9bf16 126) strbuf_addstr(hook_info, iter->string);
0ae9bf16 127) strbuf_complete_line(hook_info);

Emily Shaffer	5538f178 bugreport: summarize contents of alternates file
bugreport.c
5538f178 282) while (strbuf_getline(&alternate, file) != EOF) {
5538f178 283) if (!access(alternate.buf, F_OK))
5538f178 284) exists++;
5538f178 286) broken++;
5538f178 289) strbuf_addf(alternates_info,
5538f178 295) fclose(file);
5538f178 296) strbuf_release(&alternate);
5538f178 297) strbuf_release(&alternates_path);

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

Garima Singh	6bdbf235 commit-graph: compute Bloom filters for changed paths
commit-graph.c
6bdbf235 1290) ctx->commits.nr);

Heba Waly	51b9d1b6 advice: refactor advise API
advice.c
51b9d1b6 170) int advice_push_update_rejected_enabled(void)
51b9d1b6 172) return advice_enabled(PUSH_UPDATE_REJECTED) ||
51b9d1b6 173)        advice_enabled(PUSH_UPDATE_REJECTED_ALIAS);

Jeff King	dc9f0216 commit-graph: examine changed-path objects in pack order
commit-graph.c
dc9f0216 62) return; /* should never happen, but be lenient */
dc9f0216 67) static int commit_pos_cmp(const void *va, const void *vb)
dc9f0216 69) const struct commit *a = *(const struct commit **)va;
dc9f0216 70) const struct commit *b = *(const struct commit **)vb;
dc9f0216 71) return commit_pos_at(&commit_pos, a) -
dc9f0216 72)        commit_pos_at(&commit_pos, b);

Phillip Wood	430b75f7 commit: give correct advice for empty commit during a rebase
sequencer.c
430b75f7 1474)     return -1;

Pranit Bauva	a287a32f run-command: make `exists_in_PATH()` non-static
run-command.c
a287a32f 213) int exists_in_PATH(const char *file)

Pranit Bauva	eb337930 bisect: libify `bisect_next_all`
bisect.c
eb337930 1024) return BISECT_FAILED;

Pranit Bauva	f9b21d38 bisect: libify `check_good_are_ancestors_of_bad` and its dependents
bisect.c
f9b21d38 920) warning_errno(_("could not create file '%s'"),

Tanushree Tumane	670e173f bisect--helper: introduce new `decide_next()` function
builtin/bisect--helper.c
670e173f 320) return -1;
670e173f 321) return 0;

Tanushree Tumane	14d137cf bisect--helper: change `retval` to `res`
builtin/bisect--helper.c
14d137cf 227) res = -1;
14d137cf 233) res = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
14d137cf 410) res = -1;
14d137cf 416) res = -1;
14d137cf 582) res = -1;
14d137cf 594) res = -1;
14d137cf 606) res = -1;

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
Elijah Newren	8a997ed1 rebase, sequencer: remove the broken GIT_QUIET handling
builtin/rebase.c
8a997ed1 695) write_file(state_dir_path("quiet", opts), "%s", "");

Elijah Newren	e98c4269 rebase (interactive-backend): fix handling of commits that become empty
sequencer.c
e98c4269 2523) opts->keep_redundant_commits = 1;

Elijah Newren	10cdb9f3 rebase: rename the two primary rebase backends
builtin/rebase.c
10cdb9f3 1664) if (is_merge(&options))

Elijah Newren	d48e5e21 rebase (interactive-backend): make --keep-empty the default
sequencer.c
d48e5e21 1529) return originally_empty;



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
Bert Wesarg	1a83068c remote: clean-up by returning early to avoid one indentation
builtin/remote.c
1a83068c 287) return 0;

Bert Wesarg	f2a2327a config: provide access to the current line number
config.c
f2a2327a 3346) return cf->linenr;

Bert Wesarg	88f8576e pull --rebase/remote rename: document and honor single-letter abbreviations rebase types
rebase.c
88f8576e 26) return REBASE_MERGES;

Jeff King	792f8119 rev-list: factor out bitmap-optimized routines
builtin/rev-list.c
792f8119 394) return -1;
792f8119 437) return -1;

Jeff King	608d9c93 rev-list: allow bitmaps when counting objects
builtin/rev-list.c
608d9c93 403) return -1;

Jeff King	4eb707eb rev-list: allow commit-only bitmap traversals
pack-bitmap.c
4eb707eb 626)     (obj->type == OBJ_TAG && !revs->tag_objects))
4eb707eb 627) continue;

Jeff King	4f3bd560 pack-bitmap: implement BLOB_NONE filtering
pack-bitmap.c
4f3bd560 732) continue;

Jeff King	84243da1 pack-bitmap: implement BLOB_LIMIT filtering
pack-bitmap.c
84243da1 799) nth_packed_object_oid(&oid, pack, entry->nr);



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Alban Gruin	5a5445d8 rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
sequencer.c
5a5445d8 4235) unlink(rebase_path_dropped());

Alban Gruin	1da5874c sequencer: move check_todo_list_from_file() to rebase-interactive.c
rebase-interactive.c
1da5874c 239) goto out;
1da5874c 244) goto out;
1da5874c 251) fprintf(stderr, _(edit_todo_list_advice));

Jeff King	92fb0db9 pack-objects: add checks for duplicate objects
builtin/pack-objects.c
92fb0db9 1133) return 1;
92fb0db9 2690) (reuse_packfile_bitmap &&
92fb0db9 2691)  bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));

Jeff King	e704fc79 pack-objects: introduce pack.allowPackReuse
builtin/pack-objects.c
e704fc79 2843) allow_pack_reuse = git_config_bool(k, v);
e704fc79 2844) return 0;

Jeff King	da806352 diff: move diff.wsErrorHighlight to "basic" config
diff.c
da806352 448) return -1;

Jeff King	bb514de3 pack-objects: improve partial packfile reuse
pack-bitmap.c
bb514de3 808) return;
bb514de3 811) return;
bb514de3 823) return;
bb514de3 861) i = bitmap_git->pack->num_objects / BITS_IN_EWORD;

Jonathan Tan	50033772 connected: verify promisor-ness of partial clone
connected.c
50033772 70) continue;

Kevin Willford	8da2c576 fsmonitor: handle version 2 of the hooks that will use opaque token
fsmonitor.c
8da2c576 36) if (hook_version == HOOK_INTERFACE_VERSION1 ||
8da2c576 37)     hook_version == HOOK_INTERFACE_VERSION2)
8da2c576 38) return hook_version;
8da2c576 199) strbuf_addf(&last_update_token, "%"PRIu64"", last_update);

Kevin Willford	56c69100 fsmonitor: change last update timestamp on the index_state to opaque token
fsmonitor.c
56c69100 62) timestamp = get_be64(index);
56c69100 63) strbuf_addf(&last_update, "%"PRIu64"", timestamp);
56c69100 64) index += sizeof(uint64_t);

Matheus Tavares	31877c9a object-store: allow threaded access to object reading
packfile.c
31877c9a 1472) return;

sha1-file.c
31877c9a 1431) return;
31877c9a 1440) return;

Matheus Tavares	c8123e72 streaming: allow open_istream() to handle any repo
streaming.c
c8123e72 154) if (open_istream_incore(st, r, &oi, real, type)) {

Matthew Rogers	9a83d088 submodule-config: add subomdule config scope
config.c
9a83d088 3315) return "submodule";

Matthew Rogers	6dc905d9 config: split repo scope to local and worktree
config.c
6dc905d9 3311) return "worktree";

Matthew Rogers	a5cb4204 config: make scope_name non-static and rename it
config.c
a5cb4204 3305) return "system";
a5cb4204 3317) return "unknown";

Matthew Rogers	e37efa40 config: teach git_config_source to remember its scope
builtin/config.c
e37efa40 670) given_config_source.scope = CONFIG_SCOPE_SYSTEM;

René Scharfe	2d539754 name-rev: release unused name strings
builtin/name-rev.c
2d539754 102) free(name->tip_name);

René Scharfe	a91cc7fa strbuf: add and use strbuf_insertstr()
notes.c
a91cc7fa 1337) strbuf_insertstr(sb, 0, "refs/");



