Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01460C8300D
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E052076D
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czkdWNt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgD3LVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727799AbgD3LVh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 07:21:37 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E9AC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 04:21:37 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id v26so4606184qto.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 04:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jXls/2EZttfOvmdbP3LRI1RvcTLsskiOkoXGst0C0WE=;
        b=czkdWNt2STggdLqEMdfo6iM7WVL7n90dnl3SvGjz09JR4N2pt/B+Y5gyLSEeRhUIT7
         5bOB9AQ5Ckmw7uzYJ3ssyrqAdv8q87qIR8CfH79OnRuXzAX8H0uJXqqGVLH1HErk09br
         6NV1F1YE2Y4u58Jg+H/C2b3gT1m4rezjfTzPVjSa3YUpKWpXzDU5ELED9sB9VvVQdxgQ
         xzA8mhIBUS2STSt19Z0+UuRH8iRsa9UjFUQudzVhInEsX1Uc1PuZ3B8S5KhAY2WaDc1X
         jrZ5Hcni3ZTNHtjZwgitIbCISYFAK/4e/Em4M1zIgG2DCNtS4LVSZt1C6g+T3lgBtgnU
         KfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jXls/2EZttfOvmdbP3LRI1RvcTLsskiOkoXGst0C0WE=;
        b=h1Vezm5lL/tYEjeJ9JOdibXolMLjI9727SYxwaiyAycFr+wsmgDPmpRRmtfhT/yDa+
         3KbMRWQzjfqQHLrFfketCXXkW0eEoWikeRy0/rS0dchR6gQ5I+NfuxeY/hn1ADpO+0Rj
         cswVRL5m4TkfQsZtJvlabDRh4BzkH/4qQiZv4gC64a4OiPGXz+QvPvQqxL6X+qovYnvu
         O7EnXukEl6B2NBXbywzJtMpxCV2BLwHbhSWEu9cbdEgCNLuJ+Ebj63/vH43h5EXJPEFY
         ChhUDG8DrfB2Xu+VNkL0vmUMN82yUj0Cif8fL/Rwc6pm1EBg4dqzraZfLyIt+Svd52h0
         XbLw==
X-Gm-Message-State: AGi0PuYh1CUPm7nlR7O9glzRf761n1D8kjrJRLmvVQJ+n1iiEinvaXb8
        lRshkVW5UTk39dzwRhRQyBaZyx+KS5Y=
X-Google-Smtp-Source: APiQypK6/oSWTal5lwwmjqhjkrdth0zsfal3CUY9AQrWGiwe/x631I/Amrm4KbHSAGsIhaLxqxJf8w==
X-Received: by 2002:ac8:67d2:: with SMTP id r18mr3034569qtp.161.1588245696073;
        Thu, 30 Apr 2020 04:21:36 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a194sm1562916qkb.21.2020.04.30.04.21.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 04:21:35 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (April 30, 2020)
Message-ID: <fda6d0db-f79e-f44e-7c2b-b60ed1794cd0@gmail.com>
Date:   Thu, 30 Apr 2020 07:21:33 -0400
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

Hello,

Here is today's test coverage report.

It appears that _all_ of the reftable code shows up in this report as
untested. Perhaps that is the state of the world right now, or perhaps
I need to initialize a GIT_TEST_ environment variable to ensure it runs?
In either way, do we have any test coverage of that massive contribution?
Please take a look at the online report [1] for that part of the report,
as I snipped it out of this email.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-04-30-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-04-30.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-04-30.htm

---

pu	50ce81fe7726b7eea90e201c1d31567158bfe4c1
jch	a2998880e147321b718420ae805807ef5fb483f3
next	6140810f5a86d69e4bee74d360b936fb4a8a3b1f
master	86ab15cb154862b6fa5cc646dac27532f881e1fb
master@{1}	efe3874640e2e58209ddbb3b072f48f6b7094f34


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Carlo Marcelo Arenas Belón	555c4709 credential-store: warn instead of fatal for bogus lines from store
credential-store.c
555c4709 27) strbuf_reset(&redacted_line);

