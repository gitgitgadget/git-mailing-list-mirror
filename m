Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3021BC433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 15:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029C7207D5
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 15:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwC/p77v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgFAPq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 11:46:25 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BD3C05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 08:46:24 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id f95so4924752otf.7
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kV1lhxc6AM/RsK6L/BiSQTE5hSTtnVmaqk5JkvJr/Hw=;
        b=NwC/p77vBJmMGSa9xkqLnJDQJc2CwO/4evm1vecv2ZKtXfj1PLgKUV6MII/gzzmTBK
         22on8WxtPU3hzZ2aprQLk1pbrZ1mHOqgIX7fBAfSMIYwEb8UPdqdimyDK9ccqYXP32sM
         G5dZr1vfh1H/AmZc+9MXRDF4fKoY/FeCuhBskyEhhUSnm1iw5g+RooUyU74JqsTZGw3+
         bLMk0SB98GP8FGg51j1euM8gVXljghIZUXk7ZCGXoU946AyrRXeeXoseVebB6pe81c7Y
         BUdVQy6FXj9OvObGvqnBDVvxup5po+nzbz/2Y9TwG26J/gbyvuxlOTeBBRuqibKdqj5U
         XH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kV1lhxc6AM/RsK6L/BiSQTE5hSTtnVmaqk5JkvJr/Hw=;
        b=TyOmaWeLme/1HyQArqXAmz7+WIJvU/nk3hf+vCtkPXCq+XbDE9FwQkNywSeYdFZ/YO
         d9UH/A3WeNfHElsCHlt24UL3/DmbnhmBrWgpy1yFi+kt1NpGcf48tExgQENosyNyL60V
         ZqkyHUUXbNWhD9nf9vU1s5k+6T2QSXEa2700gxN0OF8MObwky8D6ahJOBWqFQD1i353D
         yjFt3qLbEWZQ1jxh5or10BsfWA3kPKLny1fyTpsUCfmJMn8RJXFNSFs6N+nsx8sLYdyY
         +H2t0r/193Jq2y9ZZOfxF1QtRNfMutInio+H2r8kKr2Ui0TYAxM8e3o8nZOi1njjZ387
         oqJg==
X-Gm-Message-State: AOAM53142EOINvWzEn47USwKyXbN8aAQobgAHXg4A7vHulH8OmqZRmR9
        M56QyZak+g3lyvc+1IiVRLZ8Rn9rrgo=
X-Google-Smtp-Source: ABdhPJzVv3XiuxBKAVjIkGnXL5jFOYCMCebQLaaqmpLqdOkIlM4kLmDYwwGMStp99+4dEj09XOW8xA==
X-Received: by 2002:a9d:664e:: with SMTP id q14mr4737795otm.49.1591026383352;
        Mon, 01 Jun 2020 08:46:23 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p13sm128755otp.58.2020.06.01.08.46.22
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 08:46:22 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (June 1, 2020)
Message-ID: <a2ec90be-8559-b83d-de76-5e742c452378@gmail.com>
Date:   Mon, 1 Jun 2020 11:46:22 -0400
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

Here is today's test coverage report.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-06-01-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-06-01.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-06-01.htm

---

pu	d59a0e9b1b80cfd37c826aaa99c3a6a47779444e
jch	7940aedf218f360084cb616d530c7c00c2653792
next	5238fbb8ea3e0d9159ed431f9042d31285ea2d15
master	56219baf1eae50134ee05eaa64e26e7f1207042c
master@{1}	efcab5b7a3d2ce2ae4bf808b335938098b18d960


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
brian m. carlson	4b831208 fetch-pack: parse and advertise the object-format capability
fetch-pack.c
4b831208 1202)     the_hash_algo->name, hash_name);
4b831208 1204) } else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
4b831208 1206)     the_hash_algo->name);

brian m. carlson	14570dc6 wrapper: add function to compare strings with different NUL termination
wrapper.c
14570dc6 112) return res;

brian m. carlson	8b85ee4f transport-helper: implement object-format extensions
transport-helper.c
8b85ee4f 1163) exit(128);

brian m. carlson	90463f5d remote-curl: detect algorithm for dumb HTTP by size
remote-curl.c
90463f5d 264) return NULL;

brian m. carlson	7f605017 remote-curl: implement object-format extensions
remote-curl.c
7f605017 199) algo = hash_algo_by_name(value);
7f605017 200) if (algo == GIT_HASH_UNKNOWN)
7f605017 202) options.hash_algo = &hash_algos[algo];

brian m. carlson	122037c2 connect: add function to detect supported v1 hash functions
connect.c
122037c2 566) hash = hash_algos[GIT_HASH_SHA1].name;
122037c2 567) len = strlen(hash);
122037c2 573) hash = next_server_feature_value("object-format", &len, &offset);

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

Christian Couder	20a359ef upload-pack: move allow_sideband_all to upload_pack_data
upload-pack.c
20a359ef 1148) data->allow_sideband_all = git_config_bool(var, value);
20a359ef 1343)      data->allow_sideband_all) &&

Christian Couder	198bf8ec upload-pack: move keepalive to upload_pack_data
upload-pack.c
198bf8ec 1140) data->keepalive = git_config_int(var, value);
198bf8ec 1141) if (!data->keepalive)
198bf8ec 1142) data->keepalive = -1;

