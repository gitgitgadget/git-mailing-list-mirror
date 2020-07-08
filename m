Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FCDC433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 00:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0DD2073E
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 00:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koxf2gpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgGHACU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 20:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGHACT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 20:02:19 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311C0C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 17:02:19 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id t11so17617255qvk.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 17:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lu2+pZUn8ebcsGxEbLJ6L63YS6B2Q01XDF/nFq8+dOg=;
        b=koxf2gpCoI1ukX6Fiwvze381ajAlJzKuvUzZAWqTjRZVrR1Yvc6+yEvbvRdiBeicLq
         eh0gXmKpiT9z5Sl4AotQDn20mDSjeJZhUaMZJmlnQVCopeFLOPwWextr1rqDnLOYsYyJ
         UAU+P2j0izui880GNl+9zZZkZFrokoyng1rTtCJtgP2+lzUacTpxaiwUS30ID567uxDA
         2XOgEY0RduIfn4bCpH6fWXuesH1BWYvr05T0zss1NF7QHjaHYgN3AX8+YRF+lLpBs1/P
         knjTnJ+ahodvw3RqUOv1bUnhI4kUGv2i8AYyqLh+cyf3qXThalAIBM9d6dUH8s+/nZYT
         doTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lu2+pZUn8ebcsGxEbLJ6L63YS6B2Q01XDF/nFq8+dOg=;
        b=WoRaF6ztxWHuga7Qw4jShKCKTlQtn7clPRQsWhX4eDWrVOgVERdvL8j3dfLJvTl6ij
         d+/1W7Mpd7Nhyz+3h4oMBtVOoLCWdNIOEt3f60gkq2pqsHVn0+56VZq4UMB6G6rL9HFH
         AwN+yZaQqDX3G+4P1IqXM5Q0xTcsVZISFL+JnPYZg2G2cTMxcmmcXyQz23Z3sxCimUIb
         wyEyqVvcDiQSY97ovbM1ArH0taAX/T9BrOKvK5hWiuKd13pEWW9J7E2HAxeyVVQyYKCL
         4/RZYMkEafLvA9f9yCVouXKilkrDLpifJVn7ZUZGKt8c2lZMSmKvMMBMbVn8BVVg5StC
         y5qQ==
X-Gm-Message-State: AOAM530vQTqZLTGxO4x/CxXldu2hmNWEgAHOWZECSM8yslPJDYBs9eap
        ZH182vq2PsUXtpP5mwk9aFaaHEohvMM=
X-Google-Smtp-Source: ABdhPJybVpEKG/czW0R8wP0nb6o4MQc5f3D7g8REQaE7NGj5rV24iHkBvcE5991TnFp6dVzSvXKTow==
X-Received: by 2002:a0c:82a2:: with SMTP id i31mr46536019qva.106.1594166537632;
        Tue, 07 Jul 2020 17:02:17 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z18sm29642418qta.51.2020.07.07.17.02.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 17:02:17 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (July 7, 2020)
Message-ID: <fa0df357-21da-46dd-7d73-a374b76448cb@gmail.com>
Date:   Tue, 7 Jul 2020 20:02:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
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

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-07-07-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-07-07.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-07-07.htm

---

seen	66f3a24dd5403238838146bf7e526640ecb65ed7
jch	d9855b418b6ffe688a28097b01b040003bf6233f
next	b3809f4674cea6e2f5db8a478a39b85851690c7d
master	4a0fcf9f760c9774be77f51e1e88a7499b53d2e2
master@{1}	101b3204f37606972b40fc17dec84560c22f69f6


Uncovered code in 'seen' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Damien Robert	812a5889 remote.c: fix handling of %(push:remoteref)
remote.c
812a5889 1638) return NULL;
812a5889 1645) return branch->refname;
812a5889 1660) return NULL;
812a5889 1774) return NULL;

Emily Shaffer	933f1b2e hook: add list command
builtin/hook.c
933f1b2e 42) printf(_("no commands configured for hook '%s'\n"),
933f1b2e 44) return 0;

hook.c
933f1b2e 83) return NULL;

Jiang Xin	1e58de8c receive-pack: add new proc-receive hook
builtin/receive-pack.c
1e58de8c 1046) return code;
1e58de8c 1054) if (use_sideband)
1e58de8c 1055) finish_async(&muxer);
1e58de8c 1056) return code;
1e58de8c 1542) cmd->report.error_message = "broken symref";
1e58de8c 1727) cmd->report.error_message = "transaction failed to start";
1e58de8c 1866) if (!cmd->report.error_message)
1e58de8c 1867) cmd->report.error_message = "unable to migrate objects to permanent storage";

t/helper/test-proc-receive.c
1e58de8c 133) usage_msg_opt("Too many arguments.", proc_receive_usage, options);

Jiang Xin	5e4553bd New capability "report-status-v2" for git-push
send-pack.c
5e4553bd 182)        if (new_options) {
5e4553bd 184) new_options = 0;
5e4553bd 186) ret = -1;
5e4553bd 187) continue;
5e4553bd 223) ret = -1;
5e4553bd 224) break;
5e4553bd 241)     hint->status != REF_STATUS_OK &&
5e4553bd 242)     hint->status != REF_STATUS_REMOTE_REJECT) {
5e4553bd 435) else if (server_supports("report-status"))

transport-helper.c
5e4553bd 837) hint = NULL;
5e4553bd 856) (*ref)->report.message = msg;

Jiang Xin	2dd1150a receive-pack: new config receive.procReceiveRefs
builtin/receive-pack.c
2dd1150a 239) return config_error_nonbool(var);
2dd1150a 1839) continue;

Matheus Tavares	a2371e32 t/helper/test-config: facilitate addition of new cli options
t/helper/test-config.c
a2371e32 103) goto print_usage_error;
a2371e32 160) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 167) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 175) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 205) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 232) printf("Value not found for \"%s\"\n", argv[1]);

Matheus Tavares	92bca22f config: correctly read worktree configs in submodules
t/helper/test-config.c
92bca22f 109) goto print_usage_error;
92bca22f 114) fprintf(stderr, "Cannot use --submodule with read_early_config\n");
92bca22f 115) return TC_USAGE_ERROR;
92bca22f 130) fprintf(stderr, "Invalid argument to --submodule: '%s'\n",
92bca22f 132) free(subrepo);
92bca22f 133) ret = TC_USAGE_ERROR;
92bca22f 134) goto out;
92bca22f 187) fprintf(stderr, "Cannot use --submodule with configset_get_value\n");
92bca22f 188) ret = TC_USAGE_ERROR;
92bca22f 189) goto out;
92bca22f 210) fprintf(stderr, "Cannot use --submodule with configset_get_value_multi\n");
92bca22f 211) ret = TC_USAGE_ERROR;
92bca22f 212) goto out;
92bca22f 239) fprintf(stderr, "Invalid syntax. Usage: test-tool config"

Matheus Tavares	b77651be t/helper/test-config: return exit codes consistently
t/helper/test-config.c
b77651be 161) ret = TC_VALUE_NOT_FOUND;
b77651be 168) ret = TC_VALUE_NOT_FOUND;
b77651be 176) ret = TC_VALUE_NOT_FOUND;
b77651be 206) ret = TC_VALUE_NOT_FOUND;
b77651be 218) ret = TC_CONFIG_FILE_ERROR;
b77651be 219) goto out;
b77651be 233) ret = TC_VALUE_NOT_FOUND;
b77651be 241) ret = TC_USAGE_ERROR;

Matheus Tavares	e26e8bfc grep: honor sparse checkout patterns
builtin/grep.c
e26e8bfc 579) if (file_exists(sparse_file)) {
e26e8bfc 583) free(sparse_file);
e26e8bfc 584) free(patterns);
e26e8bfc 585) return NULL;

Miriam Rubio	9aadf776 bisect--helper: introduce new `write_in_file()` function
builtin/bisect--helper.c
9aadf776 90) return error_errno(_("cannot open file '%s' in mode '%s'"), path, mode);
9aadf776 95) fclose(fp);
9aadf776 96) return error_errno(_("could not write to file '%s'"), path);

Phillip Wood	86696a9d rebase -i: support --ignore-date
sequencer.c
86696a9d 893) return NULL;
86696a9d 1477) res = -1;
86696a9d 1478) goto out;

Phillip Wood	e12c40fd rebase -i: support --committer-date-is-author-date
sequencer.c
e12c40fd 1395) goto out;
e12c40fd 1399) goto out;

Pranit Bauva	10520dbf bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
builtin/bisect--helper.c
10520dbf 873) return BISECT_FAILED;
10520dbf 889) oid_array_clear(&revs);
10520dbf 890) return BISECT_FAILED;

Pranit Bauva	05a69202 bisect--helper: reimplement `bisect_autostart` shell function in C
builtin/bisect--helper.c
05a69202 822) fprintf(stderr, _("You need to start by \"git bisect "
05a69202 825) if (!isatty(STDIN_FILENO))
05a69202 826) return 1;
05a69202 833) yesno = git_prompt(_("Do you want me to do it for you "
05a69202 835) if (starts_with(yesno, _("n")) || starts_with(yesno, _("N")))
05a69202 836) return 1;
05a69202 838) return bisect_start(terms, 0, NULL, 0);

Pranit Bauva	f0bf9482 bisect--helper: finish porting `bisect_start()` to C
builtin/bisect--helper.c
f0bf9482 734) return BISECT_FAILED;
f0bf9482 755) res = BISECT_FAILED;
f0bf9482 767) res = BISECT_FAILED;
f0bf9482 779) res = BISECT_FAILED;

Pranit Bauva	587c9fac bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
builtin/bisect--helper.c
587c9fac 492) return error_errno(_("failed to write to '%s'"), git_path_bisect_log());
587c9fac 521) return error_errno(_("could not open '%s' for appending"),

Shawn O. Pearce	38a81b4e receive-pack: Wrap status reports inside side-band-64k
builtin/receive-pack.c
38a81b4e 2283) send_sideband(1, 1, buf.buf, buf.len, use_sideband);

Taylor Blau	2129af73 list_objects_filter_options: introduce 'list_object_filter_config_name'
list-objects-filter-options.c
2129af73 23) break;
2129af73 36) break;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Michael Forney	ea3f7e59 revision: use repository from rev_info when parsing commits
revision.c
ea3f7e59 1062) if (repo_parse_commit(revs->repo, p) < 0)



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
SZEDER Gábor	17e6275f commit-graph: simplify chunk writes into loop
commit-graph.c
17e6275f 1780) return -1;



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Abhishek Kumar	4844812b commit-graph: introduce commit_graph_data_slab
commit-graph.c
4844812b 1349) data->generation = GENERATION_NUMBER_MAX;

brian m. carlson	122037c2 connect: add function to detect supported v1 hash functions
connect.c
122037c2 566) hash = hash_algos[GIT_HASH_SHA1].name;
122037c2 567) len = strlen(hash);
122037c2 573) hash = next_server_feature_value("object-format", &len, &offset);

brian m. carlson	14570dc6 wrapper: add function to compare strings with different NUL termination
wrapper.c
14570dc6 112) return res;

brian m. carlson	8b85ee4f transport-helper: implement object-format extensions
transport-helper.c
8b85ee4f 1113) exit(128);

brian m. carlson	ac093d07 remote-curl: detect algorithm for dumb HTTP by size
remote-curl.c
ac093d07 264) return NULL;
ac093d07 282)     transport_anonymize_url(url.buf));

brian m. carlson	7f605017 remote-curl: implement object-format extensions
remote-curl.c
7f605017 199) algo = hash_algo_by_name(value);
7f605017 200) if (algo == GIT_HASH_UNKNOWN)
7f605017 202) options.hash_algo = &hash_algos[algo];

brian m. carlson	4b831208 fetch-pack: parse and advertise the object-format capability
fetch-pack.c
4b831208 1212)     the_hash_algo->name, hash_name);
4b831208 1214) } else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
4b831208 1216)     the_hash_algo->name);

brian m. carlson	9de0dd36 serve: advertise object-format capability for protocol v2
connect.c
9de0dd36 477) reader->hash_algo = &hash_algos[GIT_HASH_SHA1];

brian m. carlson	1349ffed connect: add function to fetch value of a v2 server capability
connect.c
1349ffed 98) return 0;

brian m. carlson	6161ce7b bundle: detect hash algorithm when reading refs
bundle.c
6161ce7b 33) return NULL;
6161ce7b 70) status = -1;
6161ce7b 71) break;

brian m. carlson	88a09a55 builtin/show-index: provide options to determine hash algo
builtin/show-index.c
88a09a55 29) hash_algo = hash_algo_by_name(hash_name);
88a09a55 30) if (hash_algo == GIT_HASH_UNKNOWN)
88a09a55 32) repo_set_hash_algo(the_repository, hash_algo);

brian m. carlson	bb095d08 builtin/receive-pack: detect when the server doesn't support our hash
builtin/receive-pack.c
bb095d08 1644) hash = hash_algos[GIT_HASH_SHA1].name;
bb095d08 1645) len = strlen(hash);

Chris Torek	8bfcb3a6 git diff: improve range handling
builtin/diff.c
8bfcb3a6 329) usage(builtin_diff_usage);

Christian Couder	f203a88c upload-pack: move keepalive to upload_pack_data
upload-pack.c
f203a88c 1193) data->keepalive = git_config_int(var, value);
f203a88c 1194) if (!data->keepalive)
f203a88c 1195) data->keepalive = -1;

Christian Couder	f8edd1ca upload-pack: move use_sideband to upload_pack_data
upload-pack.c
f8edd1ca 1039) data->use_sideband = DEFAULT_PACKET_MAX;

Christian Couder	e9d882b8 upload-pack: change multi_ack to an enum
upload-pack.c
e9d882b8 1029) data->multi_ack = MULTI_ACK;

Elijah Newren	051df3cf wt-status: show sparse checkout status as well
wt-status.c
051df3cf 1491) return;

Eric Sunshine	c9b77f2c worktree: factor out repeated string literal
builtin/worktree.c
c9b77f2c 105) strbuf_addf(reason, _("unable to read gitdir file (%s)"),

Eric Sunshine	916133ef worktree: prune linked worktree referencing main worktree path
builtin/worktree.c
916133ef 166) return -1;

Jeff King	b5a2068c upload-pack: actually use some upload_pack_data bitfields
upload-pack.c
b5a2068c 1076) data->no_progress = 1;

Jeff King	750bb325 fast-export: store anonymized oids as hex strings
builtin/fast-export.c
750bb325 731)        anonymize_oid(oid_to_hex(&obj->oid)) :

Jeff King	65b5d9fa fast-export: allow seeding the anonymized mapping
builtin/fast-export.c
65b5d9fa 177) ret = NULL;

Jeff King	a0f65641 fast-export: stop storing lengths in anonymized hashmaps
builtin/fast-export.c
a0f65641 149) b = container_of(entry_or_key, const struct anonymized_entry, hash);
a0f65641 150) return strcmp(a->orig, b->orig);

Jonathan Tan	acaaca7d upload-pack: refactor reading of pack-objects out
upload-pack.c
acaaca7d 210) return readsz;
acaaca7d 438) send_client_data(1, output_state.buffer, output_state.used,

Jonathan Tan	dd4b732d upload-pack: send part of packfile response as uri
upload-pack.c
dd4b732d 1412) string_list_clear(&data->uri_protocols, 0);

Jonathan Tan	8d5d2a34 http-fetch: support fetching packfiles by URL
http-fetch.c
8d5d2a34 128) commits = walker_targets_stdin(&commit_id, &write_ref);

Jonathan Tan	8e6adb69 http-fetch: refactor into function
http-fetch.c
8e6adb69 30) walker_targets_free(commits, commit_id, write_ref);
8e6adb69 33) fprintf(stderr,

Jonathan Tan	9da69a65 fetch-pack: support more than one pack lockfile
builtin/fetch-pack.c
9da69a65 246) pack_lockfiles.items[i].string);

Patrick Steinhardt	67541597 refs: implement reference transaction hook
refs.c
67541597 2047) return ret;
67541597 2062) ret = -1;

Randall S. Becker	f64b6a1f bugreport.c: replace strbuf_write_fd with write_in_full
bugreport.c
f64b6a1f 184) die_errno(_("unable to write to %s"), report_path.buf);


