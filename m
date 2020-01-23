Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FC9C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D232077C
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 14:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjjVABYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgAWO2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:28:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35683 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgAWO2W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 09:28:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id z76so3601405qka.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 06:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1fRwdHgahmKOlBa1xurL3aU/E2Wf5B/yMskAdzm/L+o=;
        b=gjjVABYDjqBnQ6GZ1qPzvPKWsbVnKYEP7lJIERjFMKI3cUiFfyMA1QSkt9/Ik+Db8B
         +EsBceXAgkS1NSbCqiuMiuDbBOiAasRrhUSMCdJnbnmQ4/POO8n+BsSynIfQETggcOT3
         n9lksD7KmL1lo+ZCT3nPaZAgtsc05FFsQ+rNVKBIJrPvrqx2TuUqYa8NX+hnw5hpE6A9
         x7vb7EbgBD94MSsqCdLiCG6ryl0VaRKdM4Zd5Ddye3N4XXPshkpkIdfPk3T52Hoij9Jn
         eiiETIAkr+jQ2CY5/RFkMkyOFxxwgg8r42PAbRZES/gKIbI1CzUFQ6MLYkq/Psiy0FT4
         E4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1fRwdHgahmKOlBa1xurL3aU/E2Wf5B/yMskAdzm/L+o=;
        b=k5JEnlV+ep79klLheAyxNaxbQEpNlYBTY/+QvwFkCGI7HM7k1sDqoCVr2TOiNWcgIS
         xXdLCMbEFuTm61WDKWSEivDpCye/ATpyJ002E1RdnezLv9h0U8OodPzCBjrMSAH9Ssca
         OfFjwlTGC8NIy6Oe7W8cY6aITQ9GbhOQjbsQZeYRAh9Kxc5BNKsvfAwCcf5Bnd7LDwGG
         PSFDRTlGKS/Am4Xuc2ZjIl8C3eQJ5642HFq94vfDMvXKeagytZyd0BFxroyMSrbURP58
         5jQZr0IlwsRW/gV5bpkMeTQ1U9kH3M14rH/Xm8O6cxmSdwRsWT0usfkpiY/Lm+P0UJXv
         VVMw==
X-Gm-Message-State: APjAAAU8jfhSeZvfEwCowOXjSm3uoM8Lg5n66ghFpBwyhUuFl9MFSDwT
        E0DJgfM1q9DcWEx8SRgV0EU3iEm1EDg=
X-Google-Smtp-Source: APXvYqy6eZ8gIMAxG8Ofo30fod/bvQqoq/rdfnEHgRrkNPrmTq71dq0yN4r8ZSExvExBWyo8vFXVZA==
X-Received: by 2002:a05:620a:9d9:: with SMTP id y25mr8034909qky.41.1579789700327;
        Thu, 23 Jan 2020 06:28:20 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:fdb6:49de:4189:c4f0? ([2001:4898:a800:1010:aeec:49de:4189:c4f0])
        by smtp.gmail.com with ESMTPSA id r13sm980334qtt.70.2020.01.23.06.28.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 06:28:19 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Jan 22, 2020)
Message-ID: <f4373bcf-e78e-aedf-d7d3-e6181164088b@gmail.com>
Date:   Thu, 23 Jan 2020 09:28:19 -0500
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

Here is the latest test coverage report.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2020-01-22.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2020-01-22.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2020-01-22-commits.txt

---

pu	93d4f0420cd84db6ba06dfde81314c8c5f328842
jch	75b0f54c274253cd9cb3395f261a70f4238a3e9a
next	3f081b084b0e55662871946d66dab3696a46a22a
master	232378479ee6c66206d47a9be175e3a39682aea6
master@{1}	8679ef24ed64018bb62170c43ce73e0261c0600a


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Denton Liu	186dbeed rebase: use read_oneliner()
builtin/rebase.c
186dbeed 629) } else if (!read_oneliner(&buf, state_dir_path("head", opts), 0, 1))

Denton Liu	06ebea5c rebase: generify reset_head()
builtin/rebase.c
06ebea5c 879) reset_head(the_repository, &opts->orig_head, "checkout",
06ebea5c 880)    opts->head_name, 0,

Denton Liu	e71223c6 rebase: use apply_autostash() from sequencer.c
builtin/rebase.c
e71223c6 1039) apply_autostash(state_dir_path("autostash", opts));

Denton Liu	448bea61 sequencer: make apply_rebase() accept a path
sequencer.c
448bea61 5157) apply_autostash(rebase_path_autostash());

Denton Liu	fa717471 sequencer: use file strbuf for read_oneliner()
sequencer.c
fa717471 436) goto done;
fa717471 442) goto done;

Denton Liu	b3137f2e reset: extract reset_head() from rebase
reset.c
b3137f2e 37) ret = -1;
b3137f2e 38) goto leave_reset_head;
b3137f2e 43) goto leave_reset_head;
b3137f2e 65) goto leave_reset_head;
b3137f2e 71) goto leave_reset_head;
b3137f2e 76) goto leave_reset_head;
b3137f2e 80) ret = -1;
b3137f2e 81) goto leave_reset_head;
b3137f2e 89) goto leave_reset_head;
b3137f2e 108) } else if (old_orig)
b3137f2e 109) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);