Christian Couder	e17afe0e upload-pack: change multi_ack to an enum
upload-pack.c
e17afe0e 969) data->multi_ack = multi_ack;

Christian Couder	1789fbb7 upload-pack: move use_sideband to upload_pack_data
upload-pack.c
1789fbb7 371) send_client_data(1, data, 1,
1789fbb7 979) data->use_sideband = DEFAULT_PACKET_MAX;

Damien Robert	812a5889 remote.c: fix handling of %(push:remoteref)
remote.c
812a5889 1638) return NULL;
812a5889 1645) return branch->refname;
812a5889 1660) return NULL;
812a5889 1774) return NULL;

Jeff King	6c47e1f1 upload-pack: actually use some upload_pack_data bitfields
upload-pack.c
6c47e1f1 1016) data->no_progress = 1;

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
5e4553bd 836) hint = NULL;
5e4553bd 855) (*ref)->report.message = msg;

Matheus Tavares	40d6c71c grep: honor sparse checkout patterns
builtin/grep.c
40d6c71c 579) if (file_exists(sparse_file)) {
40d6c71c 583) free(sparse_file);
40d6c71c 584) free(patterns);
40d6c71c 585) return NULL;

Matheus Tavares	f87a6d5c config: correctly read worktree configs in submodules
t/helper/test-config.c
f87a6d5c 103) goto print_usage_error;
f87a6d5c 109) goto print_usage_error;
f87a6d5c 114) fprintf(stderr, "Cannot use --submodule with read_early_config\n");
f87a6d5c 115) return TC_USAGE_ERROR;
f87a6d5c 130) fprintf(stderr, "Invalid argument to --submodule: '%s'\n",
f87a6d5c 132) free(subrepo);
f87a6d5c 133) ret = TC_USAGE_ERROR;
f87a6d5c 134) goto out;
f87a6d5c 160) printf("Value not found for \"%s\"\n", argv[1]);
f87a6d5c 167) printf("Value not found for \"%s\"\n", argv[1]);
f87a6d5c 175) printf("Value not found for \"%s\"\n", argv[1]);
f87a6d5c 187) fprintf(stderr, "Cannot use --submodule with configset_get_value\n");
f87a6d5c 188) ret = TC_USAGE_ERROR;
f87a6d5c 189) goto out;
f87a6d5c 205) printf("Value not found for \"%s\"\n", argv[1]);
f87a6d5c 210) fprintf(stderr, "Cannot use --submodule with configset_get_value_multi\n");
f87a6d5c 211) ret = TC_USAGE_ERROR;
f87a6d5c 212) goto out;
f87a6d5c 232) printf("Value not found for \"%s\"\n", argv[1]);
f87a6d5c 239) fprintf(stderr, "Invalid syntax. Usage: test-tool config"

Matheus Tavares	d86a4b75 t/helper/test-config: return exit codes consistently
t/helper/test-config.c
d86a4b75 161) ret = TC_VALUE_NOT_FOUND;
d86a4b75 168) ret = TC_VALUE_NOT_FOUND;
d86a4b75 176) ret = TC_VALUE_NOT_FOUND;
d86a4b75 206) ret = TC_VALUE_NOT_FOUND;
d86a4b75 218) ret = TC_CONFIG_FILE_ERROR;
d86a4b75 219) goto out;
d86a4b75 233) ret = TC_VALUE_NOT_FOUND;
d86a4b75 241) ret = TC_USAGE_ERROR;

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

Pranit Bauva	05a69202 bisect--helper: reimplement `bisect_autostart` shell function in C
builtin/bisect--helper.c
05a69202 823) fprintf(stderr, _("You need to start by \"git bisect "
05a69202 826) if (!isatty(STDIN_FILENO))
05a69202 827) return 1;
05a69202 834) yesno = git_prompt(_("Do you want me to do it for you "
05a69202 836) if (starts_with(yesno, _("n")) || starts_with(yesno, _("N")))
05a69202 837) return 1;
05a69202 839) return bisect_start(terms, 0, NULL, 0);

Pranit Bauva	10520dbf bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
builtin/bisect--helper.c
10520dbf 874) return BISECT_FAILED;
10520dbf 890) oid_array_clear(&revs);
10520dbf 891) return BISECT_FAILED;

Pranit Bauva	587c9fac bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
builtin/bisect--helper.c
587c9fac 493) return error_errno(_("failed to write to '%s'"), git_path_bisect_log());
587c9fac 522) return error_errno(_("could not open '%s' for appending"),

Pranit Bauva	f0bf9482 bisect--helper: finish porting `bisect_start()` to C
builtin/bisect--helper.c
f0bf9482 735) return BISECT_FAILED;
f0bf9482 756) res = BISECT_FAILED;
f0bf9482 768) res = BISECT_FAILED;
f0bf9482 780) res = BISECT_FAILED;

Shawn O. Pearce	38a81b4e receive-pack: Wrap status reports inside side-band-64k
builtin/receive-pack.c
38a81b4e 2283) send_sideband(1, 1, buf.buf, buf.len, use_sideband);



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:


Uncovered code in 'next' not in 'master'
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

Taylor Blau	5b6653e5 builtin/commit-graph.c: dereference tags in builtin
builtin/commit-graph.c
5b6653e5 244) progress = start_delayed_progress(
5b6653e5 268) stop_progress(&progress);



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:

