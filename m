Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1406C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 15:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47912075E
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 15:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6QrziWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbgFRP5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgFRP5U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 11:57:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C91C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 08:57:20 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c185so5998303qke.7
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NNJqM6ok4+WthdvzRaohfYazLQgTwgidQfLT4LMWLG4=;
        b=c6QrziWDaAXmb8wHZXresJ4fuMjhZq8zx41ERHnRw9Lgzcq6ZuNP+R/itZqHKcBorq
         4LFDDeRjSG8pt1m7sPWMHlrKSbMDSZ+jsFqbQ0PHnPL3UCAA5BPcLWm0qmDFhBV4hpr9
         YJDreuiz56IK2b9Z3Y7bTbgILCkRSwUvJ5ccyBNxzTS6MHOj24FYWZJejDDspyZ/8+/G
         w+9BrrQeGpglbC8MzZF0W+X8pvfvOKhEddS+hJojiGaO1AtuszXeyV50GYxzW6KPZ36I
         ufv2dWUUYj6BYK/v5EXg1oTSZhKYKYdOOPa/cTXLeQJfx8ee2O6UbgUfCjZPEhgGD9eJ
         PuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NNJqM6ok4+WthdvzRaohfYazLQgTwgidQfLT4LMWLG4=;
        b=bxMtIBniGJOBzSwoTkAjbyNREGNFZdfe0RHBVEi6oPxKqL8dgjxJjVQg8IlIxIcHuf
         cQw0k1eN7HswFoYONTqBIsAhNLUzosjYkE9I4EVO6cK0olNbA/KAqHoloEns+4JSEQ98
         iNDUyClXAHqEUhIHtrrfE8XO/Xwq7otbEwNMz7QIEPJaFQbkttj9AdiHyxfIiAPMfKRv
         r0z7/HCyjV0/a1bhK/OePbm/H++N0+YYH/IX8ycbbYLcZJ2wMKgmkYTE4LeG9P5B0RzT
         HDYJkJ6PYBDjMybkihCzhQLqkJbFjvL0tH1Rukf59t64KUTkgRX4Q0IrCtohAqkcTLR2
         GRwg==
X-Gm-Message-State: AOAM533YLddkod0cpDNQSEoSnE2q6jujCtalBGwZ98C94lmtqrBJC649
        ngy4v2h6mcn4kzZn7IQqBjmCmooRzN8=
X-Google-Smtp-Source: ABdhPJzBW2/mzzQZ/LvQtsjaLamj0aJ+auV499cVYjkbU9aQ1NI+804k0GGrCHHDElGWR1kRyNoXdA==
X-Received: by 2002:a37:48cc:: with SMTP id v195mr4519651qka.232.1592495839225;
        Thu, 18 Jun 2020 08:57:19 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o6sm3375570qkh.28.2020.06.18.08.57.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:57:18 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (June 18th, 2020)
Message-ID: <bb8ce425-a889-d0af-7a4e-6cf681a62e97@gmail.com>
Date:   Thu, 18 Jun 2020 11:57:17 -0400
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

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-06-18-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-06-18.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-06-18.htm

---

pu	5add94c2cd5315d7070b716bcd83c89812ea7689
jch	0df66f1da183e4f5064a831b3ea8a289621475ec
next	f2d1464379e7567b01b55fbf8432e75d72aa537f
master	101b3204f37606972b40fc17dec84560c22f69f6
master@{1}	56219baf1eae50134ee05eaa64e26e7f1207042c


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Abhishek Kumar	4844812b commit-graph: introduce commit_graph_data_slab
commit-graph.c
4844812b 1356) data->generation = GENERATION_NUMBER_MAX;

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
8b85ee4f 1168) exit(128);

brian m. carlson	90463f5d remote-curl: detect algorithm for dumb HTTP by size
remote-curl.c
90463f5d 264) return NULL;

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

brian m. carlson	22b74805 bundle: detect hash algorithm when reading refs
bundle.c
22b74805 33) return NULL;
22b74805 70) status = -1;
22b74805 71) break;