Elijah Newren	81f5bc1c rebase, sequencer: remove the broken GIT_QUIET handling
builtin/rebase.c
81f5bc1c 698) write_file(state_dir_path("quiet", opts), "%s", "");

Elijah Newren	91e0ed22 rebase (interactive-backend): fix handling of commits that become empty
sequencer.c
91e0ed22 2534) opts->keep_redundant_commits = 1;

Elijah Newren	8ef6c12e rebase (interactive-backend): make --keep-empty the default
sequencer.c
8ef6c12e 1539) return originally_empty;

Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
read-cache.c
ee70c128 1761) if (advice_unknown_index_extension) {

Josh Steadmon	6da1f1a9 protocol: advertise multiple supported versions
remote-curl.c
6da1f1a9 354) return 0;

Kevin Willford	56c69100 fsmonitor: change last update timestamp on the index_state to opaque token
fsmonitor.c
56c69100 62) timestamp = get_be64(index);
56c69100 63) strbuf_addf(&last_update, "%"PRIu64"", timestamp);
56c69100 64) index += sizeof(uint64_t);

Kevin Willford	8da2c576 fsmonitor: handle version 2 of the hooks that will use opaque token
fsmonitor.c
8da2c576 36) if (hook_version == HOOK_INTERFACE_VERSION1 ||
8da2c576 37)     hook_version == HOOK_INTERFACE_VERSION2)
8da2c576 38) return hook_version;
8da2c576 199) strbuf_addf(&last_update_token, "%"PRIu64"", last_update);

Matheus Tavares	31877c9a object-store: allow threaded access to object reading
packfile.c
31877c9a 1472) return;

sha1-file.c
31877c9a 1431) return;
31877c9a 1440) return;

Phillip Wood	430b75f7 commit: give correct advice for empty commit during a rebase
sequencer.c
430b75f7 1472)     return -1;



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

Jeff King	7cb9754e pack-objects: introduce pack.allowPackReuse
builtin/pack-objects.c
7cb9754e 2834) allow_pack_reuse = git_config_bool(k, v);
7cb9754e 2835) return 0;

Jeff King	7b143c16 pack-bitmap: introduce bitmap_walk_contains()
pack-bitmap.c
7b143c16 903) return 0;

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

Johannes Schindelin	94ac3c31 terminal: make the code of disable_echo() reusable
compat/terminal.c
94ac3c31 38) static int disable_bits(tcflag_t bits)
94ac3c31 49) t.c_lflag &= ~bits;
94ac3c31 59) static int disable_echo(void)
94ac3c31 61) return disable_bits(ECHO);

Johannes Schindelin	180f48df built-in add -p: support interactive.diffFilter
add-patch.c
180f48df 557) else if (p != pend)
180f48df 559) goto mismatched_output;
180f48df 590) return -1;

Johannes Schindelin	90a6bb98 legacy stash -p: respect the add.interactive.usebuiltin setting
builtin/add.c
90a6bb98 451) parse_pathspec(&pathspec, 0,
90a6bb98 457) return run_add_interactive(NULL, "--patch=stash", &pathspec);

Johannes Schindelin	d2a233cb built-in add -p: prepare for patch modes other than "stage"
add-patch.c
d2a233cb 1567)       _(s->mode->help_patch_text));

Johannes Schindelin	52628f94 built-in add -p: implement the "checkout" patch modes
add-patch.c
52628f94 1272) fwrite(diff->buf, diff->len, 1, stderr);

Johannes Schindelin	04f816b1 built-in add -p: respect the `interactive.singlekey` config setting
add-patch.c
04f816b1 1156) int res = read_key_without_echo(&s->answer);
04f816b1 1157) printf("%s\n", res == EOF ? "" : s->answer.buf);
04f816b1 1158) return res;

Johannes Schindelin	6610e462 built-in stash: use the built-in `git add -p` if so configured
builtin/stash.c
6610e462 1026) setenv(INDEX_ENVIRONMENT, old_index_env, 1);

Martin Ågren	3bcdd852 builtin/config: extract `handle_value_regex()` from `get_value()`
builtin/config.c
3bcdd852 330) return CONFIG_INVALID_PATTERN;
3bcdd852 375) goto free_strings;

Martin Ågren	3bf986d6 builtin/config: collect "value_regexp" data in a struct
builtin/config.c
3bf986d6 329) FREE_AND_NULL(cmd_line_value.regexp);

Ralf Thielow	a4ffbbbb submodule.c: mark more strings for translation
submodule.c
a4ffbbbb 1161) fprintf(stderr, _("Unable to push submodule '%s'\n"), path);



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
brian m. carlson	63ab08fb run-command: avoid undefined behavior in exists_in_PATH
run-command.c
63ab08fb 216) int found = r != NULL;
63ab08fb 218) return found;

Jonathan Tan	9c8a294a sha1-file: remove OBJECT_INFO_SKIP_CACHED
sha1-file.c
9c8a294a 1442) *(oi->disk_sizep) = 0;
9c8a294a 1444) hashclr(oi->delta_base_sha1);
9c8a294a 1446) strbuf_addstr(oi->type_name, type_name(co->type));



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:

