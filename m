Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95AC2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 14:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D54D2223D
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 14:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQbByOVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394826AbgDPOxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409277AbgDPN5M (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 09:57:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A1AC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 06:57:11 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q204so16590650oia.13
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=quxMtJL8EFM0gexMWfquxY15T2nGQCbGpGXpOEkcJ4k=;
        b=dQbByOVss3oi2KzGbpHIrs6cFwRb+rmlfuHUxG23Ti1CPK3lcIPKy/2D9uUnQmMuql
         MOspwQJ5YAeiTiEShya0LV3be7zyTwrznx9c2LEHDu4wubPxKuHyGJg2xw0eHOk10wfq
         uJ/XkOo7aGpr1fuAR17xvcEUkvS4lgffF+AQ7aYFUBeZAet7yBnYOpWDnXKMkZm/BLEC
         KgZx2d3I+2ar/gnyCyHzcHXCOzGSunkqRH85wzM5B/ZR5sb/tgucwPU5TeZQdCvGNvdX
         FNO0Lv49HIABzWHbdDwLvhOYPZOFEs0sPT803wQyh0LT45RWCWf2SBZtnlTn5bkIL8ty
         p9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=quxMtJL8EFM0gexMWfquxY15T2nGQCbGpGXpOEkcJ4k=;
        b=YWyGCeWOrQEZ/2HHgXcx/I7rZYajqvde65MQfYNvm5ms5n61nL8NwQst9FKdw5j98g
         mp2bPWW60bsU2yR85h4LxDL5BAE1CTD+qchUKO46dmJ56k2IqhCK4MhqcpOT6FJF0FuN
         h4GutdU5I4+57mWfNhRusUm4HKz9/z3wWsM+tn3Tp8PcPYqP/aC7hQuezFZWG0umZdNH
         63cg7KLH3zSKvidtcsTQsOySy1o8LB/BksD7S9UBn2MuGwe7MxFt7FdpSKosSRsPPYwl
         wFHuGxlc66Pyr5Iagb925KlSd9GkclK1gVAn8sr+lAuC+5o8CtY131oyRRxycfjPMCPR
         c1+w==
X-Gm-Message-State: AGi0PuaBO+RBn1wNmN7V+gg7gTXqqHffGjAWY9RZDTe2puqoUvYAzUeL
        FbQFx3cWF0M8Filp+NRnRqtJVvEaOVc=
X-Google-Smtp-Source: APiQypKZ61Lu4iy6W6YFHk4L7nveziq7DsFdWlvaM5X2B2spZZFIsZZoce2tz0zcUeDAB0T0xI9cwA==
X-Received: by 2002:a05:6808:90f:: with SMTP id w15mr3157229oih.0.1587045430519;
        Thu, 16 Apr 2020 06:57:10 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q18sm7039294otl.65.2020.04.16.06.57.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 06:57:09 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (April 16, 2020)
Message-ID: <c797df50-ec21-98a3-58c4-ade0c04284c9@gmail.com>
Date:   Thu, 16 Apr 2020 09:57:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
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

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-04-16-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-04-16.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-04-16.htm

---

pu	89b51f611e0e8e10d254fbbfd738adc6d1ea1764
jch	c58d47de3eb380e6178eb51a4dc97aa59ddd5ea8
next	55bc3eb7cb9c200ab95bbd2415bc0a35fbf29053
master	efe3874640e2e58209ddbb3b072f48f6b7094f34
master@{1}	9fadedd637b312089337d73c3ed8447e9f0aa775


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Denton Liu	be1bb600 sequencer: make apply_autostash() accept a path
sequencer.c
be1bb600 5302) apply_autostash(rebase_path_autostash());

Denton Liu	65c425a2 sequencer: stop leaking buf
sequencer.c
65c425a2 2643) goto done_rebase_i;

Denton Liu	5b2f6d9c sequencer: make file exists check more efficient
sequencer.c
5b2f6d9c 433) warning_errno(_("could not read '%s'"), path);

Denton Liu	efcf6cf0 rebase: use read_oneliner()
builtin/rebase.c
efcf6cf0 641) } else if (!read_oneliner(&buf, state_dir_path("head", opts),

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

Denton Liu	f213f069 rebase: generify reset_head()
builtin/rebase.c
f213f069 902) reset_head(the_repository, &opts->orig_head, "checkout",
f213f069 903)    opts->head_name, 0,

Denton Liu	86ed00af rebase: use apply_autostash() from sequencer.c
builtin/rebase.c
86ed00af 1063) apply_autostash(state_dir_path("autostash", opts));

Elijah Newren	16846444 dir: include DIR_KEEP_UNTRACKED_CONTENTS handling in treat_directory()
dir.c
16846444 1924) FREE_AND_NULL(dir->entries[i]);

Emily Shaffer	d14e00c1 bugreport: add uname info
bugreport.c
d14e00c1 20) strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
d14e00c1 22)     errno);

Emily Shaffer	dd763e68 help: move list_config_help to builtin/help
builtin/help.c
dd763e68 123) puts(var);
dd763e68 124) continue;

Emily Shaffer	efbace64 bugreport: gather git version and build info
help.c
efbace64 641) strbuf_addstr(buf, "no commit associated with this build\n");

Jiang Xin	bc3e2729 receive-pack: add new proc-receive hook
builtin/receive-pack.c
bc3e2729 1019) return code;
bc3e2729 1022) proc.err = 0;
bc3e2729 1027) if (use_sideband)
bc3e2729 1028) finish_async(&muxer);
bc3e2729 1029) return code;
bc3e2729 2243) packet_buf_write(&buf, "ng %s %s%c%s\n",
bc3e2729 2244)  cmd->ref_name, cmd->error_string,

t/helper/test-proc-receive.c
bc3e2729 127) usage_msg_opt("Too many arguments.", proc_receive_usage, options);
bc3e2729 167) *p = '\0';
bc3e2729 168) p += 2;
bc3e2729 169) packet_write_fmt(1, "%s%c%s\n", item->string, '\0', p);

Jiang Xin	d131afc3 send-pack: extension for client-side status report
remote.c
d131afc3 2385) return;

transport-helper.c
d131afc3 756) status = REF_STATUS_UPTODATE;
d131afc3 757) FREE_AND_NULL(msg);
d131afc3 764) status = REF_STATUS_REJECT_ALREADY_EXISTS;
d131afc3 765) FREE_AND_NULL(msg);
d131afc3 768) status = REF_STATUS_REJECT_FETCH_FIRST;
d131afc3 769) FREE_AND_NULL(msg);
d131afc3 772) status = REF_STATUS_REJECT_NEEDS_FORCE;
d131afc3 773) FREE_AND_NULL(msg);
d131afc3 776) status = REF_STATUS_REJECT_STALE;
d131afc3 777) FREE_AND_NULL(msg);
d131afc3 780) forced = 1;

transport.c
d131afc3 481) fprintf(stdout, "%c\t:%s\t", flag,

Jiang Xin	2c26d674 receive-pack: new config receive.procReceiveRefs
builtin/receive-pack.c
2c26d674 237) return config_error_nonbool(var);
2c26d674 1812) continue;

Karsten Blees	defd7c7b dir.c: git-status --ignored: don't scan the work tree three times
dir.c
defd7c7b 2177) return path_none;

Patrick Steinhardt	edc30691 refs: fix segfault when aborting empty transaction
refs/files-backend.c
edc30691 2572) strbuf_release(&err);

Patrick Steinhardt	a65b8ac2 update-ref: organize commands in an array
builtin/update-ref.c
a65b8ac2 419) continue;

Phillip Wood	cd5e0fd9 Revert "Revert "Merge branch 'ra/rebase-i-more-options'""
builtin/rebase.c
cd5e0fd9 834) argv_array_push(&am.args, "--ignore-whitespace");
cd5e0fd9 836) argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
cd5e0fd9 838) argv_array_push(&opts->git_am_opts, "--ignore-date");

sequencer.c
cd5e0fd9 877) return NULL;
cd5e0fd9 1394) goto out;
cd5e0fd9 1398) goto out;
cd5e0fd9 1474) res = -1;
cd5e0fd9 1475) goto out;