brian m. carlson	88a09a55 builtin/show-index: provide options to determine hash algo
builtin/show-index.c
88a09a55 29) hash_algo = hash_algo_by_name(hash_name);
88a09a55 30) if (hash_algo == GIT_HASH_UNKNOWN)
88a09a55 32) repo_set_hash_algo(the_repository, hash_algo);

Damien Robert	812a5889 remote.c: fix handling of %(push:remoteref)
remote.c
812a5889 1639) return NULL;
812a5889 1646) return branch->refname;
812a5889 1661) return NULL;
812a5889 1775) return NULL;

Emily Shaffer	933f1b2e hook: add list command
builtin/hook.c
933f1b2e 42) printf(_("no commands configured for hook '%s'\n"),
933f1b2e 44) return 0;

hook.c
933f1b2e 83) return NULL;

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

Jiang Xin	2dd1150a receive-pack: new config receive.procReceiveRefs
builtin/receive-pack.c
2dd1150a 239) return config_error_nonbool(var);
2dd1150a 1839) continue;

Johannes Schindelin	212055a4 send-pack/transport-helper: respect `core.defaultBranchName`
send-pack.c
212055a4 473) char *branch_name = git_default_branch_name(1);
212055a4 478) free(branch_name);

transport-helper.c
212055a4 1102) char *branch_name = git_default_branch_name(1);
212055a4 1108) free(branch_name);

Matheus Tavares	e26e8bfc grep: honor sparse checkout patterns
builtin/grep.c
e26e8bfc 579) if (file_exists(sparse_file)) {
e26e8bfc 583) free(sparse_file);
e26e8bfc 584) free(patterns);
e26e8bfc 585) return NULL;

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

Matheus Tavares	a2371e32 t/helper/test-config: facilitate addition of new cli options
t/helper/test-config.c
a2371e32 103) goto print_usage_error;
a2371e32 160) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 167) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 175) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 205) printf("Value not found for \"%s\"\n", argv[1]);
a2371e32 232) printf("Value not found for \"%s\"\n", argv[1]);

Miriam Rubio	9aadf776 bisect--helper: introduce new `write_in_file()` function
builtin/bisect--helper.c
9aadf776 91) return error_errno(_("cannot open file '%s' in mode '%s'"), path, mode);
9aadf776 96) fclose(fp);
9aadf776 97) return error_errno(_("could not write to file '%s'"), path);

Phillip Wood	1a443767 rebase -i: support --ignore-date
sequencer.c
1a443767 893) return NULL;
1a443767 1476) res = -1;
1a443767 1477) goto out;

Phillip Wood	ee9800cd rebase -i: support --committer-date-is-author-date
sequencer.c
ee9800cd 1396) goto out;
ee9800cd 1400) goto out;

Pranit Bauva	10520dbf bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
builtin/bisect--helper.c
10520dbf 874) return BISECT_FAILED;
10520dbf 890) oid_array_clear(&revs);
10520dbf 891) return BISECT_FAILED;

Pranit Bauva	f0bf9482 bisect--helper: finish porting `bisect_start()` to C
builtin/bisect--helper.c
f0bf9482 735) return BISECT_FAILED;
f0bf9482 756) res = BISECT_FAILED;
f0bf9482 768) res = BISECT_FAILED;
f0bf9482 780) res = BISECT_FAILED;

Pranit Bauva	587c9fac bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
builtin/bisect--helper.c
587c9fac 493) return error_errno(_("failed to write to '%s'"), git_path_bisect_log());
587c9fac 522) return error_errno(_("could not open '%s' for appending"),

Pranit Bauva	05a69202 bisect--helper: reimplement `bisect_autostart` shell function in C
builtin/bisect--helper.c
05a69202 823) fprintf(stderr, _("You need to start by \"git bisect "
05a69202 826) if (!isatty(STDIN_FILENO))
05a69202 827) return 1;
05a69202 834) yesno = git_prompt(_("Do you want me to do it for you "
05a69202 836) if (starts_with(yesno, _("n")) || starts_with(yesno, _("N")))
05a69202 837) return 1;
05a69202 839) return bisect_start(terms, 0, NULL, 0);

