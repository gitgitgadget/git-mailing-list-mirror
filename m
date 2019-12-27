Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C751FC2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 16:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B47C20740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 16:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPVnsgkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfL0QSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 11:18:50 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:36014 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0QSu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 11:18:50 -0500
Received: by mail-qt1-f178.google.com with SMTP id q20so24881300qtp.3
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=W59bBC+WvNHu+7jlFAHvw716bz0dlkByqF6vT8hspFY=;
        b=qPVnsgkhTUyVek5fmUFrUAVOwEL0411Yzy+FLOIUO7zn9SIioNqP4kXJZm0NK+vjTs
         N8JKYFFKNmN1/xI5l8iaFdDosn9xsajakk1u6fYP9udbWydyvpudGG4154M76ZsvfSOD
         luq9Yy6rZPKTzhdagVXPRzKh4xPiOVfUzlbE5AH6GgMNRBd+m13rhZUpwCqCU1CFCnFw
         hJDuFQoE3DuCK2xyqYvYKKHndAENClFysBPXStRTvwNzbF/na6B5k2ppTzI/7haHNCUe
         WkDz4mfNxeRzYfCs+Qrv/RNdnruL8btyq+o0fAAdGTsyaEkJrt4MzKObKWTPPPYE5Yno
         q5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=W59bBC+WvNHu+7jlFAHvw716bz0dlkByqF6vT8hspFY=;
        b=IQ3mvbS4GRdXBqCHQ0cfif1PuQtwuCG6182JrBDXDz3nEdzskqKTwMR/oUewreIYk3
         5/X2NFLRndOrkISb9uJPwiL8Mi0xFFIAsQLAg6Ll6CzeysB5yFzUhegNZN6soAO+dB84
         OILwN1lHqyXcVL/9fVXZRv/KYayYHcd69Sc0/fj20ZidPntCzzkAtJ0iksjQfsWLkaVh
         0OYR3YDwcOcB1INwSj8s5wJros4oOwv0FNynXqS39PhnHE5bOKcaAnSyMZg/4ZDcwZp6
         qQrzEQMwfFQ4PQ1uJwWcKoAxVxklWlnd+tIg4KvUILFaTYomN3YEme/dKRxP+IuQJv1j
         qsSw==
X-Gm-Message-State: APjAAAUViDoxeKXKtgRrQFcYHBiHvOMEBfkxNtKXcQ+nbC81pAe59+3K
        9O9XV688Zrzy8ajUNlh6QQGY7/2q
X-Google-Smtp-Source: APXvYqyAmmmSf3fvjke06P8D23+GVQ12Xpmo72OajTLKih+4Qzx/yecSt6suPkUmH4XHz3B14PR77A==
X-Received: by 2002:ac8:3751:: with SMTP id p17mr39474658qtb.9.1577463528682;
        Fri, 27 Dec 2019 08:18:48 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9d29:38a1:5885:e8b3? ([2001:4898:a800:1010:4e5f:38a1:5885:e8b3])
        by smtp.gmail.com with ESMTPSA id r28sm10989088qtr.3.2019.12.27.08.18.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 08:18:48 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Dec. 27)
Message-ID: <a684bfb5-ed1e-6d69-93f6-b4a5f20ff953@gmail.com>
Date:   Fri, 27 Dec 2019 11:18:48 -0500
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

Here is today's test coverage report [1][2][3]. I also got the
single-branch build working with the commit view, so I have the
commit view available for the v2.25.0-rc0 report [4].

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-12-27-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-12-27.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2019-12-27.htm
[4] https://derrickstolee.github.io/git-test-coverage/reports/v2.25.0-rc0-commits.txt


---

pu	4da9d1ed5116f89b015c733206b4b7e61883f8bb
jch	0001df5574e7f7a096d568fb64aeb26e5fe2757a
next	ca9f1ec99ff3ed584eec58c085a342c9c37d2919
master	0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
master@{1}	b02fd2accad4d48078671adf38fe5b5976d77304


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Denton Liu	daf6b9e4 sequencer: use file strbuf for read_oneliner()
sequencer.c
daf6b9e4 439) goto done;
daf6b9e4 445) goto done;

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

