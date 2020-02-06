Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D9C2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334AA217BA
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 13:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sU9ve2Zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgBFNrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:47:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43801 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBFNrC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 08:47:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id j20so5530538qka.10
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Dk9dr7CXGrkO9r6jOYcES+4vulBS4lxSyitvp09AbNk=;
        b=sU9ve2ZhMv+V0B6xwA8CXor+wcMVOfLSOIYQzFCjno8MSTlxGGmD9VHnWVdlZPGJrG
         fbCMRwdwU14WL+AKI67kZGvXl0XM1b+0tKcXBaPbgqRXM381WOSrvn/LVSwhjOddFeJT
         Fr5DYjvrFf5sa1DS0et/rRwDWQ7par/rPbNSRXOiDV/Z6+B+nFAnQz72zmQu/tSRbMNT
         uVfnJRyGKezFiXvFNyMgQehvcChMt5Co1GGcTDUuijEiXeo26vkQndtCoI2BnX/ko7M5
         tvijUWZxEqbMk0MG9G9clHVHufU7/zVG7BABOWt2obqIVkK2I6kHRVk0LX8z+i9b6yd5
         pj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Dk9dr7CXGrkO9r6jOYcES+4vulBS4lxSyitvp09AbNk=;
        b=THWhcIg4TFW7lcOHACrP5g68LSDDa5Otddr4qkTIatgqao39/5t0u/TUih84JyynY+
         9o8fw0hDGVi7TjZfmmx645yqza8L26+XL/ykzLO7wVvvYHKqF7sIdQzS8VvqhsdNbQxJ
         h2PHcvv4xeuDt5wLh4j4eEk0v2gus4wemN6mfK7axpX7oE2Vh0VUp3v1AdzC/LtnM4mP
         lvxojrF6Eqv1xHokWnifK//zzcDBKvMibZORA/gr7DD6un4g5AmAVBbpyNh1d77PtowD
         uetbzdh4PK3Rrtd2EIIBVl3tsCu0KccLi8YpmSPBHz8bbI5kgq5MjXqnJacLr7qNM0xo
         02uQ==
X-Gm-Message-State: APjAAAUfplZ+U2cyiASV2QC1yvczKNAdoIw7KMlI+La19FM1tsfOKARM
        RR776+5AEcD8gtKNoQGgp+ORCsTj6kA=
X-Google-Smtp-Source: APXvYqx2IBrZ0S/7/OB8MzHFCR8X3eEerCq3VJkkmgCSWgwS9FNZp4i82Z1Hev5cwRC0tgmk85Qryw==
X-Received: by 2002:a05:620a:4d2:: with SMTP id 18mr2700586qks.368.1580996820511;
        Thu, 06 Feb 2020 05:47:00 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c9b5:7cd5:1ee4:5066? ([2001:4898:a800:1012:7ae9:7cd5:1ee4:5066])
        by smtp.gmail.com with ESMTPSA id r37sm1638842qtj.44.2020.02.06.05.46.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 05:46:59 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Feb. 6)
Message-ID: <aed4861a-35f5-8209-942f-eba25b0a30dc@gmail.com>
Date:   Thu, 6 Feb 2020 08:46:59 -0500
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

Note that the 'pu' branch has a broken build, so the tests did not create gcov
files on which to base the report.

Impressively, the 'next' versus 'master' build did pass all tests, and still
all new code is covered. Excellent!

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-02-06-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-02-06.htm
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-02-06.txt


---

pu	d0ed4d6799b625ee919fd3f67184f372acec9a9c
jch	7310a282c0dfc9aeb35993a60e43878295777eb9
next	bab2e86ba084f1fa0dcbedeeaeed31da013036bb
master	de93cc14ab7e8db7645d8dbe4fd2603f76d5851f
master@{1}	232378479ee6c66206d47a9be175e3a39682aea6


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Alex Torok	fed842f0 rebase: fix --fork-point with short refname
builtin/merge-base.c
fed842f0 128) return 1;

Elijah Newren	8ef6c12e rebase (interactive-backend): make --keep-empty the default
sequencer.c
8ef6c12e 1527) return originally_empty;

Elijah Newren	81f5bc1c rebase, sequencer: remove the broken GIT_QUIET handling
builtin/rebase.c
81f5bc1c 706) write_file(state_dir_path("quiet", opts), "%s", "");

Elijah Newren	91e0ed22 rebase (interactive-backend): fix handling of commits that become empty
sequencer.c
91e0ed22 2519) opts->keep_redundant_commits = 1;

Jeff King	bb514de3 pack-objects: improve partial packfile reuse
pack-bitmap.c
bb514de3 808) return;
bb514de3 811) return;
bb514de3 823) return;
bb514de3 861) i = bitmap_git->pack->num_objects / BITS_IN_EWORD;

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

Martin Ågren	3bcdd852 builtin/config: extract `handle_value_regex()` from `get_value()`
builtin/config.c
3bcdd852 346) return CONFIG_INVALID_PATTERN;
3bcdd852 391) goto free_strings;

Martin Ågren	3bf986d6 builtin/config: collect "value_regexp" data in a struct
builtin/config.c
3bf986d6 345) FREE_AND_NULL(cmd_line_value.regexp);

Matheus Tavares	c8123e72 streaming: allow open_istream() to handle any repo
streaming.c
c8123e72 154) if (open_istream_incore(st, r, &oi, real, type)) {

Matthew Rogers	3c25ad75 config: add '--show-scope' to print the scope of a config value
builtin/config.c
3c25ad75 712) given_config_source.scope = CONFIG_SCOPE_SYSTEM;

config.c
3c25ad75 3310) return "system";
3c25ad75 3316) return "worktree";
3c25ad75 3320) return "submodule";
3c25ad75 3322) return "unknown";

René Scharfe	2d539754 name-rev: release unused name strings
builtin/name-rev.c
2d539754 102) free(name->tip_name);



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
brian m. carlson	63ab08fb run-command: avoid undefined behavior in exists_in_PATH
run-command.c
63ab08fb 216) int found = r != NULL;
63ab08fb 218) return found;

Hans Jerry Illikainen	54887b46 gpg-interface: add minTrustLevel as a configuration option
builtin/pull.c
54887b46 374) return status;

gpg-interface.c
54887b46 143) return 1;
54887b46 207) free(trust);
54887b46 208) goto error;
54887b46 397) return config_error_nonbool(var);

pretty.c
54887b46 1355) strbuf_addstr(sb, "never");
54887b46 1356) break;
54887b46 1358) strbuf_addstr(sb, "marginal");
54887b46 1359) break;
54887b46 1361) strbuf_addstr(sb, "fully");
54887b46 1362) break;

Johannes Schindelin	180f48df built-in add -p: support interactive.diffFilter
add-patch.c
180f48df 557) else if (p != pend)
180f48df 559) goto mismatched_output;
180f48df 590) return -1;

Johannes Schindelin	04f816b1 built-in add -p: respect the `interactive.singlekey` config setting
add-patch.c
04f816b1 1156) int res = read_key_without_echo(&s->answer);
04f816b1 1157) printf("%s\n", res == EOF ? "" : s->answer.buf);
04f816b1 1158) return res;

Johannes Schindelin	52628f94 built-in add -p: implement the "checkout" patch modes
add-patch.c
52628f94 1272) fwrite(diff->buf, diff->len, 1, stderr);

Johannes Schindelin	d2a233cb built-in add -p: prepare for patch modes other than "stage"
add-patch.c
d2a233cb 1567)       _(s->mode->help_patch_text));

Johannes Schindelin	90a6bb98 legacy stash -p: respect the add.interactive.usebuiltin setting
builtin/add.c
90a6bb98 450) parse_pathspec(&pathspec, 0,
90a6bb98 456) return run_add_interactive(NULL, "--patch=stash", &pathspec);

Johannes Schindelin	6610e462 built-in stash: use the built-in `git add -p` if so configured
builtin/stash.c
6610e462 1026) setenv(INDEX_ENVIRONMENT, old_index_env, 1);

Johannes Schindelin	94ac3c31 terminal: make the code of disable_echo() reusable
compat/terminal.c
94ac3c31 38) static int disable_bits(tcflag_t bits)
94ac3c31 49) t.c_lflag &= ~bits;
94ac3c31 59) static int disable_echo(void)
94ac3c31 61) return disable_bits(ECHO);