Shawn O. Pearce	38a81b4e receive-pack: Wrap status reports inside side-band-64k
builtin/receive-pack.c
38a81b4e 2283) send_sideband(1, 1, buf.buf, buf.len, use_sideband);

SZEDER Gábor	de726f5c commit-graph: simplify chunk writes into loop
commit-graph.c
de726f5c 1754) return -1;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Jonathan Tan	9da69a65 fetch-pack: support more than one pack lockfile
builtin/fetch-pack.c
9da69a65 246) pack_lockfiles.items[i].string);

Jonathan Tan	8e6adb69 http-fetch: refactor into function
http-fetch.c
8e6adb69 30) walker_targets_free(commits, commit_id, write_ref);
8e6adb69 33) fprintf(stderr,

Jonathan Tan	8d5d2a34 http-fetch: support fetching packfiles by URL
http-fetch.c
8d5d2a34 128) commits = walker_targets_stdin(&commit_id, &write_ref);

Jonathan Tan	acaaca7d upload-pack: refactor reading of pack-objects out
upload-pack.c
acaaca7d 210) return readsz;
acaaca7d 438) send_client_data(1, output_state.buffer, output_state.used,

Jonathan Tan	dd4b732d upload-pack: send part of packfile response as uri
upload-pack.c
dd4b732d 1411) string_list_clear(&data->uri_protocols, 0);



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
Chris Torek	8bfcb3a6 git diff: improve range handling
builtin/diff.c
8bfcb3a6 329) usage(builtin_diff_usage);

Christian Couder	f8edd1ca upload-pack: move use_sideband to upload_pack_data
upload-pack.c
f8edd1ca 381) send_client_data(1, data, 1,
f8edd1ca 982) data->use_sideband = DEFAULT_PACKET_MAX;

Christian Couder	e9d882b8 upload-pack: change multi_ack to an enum
upload-pack.c
e9d882b8 972) data->multi_ack = MULTI_ACK;

Christian Couder	f203a88c upload-pack: move keepalive to upload_pack_data
upload-pack.c
f203a88c 1135) data->keepalive = git_config_int(var, value);
f203a88c 1136) if (!data->keepalive)
f203a88c 1137) data->keepalive = -1;

Christian Couder	e3835cd4 upload-pack: move allow_sideband_all to upload_pack_data
upload-pack.c
e3835cd4 1143) data->allow_sideband_all = git_config_bool(var, value);
e3835cd4 1338)      data->allow_sideband_all) &&

Eric Sunshine	c9b77f2c worktree: factor out repeated string literal
builtin/worktree.c
c9b77f2c 105) strbuf_addf(reason, _("unable to read gitdir file (%s)"),

Eric Sunshine	916133ef worktree: prune linked worktree referencing main worktree path
builtin/worktree.c
916133ef 166) return -1;

Jeff King	b5a2068c upload-pack: actually use some upload_pack_data bitfields
upload-pack.c
b5a2068c 1019) data->no_progress = 1;



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Carlo Marcelo Arenas Belón	aba8187e t/helper: teach test-regex to report pattern errors (like REG_ILLSEQ)
t/helper/test-regex.c
aba8187e 53) goto usage;
aba8187e 59) goto usage;
aba8187e 67) goto usage;
aba8187e 90) if (silent)
aba8187e 91) return ret;
aba8187e 101) if (silent || ret == REG_NOMATCH)
aba8187e 102) return ret;

Denton Liu	0181b600 pkt-line: define PACKET_READ_RESPONSE_END
pkt-line.c
0181b600 106) die_errno(_("unable to write stateless separator packet"));

t/helper/test-pkt-line.c
0181b600 50) printf("0002\n");
0181b600 51) break;

Derrick Stolee	f32dde8c line-log: integrate with changed-path Bloom filters
line-log.c
f32dde8c 1159) return 1;
f32dde8c 1166) return 0;

Jonathan Nieder	3697caf4 config: let feature.experimental imply protocol.version=2
protocol.c
3697caf4 35) return protocol_v2;


