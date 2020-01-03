Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFE1C2D0C2
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0B1215A4
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 18:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMksH6Nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgACStN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:49:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39032 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgACStM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 13:49:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so34510675qko.6
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 10:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=c9LZHgyW3CFkCF+Qb3jYJnRzuHfgwUb5bRzgSErQb5g=;
        b=BMksH6NqI4Tjjk9nUntCCfteHSCZ/vpVk0tq7OIZFKOT/bSo+9kbYpuJRQEtOf5k5R
         SpheDcviRGRnIiV6vzPqKid89nEJiVrgD5eG7cQrCELxsr1jxDAVCdfnSAtAtw2bBx0V
         F4gWJAJpNKg2Gzv/SDzFsiCC50aAwEMa6ccxiABklEdqmYYMjk85j9GyIV93Nj9YOcQ9
         Zr642SWGRYLLutBfn0rTM0TFKa//+miGEkjAuqTvbC+assO+uiDtSUu/ANRandzbNR6M
         FXliUTiBREKEMYPdnUyqsPSC5I18UhtRoyPBKqIuRzSAGsDOxt6t79kHGX7aOSCe87iA
         sJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=c9LZHgyW3CFkCF+Qb3jYJnRzuHfgwUb5bRzgSErQb5g=;
        b=OyWQI0FgTXLTsDfq/9kQzuq6cHel8IAWXue3Dnwqb2hvPP7LRb6ZjnoURSdDhsB2jP
         a+M7puApkSPjuZcOVcSXnuGLzOmCHh7rd7xZKxjW99PQBQOkTvsfJrNF3icLIAoNR6nh
         aIgZ3lDvsGL6d+WQig575/y4AfGh8jAedVQTcpurqu8CZABb5bhDhde4racQ27FikzYU
         IbaxAiq7EP+FuzSkWQKAnYlb59LuC7Zw611sFOCWXAcS1LJj/sggUZ7hoBqzB5A2ql3c
         05txg4p36D+bRm61Y8sFY0hVzP9nWs6ae4buZIKBxYGHXHJx8+04meOLr9NVhG6xFDuY
         Z17w==
X-Gm-Message-State: APjAAAX7JW3TMXZvacASuMnHk5A1DR5v72lqb6bB1jBlw9GbV6fEWUny
        tWQCzI/K3eS6S39Zz+4NL2RqYGfE
X-Google-Smtp-Source: APXvYqz3QueLID0/PHQshSwZfuwn6KrLGhVv9V/VCHvZuVi1eMC7AnY0g7Dy8A+mesi1xvIVK03S6w==
X-Received: by 2002:a37:9ec5:: with SMTP id h188mr74256114qke.435.1578077350925;
        Fri, 03 Jan 2020 10:49:10 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a438:4a34:2dfd:4bc? ([2001:4898:a800:1012:556c:4a34:2dfd:4bc])
        by smtp.gmail.com with ESMTPSA id l25sm16709796qkk.115.2020.01.03.10.49.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 10:49:10 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Jan 3, 2020)
Message-ID: <53f2ed50-1fdc-6e9d-7916-5a09ad340296@gmail.com>
Date:   Fri, 3 Jan 2020 13:49:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report.

It appears that actually enabling the interactive add has actually covered a large
amount of those commits.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-01-03-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-01-03.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-01-03.htm

---

pu	bd265ff036f83d7427ffd08d6b4a93523a9b7b70
jch	09c6e718d25f033b1feb5d8d43d2871536ca70df
next	88dfdc41939891b16a5f8d00053e9c81d6d73f4e
master	8679ef24ed64018bb62170c43ce73e0261c0600a
master@{1}	0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Denton Liu	daf6b9e4 sequencer: use file strbuf for read_oneliner()
sequencer.c
daf6b9e4 439) goto done;
daf6b9e4 445) goto done;

Denton Liu	afc27b82 rebase: use read_oneliner()
builtin/rebase.c
afc27b82 648) } else if (!read_oneliner(&buf, state_dir_path("head", opts), 0, 1))

Denton Liu	d4e8a655 rebase: generify reset_head()
builtin/rebase.c
d4e8a655 904) reset_head(the_repository, &opts->orig_head, "checkout",
d4e8a655 905)    opts->head_name, 0,

Denton Liu	82c638ef rebase: use apply_autostash() from sequencer.c
builtin/rebase.c
82c638ef 1065) apply_autostash(state_dir_path("autostash", opts));

Denton Liu	f2096173 reset: extract reset_head() from rebase
reset.c
f2096173 37) ret = -1;
f2096173 38) goto leave_reset_head;
f2096173 43) goto leave_reset_head;
f2096173 65) goto leave_reset_head;
f2096173 71) goto leave_reset_head;
f2096173 76) goto leave_reset_head;
f2096173 80) ret = -1;
f2096173 81) goto leave_reset_head;
f2096173 89) goto leave_reset_head;
f2096173 108) } else if (old_orig)
f2096173 109) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);

Johannes Schindelin	53fa2153 built-in add -p: handle Escape sequences in interactive.singlekey mode
compat/terminal.c
53fa2153 330) if (ch == '\033' /* ESC */) {
53fa2153 338) strbuf_splice(buf, buf->len - 1, 1, "^[", 2);
53fa2153 346) struct pollfd pfd = { .fd = 0, .events = POLLIN };
53fa2153 348) if (poll(&pfd, 1, 500) < 1)
53fa2153 349) break;
53fa2153 351) ch = getchar();
53fa2153 352) if (ch == EOF)
53fa2153 353) return 0;
53fa2153 354) strbuf_addch(buf, ch);

Johannes Schindelin	61131685 built-in add -p: handle Escape sequences more efficiently
compat/terminal.c
61131685 255) static int sequence_entry_cmp(const void *hashmap_cmp_fn_data,
61131685 260) return strcmp(e1->sequence, keydata ? keydata : e2->sequence);
61131685 263) static int is_known_escape_sequence(const char *sequence)
61131685 268) if (!initialized) {
61131685 269) struct child_process cp = CHILD_PROCESS_INIT;
61131685 270) struct strbuf buf = STRBUF_INIT;
61131685 273) hashmap_init(&sequences, (hashmap_cmp_fn)sequence_entry_cmp,
61131685 276) argv_array_pushl(&cp.args, "infocmp", "-L", "-1", NULL);
61131685 277) if (pipe_command(&cp, NULL, 0, &buf, 0, NULL, 0))
61131685 278) strbuf_setlen(&buf, 0);
61131685 280) for (eol = p = buf.buf; *p; p = eol + 1) {
61131685 281) p = strchr(p, '=');
61131685 282) if (!p)
61131685 283) break;
61131685 284) p++;
61131685 285) eol = strchrnul(p, '\n');
61131685 287) if (starts_with(p, "\\E")) {
61131685 288) char *comma = memchr(p, ',', eol - p);
61131685 291) p[0] = '^';
61131685 292) p[1] = '[';
61131685 293) FLEX_ALLOC_MEM(e, sequence, p, comma - p);
61131685 294) hashmap_entry_init(&e->entry,
61131685 295)    strhash(e->sequence));
61131685 296) hashmap_add(&sequences, &e->entry);
61131685 298) if (!*eol)
61131685 299) break;
61131685 301) initialized = 1;
61131685 304) return !!hashmap_get_from_hash(&sequences, strhash(sequence), sequence);
61131685 345) while (!is_known_escape_sequence(buf->buf)) {

Johannes Schindelin	74e42899 terminal: add a new function to read a single keystroke
compat/terminal.c
74e42899 64) static int enable_non_canonical(void)
74e42899 66) return disable_bits(ICANON | ECHO);
74e42899 307) int read_key_without_echo(struct strbuf *buf)
74e42899 312) if (warning_displayed || enable_non_canonical() < 0) {
74e42899 313) if (!warning_displayed) {
74e42899 316) warning_displayed = 1;
74e42899 319) return strbuf_getline(buf, stdin);
74e42899 322) strbuf_reset(buf);
74e42899 323) ch = getchar();
74e42899 324) if (ch == EOF) {
74e42899 325) restore_term();
74e42899 326) return EOF;
74e42899 328) strbuf_addch(buf, ch);
74e42899 358) restore_term();
74e42899 359) return 0;

Johannes Schindelin	aaafd603 terminal: make the code of disable_echo() reusable
compat/terminal.c
aaafd603 38) static int disable_bits(tcflag_t bits)
aaafd603 49) t.c_lflag &= ~bits;
aaafd603 59) static int disable_echo(void)
aaafd603 61) return disable_bits(ECHO);

Johannes Schindelin	60b7e674 built-in add -p: respect the `interactive.singlekey` config setting
add-patch.c
60b7e674 1156) int res = read_key_without_echo(&s->answer);
60b7e674 1157) printf("%s\n", res == EOF ? "" : s->answer.buf);
60b7e674 1158) return res;

Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
read-cache.c
ee70c128 1761) if (advice_unknown_index_extension) {

Josh Steadmon	6da1f1a9 protocol: advertise multiple supported versions
remote-curl.c
6da1f1a9 354) return 0;

Matheus Tavares	beebb9d2 object-store: allow threaded access to object reading
packfile.c
beebb9d2 1453) return;

sha1-file.c
beebb9d2 1431) return;
beebb9d2 1440) return;

Phillip Wood	430b75f7 commit: give correct advice for empty commit during a rebase
sequencer.c
430b75f7 1580)     return -1;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Alban Gruin	0d50cf5e sequencer: move check_todo_list_from_file() to rebase-interactive.c
rebase-interactive.c
0d50cf5e 210) goto out;
0d50cf5e 215) goto out;
0d50cf5e 224) fprintf(stderr, _(edit_todo_list_advice));

Alex Torok	fed842f0 rebase: fix --fork-point with short refname
builtin/merge-base.c
fed842f0 128) return 1;

Jonathan Tan	9c8a294a sha1-file: remove OBJECT_INFO_SKIP_CACHED
sha1-file.c
9c8a294a 1442) *(oi->disk_sizep) = 0;
9c8a294a 1444) hashclr(oi->delta_base_sha1);
9c8a294a 1446) strbuf_addstr(oi->type_name, type_name(co->type));

Martin Ågren	3bf986d6 builtin/config: collect "value_regexp" data in a struct
builtin/config.c
3bf986d6 329) FREE_AND_NULL(cmd_line_value.regexp);

Martin Ågren	3bcdd852 builtin/config: extract `handle_value_regex()` from `get_value()`
builtin/config.c
3bcdd852 330) return CONFIG_INVALID_PATTERN;
3bcdd852 375) goto free_strings;



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
Elijah Newren	4d861fad rebase, sequencer: remove the broken GIT_QUIET handling
builtin/rebase.c
4d861fad 725) write_file(state_dir_path("quiet", opts), "%s", "");

Elijah Newren	7ee11336 rebase: extend the options for handling of empty commits
sequencer.c
7ee11336 2055) res = allow;
7ee11336 2056) goto leave;
7ee11336 2515) opts->drop_redundant_commits =
7ee11336 2516) git_config_bool_or_int(key, value, &error_flag);
7ee11336 2521) opts->ask_on_initially_empty =
7ee11336 2522) git_config_bool_or_int(key, value, &error_flag);
7ee11336 3066) res |= git_config_set_in_file_gently(opts_file,
7ee11336 3072) res |= git_config_set_in_file_gently(opts_file,
7ee11336 4786) continue;

Hans Jerry Illikainen	63add83b gpg-interface: add minTrustLevel as a configuration option
builtin/pull.c
63add83b 374) return status;

gpg-interface.c
63add83b 143) return 1;
63add83b 207) free(trust);
63add83b 208) goto error;
63add83b 397) return config_error_nonbool(var);

pretty.c
63add83b 1355) strbuf_addstr(sb, "never");
63add83b 1356) break;
63add83b 1358) strbuf_addstr(sb, "marginal");
63add83b 1359) break;
63add83b 1361) strbuf_addstr(sb, "fully");
63add83b 1362) break;

Jeff King	4f0bd8b9 pack-objects: improve partial packfile reuse
builtin/pack-objects.c
4f0bd8b9 1124) return 1;
4f0bd8b9 2681) (reuse_packfile_bitmap &&
4f0bd8b9 2682)  bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));

pack-bitmap.c
4f0bd8b9 808) return;
4f0bd8b9 811) return;
4f0bd8b9 823) return;
4f0bd8b9 861) i = bitmap_git->pack->num_objects / BITS_IN_EWORD;

Jeff King	7cb9754e pack-objects: introduce pack.allowPackReuse
builtin/pack-objects.c
7cb9754e 2834) allow_pack_reuse = git_config_bool(k, v);
7cb9754e 2835) return 0;

Jeff King	7b143c16 pack-bitmap: introduce bitmap_walk_contains()
pack-bitmap.c
7b143c16 903) return 0;

Johannes Schindelin	52628f94 built-in add -p: implement the "checkout" patch modes
add-patch.c
52628f94 1224) fwrite(diff->buf, diff->len, 1, stderr);

Johannes Schindelin	d2a233cb built-in add -p: prepare for patch modes other than "stage"
add-patch.c
d2a233cb 1520)       _(s->mode->help_patch_text));

Johannes Schindelin	90a6bb98 legacy stash -p: respect the add.interactive.usebuiltin setting
builtin/add.c
90a6bb98 450) parse_pathspec(&pathspec, 0,
90a6bb98 456) return run_add_interactive(NULL, "--patch=stash", &pathspec);

Johannes Schindelin	6610e462 built-in stash: use the built-in `git add -p` if so configured
builtin/stash.c
6610e462 1026) setenv(INDEX_ENVIRONMENT, old_index_env, 1);



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Elijah Newren	4fe7e43c rebase: fix saving of --signoff state for am-based rebases
builtin/rebase.c
4fe7e43c 709) write_file(state_dir_path("signoff", opts), "--signoff");