Johannes Schindelin	a5e46e6b terminal: add a new function to read a single keystroke
compat/terminal.c
a5e46e6b 64) static int enable_non_canonical(void)
a5e46e6b 66) return disable_bits(ICANON | ECHO);
a5e46e6b 307) int read_key_without_echo(struct strbuf *buf)
a5e46e6b 312) if (warning_displayed || enable_non_canonical() < 0) {
a5e46e6b 313) if (!warning_displayed) {
a5e46e6b 316) warning_displayed = 1;
a5e46e6b 319) return strbuf_getline(buf, stdin);
a5e46e6b 322) strbuf_reset(buf);
a5e46e6b 323) ch = getchar();
a5e46e6b 324) if (ch == EOF) {
a5e46e6b 325) restore_term();
a5e46e6b 326) return EOF;
a5e46e6b 328) strbuf_addch(buf, ch);
a5e46e6b 358) restore_term();
a5e46e6b 359) return 0;

Johannes Schindelin	12acdf57 built-in add -p: handle Escape sequences more efficiently
compat/terminal.c
12acdf57 255) static int sequence_entry_cmp(const void *hashmap_cmp_fn_data,
12acdf57 260) return strcmp(e1->sequence, keydata ? keydata : e2->sequence);
12acdf57 263) static int is_known_escape_sequence(const char *sequence)
12acdf57 268) if (!initialized) {
12acdf57 269) struct child_process cp = CHILD_PROCESS_INIT;
12acdf57 270) struct strbuf buf = STRBUF_INIT;
12acdf57 273) hashmap_init(&sequences, (hashmap_cmp_fn)sequence_entry_cmp,
12acdf57 276) argv_array_pushl(&cp.args, "infocmp", "-L", "-1", NULL);
12acdf57 277) if (pipe_command(&cp, NULL, 0, &buf, 0, NULL, 0))
12acdf57 278) strbuf_setlen(&buf, 0);
12acdf57 280) for (eol = p = buf.buf; *p; p = eol + 1) {
12acdf57 281) p = strchr(p, '=');
12acdf57 282) if (!p)
12acdf57 283) break;
12acdf57 284) p++;
12acdf57 285) eol = strchrnul(p, '\n');
12acdf57 287) if (starts_with(p, "\\E")) {
12acdf57 288) char *comma = memchr(p, ',', eol - p);
12acdf57 291) p[0] = '^';
12acdf57 292) p[1] = '[';
12acdf57 293) FLEX_ALLOC_MEM(e, sequence, p, comma - p);
12acdf57 294) hashmap_entry_init(&e->entry,
12acdf57 295)    strhash(e->sequence));
12acdf57 296) hashmap_add(&sequences, &e->entry);
12acdf57 298) if (!*eol)
12acdf57 299) break;
12acdf57 301) initialized = 1;
12acdf57 304) return !!hashmap_get_from_hash(&sequences, strhash(sequence), sequence);
12acdf57 345) while (!is_known_escape_sequence(buf->buf)) {

Johannes Schindelin	e118f063 built-in add -p: handle Escape sequences in interactive.singlekey mode
compat/terminal.c
e118f063 330) if (ch == '\033' /* ESC */) {
e118f063 338) strbuf_splice(buf, buf->len - 1, 1, "^[", 2);
e118f063 346) struct pollfd pfd = { .fd = 0, .events = POLLIN };
e118f063 348) if (poll(&pfd, 1, 500) < 1)
e118f063 349) break;
e118f063 351) ch = getchar();
e118f063 352) if (ch == EOF)
e118f063 353) return 0;
e118f063 354) strbuf_addch(buf, ch);

Jonathan Tan	9c8a294a sha1-file: remove OBJECT_INFO_SKIP_CACHED
sha1-file.c
9c8a294a 1442) *(oi->disk_sizep) = 0;
9c8a294a 1444) hashclr(oi->delta_base_sha1);
9c8a294a 1446) strbuf_addstr(oi->type_name, type_name(co->type));

Ralf Thielow	a4ffbbbb submodule.c: mark more strings for translation
submodule.c
a4ffbbbb 1161) fprintf(stderr, _("Unable to push submodule '%s'\n"), path);


