Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56DBC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998ED2072D
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoBdWDh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCFMIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:08:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43664 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgCFMIq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 07:08:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id f8so775518plt.10
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=T5gMJnBs5H8HN49QhHB6QXaH5HAtShLmknGKSu+/NYg=;
        b=QoBdWDh7HcYyHOad7Ip8g7MTF7h7+NsyBmGILS8BigU86/nPq1xDIjtj/JPfeHgAY8
         tzcAe3XG4RIiX2u1sWjlK6kaNihnJKktCLGOEpIH6dj9W0fq/1vEAtbHzdKLSVAb/kHB
         0NozqZIWlsnKVWfx44qJ7lKLNBw0FwZ0O2uW2xF+1rX00Y2SgcrmGJ9KGJbKMulpb9Ra
         hIfgAEWz7Fi1MGK05OeVWYlFUsWanCBN99+iJXGl6wpfFWfeWlC7e4ZDzR//AwjEtmlI
         uio6SeKZnMJG8Ix1bvcibI4YOzNp7gnrFVDiGkGBfJl83prd+enGT+9HylL3NW0tOy33
         c6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=T5gMJnBs5H8HN49QhHB6QXaH5HAtShLmknGKSu+/NYg=;
        b=MDHWPl9PJn9KyOkqdZ+dP3yt5gZvXdUMDLnFgcrwB7rh6DONtgHgV8zjddLiyf9aVs
         4QM83VT+dl8/+ub+OAybcJzh0eBM3x8o/9kSRPjyHUJOSABcYkxk7ZnM7hIOYW+zxlPm
         TegPNP/q311VG60iGRP6NSA+RsfM8HSlN8FrCvoqvSfGqOOOSYijoa++dJ5CjfnYsOrz
         PO19SLS7oXYyZ35ZrwNa/E9uWTjtjVdLaWp5zoUZVvHNCkl9hXicvj5xBghWkV4B0FBa
         6ycaITA4zap7W7jBmK/mTd43++HSEiEQcafXNfhJ6jOusEHoLsiTmVC0s9vLpiK8CfYS
         hUrA==
X-Gm-Message-State: ANhLgQ3bt5dGIyagBZL6l3gBYEOQx2x4+uMLu7dVGUWNtXeWMahAQyGu
        4K9xG/vi6VHmvIwkgLJsG07aKM1Q
X-Google-Smtp-Source: ADFU+vvz317dt9T6HuG4busDpua4+5GN5Bm/WwUcBEYGVW21eT5Npg3dXv8L2/bGbqqK7mlk6ug8eg==
X-Received: by 2002:a17:90a:c218:: with SMTP id e24mr3340048pjt.64.1583496524578;
        Fri, 06 Mar 2020 04:08:44 -0800 (PST)
Received: from [10.1.2.155] ([38.126.33.187])
        by smtp.gmail.com with ESMTPSA id y193sm20717723pfg.162.2020.03.06.04.08.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 04:08:43 -0800 (PST)
To:     GIT Mailing-list <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (v2.26.0-rc0)
Message-ID: <6c0641cc-b4f5-e05c-9ffc-3003dd376cf3@gmail.com>
Date:   Fri, 6 Mar 2020 07:08:38 -0500
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

Here is the test coverage report for v2.26.0-rc0 versus v2.25.1.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/v2.26.0-rc0-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/v2.26.0-rc0.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/v2.26.0-rc0.htm

---

target	fork/master
base	refs/tags/v2.25.1


Uncovered code in 'target' not in 'base'
--------------------------------------------------------

Commits introducing uncovered code:
Alban Gruin	5a5445d8 rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
sequencer.c
5a5445d8 4261) unlink(rebase_path_dropped());

Alban Gruin	1da5874c sequencer: move check_todo_list_from_file() to rebase-interactive.c
rebase-interactive.c
1da5874c 234) goto out;
1da5874c 239) goto out;
1da5874c 246) fprintf(stderr, _(edit_todo_list_advice));

Benno Evers	30b1c7ad describe: don't abort too early when searching tags
builtin/describe.c
30b1c7ad 394) fprintf(stderr, _("finished search at %s\n"),
30b1c7ad 395) oid_to_hex(&c->object.oid));

Bert Wesarg	f2a2327a config: provide access to the current line number
config.c
f2a2327a 3346) return cf->linenr;

Bert Wesarg	88f8576e pull --rebase/remote rename: document and honor single-letter abbreviations rebase types
rebase.c
88f8576e 26) return REBASE_MERGES;

Bert Wesarg	1a83068c remote: clean-up by returning early to avoid one indentation
builtin/remote.c
1a83068c 287) return 0;

Elijah Newren	e98c4269 rebase (interactive-backend): fix handling of commits that become empty
sequencer.c
e98c4269 2523) opts->keep_redundant_commits = 1;

Elijah Newren	8a997ed1 rebase, sequencer: remove the broken GIT_QUIET handling
builtin/rebase.c
8a997ed1 695) write_file(state_dir_path("quiet", opts), "%s", "");

Elijah Newren	10cdb9f3 rebase: rename the two primary rebase backends
builtin/rebase.c
10cdb9f3 1664) if (is_merge(&options))

Elijah Newren	d48e5e21 rebase (interactive-backend): make --keep-empty the default
sequencer.c
d48e5e21 1529) return originally_empty;

Hans Jerry Illikainen	54887b46 gpg-interface: add minTrustLevel as a configuration option
builtin/pull.c
54887b46 353) return status;

gpg-interface.c
54887b46 143) return 1;
54887b46 207) free(trust);
54887b46 208) goto error;
54887b46 348) return config_error_nonbool(var);

pretty.c
54887b46 1355) strbuf_addstr(sb, "never");
54887b46 1356) break;
54887b46 1358) strbuf_addstr(sb, "marginal");
54887b46 1359) break;
54887b46 1361) strbuf_addstr(sb, "fully");
54887b46 1362) break;

Hariom Verma	4ef34648 receive.denyCurrentBranch: respect all worktrees
builtin/receive-pack.c
4ef34648 998) else if (git_work_tree_cfg)
4ef34648 999) work_tree = git_work_tree_cfg;
4ef34648 1001) work_tree = "..";
4ef34648 1008) git_dir = get_git_dir();

Jeff King	da806352 diff: move diff.wsErrorHighlight to "basic" config
diff.c
da806352 448) return -1;

Jeff King	4eb707eb rev-list: allow commit-only bitmap traversals
pack-bitmap.c
4eb707eb 626)     (obj->type == OBJ_TAG && !revs->tag_objects))
4eb707eb 627) continue;

Jeff King	4f3bd560 pack-bitmap: implement BLOB_NONE filtering
pack-bitmap.c
4f3bd560 732) continue;

Jeff King	bb514de3 pack-objects: improve partial packfile reuse
pack-bitmap.c
bb514de3 1033) return;
bb514de3 1036) return;
bb514de3 1048) return;
bb514de3 1086) i = bitmap_git->pack->num_objects / BITS_IN_EWORD;

Jeff King	6ac9760a packed_object_info(): use object_id internally for delta base
packfile.c
6ac9760a 1245) return -1;
6ac9760a 1249) return -1;
6ac9760a 1253) return -1;

Jeff King	e704fc79 pack-objects: introduce pack.allowPackReuse
builtin/pack-objects.c
e704fc79 2845) allow_pack_reuse = git_config_bool(k, v);
e704fc79 2846) return 0;

Jeff King	792f8119 rev-list: factor out bitmap-optimized routines
builtin/rev-list.c
792f8119 401) return -1;
792f8119 444) return -1;

Jeff King	b99b6bcc packed_object_info(): use object_id for returning delta base
sha1-file.c
b99b6bcc 1478) oidclr(oi->delta_base_oid);

Jeff King	3f83fd5e pack-objects: read delta base oid into object_id struct
builtin/pack-objects.c
3f83fd5e 1647) if (!in_same_island(&delta->idx.oid, base_oid))

Jeff King	2fecc48c packfile: drop nth_packed_object_sha1()
packfile.c
2fecc48c 1878) return -1;

Jeff King	92fb0db9 pack-objects: add checks for duplicate objects
builtin/pack-objects.c
92fb0db9 1134) return 1;
92fb0db9 2692) (reuse_packfile_bitmap &&
92fb0db9 2693)  bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));

Jeff King	608d9c93 rev-list: allow bitmaps when counting objects
builtin/rev-list.c
608d9c93 410) return -1;

Johannes Schindelin	6610e462 built-in stash: use the built-in `git add -p` if so configured
builtin/stash.c
6610e462 1026) setenv(INDEX_ENVIRONMENT, old_index_env, 1);

Johannes Schindelin	180f48df built-in add -p: support interactive.diffFilter
add-patch.c
180f48df 557) else if (p != pend)
180f48df 559) goto mismatched_output;
180f48df 590) return -1;

Johannes Schindelin	d2a233cb built-in add -p: prepare for patch modes other than "stage"
add-patch.c
d2a233cb 1567)       _(s->mode->help_patch_text));

Johannes Schindelin	94ac3c31 terminal: make the code of disable_echo() reusable
compat/terminal.c
94ac3c31 38) static int disable_bits(tcflag_t bits)
94ac3c31 49) t.c_lflag &= ~bits;
94ac3c31 59) static int disable_echo(void)
94ac3c31 61) return disable_bits(ECHO);

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

Johannes Schindelin	52628f94 built-in add -p: implement the "checkout" patch modes
add-patch.c
52628f94 1272) fwrite(diff->buf, diff->len, 1, stderr);

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

Johannes Schindelin	04f816b1 built-in add -p: respect the `interactive.singlekey` config setting
add-patch.c
04f816b1 1156) int res = read_key_without_echo(&s->answer);
04f816b1 1157) printf("%s\n", res == EOF ? "" : s->answer.buf);
04f816b1 1158) return res;

Johannes Schindelin	90a6bb98 legacy stash -p: respect the add.interactive.usebuiltin setting
builtin/add.c
90a6bb98 453) parse_pathspec(&pathspec, 0,
90a6bb98 459) return run_add_interactive(NULL, "--patch=stash", &pathspec);

Jonathan Tan	50033772 connected: verify promisor-ness of partial clone
connected.c
50033772 70) continue;

Junio C Hamano	0106b1d4 Revert "gpg-interface: prefer check_signature() for GPG verification"
builtin/fmt-merge-msg.c
0106b1d4 506) if (!sig.len)
0106b1d4 507) strbuf_addstr(&sig, "gpg verification failed.\n");

gpg-interface.c
0106b1d4 434) return error_errno(_("could not create temporary file"));
0106b1d4 437) error_errno(_("failed writing detached signature to '%s'"),
0106b1d4 439) delete_tempfile(&temp);
0106b1d4 440) return -1;

log-tree.c
0106b1d4 462) strbuf_addstr(&gpg_output, "No signature\n");
0106b1d4 534) else if (verify_message.len <= gpg_message_offset)

Junio C Hamano	e8e71848 Merge branch 'jk/nth-packed-object-id'
pack-bitmap.c
e8e71848 799) nth_packed_object_id(&oid, pack, entry->nr);

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

Matheus Tavares	31877c9a object-store: allow threaded access to object reading
packfile.c
31877c9a 1474) return;

sha1-file.c
31877c9a 1431) return;
31877c9a 1440) return;

Matheus Tavares	c8123e72 streaming: allow open_istream() to handle any repo
streaming.c
c8123e72 154) if (open_istream_incore(st, r, &oi, real, type)) {

Matthew Rogers	9a83d088 submodule-config: add subomdule config scope
config.c
9a83d088 3315) return "submodule";

Matthew Rogers	e37efa40 config: teach git_config_source to remember its scope
builtin/config.c
e37efa40 670) given_config_source.scope = CONFIG_SCOPE_SYSTEM;

Matthew Rogers	6dc905d9 config: split repo scope to local and worktree
config.c
6dc905d9 3311) return "worktree";

Matthew Rogers	a5cb4204 config: make scope_name non-static and rename it
config.c
a5cb4204 3305) return "system";
a5cb4204 3317) return "unknown";

Pranit Bauva	6c69f222 bisect: libify `bisect_next_all`
bisect.c
6c69f222 1024) return BISECT_FAILED;

Pranit Bauva	45b63708 bisect: libify `check_good_are_ancestors_of_bad` and its dependents
bisect.c
45b63708 920) warning_errno(_("could not create file '%s'"),

René Scharfe	2ce6d075 use strpbrk(3) to search for characters from a given set
builtin/show-branch.c
2ce6d075 539) if (strpbrk(av, "*?[")) {

René Scharfe	a91cc7fa strbuf: add and use strbuf_insertstr()
notes.c
a91cc7fa 1337) strbuf_insertstr(sb, 0, "refs/");

René Scharfe	2d539754 name-rev: release unused name strings
builtin/name-rev.c
2d539754 102) free(name->tip_name);

Tanushree Tumane	bfacfce7 bisect--helper: introduce new `decide_next()` function
builtin/bisect--helper.c
bfacfce7 320) return -1;
bfacfce7 321) return 0;

Tanushree Tumane	292731c4 bisect--helper: change `retval` to `res`
builtin/bisect--helper.c
292731c4 227) res = -1;
292731c4 233) res = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
292731c4 410) res = -1;
292731c4 416) res = -1;
292731c4 582) res = -1;
292731c4 594) res = -1;
292731c4 606) res = -1;