[...snipped all reftable code...]

Jiang Xin	2c26d674 receive-pack: new config receive.procReceiveRefs
builtin/receive-pack.c
2c26d674 237) return config_error_nonbool(var);
2c26d674 1814) continue;

Jiang Xin	bc3e2729 receive-pack: add new proc-receive hook
builtin/receive-pack.c
bc3e2729 1021) return code;
bc3e2729 1024) proc.err = 0;
bc3e2729 1029) if (use_sideband)
bc3e2729 1030) finish_async(&muxer);
bc3e2729 1031) return code;
bc3e2729 2245) packet_buf_write(&buf, "ng %s %s%c%s\n",
bc3e2729 2246)  cmd->ref_name, cmd->error_string,

t/helper/test-proc-receive.c
bc3e2729 127) usage_msg_opt("Too many arguments.", proc_receive_usage, options);
bc3e2729 167) *p = '\0';
bc3e2729 168) p += 2;
bc3e2729 169) packet_write_fmt(1, "%s%c%s\n", item->string, '\0', p);

Jiang Xin	d131afc3 send-pack: extension for client-side status report
remote.c
d131afc3 2362) return;

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

Miriam Rubio	9aadf776 bisect--helper: introduce new `write_in_file()` function
builtin/bisect--helper.c
9aadf776 91) return error_errno(_("cannot open file '%s' in mode '%s'"), path, mode);
9aadf776 96) fclose(fp);
9aadf776 97) return error_errno(_("could not write to file '%s'"), path);

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

Pranit Bauva	587c9fac bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
builtin/bisect--helper.c
587c9fac 493) return error_errno(_("failed to write to '%s'"), git_path_bisect_log());
587c9fac 522) return error_errno(_("could not open '%s' for appending"),

Pranit Bauva	f0bf9482 bisect--helper: finish porting `bisect_start()` to C
builtin/bisect--helper.c
f0bf9482 730) return BISECT_FAILED;
f0bf9482 751) res = BISECT_FAILED;
f0bf9482 763) res = BISECT_FAILED;
f0bf9482 775) res = BISECT_FAILED;

Pranit Bauva	05a69202 bisect--helper: reimplement `bisect_autostart` shell function in C
builtin/bisect--helper.c
05a69202 818) fprintf(stderr, _("You need to start by \"git bisect "
05a69202 821) if (!isatty(STDIN_FILENO))
05a69202 822) return 1;
05a69202 829) yesno = git_prompt(_("Do you want me to do it for you "
05a69202 831) if (starts_with(yesno, _("n")) || starts_with(yesno, _("N")))
05a69202 832) return 1;
05a69202 834) return bisect_start(terms, 0, NULL, 0);

Pranit Bauva	10520dbf bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
builtin/bisect--helper.c
10520dbf 869) return BISECT_FAILED;
10520dbf 885) oid_array_clear(&revs);
10520dbf 886) return BISECT_FAILED;

Taylor Blau	7cb91802 commit-graph.c: ensure graph layers respect core.sharedRepository
commit-graph.c
7cb91802 1591) return -1;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Damien Robert	812a5889 remote.c: fix handling of %(push:remoteref)
remote.c
812a5889 1638) return NULL;
812a5889 1645) return branch->refname;
812a5889 1660) return NULL;
812a5889 1774) return NULL;

Johannes Schindelin	12294990 credential: handle `credential.<partial-URL>.<key>` again
urlmatch.c
12294990 581) retval = 0;



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
Denton Liu	be1bb600 sequencer: make apply_autostash() accept a path
sequencer.c
be1bb600 5203) apply_autostash(rebase_path_autostash());

Denton Liu	65c425a2 sequencer: stop leaking buf
sequencer.c
65c425a2 2557) goto done_rebase_i;

Denton Liu	5b2f6d9c sequencer: make file exists check more efficient
sequencer.c
5b2f6d9c 431) warning_errno(_("could not read '%s'"), path);

Denton Liu	efcf6cf0 rebase: use read_oneliner()
builtin/rebase.c
efcf6cf0 625) } else if (!read_oneliner(&buf, state_dir_path("head", opts),

Denton Liu	f213f069 rebase: generify reset_head()
builtin/rebase.c
f213f069 880) reset_head(the_repository, &opts->orig_head, "checkout",
f213f069 881)    opts->head_name, 0,

Denton Liu	86ed00af rebase: use apply_autostash() from sequencer.c
builtin/rebase.c
86ed00af 1041) apply_autostash(state_dir_path("autostash", opts));

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

Derrick Stolee	e3696980 diff: halt tree-diff early after max_changes
tree-diff.c
e3696980 438) break;

Derrick Stolee	8918e379 revision: complicated pathspecs disable filters
revision.c
8918e379 658) return 1;
8918e379 662) return 1;

Derrick Stolee	0906ac2b blame: use changed-path Bloom filters
blame.c
0906ac2b 1281) return 1;
0906ac2b 1302) bd->alloc *= 2;
0906ac2b 1303) REALLOC_ARRAY(bd->keys, bd->alloc);
0906ac2b 2899) return;

Đoàn Trần Công Danh	c933b28d date.c: s/is_date/set_date/
date.c
c933b28d 521) return -1;
c933b28d 532) return -1;

Đoàn Trần Công Danh	4f89f4fc date.c: validate and set time in a helper function
date.c
4f89f4fc 553) return -1;

Elijah Newren	7af7a258 unpack-trees: add a new update_sparsity() function
unpack-trees.c
7af7a258 1846) ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;

Elijah Newren	16846444 dir: include DIR_KEEP_UNTRACKED_CONTENTS handling in treat_directory()
dir.c
16846444 1924) FREE_AND_NULL(dir->entries[i]);

Emily Shaffer	617d5719 bugreport: gather git version and build info
help.c
617d5719 641) strbuf_addstr(buf, "no commit associated with this build\n");

Emily Shaffer	709df95b help: move list_config_help to builtin/help
builtin/help.c
709df95b 123) puts(var);
709df95b 124) continue;

Emily Shaffer	1411914a bugreport: add uname info
bugreport.c
1411914a 18) strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
1411914a 20)     errno);

Garima Singh	f97b9325 commit-graph: compute Bloom filters for changed paths
commit-graph.c
f97b9325 1298) progress = start_delayed_progress(
f97b9325 1300) ctx->commits.nr);

Garima Singh	ed591feb bloom.c: core Bloom filter implementation for changed paths.
bloom.c
ed591feb 172) return NULL;
ed591feb 246) for (i = 0; i < diff_queued_diff.nr; i++)
ed591feb 247) diff_free_filepair(diff_queued_diff.queue[i]);
ed591feb 248) filter->data = NULL;
ed591feb 249) filter->len = 0;

Garima Singh	76ffbca7 commit-graph: write Bloom filters to commit graph file
commit-graph.c
76ffbca7 338) chunk_repeated = 1;
76ffbca7 345) chunk_repeated = 1;
76ffbca7 352) break;
76ffbca7 1094) progress = start_delayed_progress(
76ffbca7 1096) ctx->commits.nr);
76ffbca7 1119) progress = start_delayed_progress(
76ffbca7 1121) ctx->commits.nr);

Garima Singh	a56b9464 revision.c: use Bloom filters to speed up path based revision walks
bloom.c
a56b9464 266) return -1;

revision.c
a56b9464 721) return -1;

Garima Singh	3d112755 commit-graph: examine commits by generation number
commit-graph.c
3d112755 1306) QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);

Garima Singh	f1294eaf bloom.c: introduce core Bloom filter constructs
t/helper/test-bloom.c
f1294eaf 25) printf("No filter.\n");
f1294eaf 26) return;

Jeff King	d21ee7d1 commit-graph: examine changed-path objects in pack order
commit-graph.c
d21ee7d1 76) return; /* should never happen, but be lenient */
d21ee7d1 81) static int commit_pos_cmp(const void *va, const void *vb)
d21ee7d1 83) const struct commit *a = *(const struct commit **)va;
d21ee7d1 84) const struct commit *b = *(const struct commit **)vb;
d21ee7d1 85) return commit_pos_at(&commit_pos, a) -
d21ee7d1 86)        commit_pos_at(&commit_pos, b);

Jeff King	1b4c57fa test-bloom: check that we have expected arguments
t/helper/test-bloom.c
1b4c57fa 54) usage(bloom_usage);
1b4c57fa 59) usage(bloom_usage);
1b4c57fa 71) usage(bloom_usage);
1b4c57fa 85) usage(bloom_usage);

Karsten Blees	defd7c7b dir.c: git-status --ignored: don't scan the work tree three times
dir.c
defd7c7b 2177) return path_none;

Patrick Steinhardt	edc30691 refs: fix segfault when aborting empty transaction
refs/files-backend.c
edc30691 2572) strbuf_release(&err);

Patrick Steinhardt	a65b8ac2 update-ref: organize commands in an array
builtin/update-ref.c
a65b8ac2 419) continue;

Taylor Blau	37b9dcab shallow.c: use '{commit,rollback}_shallow_file'
builtin/receive-pack.c
37b9dcab 896) rollback_shallow_file(the_repository, &shallow_lock);

Taylor Blau	fdbde82f builtin/commit-graph.c: introduce split strategy 'no-merge'
commit-graph.c
fdbde82f 1780) break;



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason	5cc044e0 get_short_oid: sort ambiguous objects by type, then SHA-1
oid-array.c
5cc044e0 56) return ret;

brian m. carlson	edc6dccf builtin/receive-pack: use constant-time comparison for HMAC value
builtin/receive-pack.c
edc6dccf 568) retval = NONCE_BAD;
edc6dccf 569) goto leave;

brian m. carlson	910650d2 Rename sha1_array to oid_array
t/helper/test-oid-array.c
910650d2 29) oid_array_clear(&array);

Denton Liu	7cd54d37 wrapper: indent with tabs
wrapper.c
7cd54d37 221) len = MAX_IO_SIZE;
7cd54d37 243) len = MAX_IO_SIZE;

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

Derrick Stolee	c9f7a793 log-tree: make ref_filter_match() a helper method
log-tree.c
c9f7a793 94)     (!*rest || *rest == '/'))

Elijah Newren	b9cbd295 rebase: reinstate --no-keep-empty
sequencer.c
b9cbd295 4674) continue;

Jeff King	24036686 credential: parse URL without host as empty host, not unset
http.c
24036686 582) cert_auth.host = xstrdup("");

Jeff King	16ddcd40 sha1_array: let callbacks interrupt iteration
oid-array.c
16ddcd40 76) return ret;

Jeff King	348482de config: reject parsing of files over INT_MAX
config.c
348482de 537) cf->eof = 1;
348482de 538) return 0;

Jeff King	d8410a81 fast-import: replace custom hash with hashmap.c
fast-import.c
d8410a81 60) e2 = container_of(entry_or_key, const struct object_entry, ent);
d8410a81 61) return oidcmp(&e1->idx.oid, &e2->idx.oid);

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

Josh Steadmon	3d3adaad trace2: teach Git to log environment variables
trace2/tr2_cfg.c
3d3adaad 63) return tr2_cfg_env_vars_count;

Junio C Hamano	56a1d9ca Merge branch 'dl/libify-a-few'
fmt-merge-msg.c
56a1d9ca 498) strbuf_addstr(&sig, "gpg verification failed.\n");

Vasil Dimov	8cf51561 range-diff: fix a crash in parsing git-log output
range-diff.c
8cf51561 115) string_list_clear(list, 1);
8cf51561 116) strbuf_release(&buf);
8cf51561 117) strbuf_release(&contents);
8cf51561 118) finish_command(&cp);
8cf51561 119) return -1;


