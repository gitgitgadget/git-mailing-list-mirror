Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1ABC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E51D20748
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMBm/2QV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgGJCM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGJCM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 22:12:28 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500C2C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 19:12:28 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id m9so1927180qvx.5
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UyYyej/RuPbQ4Az+iOD1U2N5xeY5+qyPgquY8hNRwzg=;
        b=ZMBm/2QVbUmOvA7luDqvAuc6hnQpbC1ib9As6eEj/ORXXyFFOoj8oLWP1biYRs5C7T
         rybpkJjOW21SBA4Ww6xitwnBsuZunchWQuYBYsmatwzJ9ospEB4DNkGITId33X9SILJZ
         NxmUuF+7v+RjNRv1kU/RylOz2+BY0lvBSbwT/dgqYqm8xOwyZykraGM1Epoy+s51JFSC
         JQSGINFka4QLsFrMH2bRsHpTSBOspdZjifIMRxPKZPnHBPF9FuxOPVmmqVAlPGUc/S6O
         RXIyYMU0LH2uUu9yG6hUe+Xbek5aoC8EjEXMt19Kaa020FIqjFcAgK7bAxTYz+NndMHK
         AFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UyYyej/RuPbQ4Az+iOD1U2N5xeY5+qyPgquY8hNRwzg=;
        b=m/TXY1uALgK2ABW/64U//apjUAGKSlVdyTJy6O+CmYBgcMPV49V7jNqsnqjHVHGj93
         U8MM3pCR/zxVX9DKLVii4Vjp8ZmEWP1oxSaonU4P9PjvuM3EB+kueCysmmVqBqEcmV6J
         nzlL64i0uWWOtUGh5pia8qiqxtVKtWooiHwTJPCBk8qTjZgTl1H10gQtW/SD9xqXtDd9
         J3cazBfyIirgZ+9D4f8gYhiEz6yl1SEkDlfzBnJHCJFJNl2XB7Z3DIVkvWMLqAjAdWQS
         HAdBKWAKQexTv7ARtDagq6b6bjwICMvFQktBYNdn5SBgtlgdTRMNwqlVjJ1sjTk8sumQ
         1Csw==
X-Gm-Message-State: AOAM531oFRaqCiClEtu7db7VdESn3u4bKGfdTKrzv+WeFglm1yqSIX8l
        CBR6GwkCOUwtUq3Q4OyYmmLDUCCsgcg=
X-Google-Smtp-Source: ABdhPJyJn9wMP0VpzduZJWqtEdtBgI28CWWPZ2CIkzAjjVOJuKzcFWxY7m3UF2bm+StEG8pWkuP0mA==
X-Received: by 2002:a05:6214:88e:: with SMTP id cz14mr65630275qvb.72.1594347146669;
        Thu, 09 Jul 2020 19:12:26 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p25sm5756222qki.107.2020.07.09.19.12.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 19:12:26 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (v2.28.0-rc0)
Message-ID: <fcc3f6da-2b6a-239d-c865-64378ba31510@gmail.com>
Date:   Thu, 9 Jul 2020 22:12:26 -0400
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

Here is the test coverage report for code in v2.28.0-rc0 that was not in v2.27.0.

Thanks,
-Stolee

---


Uncovered code in 'v2.28.0-rc0' not in 'v2.27.0'
--------------------------------------------------------

Commits introducing uncovered code:
Abhishek Kumar	4844812b commit-graph: introduce commit_graph_data_slab
commit-graph.c
4844812b 1350) data->generation = GENERATION_NUMBER_MAX;

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

brian m. carlson	6161ce7b bundle: detect hash algorithm when reading refs
bundle.c
6161ce7b 33) return NULL;
6161ce7b 70) status = -1;
6161ce7b 71) break;

brian m. carlson	14570dc6 wrapper: add function to compare strings with different NUL termination
wrapper.c
14570dc6 112) return res;

brian m. carlson	88a09a55 builtin/show-index: provide options to determine hash algo
builtin/show-index.c
88a09a55 29) hash_algo = hash_algo_by_name(hash_name);
88a09a55 30) if (hash_algo == GIT_HASH_UNKNOWN)
88a09a55 32) repo_set_hash_algo(the_repository, hash_algo);

brian m. carlson	8b85ee4f transport-helper: implement object-format extensions
transport-helper.c
8b85ee4f 1113) exit(128);

brian m. carlson	bb095d08 builtin/receive-pack: detect when the server doesn't support our hash
builtin/receive-pack.c
bb095d08 1644) hash = hash_algos[GIT_HASH_SHA1].name;
bb095d08 1645) len = strlen(hash);