Taylor Blau	fdbde82f builtin/commit-graph.c: introduce split strategy 'no-merge'
commit-graph.c
fdbde82f 1777) break;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
brian m. carlson	edc6dccf builtin/receive-pack: use constant-time comparison for HMAC value
builtin/receive-pack.c
edc6dccf 566) retval = NONCE_BAD;
edc6dccf 567) goto leave;

Denton Liu	9460fd48 Lib-ify prune-packed
prune-packed.c
9460fd48 26) printf("rm -f %s\n", path);
9460fd48 35) progress = start_delayed_progress(_("Removing duplicate objects"), 256);

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

Derrick Stolee	efb0e3a0 blame: use changed-path Bloom filters
blame.c
efb0e3a0 1276) if (origin->commit->generation == GENERATION_NUMBER_INFINITY)
efb0e3a0 1277) return 1;
efb0e3a0 1279) filter = get_bloom_filter(r, origin->commit, 0);
efb0e3a0 1281) if (!filter)
efb0e3a0 1282) return 1;
efb0e3a0 1284) bloom_count_queries++;
efb0e3a0 1285) for (i = 0; i < bd->nr; i++) {
efb0e3a0 1286) if (bloom_filter_contains(filter,
efb0e3a0 1287)   bd->keys[i],
efb0e3a0 1288)   bd->settings))
efb0e3a0 1289) return 1;
efb0e3a0 1292) bloom_count_no++;
efb0e3a0 1293) return 0;
efb0e3a0 1302) if (bd->nr >= bd->alloc) {
efb0e3a0 1303) bd->alloc *= 2;
efb0e3a0 1304) REALLOC_ARRAY(bd->keys, bd->alloc);
efb0e3a0 1307) bd->keys[bd->nr] = xmalloc(sizeof(struct bloom_key));
efb0e3a0 1308) fill_bloom_key(path, strlen(path), bd->keys[bd->nr], bd->settings);
efb0e3a0 1309) bd->nr++;
efb0e3a0 2903) bd = xmalloc(sizeof(struct blame_bloom_data));
efb0e3a0 2905) bd->settings = sb->repo->objects->commit_graph->bloom_filter_settings;
efb0e3a0 2907) bd->alloc = 4;
efb0e3a0 2908) bd->nr = 0;
efb0e3a0 2909) ALLOC_ARRAY(bd->keys, bd->alloc);
efb0e3a0 2911) add_bloom_key(bd, path);
efb0e3a0 2913) sb->bloom_data = bd;
efb0e3a0 2920) for (i = 0; i < sb->bloom_data->nr; i++) {
efb0e3a0 2921) free(sb->bloom_data->keys[i]->hashes);
efb0e3a0 2922) free(sb->bloom_data->keys[i]);
efb0e3a0 2924) free(sb->bloom_data->keys);
efb0e3a0 2925) FREE_AND_NULL(sb->bloom_data);
efb0e3a0 2927) trace2_data_intmax("blame", sb->repo,
efb0e3a0 2929) trace2_data_intmax("blame", sb->repo,

Derrick Stolee	88d2bac8 revision: complicated pathspecs disable filters
revision.c
88d2bac8 658) return 1;
88d2bac8 662) return 1;

Derrick Stolee	e3696980 diff: halt tree-diff early after max_changes
tree-diff.c
e3696980 438) break;

Derrick Stolee	72ca4f9b commit: write commit-graph with Bloom filters
commit-graph.c
72ca4f9b 1979) ctx->changed_paths = 1;

Garima Singh	76ffbca7 commit-graph: write Bloom filters to commit graph file
commit-graph.c
76ffbca7 335) chunk_repeated = 1;
76ffbca7 342) chunk_repeated = 1;
76ffbca7 349) break;
76ffbca7 1091) progress = start_delayed_progress(
76ffbca7 1093) ctx->commits.nr);
76ffbca7 1116) progress = start_delayed_progress(
76ffbca7 1118) ctx->commits.nr);