Johannes Schindelin	6610e462 built-in stash: use the built-in `git add -p` if so configured
builtin/stash.c
6610e462 1026) setenv(INDEX_ENVIRONMENT, old_index_env, 1);

Johannes Schindelin	90a6bb98 legacy stash -p: respect the add.interactive.usebuiltin setting
builtin/add.c
90a6bb98 450) parse_pathspec(&pathspec, 0,
90a6bb98 456) return run_add_interactive(NULL, "--patch=stash", &pathspec);

Johannes Schindelin	d2a233cb built-in add -p: prepare for patch modes other than "stage"
add-patch.c
d2a233cb 1567)       _(s->mode->help_patch_text));

Johannes Schindelin	52628f94 built-in add -p: implement the "checkout" patch modes
add-patch.c
52628f94 1272) fwrite(diff->buf, diff->len, 1, stderr);

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
7ee11336 4798) continue;

Hans Jerry Illikainen	917ddb16 gpg-interface: add minTrustLevel as a configuration option
builtin/pull.c
917ddb16 374) return status;

gpg-interface.c
917ddb16 143) return 1;
917ddb16 209) free(trust);
917ddb16 210) goto error;
917ddb16 399) return config_error_nonbool(var);

pretty.c
917ddb16 1355) strbuf_addstr(sb, "never");
917ddb16 1356) break;
917ddb16 1358) strbuf_addstr(sb, "marginal");
917ddb16 1359) break;
917ddb16 1361) strbuf_addstr(sb, "fully");
917ddb16 1362) break;

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
Elijah Newren	4fe7e43c rebase: fix saving of --signoff state for am-based rebases
builtin/rebase.c
4fe7e43c 709) write_file(state_dir_path("signoff", opts), "--signoff");

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



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Derrick Stolee	96cc8ab5 sparse-checkout: use hashmaps for cone patterns
dir.c
96cc8ab5 663) pl->use_cone_patterns = 0;
96cc8ab5 665) goto clear_hashmaps;
96cc8ab5 689) hashmap_add(&pl->parent_hashmap, &translated->ent);
96cc8ab5 690) hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
96cc8ab5 691) free(data);
96cc8ab5 692) return;
96cc8ab5 698) goto clear_hashmaps;
96cc8ab5 716) hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
96cc8ab5 717) free(data);
96cc8ab5 718) free(translated);
96cc8ab5 1280) return MATCHED;

Derrick Stolee	af09ce24 sparse-checkout: init and set in cone mode
builtin/sparse-checkout.c
af09ce24 352) return;

Derrick Stolee	190a65f9 sparse-checkout: respect core.ignoreCase in cone mode
builtin/sparse-checkout.c
190a65f9 337)    strihash(e->pattern) :

dir.c
190a65f9 676)    strihash(translated->pattern) :
190a65f9 707)    strihash(translated->pattern) :

Derrick Stolee	bab3c359 sparse-checkout: create 'init' subcommand
builtin/sparse-checkout.c
bab3c359 221) return 1;
bab3c359 275) return 1;

Derrick Stolee	e091228e sparse-checkout: update working directory in-process
builtin/sparse-checkout.c
e091228e 85) return 0;

Derrick Stolee	d89f09c8 clone: add --sparse mode
builtin/clone.c
d89f09c8 753) result = 1;
d89f09c8 1132) return 1;

Johannes Schindelin	5906d5de built-in app -p: allow selecting a mode change as a "hunk"
add-patch.c
5906d5de 146) return 0;
5906d5de 150) return 0;
5906d5de 277) file_diff->hunk->colored_start =
5906d5de 278) colored_p - colored->buf;
5906d5de 425) const char *p = s->colored.buf;
5906d5de 427) strbuf_add(out, p + head->colored_start,
5906d5de 428)     first->colored_start - head->colored_start);
5906d5de 429) strbuf_add(out, p + first->colored_end,
5906d5de 430)     head->colored_end - first->colored_end);