Carlo Marcelo Arenas Belón	aba8187e t/helper: teach test-regex to report pattern errors (like REG_ILLSEQ)
t/helper/test-regex.c
aba8187e 53) goto usage;
aba8187e 59) goto usage;
aba8187e 61) if (!strcmp(*argv, "--silent")) {
aba8187e 62) silent = 1;
aba8187e 64) argc--;
aba8187e 66) if (!argc)
aba8187e 67) goto usage;
aba8187e 69) pat = *argv++;
aba8187e 70) if (argc == 1)
aba8187e 71) str = NULL;
aba8187e 73) str = *argv++;
aba8187e 74) while (*argv) {
aba8187e 76) for (rf = reg_flags; rf->name; rf++)
aba8187e 77) if (!strcmp(*argv, rf->name)) {
aba8187e 78) flags |= rf->flag;
aba8187e 79) break;
aba8187e 81) if (!rf->name)
aba8187e 83) argv++;
aba8187e 88) ret = regcomp(&r, pat, flags);
aba8187e 89) if (ret) {
aba8187e 90) if (silent)
aba8187e 91) return ret;
aba8187e 96) if (!str)
aba8187e 97) return 0;
aba8187e 99) ret = regexec(&r, str, 1, m, 0);
aba8187e 100) if (ret) {
aba8187e 101) if (silent || ret == REG_NOMATCH)
aba8187e 102) return ret;

Chris Torek	8bfcb3a6 git diff: improve range handling
builtin/diff.c
8bfcb3a6 329) usage(builtin_diff_usage);

Christian Couder	f203a88c upload-pack: move keepalive to upload_pack_data
upload-pack.c
f203a88c 1193) data->keepalive = git_config_int(var, value);
f203a88c 1194) if (!data->keepalive)
f203a88c 1195) data->keepalive = -1;

Christian Couder	e9d882b8 upload-pack: change multi_ack to an enum
upload-pack.c
e9d882b8 1029) data->multi_ack = MULTI_ACK;

Christian Couder	f8edd1ca upload-pack: move use_sideband to upload_pack_data
upload-pack.c
f8edd1ca 1039) data->use_sideband = DEFAULT_PACKET_MAX;

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

Elijah Newren	051df3cf wt-status: show sparse checkout status as well
wt-status.c
051df3cf 1491) return;

Eric Sunshine	916133ef worktree: prune linked worktree referencing main worktree path
builtin/worktree.c
916133ef 166) return -1;

Eric Sunshine	c9b77f2c worktree: factor out repeated string literal
builtin/worktree.c
c9b77f2c 105) strbuf_addf(reason, _("unable to read gitdir file (%s)"),

Jeff King	b5a2068c upload-pack: actually use some upload_pack_data bitfields
upload-pack.c
b5a2068c 1076) data->no_progress = 1;

Jeff King	65b5d9fa fast-export: allow seeding the anonymized mapping
builtin/fast-export.c
65b5d9fa 177) ret = NULL;

Jeff King	750bb325 fast-export: store anonymized oids as hex strings
builtin/fast-export.c
750bb325 731)        anonymize_oid(oid_to_hex(&obj->oid)) :

Jeff King	a0f65641 fast-export: stop storing lengths in anonymized hashmaps
builtin/fast-export.c
a0f65641 149) b = container_of(entry_or_key, const struct anonymized_entry, hash);
a0f65641 150) return strcmp(a->orig, b->orig);

Jonathan Nieder	b5651a20 experimental: default to fetch.writeCommitGraph=false
repo-settings.c
b5651a20 60) UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);

Jonathan Nieder	3697caf4 config: let feature.experimental imply protocol.version=2
protocol.c
3697caf4 35) return protocol_v2;

Jonathan Tan	dd4b732d upload-pack: send part of packfile response as uri
upload-pack.c
dd4b732d 1412) string_list_clear(&data->uri_protocols, 0);

Jonathan Tan	8d5d2a34 http-fetch: support fetching packfiles by URL
http-fetch.c
8d5d2a34 128) commits = walker_targets_stdin(&commit_id, &write_ref);

Jonathan Tan	9da69a65 fetch-pack: support more than one pack lockfile
builtin/fetch-pack.c
9da69a65 246) pack_lockfiles.items[i].string);

Jonathan Tan	acaaca7d upload-pack: refactor reading of pack-objects out
upload-pack.c
acaaca7d 210) return readsz;
acaaca7d 438) send_client_data(1, output_state.buffer, output_state.used,

Jonathan Tan	8e6adb69 http-fetch: refactor into function
http-fetch.c
8e6adb69 30) walker_targets_free(commits, commit_id, write_ref);
8e6adb69 33) fprintf(stderr,

Patrick Steinhardt	67541597 refs: implement reference transaction hook
refs.c
67541597 2047) return ret;
67541597 2061) if (errno != EPIPE)
67541597 2062) ret = -1;
67541597 2063) break;

Randall S. Becker	f64b6a1f bugreport.c: replace strbuf_write_fd with write_in_full
bugreport.c
f64b6a1f 184) die_errno(_("unable to write to %s"), report_path.buf);