Garima Singh	3d112755 commit-graph: examine commits by generation number
commit-graph.c
3d112755 95) return -1;
3d112755 98) return 0;
3d112755 1300) QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);

Garima Singh	a56b9464 revision.c: use Bloom filters to speed up path based revision walks
bloom.c
a56b9464 266) return -1;

revision.c
a56b9464 721) return -1;
a56b9464 724) return -1;
a56b9464 735) return -1;

Garima Singh	ed591feb bloom.c: core Bloom filter implementation for changed paths.
bloom.c
ed591feb 172) return NULL;
ed591feb 246) for (i = 0; i < diff_queued_diff.nr; i++)
ed591feb 247) diff_free_filepair(diff_queued_diff.queue[i]);
ed591feb 248) filter->data = NULL;
ed591feb 249) filter->len = 0;

Garima Singh	42e50e78 revision.c: add trace2 stats around Bloom filter usage
revision.c
42e50e78 734) count_bloom_filter_length_zero++;

Garima Singh	f1294eaf bloom.c: introduce core Bloom filter constructs
t/helper/test-bloom.c
f1294eaf 25) printf("No filter.\n");
f1294eaf 26) return;

Garima Singh	f97b9325 commit-graph: compute Bloom filters for changed paths
commit-graph.c
f97b9325 1292) progress = start_delayed_progress(
f97b9325 1294) ctx->commits.nr);

Jeff King	348482de config: reject parsing of files over INT_MAX
config.c
348482de 537) cf->eof = 1;
348482de 538) return 0;

Jeff King	d8410a81 fast-import: replace custom hash with hashmap.c
fast-import.c
d8410a81 60) e2 = container_of(entry_or_key, const struct object_entry, ent);
d8410a81 61) return oidcmp(&e1->idx.oid, &e2->idx.oid);

Jeff King	d21ee7d1 commit-graph: examine changed-path objects in pack order
commit-graph.c
d21ee7d1 69) return; /* should never happen, but be lenient */
d21ee7d1 74) static int commit_pos_cmp(const void *va, const void *vb)
d21ee7d1 76) const struct commit *a = *(const struct commit **)va;
d21ee7d1 77) const struct commit *b = *(const struct commit **)vb;
d21ee7d1 78) return commit_pos_at(&commit_pos, a) -
d21ee7d1 79)        commit_pos_at(&commit_pos, b);

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

Junio C Hamano	4cdae8d2 Merge branch 'dl/libify-a-few' into jch
fmt-merge-msg.c
4cdae8d2 498) strbuf_addstr(&sig, "gpg verification failed.\n");



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason	5cc044e0 get_short_oid: sort ambiguous objects by type, then SHA-1
oid-array.c
5cc044e0 56) return ret;

brian m. carlson	910650d2 Rename sha1_array to oid_array
t/helper/test-oid-array.c
910650d2 29) oid_array_clear(&array);

Damien Robert	1fec6fa2 remote.c: fix handling of %(push:remoteref)
remote.c
1fec6fa2 1656) return NULL;
1fec6fa2 1663) return branch->refname;
1fec6fa2 1681) return NULL;
1fec6fa2 1808) return NULL;

Damien Robert	e3165570 remote.c: fix %(push) for triangular workflows
remote.c
e3165570 1766) return NULL;

Denton Liu	7cd54d37 wrapper: indent with tabs
wrapper.c
7cd54d37 221) len = MAX_IO_SIZE;
7cd54d37 243) len = MAX_IO_SIZE;

Elijah Newren	b9cbd295 rebase: reinstate --no-keep-empty
sequencer.c
b9cbd295 4674) continue;

Elijah Newren	7af7a258 unpack-trees: add a new update_sparsity() function
unpack-trees.c
7af7a258 1847) ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;

Jeff King	16ddcd40 sha1_array: let callbacks interrupt iteration
oid-array.c
16ddcd40 76) return ret;

Josh Steadmon	3d3adaad trace2: teach Git to log environment variables
trace2/tr2_cfg.c
3d3adaad 63) return tr2_cfg_env_vars_count;



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:

