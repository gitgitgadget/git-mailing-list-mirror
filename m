Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A672BC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 15:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74BAA2080D
	for <git@archiver.kernel.org>; Wed,  6 May 2020 15:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrIfh8NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgEFPTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbgEFPTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 11:19:42 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68DBC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 08:19:41 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i27so1638862ota.7
        for <git@vger.kernel.org>; Wed, 06 May 2020 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QWzZJojeiZNWKiRRccCOQdvOl/oMJ6cLzTa1rJk1aNk=;
        b=jrIfh8NFwoQFoodg9Xraz6utaHsxFHhim5M8sn5wlnsC9hdEHYN2tzeoaSJ2PFk9Y+
         VIGgqH15fWFDx2pRXta8I4NeUhZW3zC7B40pcO3G6mVlqVAmZg3gjLOLgG1RYL02xZbW
         eCDQtakrgQVwJh8xouPRisre41BhgO9hZEiGAMGAeIcbMYujvzQED76kL07Gr2XJ2qs4
         3rsmklBQ/j+Qj0h3Zhay0tlnoUJBq6m5u+Bf2HlIU49vh2JX0ZEpCBM42WPf3mp4lF5w
         6na3MABIFXWVRM4v0XMXF9Kb/tqdIO/3DnqiaZp5ofxgIYGfNBvti/lHq1LdgO6Ynh3d
         uGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QWzZJojeiZNWKiRRccCOQdvOl/oMJ6cLzTa1rJk1aNk=;
        b=pM4JUzYaCNLKBFVNJASyuDqszZfyzns1VMLOyFhk2UdsQt6JptAD5E7r+deCBDMSZX
         YK8n/C8PX+thGRdytgeaBH35mNu38iLUG+cA9Xr2ckMYTUwFwXKUFBmN8bftoyp+vGdL
         /Z7K2YJeyDAJMuWqxBi1+t8kBb7Q6U2w3I/C2cII5a8Mq3RZSgZ2VmuNxZzBIJkdJI0X
         jTD4K51l7n97vLoKf+uRVpL9+JsOnVbn22Itw80hXzEH/7Fll5PaNkVPmiVpvfu/8yxw
         JzMvr+6wMF+VjyKLsGZBWbVJEMixN2QS0BzSlPRGh3tB5x6sPAlRQv46/BNEmUh4iY6o
         Gs1g==
X-Gm-Message-State: AGi0PuY3Uwnr6+rITWygyKZAegQ0mgb9sINq1IM7WFFlcjQzh4fgDDRH
        RWkeYWLo7HkhKZBveXHn+cWtPG/Rxx4=
X-Google-Smtp-Source: APiQypJbsD1AEZ2RX5iDnz6UPGp3/jl4iAVIDUY2WxqKfJdVAiyH3cG4j6NFAr0266+MUh2auvTueQ==
X-Received: by 2002:a05:6830:1d8:: with SMTP id r24mr6625668ota.277.1588778380379;
        Wed, 06 May 2020 08:19:40 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b6sm590736otp.31.2020.05.06.08.19.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 08:19:39 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (May 6, 2020)
Message-ID: <4a47a215-f636-3f94-17f5-33f13140bdc7@gmail.com>
Date:   Wed, 6 May 2020 11:19:38 -0400
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


[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-05-06-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-05-06.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-05-06.htm

---

pu	c0f7ae5a7ea5cf8246270fcf1853726167ca8ef4
jch	fffcd002d6befa77784a44046b986934b87e6c3b
next	55c56c9c57da646085d27e61a3420043978ab4a1
master	07d8ea56f2ecb64b75b92264770c0a664231ce17
master@{1}	86ab15cb154862b6fa5cc646dac27532f881e1fb


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Derrick Stolee	78a1541e line-log: integrate with changed-path Bloom filters
line-log.c
78a1541e 1159) return 1;
78a1541e 1166) return 0;

Jiang Xin	7e70e854 receive-pack: new config receive.procReceiveRefs
builtin/receive-pack.c
7e70e854 239) return config_error_nonbool(var);
7e70e854 1838) continue;

Jiang Xin	ad8697b0 receive-pack: add new proc-receive hook
builtin/receive-pack.c
ad8697b0 1045) return code;
ad8697b0 1048) proc.err = 0;
ad8697b0 1053) if (use_sideband)
ad8697b0 1054) finish_async(&muxer);
ad8697b0 1055) return code;
ad8697b0 1541) cmd->report.error_message = "broken symref";
ad8697b0 1726) cmd->report.error_message = "transaction failed to start";
ad8697b0 1865) if (!cmd->report.error_message)
ad8697b0 1866) cmd->report.error_message = "unable to migrate objects to permanent storage";
ad8697b0 2266)  cmd->ref_name, cmd->report.error_message);

t/helper/test-proc-receive.c
ad8697b0 134) usage_msg_opt("Too many arguments.", proc_receive_usage, options);

Jiang Xin	1b722303 New capability "report-status-v2" for git-push
send-pack.c
1b722303 183)        if (new_options) {
1b722303 185) new_options = 0;
1b722303 187) ret = -1;
1b722303 188) continue;
1b722303 228) ret = -1;
1b722303 229) break;
1b722303 243)     hint->status != REF_STATUS_OK &&
1b722303 244)     hint->status != REF_STATUS_REMOTE_REJECT) {

transport-helper.c
1b722303 833) hint = NULL;
1b722303 852) (*ref)->report.message = msg;

Miriam Rubio	9aadf776 bisect--helper: introduce new `write_in_file()` function
builtin/bisect--helper.c
9aadf776 91) return error_errno(_("cannot open file '%s' in mode '%s'"), path, mode);
9aadf776 96) fclose(fp);
9aadf776 97) return error_errno(_("could not write to file '%s'"), path);

Phillip Wood	30b22821 rebase -i: support --ignore-date
sequencer.c
30b22821 893) return NULL;
30b22821 1475) res = -1;
30b22821 1476) goto out;

Phillip Wood	66f46e74 rebase -i: support --committer-date-is-author-date
sequencer.c
66f46e74 1395) goto out;
66f46e74 1399) goto out;

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

Shawn O. Pearce	38a81b4e receive-pack: Wrap status reports inside side-band-64k
builtin/receive-pack.c
38a81b4e 2265) packet_buf_write(&buf, "ng %s %s\n",
38a81b4e 2271) send_sideband(1, 1, buf.buf, buf.len, use_sideband);

Taylor Blau	199d758e builtin/commit-graph.c: dereference tags in builtin
builtin/commit-graph.c
199d758e 244) progress = start_delayed_progress(



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Damien Robert	812a5889 remote.c: fix handling of %(push:remoteref)
remote.c
812a5889 1638) return NULL;
812a5889 1645) return branch->refname;
812a5889 1660) return NULL;
812a5889 1774) return NULL;

Jonathan Tan	fbda77c6 commit-graph: avoid Memory Leaks
commit-graph.c
fbda77c6 296) goto free_and_return;
fbda77c6 363) goto free_and_return;



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:


Uncovered code in 'master' not in 'master@{1}'
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

Derrick Stolee	6c622f9f commit-graph: write commit-graph chains
commit-graph.c
6c622f9f 1585) return -1;

Derrick Stolee	0906ac2b blame: use changed-path Bloom filters
blame.c
0906ac2b 1281) return 1;
0906ac2b 1302) bd->alloc *= 2;
0906ac2b 1303) REALLOC_ARRAY(bd->keys, bd->alloc);
0906ac2b 2899) return;

Đoàn Trần Công Danh	4f89f4fc date.c: validate and set time in a helper function
date.c
4f89f4fc 553) return -1;

Đoàn Trần Công Danh	c933b28d date.c: s/is_date/set_date/
date.c
c933b28d 521) return -1;
c933b28d 532) return -1;

Elijah Newren	7af7a258 unpack-trees: add a new update_sparsity() function
unpack-trees.c
7af7a258 1846) ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;

Elijah Newren	16846444 dir: include DIR_KEEP_UNTRACKED_CONTENTS handling in treat_directory()
dir.c
16846444 1924) FREE_AND_NULL(dir->entries[i]);

Emily Shaffer	1411914a bugreport: add uname info
bugreport.c
1411914a 18) strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
1411914a 20)     errno);

Emily Shaffer	617d5719 bugreport: gather git version and build info
help.c
617d5719 641) strbuf_addstr(buf, "no commit associated with this build\n");

Emily Shaffer	709df95b help: move list_config_help to builtin/help
builtin/help.c
709df95b 123) puts(var);
709df95b 124) continue;

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

Garima Singh	f1294eaf bloom.c: introduce core Bloom filter constructs
t/helper/test-bloom.c
f1294eaf 25) printf("No filter.\n");
f1294eaf 26) return;

Garima Singh	f97b9325 commit-graph: compute Bloom filters for changed paths
commit-graph.c
f97b9325 1298) progress = start_delayed_progress(
f97b9325 1300) ctx->commits.nr);

Garima Singh	3d112755 commit-graph: examine commits by generation number
commit-graph.c
3d112755 1306) QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);

Jeff King	1b4c57fa test-bloom: check that we have expected arguments
t/helper/test-bloom.c
1b4c57fa 54) usage(bloom_usage);
1b4c57fa 59) usage(bloom_usage);
1b4c57fa 71) usage(bloom_usage);
1b4c57fa 85) usage(bloom_usage);

Jeff King	d21ee7d1 commit-graph: examine changed-path objects in pack order
commit-graph.c
d21ee7d1 76) return; /* should never happen, but be lenient */
d21ee7d1 81) static int commit_pos_cmp(const void *va, const void *vb)
d21ee7d1 83) const struct commit *a = *(const struct commit **)va;
d21ee7d1 84) const struct commit *b = *(const struct commit **)vb;
d21ee7d1 85) return commit_pos_at(&commit_pos, a) -
d21ee7d1 86)        commit_pos_at(&commit_pos, b);

Johannes Schindelin	12294990 credential: handle `credential.<partial-URL>.<key>` again
urlmatch.c
12294990 581) retval = 0;

Karsten Blees	defd7c7b dir.c: git-status --ignored: don't scan the work tree three times
dir.c
defd7c7b 2177) return path_none;

Patrick Steinhardt	a65b8ac2 update-ref: organize commands in an array
builtin/update-ref.c
a65b8ac2 419) continue;

Patrick Steinhardt	edc30691 refs: fix segfault when aborting empty transaction
refs/files-backend.c
edc30691 2572) strbuf_release(&err);

Taylor Blau	37b9dcab shallow.c: use '{commit,rollback}_shallow_file'
builtin/receive-pack.c
37b9dcab 896) rollback_shallow_file(the_repository, &shallow_lock);

Taylor Blau	fdbde82f builtin/commit-graph.c: introduce split strategy 'no-merge'
commit-graph.c
fdbde82f 1788) break;