Johannes Schindelin	25ea47af built-in add -p: adjust hunk headers as needed
add-patch.c
25ea47af 87) return -1;
25ea47af 104) eol = s->plain.buf + s->plain.len;
25ea47af 127) eol = s->colored.buf + s->colored.len;
25ea47af 250) return -1;
25ea47af 393) strbuf_addf(out, "%s\n", GIT_COLOR_RESET);
25ea47af 1296) repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,

Johannes Schindelin	7584dd3c built-in add -p: offer a helpful error message when hunk navigation failed
add-patch.c
7584dd3c 52) static void err(struct add_p_state *s, const char *fmt, ...)
7584dd3c 56) va_start(args, fmt);
7584dd3c 57) fputs(s->s.error_color, stderr);
7584dd3c 58) vfprintf(stderr, fmt, args);
7584dd3c 59) fputs(s->s.reset_color, stderr);
7584dd3c 60) fputc('\n', stderr);
7584dd3c 61) va_end(args);
7584dd3c 62) }
7584dd3c 1134) if (hunk_index)
7584dd3c 1135) hunk_index--;
7584dd3c 1137) err(s, _("No previous hunk"));
7584dd3c 1140) hunk_index++;
7584dd3c 1142) err(s, _("No next hunk"));
7584dd3c 1144) if (undecided_previous >= 0)
7584dd3c 1145) hunk_index = undecided_previous;
7584dd3c 1147) err(s, _("No previous hunk"));
7584dd3c 1149) if (undecided_next >= 0)
7584dd3c 1150) hunk_index = undecided_next;
7584dd3c 1152) err(s, _("No next hunk"));

Johannes Schindelin	54d9d9b2 built-in add -p: only show the applicable parts of the help text
add-patch.c
54d9d9b2 1254) const char *p = _(help_patch_remainder), *eol = p;
54d9d9b2 1256) color_fprintf(stdout, s->s.help_color, "%s",
54d9d9b2 1263) for (; *p; p = eol + (*eol == '\n')) {
54d9d9b2 1264) eol = strchrnul(p, '\n');
54d9d9b2 1271) if (*p != '?' && !strchr(s->buf.buf, *p))
54d9d9b2 1272) continue;
54d9d9b2 1274) color_fprintf_ln(stdout, s->s.help_color,
54d9d9b2 1275)  "%.*s", (int)(eol - p), p);

Johannes Schindelin	d6cf8733 built-in add -p: implement the '/' ("search regex") command
add-patch.c
d6cf8733 1195) err(s, _("No other hunks to search"));
d6cf8733 1196) continue;
d6cf8733 1201) printf("%s", _("search for regex? "));
d6cf8733 1202) fflush(stdout);
d6cf8733 1203) if (strbuf_getline(&s->answer,
d6cf8733 1205) break;
d6cf8733 1206) strbuf_trim_trailing_newline(&s->answer);
d6cf8733 1207) if (s->answer.len == 0)
d6cf8733 1208) continue;
d6cf8733 1216) err(s, _("Malformed search regexp %s: %s"),
d6cf8733 1218) continue;
d6cf8733 1233) err(s, _("No hunk matches the given pattern"));
d6cf8733 1234) break;

Johannes Schindelin	80399aec built-in add -p: support multi-file diffs
add-patch.c
80399aec 1118) for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
80399aec 1119) hunk = file_diff->hunk + hunk_index;
80399aec 1139) if (hunk_index + 1 < file_diff->hunk_nr)

Johannes Schindelin	9254bdfb built-in add -p: implement the 'g' ("goto") command
add-patch.c
9254bdfb 981) strbuf_setlen(out, len + SUMMARY_LINE_WIDTH);
9254bdfb 1158) err(s, _("No other hunks to goto"));
9254bdfb 1159) continue;
9254bdfb 1174) break;
9254bdfb 1181) err(s, _("Invalid number: '%s'"),
9254bdfb 1189)     (int)file_diff->hunk_nr);

Johannes Schindelin	bcdd297b built-in add -p: implement hunk editing
add-patch.c
bcdd297b 770) hunk->colored_start = s->colored.len;
bcdd297b 771) for (current = hunk->start; current < hunk->end; ) {
bcdd297b 772) for (eol = current; eol < hunk->end; eol++)
bcdd297b 773) if (plain[eol] == '\n')
bcdd297b 774) break;
bcdd297b 775) next = eol + (eol < hunk->end);
bcdd297b 776) if (eol > current && plain[eol - 1] == '\r')
bcdd297b 777) eol--;
bcdd297b 779) strbuf_addstr(&s->colored,
bcdd297b 780)       plain[current] == '-' ?
bcdd297b 782)       plain[current] == '+' ?
bcdd297b 785) strbuf_add(&s->colored, plain + current, eol - current);
bcdd297b 786) strbuf_addstr(&s->colored, GIT_COLOR_RESET);
bcdd297b 787) if (next > eol)
bcdd297b 788) strbuf_add(&s->colored, plain + eol, next - eol);
bcdd297b 789) current = next;
bcdd297b 791) hunk->colored_end = s->colored.len;
bcdd297b 825) return -1;
bcdd297b 840) return 0;
bcdd297b 906) return -1;
bcdd297b 910) case 'y': return 1;
bcdd297b 912) }
bcdd297b 927) *hunk = backup;
bcdd297b 928) return -1;
bcdd297b 1248) err(s, _("Sorry, cannot edit this hunk"));

Johannes Schindelin	11f2c0da built-in add -p: coalesce hunks after splitting them
add-patch.c
11f2c0da 449) return 0;

Johannes Schindelin	510aeca1 built-in add -p: implement the hunk splitting feature
add-patch.c
510aeca1 235) hunk->splittable_into++;
510aeca1 356) return sb->len;
510aeca1 618) return 0;
510aeca1 629) memmove(file_diff->hunk + hunk_index + splittable_into,
510aeca1 630) file_diff->hunk + hunk_index + 1,
510aeca1 631) (file_diff->hunk_nr - hunk_index - splittable_into)
510aeca1 642) colored_current = hunk->colored_start;
510aeca1 660) hunk[1].colored_start = colored_current;
510aeca1 675) ch = marker ? marker : ' ';
510aeca1 689) colored_current =
510aeca1 690) find_next_line(&s->colored,
510aeca1 732) hunk->colored_end = colored_current;
510aeca1 757) hunk->colored_end = colored_end;
510aeca1 1240) err(s, _("Sorry, cannot split this hunk"));

Johannes Schindelin	f6aa7ecc built-in add -i: start implementing the `patch` functionality in C
add-patch.c
f6aa7ecc 209) eol = pend;
f6aa7ecc 1051) undecided_previous = i;
f6aa7ecc 1052) break;
f6aa7ecc 1073) strbuf_addstr(&s->buf, ",k");
f6aa7ecc 1107) continue;
f6aa7ecc 1120) if (hunk->use == UNDECIDED_HUNK)
f6aa7ecc 1121) hunk->use = USE_HUNK;
f6aa7ecc 1317) strbuf_release(&s.plain);
f6aa7ecc 1319) return -1;

Johannes Schindelin	e3bd11b4 built-in add -p: show colored hunks by default
add-patch.c
e3bd11b4 175) argv_array_clear(&args);
e3bd11b4 320) colored_p = colored_pend;
e3bd11b4 1318) strbuf_release(&s.colored);

Johannes Schindelin	b38dd9e7 strbuf: add a helper function to call the editor "on an strbuf"
strbuf.c
b38dd9e7 1140) res = error_errno(_("could not open '%s' for writing"), path);
b38dd9e7 1142) res = error_errno(_("could not write to '%s'"), path);
b38dd9e7 1143) close(fd);
b38dd9e7 1145) res = error_errno(_("could not close '%s'"), path);
b38dd9e7 1149) res = error_errno(_("could not edit '%s'"), path);

Tanushree Tumane	51a0a4ed bisect--helper: avoid use-after-free
builtin/bisect--helper.c
51a0a4ed 177) return -1;


