Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4093EC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6E02053B
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCX8P1Tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfKYPds (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:33:48 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:45970 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfKYPdr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 10:33:47 -0500
Received: by mail-qt1-f172.google.com with SMTP id 30so17588119qtz.12
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 07:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=biCUTFuDW2LAtQIfazwPu9RjSBlnr9cfnHoVdbTmZeU=;
        b=kCX8P1TkkMI/zyjiIRXF27N72LChr6qYqxfaphGN94Ch+m+BTwdxqdHjruoe9SElUW
         /QDEcxeM96Zor68+9a7u6uqP4b/4gXagrENSYVQcR3YseIrjLWV3P+sHudlwIUwnyrVz
         5HjuyVQjoDWNuO9xjdzYuXhLeWY/K23d3d+QZDiXHRCPnyYKxKJUZnH4gMfJLwmQRWNA
         fhiKjhzAi8E3k9G8PjJyNw4l6vgpv1WHxOWCp+/6CJc29nryC/1f/4rManIwZCV80gZ0
         x1rFa8en5vJL748oytOoGnSmRAvildaO7Wqh8HDcvgPnRqOMx77nPm0HubXPAse5gvKC
         wIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=biCUTFuDW2LAtQIfazwPu9RjSBlnr9cfnHoVdbTmZeU=;
        b=i/It2lUwHqhGDVus+PgB+AGz8YRnem+quCH0rTjT8HhVnsr1UeDiAz80WWIxniD4M0
         4/+LYHeI8AB+9JnDWZF0GgmPQHWdvFZNPEpYKzADQUWjUg3beWl31PkbwH/J4/MwDwEU
         n2uit9Pz/EqWbP+vjvtm/52ZRW3sie0Y3oOjemfoDT9EuKdW+yFs7gkQ+pa8LN84pa9K
         Lm9mEqpksbNS7sXqP7ytbvtTAeHXk3FM9f3YjxPFzrAEcLSzSyStNO/0K8VHBzVq63+h
         /nlCNECxdIIl2aHQXSEJlLn+8+CoyK9cfgrlHE9mjVMAsesrdMqWa79t8MoqKGrLTAPY
         DLvA==
X-Gm-Message-State: APjAAAU63JS7wv6svku7izM9fOaPrN2vwe6X17igCcadffxBSUY70r/X
        FjTMpVMfjl2oqOK/w22Bv5SQLqcGLOY=
X-Google-Smtp-Source: APXvYqwibwW2FVNwTG94xRbfVTuxv59I3K3MVr++blC6rp5BUnxFPQ27NizLHZ9Vss3+uyWQhCTstw==
X-Received: by 2002:aed:3eba:: with SMTP id n55mr18469667qtf.374.1574696022794;
        Mon, 25 Nov 2019 07:33:42 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:b980:e052:6a66:fccd? ([2001:4898:a800:1010:6ab6:e052:6a66:fccd])
        by smtp.gmail.com with ESMTPSA id k65sm4067050qtd.14.2019.11.25.07.33.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 07:33:41 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Nov 25)
Message-ID: <1cb7ddbf-020e-d63a-85b6-5a9267c0a5a3@gmail.com>
Date:   Mon, 25 Nov 2019 10:33:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report.

Sorry for the delay, but I had some issues working out the new
"ignored lines" logic. Now there are a few phrases that are
ignored automatically, including "BUG(" or "die(".

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-11-25.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-11-25.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2019-11-25-commits.txt

--- 

pu	28de5786e631095b76bbdbda51d874e6bee6cb70
jch	3cd56eb17de579e1687a705ccad9e58dca9f3dba
next	34dc348eaf04483f062911e310f14c9f4e8ddf1e
master	d9f6f3b6195a0ca35642561e530798ad1469bd41
master@{1}	origin/maint


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Derrick Stolee	d89f09c8 clone: add --sparse mode
builtin/clone.c
d89f09c8 753) result = 1;
d89f09c8 1136) return 1;

Derrick Stolee	e091228e sparse-checkout: update working directory in-process
builtin/sparse-checkout.c
e091228e 85) return 0;

Derrick Stolee	bab3c359 sparse-checkout: create 'init' subcommand
builtin/sparse-checkout.c
bab3c359 221) return 1;
bab3c359 275) return 1;

Derrick Stolee	af09ce24 sparse-checkout: init and set in cone mode
builtin/sparse-checkout.c
af09ce24 346) return;

Derrick Stolee	96cc8ab5 sparse-checkout: use hashmaps for cone patterns
dir.c
96cc8ab5 654) pl->use_cone_patterns = 0;
96cc8ab5 656) goto clear_hashmaps;
96cc8ab5 678) hashmap_add(&pl->parent_hashmap, &translated->ent);
96cc8ab5 679) hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
96cc8ab5 680) free(data);
96cc8ab5 681) return;
96cc8ab5 687) goto clear_hashmaps;
96cc8ab5 703) hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
96cc8ab5 704) free(data);
96cc8ab5 705) free(translated);
96cc8ab5 1264) return MATCHED;

Derrick Stolee	69dbc5db progress: create GIT_PROGRESS_DELAY
progress.c
69dbc5db 308) return start_progress_delay(title, total, get_default_delay(), 1);

Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
read-cache.c
ee70c128 1745) if (advice_unknown_index_extension) {

Josh Steadmon	6da1f1a9 protocol: advertise multiple supported versions
remote-curl.c
6da1f1a9 354) return 0;

Matheus Tavares	beebb9d2 object-store: allow threaded access to object reading
packfile.c
beebb9d2 1464) return;

sha1-file.c
beebb9d2 1431) return;
beebb9d2 1440) return;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Alban Gruin	393adf7a sequencer: directly call pick_commits() from complete_action()
sequencer.c
393adf7a 5270) goto cleanup;

Daniel Ferreira	5e82b9e4 built-in add -i: implement the `status` command
add-interactive.c
5e82b9e4 626) return -1;
5e82b9e4 629) putchar('\n');
5e82b9e4 631) return 0;

Johannes Schindelin	eea4a7f4 mingw: demonstrate that all file handles are inherited by child processes
t/helper/test-run-command.c
eea4a7f4 203) static int inherit_handle(const char *argv0)
eea4a7f4 205) struct child_process cp = CHILD_PROCESS_INIT;
eea4a7f4 210) xsnprintf(path, sizeof(path), "out-XXXXXX");
eea4a7f4 211) tmp = xmkstemp(path);
eea4a7f4 213) argv_array_pushl(&cp.args,
eea4a7f4 215) cp.in = -1;
eea4a7f4 216) cp.no_stdout = cp.no_stderr = 1;
eea4a7f4 217) if (start_command(&cp) < 0)
eea4a7f4 221) close(tmp);
eea4a7f4 222) if (unlink(path))
eea4a7f4 225) if (close(cp.in) < 0 || finish_command(&cp) < 0)
eea4a7f4 228) return 0;
eea4a7f4 231) static int inherit_handle_child(void)
eea4a7f4 233) struct strbuf buf = STRBUF_INIT;
eea4a7f4 235) if (strbuf_read(&buf, 0, 0) < 0)
eea4a7f4 237) printf("Received %s\n", buf.buf);
eea4a7f4 238) strbuf_release(&buf);
eea4a7f4 240) return 0;
eea4a7f4 251) exit(inherit_handle(argv[0]));
eea4a7f4 253) exit(inherit_handle_child());

Johannes Schindelin	116a408b commit: give correct advice for empty commit during a rebase
builtin/commit.c
116a408b 478) else if (whence == FROM_CHERRY_PICK) {
116a408b 479) if (rebase_in_progress && !sequencer_in_use)
116a408b 1186) else if (whence == FROM_CHERRY_PICK) {
116a408b 1187) if (rebase_in_progress && !sequencer_in_use)

Johannes Schindelin	0de7b036 built-in add -i: offer the `quit` command
add-interactive.c
0de7b036 1126) if (i < 0 || i >= commands.items.nr)
0de7b036 1127) util = NULL;
0de7b036 1129) util = commands.items.items[i].util;
0de7b036 1131) if (i == LIST_AND_CHOOSE_QUIT || (util && !util->command)) {
0de7b036 1137) if (util)

Johannes Schindelin	d17e3a76 built-in add -i: prepare for multi-selection commands
add-interactive.c
d17e3a76 88) FREE_AND_NULL(list->selected);
d17e3a76 195) static void list(struct add_i_state *s, struct string_list *list, int *selected,
d17e3a76 208) opts->print_item(i, selected ? selected[i] : 0, list->items + i,
d17e3a76 249) int singleton = opts->flags & SINGLETON;
d17e3a76 250) int immediate = opts->flags & IMMEDIATE;
d17e3a76 253) ssize_t res = singleton ? LIST_AND_CHOOSE_ERROR : 0;
d17e3a76 255) if (!singleton) {
d17e3a76 256) free(items->selected);
d17e3a76 257) CALLOC_ARRAY(items->selected, items->items.nr);
d17e3a76 260) if (singleton && !immediate)
d17e3a76 270) list(s, &items->items, items->selected, &opts->list_opts);
d17e3a76 273) fputs(singleton ? "> " : ">> ", stdout);
d17e3a76 278) if (immediate)
d17e3a76 279) res = LIST_AND_CHOOSE_QUIT;
d17e3a76 295) int choose = 1;
d17e3a76 297) ssize_t from = -1, to = -1;
d17e3a76 307) if (*p == '-') {
d17e3a76 308) choose = 0;
d17e3a76 309) p++;
d17e3a76 310) sep--;
d17e3a76 313) if (sep == 1 && *p == '*') {
d17e3a76 314) from = 0;
d17e3a76 315) to = items->items.nr;
d17e3a76 316) } else if (isdigit(*p)) {
d17e3a76 327) from = strtoul(p, &endp, 10) - 1;
d17e3a76 328) if (endp == p + sep)
d17e3a76 329) to = from + 1;
d17e3a76 330) else if (*endp == '-') {
d17e3a76 331) to = strtoul(++endp, &endp, 10);
d17e3a76 333) if (endp != p + sep)
d17e3a76 334) from = -1;
d17e3a76 340) if (from < 0) {
d17e3a76 341) from = find_unique(p, items);
d17e3a76 342) if (from >= 0)
d17e3a76 343) to = from + 1;
d17e3a76 346) if (from < 0 || from >= items->items.nr ||
d17e3a76 347)     (singleton && from + 1 != to)) {
d17e3a76 350) break;
d17e3a76 351) } else if (singleton) {
d17e3a76 352) res = from;
d17e3a76 356) if (to > items->items.nr)
d17e3a76 357) to = items->items.nr;
d17e3a76 359) for (; from < to; from++)
d17e3a76 360) if (items->selected[from] != choose) {
d17e3a76 361) items->selected[from] = choose;
d17e3a76 362) res += choose ? +1 : -1;
d17e3a76 368) if ((immediate && res != LIST_AND_CHOOSE_ERROR) ||
d17e3a76 369)     !strcmp(input.buf, "*"))
d17e3a76 585) static void print_file_item(int i, int selected, struct string_list_item *item,
d17e3a76 618) printf("%c%2d: %s", selected ? '*' : ' ', i + 1, d->buf.buf);
d17e3a76 1025) static void print_command_item(int i, int selected,

Johannes Schindelin	dea080c8 built-in add -i: re-implement `revert` in C
add-interactive.c
dea080c8 683) static void revert_from_diff(struct diff_queue_struct *q,
dea080c8 686) int i, add_flags = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
dea080c8 688) for (i = 0; i < q->nr; i++) {
dea080c8 689) struct diff_filespec *one = q->queue[i]->one;
dea080c8 692) if (!(one->mode && !is_null_oid(&one->oid))) {
dea080c8 693) remove_file_from_index(opt->repo->index, one->path);
dea080c8 694) printf(_("note: %s is untracked now.\n"), one->path);
dea080c8 696) ce = make_cache_entry(opt->repo->index, one->mode,
dea080c8 697)       &one->oid, one->path, 0, 0);
dea080c8 698) if (!ce)
dea080c8 701) add_index_entry(opt->repo->index, ce, add_flags);
dea080c8 704) }
dea080c8 706) static int run_revert(struct add_i_state *s, const struct pathspec *ps,
dea080c8 710) int res = 0, fd;
dea080c8 714) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
dea080c8 719) struct diff_options diffopt = { NULL };
dea080c8 724) if (!files->items.nr) {
dea080c8 725) putchar('\n');
dea080c8 726) return 0;
dea080c8 729) opts->prompt = N_("Revert");
dea080c8 730) count = list_and_choose(s, files, opts);
dea080c8 731) if (count <= 0)
dea080c8 732) goto finish_revert;
dea080c8 734) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
dea080c8 735) if (fd < 0) {
dea080c8 736) res = -1;
dea080c8 737) goto finish_revert;
dea080c8 740) if (is_initial)
dea080c8 741) oidcpy(&oid, s->r->hash_algo->empty_tree);
dea080c8 743) tree = parse_tree_indirect(&oid);
dea080c8 744) if (!tree) {
dea080c8 746) goto finish_revert;
dea080c8 748) oidcpy(&oid, &tree->object.oid);
dea080c8 751) ALLOC_ARRAY(paths, count + 1);
dea080c8 752) for (i = j = 0; i < files->items.nr; i++)
dea080c8 753) if (files->selected[i])
dea080c8 754) paths[j++] = files->items.items[i].string;
dea080c8 755) paths[j] = NULL;
dea080c8 757) parse_pathspec(&diffopt.pathspec, 0,
dea080c8 761) diffopt.output_format = DIFF_FORMAT_CALLBACK;
dea080c8 762) diffopt.format_callback = revert_from_diff;
dea080c8 763) diffopt.flags.override_submodule_config = 1;
dea080c8 764) diffopt.repo = s->r;
dea080c8 766) if (do_diff_cache(&oid, &diffopt))
dea080c8 767) res = -1;
dea080c8 769) diffcore_std(&diffopt);
dea080c8 770) diff_flush(&diffopt);
dea080c8 772) free(paths);
dea080c8 773) clear_pathspec(&diffopt.pathspec);
dea080c8 775) if (!res && write_locked_index(s->r->index, &index_lock,
dea080c8 777) res = -1;
dea080c8 779) res = repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0, 1,
dea080c8 782) if (!res)
dea080c8 783) printf(Q_("reverted %d path\n",
dea080c8 788) return res;

Johannes Schindelin	daabf56b built-in add -i: re-implement `add-untracked` in C
add-interactive.c
daabf56b 606) if (d->only_names) {
daabf56b 607) printf("%c%2d: %s", selected ? '*' : ' ', i + 1,
daabf56b 609) return;
daabf56b 791) static int get_untracked_files(struct repository *r,
daabf56b 795) struct dir_struct dir = { 0 };
daabf56b 797) struct strbuf buf = STRBUF_INIT;
daabf56b 799) if (repo_read_index(r) < 0)
daabf56b 802) prefix_item_list_clear(files);
daabf56b 803) setup_standard_excludes(&dir);
daabf56b 804) add_pattern_list(&dir, EXC_CMDL, "--exclude option");
daabf56b 805) fill_directory(&dir, r->index, ps);
daabf56b 807) for (i = 0; i < dir.nr; i++) {
daabf56b 808) struct dir_entry *ent = dir.entries[i];
daabf56b 810) if (index_name_is_other(r->index, ent->name, ent->len)) {
daabf56b 811) strbuf_reset(&buf);
daabf56b 812) strbuf_add(&buf, ent->name, ent->len);
daabf56b 813) add_file_item(&files->items, buf.buf);
daabf56b 817) strbuf_release(&buf);
daabf56b 821) static int run_add_untracked(struct add_i_state *s, const struct pathspec *ps,
daabf56b 825) struct print_file_item_data *d = opts->list_opts.print_item_data;
daabf56b 826) int res = 0, fd;
daabf56b 830) if (get_untracked_files(s->r, files, ps) < 0)
daabf56b 831) return -1;
daabf56b 833) if (!files->items.nr) {
daabf56b 834) printf(_("No untracked files.\n"));
daabf56b 835) goto finish_add_untracked;
daabf56b 838) opts->prompt = N_("Add untracked");
daabf56b 839) d->only_names = 1;
daabf56b 840) count = list_and_choose(s, files, opts);
daabf56b 841) d->only_names = 0;
daabf56b 842) if (count <= 0)
daabf56b 843) goto finish_add_untracked;
daabf56b 845) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
daabf56b 846) if (fd < 0) {
daabf56b 847) res = -1;
daabf56b 848) goto finish_add_untracked;
daabf56b 851) for (i = 0; i < files->items.nr; i++) {
daabf56b 852) const char *name = files->items.items[i].string;
daabf56b 853) if (files->selected[i] &&
daabf56b 854)     add_file_to_index(s->r->index, name, 0) < 0) {
daabf56b 856) break;
daabf56b 860) if (!res &&
daabf56b 861)     write_locked_index(s->r->index, &index_lock, COMMIT_LOCK) < 0)
daabf56b 864) if (!res)
daabf56b 865) printf(Q_("added %d path\n",
daabf56b 869) putchar('\n');
daabf56b 870) return res;

Johannes Schindelin	4ba7c22a built-in add -i: implement the `update` command
add-interactive.c
4ba7c22a 504) prefix_item_list_clear(files);
4ba7c22a 505) s.files = &files->items;
4ba7c22a 545) string_list_sort(&files->items);
4ba7c22a 590) const char *highlighted = NULL;
4ba7c22a 597) if (c->prefix_length > 0 &&
4ba7c22a 598)     is_valid_prefix(item->string, c->prefix_length)) {
4ba7c22a 599) strbuf_reset(&d->name);
4ba7c22a 600) strbuf_addf(&d->name, "%s%.*s%s%s", d->color,
4ba7c22a 601)     (int)c->prefix_length, item->string, d->reset,
4ba7c22a 602)     item->string + c->prefix_length);
4ba7c22a 603) highlighted = d->name.buf;
4ba7c22a 615) strbuf_addf(&d->buf, d->modified_fmt, d->index.buf, d->worktree.buf,
4ba7c22a 628) list(s, &files->items, NULL, &opts->list_opts);
4ba7c22a 634) static int run_update(struct add_i_state *s, const struct pathspec *ps,
4ba7c22a 638) int res = 0, fd;
4ba7c22a 643) return -1;
4ba7c22a 645) if (!files->items.nr) {
4ba7c22a 646) putchar('\n');
4ba7c22a 647) return 0;
4ba7c22a 650) opts->prompt = N_("Update");
4ba7c22a 651) count = list_and_choose(s, files, opts);
4ba7c22a 652) if (count <= 0) {
4ba7c22a 653) putchar('\n');
4ba7c22a 654) return 0;
4ba7c22a 657) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
4ba7c22a 658) if (fd < 0) {
4ba7c22a 659) putchar('\n');
4ba7c22a 660) return -1;
4ba7c22a 663) for (i = 0; i < files->items.nr; i++) {
4ba7c22a 664) const char *name = files->items.items[i].string;
4ba7c22a 665) if (files->selected[i] &&
4ba7c22a 666)     add_file_to_index(s->r->index, name, 0) < 0) {
4ba7c22a 668) break;
4ba7c22a 672) if (!res && write_locked_index(s->r->index, &index_lock, COMMIT_LOCK) < 0)
4ba7c22a 675) if (!res)
4ba7c22a 676) printf(Q_("updated %d path\n",
4ba7c22a 679) putchar('\n');
4ba7c22a 680) return res;
4ba7c22a 992) static void choose_prompt_help(struct add_i_state *s)
4ba7c22a 994) color_fprintf_ln(stdout, s->help_color, "%s",
4ba7c22a 996) color_fprintf_ln(stdout, s->help_color, "1          - %s",
4ba7c22a 998) color_fprintf_ln(stdout, s->help_color, "3-5        - %s",
4ba7c22a 1000) color_fprintf_ln(stdout, s->help_color, "2-3,6-9    - %s",
4ba7c22a 1002) color_fprintf_ln(stdout, s->help_color, "foo        - %s",
4ba7c22a 1004) color_fprintf_ln(stdout, s->help_color, "-...       - %s",
4ba7c22a 1006) color_fprintf_ln(stdout, s->help_color, "*          - %s",
4ba7c22a 1008) color_fprintf_ln(stdout, s->help_color, "           - %s",
4ba7c22a 1010) }
4ba7c22a 1080) struct list_and_choose_options opts = {
4ba7c22a 1085) struct prefix_item_list files = PREFIX_ITEM_LIST_INIT;
4ba7c22a 1106) print_file_item_data.color = data.color;
4ba7c22a 1107) print_file_item_data.reset = data.reset;
4ba7c22a 1112) opts.list_opts.header = header.buf;
4ba7c22a 1141) prefix_item_list_clear(&files);
4ba7c22a 1143) strbuf_release(&print_file_item_data.name);

Johannes Schindelin	9d86921e built-in add -i: implement the `patch` command
add-interactive.c
9d86921e 462) other_adddel = s->phase == FROM_INDEX ?
9d86921e 463) &file_item->worktree : &file_item->index;
9d86921e 467) if (stat.files[i]->is_binary) {
9d86921e 468) if (!other_adddel->binary)
9d86921e 469) s->binary_count++;
9d86921e 472) if (stat.files[i]->is_unmerged) {
9d86921e 473) if (!other_adddel->unmerged)
9d86921e 474) s->unmerged_count++;
9d86921e 475) adddel->unmerged = 1;
9d86921e 539) if (unmerged_count)
9d86921e 540) *unmerged_count = s.unmerged_count;
9d86921e 541) if (binary_count)
9d86921e 542) *binary_count = s.binary_count;
9d86921e 625) if (get_modified_files(s->r, NO_FILTER, files, ps, NULL, NULL) < 0)
9d86921e 642) if (get_modified_files(s->r, WORKTREE_ONLY, files, ps, NULL, NULL) < 0)
9d86921e 721) if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
9d86921e 873) static int run_patch(struct add_i_state *s, const struct pathspec *ps,
9d86921e 877) int res = 0;
9d86921e 879) size_t unmerged_count = 0, binary_count = 0;
9d86921e 881) if (get_modified_files(s->r, WORKTREE_ONLY, files, ps,
9d86921e 883) return -1;
9d86921e 885) if (unmerged_count || binary_count) {
9d86921e 886) for (i = j = 0; i < files->items.nr; i++) {
9d86921e 887) struct file_item *item = files->items.items[i].util;
9d86921e 889) if (item->index.binary || item->worktree.binary) {
9d86921e 890) free(item);
9d86921e 891) free(files->items.items[i].string);
9d86921e 892) } else if (item->index.unmerged ||
9d86921e 894) color_fprintf_ln(stderr, s->error_color,
9d86921e 896)  files->items.items[i].string);
9d86921e 897) free(item);
9d86921e 898) free(files->items.items[i].string);
9d86921e 900) files->items.items[j++] = files->items.items[i];
9d86921e 902) files->items.nr = j;
9d86921e 905) if (!files->items.nr) {
9d86921e 906) if (binary_count)
9d86921e 907) fprintf(stderr, _("Only binary files changed.\n"));
9d86921e 909) fprintf(stderr, _("No changes.\n"));
9d86921e 910) return 0;
9d86921e 913) opts->prompt = N_("Patch update");
9d86921e 914) count = list_and_choose(s, files, opts);
9d86921e 915) if (count >= 0) {
9d86921e 916) struct argv_array args = ARGV_ARRAY_INIT;
9d86921e 918) argv_array_pushl(&args, "git", "add--interactive", "--patch",
9d86921e 920) for (i = 0; i < files->items.nr; i++)
9d86921e 921) if (files->selected[i])
9d86921e 922) argv_array_push(&args,
9d86921e 923) files->items.items[i].string);
9d86921e 924) res = run_command_v_opt(args.argv, 0);
9d86921e 925) argv_array_clear(&args);
9d86921e 928) return res;

Johannes Schindelin	a5ced6db built-in add -i: allow filtering the modified files list
add-interactive.c
a5ced6db 447) if (s->skip_unseen)
a5ced6db 448) continue;
a5ced6db 487) static int get_modified_files(struct repository *r,
a5ced6db 508) for (i = 0; i < 2; i++) {
a5ced6db 512) if (filter == INDEX_ONLY)
a5ced6db 513) s.phase = i ? FROM_WORKTREE : FROM_INDEX;
a5ced6db 515) s.phase = i ? FROM_INDEX : FROM_WORKTREE;
a5ced6db 516) s.skip_unseen = filter && i;

Johannes Schindelin	465a9699 built-in add -i: re-implement the `diff` command
add-interactive.c
465a9699 931) static int run_diff(struct add_i_state *s, const struct pathspec *ps,
465a9699 935) int res = 0;
465a9699 939) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
465a9699 941) if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
465a9699 942) return -1;
465a9699 944) if (!files->items.nr) {
465a9699 945) putchar('\n');
465a9699 946) return 0;
465a9699 949) opts->prompt = N_("Review diff");
465a9699 950) opts->flags = IMMEDIATE;
465a9699 951) count = list_and_choose(s, files, opts);
465a9699 952) opts->flags = 0;
465a9699 953) if (count >= 0) {
465a9699 954) struct argv_array args = ARGV_ARRAY_INIT;
465a9699 956) argv_array_pushl(&args, "git", "diff", "-p", "--cached",
465a9699 958)     s->r->hash_algo->empty_tree),
465a9699 960) for (i = 0; i < files->items.nr; i++)
465a9699 961) if (files->selected[i])
465a9699 962) argv_array_push(&args,
465a9699 963) files->items.items[i].string);
465a9699 964) res = run_command_v_opt(args.argv, 0);
465a9699 965) argv_array_clear(&args);
465a9699 968) putchar('\n');
465a9699 969) return res;

Martin Ågren	3bcdd852 builtin/config: extract `handle_value_regex()` from `get_value()`
builtin/config.c
3bcdd852 330) return CONFIG_INVALID_PATTERN;
3bcdd852 375) goto free_strings;

Martin Ågren	3bf986d6 builtin/config: collect "value_regexp" data in a struct
builtin/config.c
3bf986d6 329) FREE_AND_NULL(cmd_line_value.regexp);

Mike Hommey	0aa0c2b2 revision: free topo_walk_info before creating a new one in init_topo_walk
revision.c
0aa0c2b2 3214) static void reset_topo_walk(struct rev_info *revs)
0aa0c2b2 3216) struct topo_walk_info *info = revs->topo_walk_info;
0aa0c2b2 3218) clear_prio_queue(&info->explore_queue);
0aa0c2b2 3219) clear_prio_queue(&info->indegree_queue);
0aa0c2b2 3220) clear_prio_queue(&info->topo_queue);
0aa0c2b2 3221) clear_indegree_slab(&info->indegree);
0aa0c2b2 3222) clear_author_date_slab(&info->author_date);
0aa0c2b2 3224) FREE_AND_NULL(revs->topo_walk_info);
0aa0c2b2 3225) }
0aa0c2b2 3232) reset_topo_walk(revs);

Rohit Ashiwal	c068bcc5 sequencer: allow callers of read_author_script() to ignore fields
sequencer.c
c068bcc5 840) free(kv.items[date_i].util);

Rohit Ashiwal	cbd8db17 rebase -i: support --committer-date-is-author-date
sequencer.c
cbd8db17 890) return NULL;
cbd8db17 989) return -1;
cbd8db17 1428) goto out;
cbd8db17 1432) goto out;
cbd8db17 2603) opts->allow_ff = 0;
cbd8db17 2604) opts->committer_date_is_author_date = 1;

Rohit Ashiwal	08187b4c rebase -i: support --ignore-date
sequencer.c
08187b4c 903) return NULL;
08187b4c 920) argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
08187b4c 1508) res = -1;
08187b4c 1509) goto out;
08187b4c 2608) opts->allow_ff = 0;
08187b4c 2609) opts->ignore_date = 1;
08187b4c 3639) push_dates(&cmd, opts->committer_date_is_author_date);



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
Daniel Ferreira	5e82b9e4 built-in add -i: implement the `status` command
add-interactive.c
5e82b9e4 36) static void init_add_i_state(struct add_i_state *s, struct repository *r)
5e82b9e4 54) }
5e82b9e4 194) if (!list->nr)
5e82b9e4 195) return;
5e82b9e4 197) if (opts->header)
5e82b9e4 201) for (i = 0; i < list->nr; i++) {
5e82b9e4 202) opts->print_item(i, list->items + i, opts->print_item_data);
5e82b9e4 215) putchar('\n');
5e82b9e4 305) }
5e82b9e4 320) static void add_file_item(struct string_list *files, const char *name)
5e82b9e4 322) struct file_item *item = xcalloc(sizeof(*item), 1);
5e82b9e4 324) string_list_append(files, name)->util = item;
5e82b9e4 325) }
5e82b9e4 333) static int pathname_entry_cmp(const void *unused_cmp_data,
5e82b9e4 338) const struct pathname_entry *e1 =
5e82b9e4 340) const struct pathname_entry *e2 =
5e82b9e4 343) return strcmp(e1->name, name ? (const char *)name : e2->name);
5e82b9e4 355) static void collect_changes_cb(struct diff_queue_struct *q,
5e82b9e4 359) struct collection_status *s = data;
5e82b9e4 360) struct diffstat_t stat = { 0 };
5e82b9e4 363) if (!q->nr)
5e82b9e4 364) return;
5e82b9e4 366) compute_diffstat(options, &stat, q);
5e82b9e4 368) for (i = 0; i < stat.nr; i++) {
5e82b9e4 369) const char *name = stat.files[i]->name;
5e82b9e4 370) int hash = strhash(name);
5e82b9e4 375) entry = hashmap_get_entry_from_hash(&s->file_map, hash, name,
5e82b9e4 377) if (!entry) {
5e82b9e4 378) add_file_item(s->files, name);
5e82b9e4 380) entry = xcalloc(sizeof(*entry), 1);
5e82b9e4 381) hashmap_entry_init(&entry->ent, hash);
5e82b9e4 382) entry->name = s->files->items[s->files->nr - 1].string;
5e82b9e4 383) entry->item = s->files->items[s->files->nr - 1].util;
5e82b9e4 384) hashmap_add(&s->file_map, &entry->ent);
5e82b9e4 387) file_item = entry->item;
5e82b9e4 388) adddel = s->phase == FROM_INDEX ?
5e82b9e4 389) &file_item->index : &file_item->worktree;
5e82b9e4 390) adddel->seen = 1;
5e82b9e4 391) adddel->add = stat.files[i]->added;
5e82b9e4 392) adddel->del = stat.files[i]->deleted;
5e82b9e4 393) if (stat.files[i]->is_binary)
5e82b9e4 394) adddel->binary = 1;
5e82b9e4 396) free_diffstat_info(&stat);
5e82b9e4 399) static int get_modified_files(struct repository *r, struct string_list *files,
5e82b9e4 403) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
5e82b9e4 405) struct collection_status s = { FROM_WORKTREE };
5e82b9e4 407) if (discard_index(r->index) < 0 ||
5e82b9e4 408)     repo_read_index_preload(r, ps, 0) < 0)
5e82b9e4 411) string_list_clear(files, 1);
5e82b9e4 412) s.files = files;
5e82b9e4 413) hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
5e82b9e4 415) for (s.phase = FROM_WORKTREE; s.phase <= FROM_INDEX; s.phase++) {
5e82b9e4 417) struct setup_revision_opt opt = { 0 };
5e82b9e4 419) opt.def = is_initial ?
5e82b9e4 420) empty_tree_oid_hex() : oid_to_hex(&head_oid);
5e82b9e4 422) init_revisions(&rev, NULL);
5e82b9e4 423) setup_revisions(0, NULL, &rev, &opt);
5e82b9e4 425) rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
5e82b9e4 426) rev.diffopt.format_callback = collect_changes_cb;
5e82b9e4 427) rev.diffopt.format_callback_data = &s;
5e82b9e4 429) if (ps)
5e82b9e4 430) copy_pathspec(&rev.prune_data, ps);
5e82b9e4 432) if (s.phase == FROM_INDEX)
5e82b9e4 433) run_diff_index(&rev, 1);
5e82b9e4 435) rev.diffopt.flags.ignore_dirty_submodules = 1;
5e82b9e4 436) run_diff_files(&rev, 0);
5e82b9e4 439) hashmap_free_entries(&s.file_map, struct pathname_entry, ent);
5e82b9e4 442) string_list_sort(files);
5e82b9e4 444) return 0;
5e82b9e4 447) static void render_adddel(struct strbuf *buf,
5e82b9e4 450) if (ad->binary)
5e82b9e4 451) strbuf_addstr(buf, _("binary"));
5e82b9e4 452) else if (ad->seen)
5e82b9e4 453) strbuf_addf(buf, "+%"PRIuMAX"/-%"PRIuMAX,
5e82b9e4 454)     (uintmax_t)ad->add, (uintmax_t)ad->del);
5e82b9e4 456) strbuf_addstr(buf, no_changes);
5e82b9e4 457) }
5e82b9e4 481) static void print_file_item(int i, struct string_list_item *item,
5e82b9e4 484) struct file_item *c = item->util;
5e82b9e4 485) struct print_file_item_data *d = print_file_item_data;
5e82b9e4 487) strbuf_reset(&d->index);
5e82b9e4 488) strbuf_reset(&d->worktree);
5e82b9e4 489) strbuf_reset(&d->buf);
5e82b9e4 491) render_adddel(&d->worktree, &c->worktree, _("nothing"));
5e82b9e4 492) render_adddel(&d->index, &c->index, _("unchanged"));
5e82b9e4 493) strbuf_addf(&d->buf, d->modified_fmt,
5e82b9e4 496) printf(" %2d: %s", i + 1, d->buf.buf);
5e82b9e4 497) }
5e82b9e4 499) static int run_status(struct add_i_state *s, const struct pathspec *ps,
5e82b9e4 502) if (get_modified_files(s->r, files, ps) < 0)
5e82b9e4 503) return -1;
5e82b9e4 506) putchar('\n');
5e82b9e4 508) return 0;
5e82b9e4 573) struct add_i_state s = { NULL };
5e82b9e4 588) struct print_file_item_data print_file_item_data = {
5e82b9e4 591) struct list_options opts = {
5e82b9e4 594) struct strbuf header = STRBUF_INIT;
5e82b9e4 595) struct string_list files = STRING_LIST_INIT_DUP;
5e82b9e4 597) int res = 0;
5e82b9e4 606) init_add_i_state(&s, r);
5e82b9e4 617) strbuf_addstr(&header, "      ");
5e82b9e4 618) strbuf_addf(&header, print_file_item_data.modified_fmt,
5e82b9e4 620) opts.header = header.buf;
5e82b9e4 622) if (discard_index(r->index) < 0 ||
5e82b9e4 623)     repo_read_index(r) < 0 ||
5e82b9e4 624)     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
5e82b9e4 628) res = run_status(&s, ps, &files, &opts);
5e82b9e4 644) string_list_clear(&files, 1);
5e82b9e4 645) strbuf_release(&print_file_item_data.buf);
5e82b9e4 646) strbuf_release(&print_file_item_data.index);
5e82b9e4 647) strbuf_release(&print_file_item_data.worktree);
5e82b9e4 648) strbuf_release(&header);
5e82b9e4 651) return res;

Derrick Stolee	4bd0593e test-tool: use 'read-graph' helper
t/helper/test-read-graph.c
4bd0593e 23) die_errno(_("Could not open commit-graph '%s'"), graph_name);
4bd0593e 27) return 1;

Hans Jerry Illikainen	392b862e gpg-interface: refactor the free-and-xmemdupz pattern
gpg-interface.c
392b862e 115) *field = NULL;

Hans Jerry Illikainen	67a6ea63 gpg-interface: limit search for primary key fingerprint
gpg-interface.c
67a6ea63 184) replace_cstring(field, NULL, NULL);

James Coglan	fbccf255 graph: automatically track display width of graph lines
graph.c
fbccf255 904) graph_line_write_column(line, col, '|');

James Coglan	0195285b graph: rename `new_mapping` to `old_mapping`
graph.c
0195285b 421) REALLOC_ARRAY(graph->old_mapping, graph->column_capacity * 2);

Jeff King	103fb6d4 fsck: accept an oid instead of a "struct tag" for fsck_tag()
fsck.c
103fb6d4 837) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
103fb6d4 841) ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
103fb6d4 848) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
103fb6d4 853) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
103fb6d4 857) ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
103fb6d4 863) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
103fb6d4 868) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");

Jeff King	6da40b22 fsck: accept an oid instead of a "struct blob" for fsck_blob()
fsck.c
6da40b22 958) return report(options, oid, OBJ_BLOB,

Jeff King	38370253 fsck: don't require an object struct for report()
fsck.c
38370253 980) return report(options, NULL, OBJ_NONE, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
38370253 991) return report(options, &obj->oid, obj->type,
38370253 994)       obj->type);
38370253 1029) ret |= report(options,

Jeff King	b8b00f16 fsck: drop blob struct from fsck_finish()
fsck.c
b8b00f16 1027) if (is_promisor_object(oid))

Jeff King	c5b4269b fsck: accept an oid instead of a "struct commit" for fsck_commit()
fsck.c
c5b4269b 781) return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
c5b4269b 783) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
c5b4269b 790) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
c5b4269b 804) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
c5b4269b 810) return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");

Jeff King	7b143c16 pack-bitmap: introduce bitmap_walk_contains()
pack-bitmap.c
7b143c16 903) return 0;

Jeff King	f66e0401 pack-objects: avoid pointless oe_map_new_pack() calls
pack-objects.c
f66e0401 122) if (pack->in_pack)
f66e0401 125) ALLOC_ARRAY(pack->in_pack, pack->nr_alloc);

Jeff King	ad7a4032 send-pack: check remote ref status on pack-objects failure
send-pack.c
ad7a4032 580) receive_status(&reader, remote_refs);

Jeff King	228c78fb commit, tag: don't set parsed bit for parse failures
tag.c
228c78fb 152) FREE_AND_NULL(item->tag);

Jeff King	78543993 fsck: don't require an object struct for fsck_ident()
fsck.c
78543993 733) return report(options, oid, type, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
78543993 740) return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
78543993 744) return report(options, oid, type, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
78543993 750) return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
78543993 754) return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
78543993 762) return report(options, oid, type, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");

Jeff King	cc579000 fsck: don't require an object struct in verify_headers()
fsck.c
cc579000 717) return report(options, oid, type,

Jeff King	73390290 fsck: use oids rather than objects for object_name API
fsck.c
73390290 400) fsck_put_object_name(options, &entry.oid, "%s%s/",
73390290 469) fsck_put_object_name(options, oid, "%s^%d",
73390290 472) fsck_put_object_name(options, oid, "%.*s~%d",
73390290 495) fsck_put_object_name(options, &tag->tagged->oid, "%s", name);

Jeff King	7cb9754e pack-objects: introduce pack.allowPackReuse
builtin/pack-objects.c
7cb9754e 2834) allow_pack_reuse = git_config_bool(k, v);
7cb9754e 2835) return 0;

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

Jeff King	82ef89b3 fsck: don't require object structs for display functions
builtin/fsck.c
82ef89b3 64) type = oid_object_info(the_repository, oid, NULL);
82ef89b3 309) printf_ln(_("unreachable %s %s"),
82ef89b3 310)   printable_type(&obj->oid, obj->type),
82ef89b3 311)   describe_object(&obj->oid));
82ef89b3 367) fprintf_ln(stderr, _("Checking %s"), describe_object(&obj->oid));
82ef89b3 425)    printable_type(&obj->oid, obj->type),
82ef89b3 426)    describe_object(&obj->oid));
82ef89b3 439)   describe_object(&commit->object.oid));

Jeff King	b2f2039c fsck: accept an oid instead of a "struct tree" for fsck_tree()
fsck.c
b2f2039c 622) retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
b2f2039c 669) retval += report(options, oid, OBJ_TREE, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
b2f2039c 671) retval += report(options, oid, OBJ_TREE, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
b2f2039c 679) retval += report(options, oid, OBJ_TREE, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
b2f2039c 681) retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
b2f2039c 685) retval += report(options, oid, OBJ_TREE, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");

Johannes Schindelin	68db1cbf built-in add -i: support `?` (prompt help)
add-interactive.c
68db1cbf 50) init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
68db1cbf 263) if (!strcmp(input.buf, "?")) {
68db1cbf 264) opts->print_help(s);
68db1cbf 265) continue;
68db1cbf 559) static void command_prompt_help(struct add_i_state *s)
68db1cbf 561) const char *help_color = s->help_color;
68db1cbf 562) color_fprintf_ln(stdout, help_color, "%s", _("Prompt help:"));
68db1cbf 563) color_fprintf_ln(stdout, help_color, "1          - %s",
68db1cbf 565) color_fprintf_ln(stdout, help_color, "foo        - %s",
68db1cbf 567) color_fprintf_ln(stdout, help_color, "           - %s",
68db1cbf 569) }

Johannes Schindelin	76b74323 built-in add -i: show unique prefixes of the commands
add-interactive.c
76b74323 80) static void prefix_item_list_clear(struct prefix_item_list *list)
76b74323 82) string_list_clear(&list->items, 1);
76b74323 83) string_list_clear(&list->sorted, 0);
76b74323 84) }
76b74323 86) static void extend_prefix_length(struct string_list_item *p,
76b74323 89) size_t *len = p->util;
76b74323 91) if (!*len || memcmp(p->string, other_string, *len))
76b74323 92) return;
76b74323 95) char c = p->string[*len];
76b74323 103) if (!c || ++*len > max_length || !isascii(c)) {
76b74323 104) *len = 0;
76b74323 105) break;
76b74323 108) if (c != other_string[*len - 1])
76b74323 109) break;
76b74323 110) }
76b74323 113) static void find_unique_prefixes(struct prefix_item_list *list)
76b74323 117) if (list->sorted.nr == list->items.nr)
76b74323 118) return;
76b74323 120) string_list_clear(&list->sorted, 0);
76b74323 122) list->sorted.items = xmalloc(st_mult(sizeof(*list->sorted.items),
76b74323 123)      list->items.nr));
76b74323 124) list->sorted.nr = list->sorted.alloc = list->items.nr;
76b74323 126) for (i = 0; i < list->items.nr; i++) {
76b74323 127) list->sorted.items[i].string = list->items.items[i].string;
76b74323 128) list->sorted.items[i].util = list->items.items + i;
76b74323 131) string_list_sort(&list->sorted);
76b74323 133) for (i = 0; i < list->sorted.nr; i++) {
76b74323 134) struct string_list_item *sorted_item = list->sorted.items + i;
76b74323 135) struct string_list_item *item = sorted_item->util;
76b74323 136) size_t *len = item->util;
76b74323 138) *len = 0;
76b74323 139) while (*len < list->min_length) {
76b74323 140) char c = item->string[(*len)++];
76b74323 142) if (!c || !isascii(c)) {
76b74323 143) *len = 0;
76b74323 144) break;
76b74323 148) if (i > 0)
76b74323 149) extend_prefix_length(item, sorted_item[-1].string,
76b74323 151) if (i + 1 < list->sorted.nr)
76b74323 152) extend_prefix_length(item, sorted_item[1].string,
76b74323 157) static ssize_t find_unique(const char *string, struct prefix_item_list *list)
76b74323 159) int index = string_list_find_insert_index(&list->sorted, string, 1);
76b74323 162) if (list->items.nr != list->sorted.nr)
76b74323 167) if (index < 0)
76b74323 168) item = list->sorted.items[-1 - index].util;
76b74323 169) else if (index > 0 &&
76b74323 170)  starts_with(list->sorted.items[index - 1].string, string))
76b74323 171) return -1;
76b74323 172) else if (index + 1 < list->sorted.nr &&
76b74323 173)  starts_with(list->sorted.items[index + 1].string, string))
76b74323 174) return -1;
76b74323 175) else if (index < list->sorted.nr)
76b74323 176) item = list->sorted.items[Index].util;
76b74323 178) return -1;
76b74323 179) return item - list->items.items;
76b74323 233) static ssize_t list_and_choose(struct add_i_state *s,
76b74323 240) find_unique_prefixes(items);
76b74323 247) list(s, &items->items, &opts->list_opts);
76b74323 289) if (index < 0)
76b74323 290) index = find_unique(p, items);
76b74323 292) if (index < 0 || index >= items->items.nr)
76b74323 460) static int is_valid_prefix(const char *prefix, size_t prefix_len)
76b74323 462) return prefix_len && prefix &&
76b74323 468) strcspn(prefix, " \t\r\n,") >= prefix_len &&	/* separators */
76b74323 469) *prefix != '-' &&				/* deselection */
76b74323 470) !isdigit(*prefix) &&				/* selection */
76b74323 471) (prefix_len != 1 ||
76b74323 472)  (*prefix != '*' &&				/* "all" wildcard */
76b74323 473)   *prefix != '?'));				/* prompt help */
76b74323 548) struct command_item *util = item->util;
76b74323 550) if (!util->prefix_length ||
76b74323 551)     !is_valid_prefix(item->string, util->prefix_length))
76b74323 552) printf(" %2d: %s", i + 1, item->string);
76b74323 586) struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
76b74323 599) for (i = 0; i < ARRAY_SIZE(command_list); i++) {
76b74323 600) struct command_item *util = xcalloc(sizeof(*util), 1);
76b74323 601) util->command = command_list[i].command;
76b74323 602) string_list_append(&commands.items, command_list[i].string)
76b74323 603) ->util = util;
76b74323 638) struct command_item *util =
76b74323 639) commands.items.items[i].util;
76b74323 640) res = util->command(&s, ps, &files, &opts);
76b74323 649) prefix_item_list_clear(&commands);

Johannes Schindelin	867bc1d2 rebase-merges: move labels' whitespace mangling into `label_oid()`
sequencer.c
867bc1d2 4539) }

Johannes Schindelin	6348bfba built-in add -i: implement the main loop
add-interactive.c
6348bfba 192) int i, last_lf = 0;
6348bfba 204) if ((opts->columns) && ((i + 1) % (opts->columns))) {
6348bfba 205) putchar('\t');
6348bfba 206) last_lf = 0;
6348bfba 209) putchar('\n');
6348bfba 210) last_lf = 1;
6348bfba 214) if (!last_lf)
6348bfba 237) struct strbuf input = STRBUF_INIT;
6348bfba 238) ssize_t res = LIST_AND_CHOOSE_ERROR;
6348bfba 245) strbuf_reset(&input);
6348bfba 251) fflush(stdout);
6348bfba 253) if (strbuf_getline(&input, stdin) == EOF) {
6348bfba 254) putchar('\n');
6348bfba 255) res = LIST_AND_CHOOSE_QUIT;
6348bfba 256) break;
6348bfba 258) strbuf_trim(&input);
6348bfba 260) if (!input.len)
6348bfba 261) break;
6348bfba 268) p = input.buf;
6348bfba 270) size_t sep = strcspn(p, " \t\r\n,");
6348bfba 271) ssize_t index = -1;
6348bfba 273) if (!sep) {
6348bfba 274) if (!*p)
6348bfba 275) break;
6348bfba 276) p++;
6348bfba 277) continue;
6348bfba 280) if (isdigit(*p)) {
6348bfba 282) index = strtoul(p, &endp, 10) - 1;
6348bfba 283) if (endp != p + sep)
6348bfba 284) index = -1;
6348bfba 287) if (p[sep])
6348bfba 288) p[sep++] = '\0';
6348bfba 296) res = index;
6348bfba 297) break;
6348bfba 300) p += sep;
6348bfba 301) }
6348bfba 303) if (res != LIST_AND_CHOOSE_ERROR)
6348bfba 304) break;
6348bfba 307) strbuf_release(&input);
6348bfba 308) return res;
6348bfba 544) static void print_command_item(int i, struct string_list_item *item,
6348bfba 557) }
6348bfba 575) struct list_and_choose_options main_loop_opts = {
6348bfba 582) } command_list[] = {
6348bfba 631) i = list_and_choose(&s, &commands, &main_loop_opts);
6348bfba 632) if (i == LIST_AND_CHOOSE_QUIT) {
6348bfba 633) printf(_("Bye.\n"));
6348bfba 634) res = 0;
6348bfba 635) break;
6348bfba 637) if (i != LIST_AND_CHOOSE_ERROR) {
6348bfba 642) }

Johannes Schindelin	4d17fd25 remote-curl: unbreak http.extraHeader with custom allocators
http.c
4d17fd25 417) string_list_clear(&extra_http_headers, 0);

Johannes Schindelin	2e0afafe Add git-bundle: move objects and references by archive
builtin/bundle.c
2e0afafe 115) return 1;

Johannes Schindelin	116d1fa6 vreportf(): avoid relying on stdio buffering
usage.c
116d1fa6 16) fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
116d1fa6 17) abort();
116d1fa6 22) *p = '\0'; /* vsnprintf() failed, clip at prefix */

Johannes Schindelin	f83dff60 Start to implement a built-in version of `git add --interactive`
add-interactive.c
f83dff60 571) int run_add_i(struct repository *r, const struct pathspec *ps)

builtin/add.c
f83dff60 197) return !!run_add_i(the_repository, pathspec);

Matthew Rogers	cd552227 rebase -r: let `label` generate safer labels
sequencer.c
cd552227 4514) strbuf_addstr(buf, "rev-");
cd552227 4515) strbuf_add_unique_abbrev(buf, oid, default_abbrev);

Phillip Wood	2d05ef27 sequencer: fix empty commit check when amending
sequencer.c
2d05ef27 1361) goto out;

Robin H. Johnson	73c3253d bundle: framework for options before bundle file
builtin/bundle.c
73c3253d 138) return 1;
73c3253d 143) static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix) {
73c3253d 145) int bundle_fd = -1;
73c3253d 147) struct option options[] = {
73c3253d 152) argc = parse_options_cmd_bundle(argc, argv, prefix,
73c3253d 156) memset(&header, 0, sizeof(header));
73c3253d 157) if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0)
73c3253d 158) return 1;
73c3253d 159) if (!startup_info->have_repository)
73c3253d 161) return !!unbundle(the_repository, &header, bundle_fd, 0) ||
73c3253d 162) list_bundle_refs(&header, argc, argv);
73c3253d 187) else if (!strcmp(argv[0], "unbundle"))
73c3253d 188) result = cmd_bundle_unbundle(argc, argv, prefix);

Robin H. Johnson	79862b6b bundle-create: progress output control
builtin/bundle.c
79862b6b 85) else if (progress == 1)
79862b6b 86) argv_array_push(&pack_opts, "--progress");
79862b6b 87) else if (progress == 2)
79862b6b 88) argv_array_push(&pack_opts, "--all-progress");
79862b6b 90) argv_array_push(&pack_opts, "--all-progress-implied");

Slavica Đukić	8c159044 built-in add -i: implement the `help` command
add-interactive.c
8c159044 511) static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
8c159044 515) color_fprintf_ln(stdout, s->help_color, "status        - %s",
8c159044 517) color_fprintf_ln(stdout, s->help_color, "update        - %s",
8c159044 519) color_fprintf_ln(stdout, s->help_color, "revert        - %s",
8c159044 521) color_fprintf_ln(stdout, s->help_color, "patch         - %s",
8c159044 523) color_fprintf_ln(stdout, s->help_color, "diff          - %s",
8c159044 525) color_fprintf_ln(stdout, s->help_color, "add untracked - %s",
8c159044 528) return 0;

Slavica Đukić	3d965c76 built-in add -i: use color in the main loop
add-interactive.c
3d965c76 51) init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
3d965c76 52) init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
3d965c76 53) init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
3d965c76 249) color_fprintf(stdout, s->prompt_color, "%s", opts->prompt);
3d965c76 250) fputs("> ", stdout);
3d965c76 293) color_fprintf_ln(stdout, s->error_color,
3d965c76 547) struct print_command_item_data *d = print_command_item_data;
3d965c76 554) printf(" %2d: %s%.*s%s%s", i + 1,
3d965c76 555)        d->color, (int)util->prefix_length, item->string,
3d965c76 556)        d->reset, item->string + util->prefix_length);
3d965c76 574) struct print_command_item_data data = { "[", "]" };
3d965c76 612) if (s.use_color) {
3d965c76 613) data.color = s.prompt_color;
3d965c76 614) data.reset = s.reset_color;

Slavica Đukić	1daaebca built-in add -i: color the header in the `status` command
add-interactive.c
1daaebca 20) static void init_color(struct repository *r, struct add_i_state *s,
1daaebca 24) char *key = xstrfmt("color.interactive.%s", slot_name);
1daaebca 27) if (!s->use_color)
1daaebca 28) dst[0] = '\0';
1daaebca 29) else if (repo_config_get_value(r, key, &value) ||
1daaebca 30)  color_parse(value, dst))
1daaebca 31) strlcpy(dst, default_color, COLOR_MAXLEN);
1daaebca 33) free(key);
1daaebca 34) }
1daaebca 40) s->r = r;
1daaebca 42) if (repo_config_get_value(r, "color.interactive", &value))
1daaebca 43) s->use_color = -1;
1daaebca 45) s->use_color =
1daaebca 46) git_config_colorbool("color.interactive", value);
1daaebca 47) s->use_color = want_color(s->use_color);
1daaebca 49) init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
1daaebca 189) static void list(struct add_i_state *s, struct string_list *list,
1daaebca 198) color_fprintf_ln(stdout, s->header_color,
1daaebca 505) list(s, files, opts);



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducting uncovered code:
Alex Henrie	baed6bbb diffcore-break: use a goto instead of a redundant if statement
diffcore-break.c
baed6bbb 295) diff_q(&outq, p);

Ali Utku Selen	ddb3c856 shallow.c: don't free unallocated slabs
shallow.c
ddb3c856 157) continue;

Brandon Casey	040a6551 cleanup: use internal memory allocation wrapper functions everywhere
stable-qsort.c
040a6551 58) char *tmp = xmalloc(size);

Brian Downing	43fe901b compat: Add simplified merge sort implementation from glibc
stable-qsort.c
43fe901b 59) msort_with_tmp(b, n, s, cmp, tmp);
43fe901b 60) free(tmp);

brian m. carlson	ce17feb1 path: add a function to check for path suffix
path.c
ce17feb1 1246) return -1;
ce17feb1 1250) return -1;
ce17feb1 1259) return -1;

brian m. carlson	6f119424 remote-curl: pass on atomic capability to remote side
remote-curl.c
6f119424 155) else if (!strcmp(value, "false"))
6f119424 156) options.atomic = 0;
6f119424 158) return -1;

brian m. carlson	7e0d029f builtin/rev-parse: switch to use the_hash_algo
builtin/rev-parse.c
7e0d029f 735) abbrev = hexsz;

brian m. carlson	8d4d86b0 cache: remove null_sha1
builtin/submodule--helper.c
8d4d86b0 427) printf("%06o %s U\t", ce->ce_mode, oid_to_hex(&null_oid));

brian m. carlson	28ba1830 builtin/replace: make hash size independent
builtin/replace.c
28ba1830 275) if (strbuf_read(&result, cmd.out, the_hash_algo->hexsz + 1) < 0) {

brian m. carlson	fabec2c5 builtin/receive-pack: switch to use the_hash_algo
builtin/receive-pack.c
fabec2c5 433) the_hash_algo->init_fn(&ctx);
fabec2c5 434) the_hash_algo->update_fn(&ctx, key_in, key_len);
fabec2c5 435) the_hash_algo->final_fn(key, &ctx);

Christian Couder	4ca9474e Move core_partial_clone_filter_default to promisor-remote.c
promisor-remote.c
4ca9474e 111) return git_config_string(&core_partial_clone_filter_default,

Christian Couder	fa3d1b63 promisor-remote: parse remote.*.partialclonefilter
promisor-remote.c
fa3d1b63 142) return 0;

Christian Couder	9e27beaa promisor-remote: implement promisor_remote_get_direct()
promisor-remote.c
9e27beaa 205) static int remove_fetched_oids(struct repository *repo,
9e27beaa 209) int i, remaining_nr = 0;
9e27beaa 210) int *remaining = xcalloc(oid_nr, sizeof(*remaining));
9e27beaa 211) struct object_id *old_oids = *oids;
9e27beaa 214) for (i = 0; i < oid_nr; i++)
9e27beaa 215) if (oid_object_info_extended(repo, &old_oids[i], NULL,
9e27beaa 217) remaining[i] = 1;
9e27beaa 218) remaining_nr++;
9e27beaa 221) if (remaining_nr) {
9e27beaa 222) int j = 0;
9e27beaa 223) new_oids = xcalloc(remaining_nr, sizeof(*new_oids));
9e27beaa 224) for (i = 0; i < oid_nr; i++)
9e27beaa 225) if (remaining[i])
9e27beaa 226) oidcpy(&new_oids[j++], &old_oids[i]);
9e27beaa 227) *oids = new_oids;
9e27beaa 228) if (to_free)
9e27beaa 229) free(old_oids);
9e27beaa 232) free(remaining);
9e27beaa 234) return remaining_nr;
9e27beaa 251) if (remaining_nr == 1)
9e27beaa 252) continue;
9e27beaa 253) remaining_nr = remove_fetched_oids(repo, &remaining_oids,
9e27beaa 255) if (remaining_nr) {
9e27beaa 256) to_free = 1;
9e27beaa 257) continue;
9e27beaa 265) free(remaining_oids);

Christian Couder	48de3158 Add initial support for many promisor remotes
promisor-remote.c
48de3158 63) return NULL;

Christian Couder	faf2abf4 promisor-remote: use repository_format_partial_clone
promisor-remote.c
faf2abf4 95) if (previous)
faf2abf4 96) previous->next = r->next;
faf2abf4 98) promisors = r->next ? r->next : r;
faf2abf4 99) r->next = NULL;
faf2abf4 100) *promisors_tail = r;
faf2abf4 101) promisors_tail = &r->next;

Denton Liu	c0efb4c1 rebase: fast-forward --onto in more cases
builtin/rebase.c
c0efb4c1 1289) goto done;

Denton Liu	2b318aa6 rebase: refactor can_fast_forward into goto tower
builtin/rebase.c
2b318aa6 1273) goto done;

Derrick Stolee	50f26bd0 fetch: add fetch.writeCommitGraph config setting
repo-settings.c
50f26bd0 57) UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);

Derrick Stolee	aaf633c2 repo-settings: create feature.experimental setting
fetch-pack.c
aaf633c2 952) else if (args->depth > 0 || is_repository_shallow(r))

repo-settings.c
aaf633c2 43) r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
aaf633c2 55) UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
aaf633c2 56) UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);

Elijah Newren	ff1bfa2c merge-recursive: use common name for ancestors/common/base_list
merge-recursive.c
ff1bfa2c 3815)    oid_to_hex(merge_bases[i]));

Elijah Newren	f836bf39 merge-recursive: future-proof update_file_flags() against memory leaks
merge-recursive.c
f836bf39 960) ret = err(opt, _("cannot read object %s '%s'"),
f836bf39 962) goto free_buf;

Elijah Newren	98a1d3d8 merge-recursive: exit early if index != head
merge-recursive.c
98a1d3d8 3750) return -1;

Elijah Newren	65c01c64 checkout: provide better conflict hunk description with detached HEAD
builtin/checkout.c
65c01c64 766) strbuf_add_unique_abbrev(&old_commit_shortname,
65c01c64 767)  &old_branch_info->commit->object.oid,
65c01c64 769) o.ancestor = old_commit_shortname.buf;

Elijah Newren	941790d7 fast-export: handle nested tags
builtin/fast-export.c
941790d7 864) tagged_mark = get_object_mark(tagged);

Elijah Newren	3164e6bd fast-import: fix handling of deleted tags
fast-import.c
3164e6bd 2835) first_tag = t->next_tag;

Elijah Newren	9822175d Ensure index matches head before invoking merge machinery, round N
builtin/merge-recursive.c
9822175d 68) die_resolve_conflict("merge");

Elijah Newren	b8f50e5b fast-import: add support for new 'alias' command
fast-import.c
b8f50e5b 2554) return 0;

Elijah Newren	724dd767 cache-tree: share code between functions writing an index as a tree
cache-tree.c
724dd767 619) cache_tree_free(&index_state->cache_tree);
724dd767 620) cache_tree_valid = 0;
724dd767 633) return WRITE_TREE_PREFIX_ERROR;
724dd767 653) fprintf(stderr, "BUG: There are unmerged index entries:\n");
724dd767 654) for (i = 0; i < index_state->cache_nr; i++) {
724dd767 655) const struct cache_entry *ce = index_state->cache[i];
724dd767 656) if (ce_stage(ce))
724dd767 657) fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
724dd767 658) (int)ce_namelen(ce), ce->name);

Elijah Newren	89a1f4aa dir: if our pathspec might match files under a dir, recurse into it
dir.c
89a1f4aa 374) return MATCHED_RECURSIVELY_LEADING_PATHSPEC;

Eric Wong	b94e5c1d hashmap_add takes "struct hashmap_entry *"
t/helper/test-hashmap.c
b94e5c1d 110) hashmap_add(&map, &entries[i]->ent);
b94e5c1d 123) hashmap_add(&map, &entries[i]->ent);

Eric Wong	c8e424c9 hashmap: introduce hashmap_free_entries
t/helper/test-hashmap.c
c8e424c9 113) hashmap_free(&map);
c8e424c9 133) hashmap_free(&map);

Eric Wong	87571c3f hashmap: use *_entry APIs for iteration
t/helper/test-lazy-init-name-hash.c
87571c3f 44) hashmap_for_each_entry(&the_index.dir_hash, &iter_dir, dir,
87571c3f 48) hashmap_for_each_entry(&the_index.name_hash, &iter_cache, ce,

Eric Wong	28ee7941 hashmap_remove takes "const struct hashmap_entry *"
name-hash.c
28ee7941 100) hashmap_remove(&istate->dir_hash, &dir->ent, NULL);

Eric Wong	d22245a2 hashmap_entry_init takes "struct hashmap_entry *"
t/helper/test-hashmap.c
d22245a2 109) hashmap_entry_init(&entries[i]->ent, hashes[i]);
d22245a2 122) hashmap_entry_init(&entries[i]->ent, hashes[i]);

Jeff Hostetler	742ed633 trace2: cleanup whitespace in perf format
trace2/tr2_tgt_perf.c
742ed633 302) strbuf_addf(&buf_payload, "alias:%s argv:[", alias);
742ed633 303) sq_append_quote_argv_pretty(&buf_payload, argv);
742ed633 304) strbuf_addch(&buf_payload, ']');
742ed633 335) strbuf_addstr(&buf_payload, "git");
742ed633 336) if (cmd->argv[0])
742ed633 337) strbuf_addch(&buf_payload, ' ');
742ed633 391) strbuf_addstr(&buf_payload, "argv:[");
742ed633 392) if (exe) {
742ed633 393) strbuf_addstr(&buf_payload, exe);
742ed633 394) if (argv[0])
742ed633 395) strbuf_addch(&buf_payload, ' ');
742ed633 397) sq_append_quote_argv_pretty(&buf_payload, argv);
742ed633 398) strbuf_addch(&buf_payload, ']');

Jeff Hostetler	e3443055 trace2: cleanup whitespace in normal format
trace2/tr2_tgt_normal.c
e3443055 189) strbuf_addf(&buf_payload, "alias %s -> ", alias);
e3443055 190) sq_append_quote_argv_pretty(&buf_payload, argv);
e3443055 201) strbuf_addf(&buf_payload, "child_start[%d]", cmd->trace2_child_id);
e3443055 204) strbuf_addstr(&buf_payload, " cd ");
e3443055 206) strbuf_addstr(&buf_payload, ";");
e3443055 214) strbuf_addch(&buf_payload, ' ');
e3443055 216) strbuf_addstr(&buf_payload, "git ");
e3443055 217) sq_append_quote_argv_pretty(&buf_payload, cmd->argv);
e3443055 242) if (exe) {
e3443055 244) strbuf_addch(&buf_payload, ' ');
e3443055 246) sq_append_quote_argv_pretty(&buf_payload, argv);

Jeff Hostetler	da4589ce trace2: trim whitespace in region messages in perf target format
trace2/tr2_tgt_perf.c
da4589ce 459) strbuf_addf(&buf_payload, "label:%s", label);
da4589ce 460) if (fmt && *fmt) {
da4589ce 461) strbuf_addch(&buf_payload, ' ');
da4589ce 462) maybe_append_string_va(&buf_payload, fmt, ap);
da4589ce 479) strbuf_addf(&buf_payload, "label:%s", label);
da4589ce 480) if (fmt && *fmt) {
da4589ce 481) strbuf_addch(&buf_payload, ' ' );
da4589ce 482) maybe_append_string_va(&buf_payload, fmt, ap);

Jeff Hostetler	371df1be trace2: cleanup column alignment in perf target format
trace2/tr2_tgt_perf.c
371df1be 88) fl_end_col = buf->len + TR2FMT_PERF_FL_WIDTH;
371df1be 90) if (file && *file) {
371df1be 91) struct strbuf buf_fl = STRBUF_INIT;
371df1be 93) strbuf_addf(&buf_fl, "%s:%d", file, line);
371df1be 95) if (buf_fl.len <= TR2FMT_PERF_FL_WIDTH)
371df1be 96) strbuf_addbuf(buf, &buf_fl);
371df1be 98) size_t avail = TR2FMT_PERF_FL_WIDTH - 3;
371df1be 99) strbuf_addstr(buf, "...");
371df1be 100) strbuf_add(buf,
371df1be 101)    &buf_fl.buf[buf_fl.len - avail],
371df1be 105) strbuf_release(&buf_fl);
371df1be 108) while (buf->len < fl_end_col)
371df1be 111) strbuf_addstr(buf, " | ");

Jeff King	90553847 tree-walk: drop oid from traverse_info
unpack-trees.c
90553847 1144) if (*info->prev->name)
90553847 1147) printf("%s", info->name);

Jeff King	0dfed92d git-am: handle missing "author" when parsing commit
builtin/am.c
0dfed92d 1263)       oid_to_hex(&commit->object.oid));

Jeff King	9827d4c1 packfile: drop release_pack_memory()
wrapper.c
9827d4c1 45) if (!gentle)
9827d4c1 51) return NULL;

Johannes Schindelin	d54dea77 fetch: let --jobs=<n> parallelize --multiple, too
builtin/fetch.c
d54dea77 113) fetch_parallel_config = git_config_int(k, v);
d54dea77 114) if (fetch_parallel_config < 0)
d54dea77 116) return 0;
d54dea77 1566) static int fetch_failed_to_start(struct strbuf *out, void *cb, void *task_cb)
d54dea77 1568) struct parallel_fetch_state *state = cb;
d54dea77 1569) const char *remote = task_cb;
d54dea77 1573) return 0;

Johannes Schindelin	e145d993 rebase -r: support merge strategies other than `recursive`
sequencer.c
e145d993 3304) (!opts->strategy || !strcmp(opts->strategy, "recursive")) ?

Johannes Schindelin	e2683d51 Fix .git/ discovery at the root of UNC shares
setup.c
e2683d51 952)     !is_dir_sep(dir->buf[min_offset - 1])) {
e2683d51 953) strbuf_addch(dir, '/');
e2683d51 954) min_offset++;

Johannes Schindelin	be5d88e1 test-tool run-command: learn to run (parts of) the testsuite
t/helper/test-run-command.c
be5d88e1 66) static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
be5d88e1 69) struct testsuite *suite = cb;
be5d88e1 71) if (suite->next >= suite->tests.nr)
be5d88e1 72) return 0;
be5d88e1 74) test = suite->tests.items[suite->next++].string;
be5d88e1 75) argv_array_pushl(&cp->args, "sh", test, NULL);
be5d88e1 76) if (suite->quiet)
be5d88e1 77) argv_array_push(&cp->args, "--quiet");
be5d88e1 78) if (suite->immediate)
be5d88e1 79) argv_array_push(&cp->args, "-i");
be5d88e1 80) if (suite->verbose)
be5d88e1 81) argv_array_push(&cp->args, "-v");
be5d88e1 82) if (suite->verbose_log)
be5d88e1 83) argv_array_push(&cp->args, "-V");
be5d88e1 84) if (suite->trace)
be5d88e1 85) argv_array_push(&cp->args, "-x");
be5d88e1 86) if (suite->write_junit_xml)
be5d88e1 87) argv_array_push(&cp->args, "--write-junit-xml");
be5d88e1 89) strbuf_addf(err, "Output of '%s':\n", test);
be5d88e1 90) *task_cb = (void *)test;
be5d88e1 92) return 1;
be5d88e1 95) static int test_finished(int result, struct strbuf *err, void *cb,
be5d88e1 98) struct testsuite *suite = cb;
be5d88e1 99) const char *name = (const char *)task_cb;
be5d88e1 101) if (result)
be5d88e1 102) string_list_append(&suite->failed, name);
be5d88e1 104) strbuf_addf(err, "%s: '%s'\n", result ? "FAIL" : "SUCCESS", name);
be5d88e1 106) return 0;
be5d88e1 109) static int test_failed(struct strbuf *out, void *cb, void *task_cb)
be5d88e1 111) struct testsuite *suite = cb;
be5d88e1 112) const char *name = (const char *)task_cb;
be5d88e1 114) string_list_append(&suite->failed, name);
be5d88e1 115) strbuf_addf(out, "FAILED TO START: '%s'\n", name);
be5d88e1 117) return 0;
be5d88e1 125) static int testsuite(int argc, const char **argv)
be5d88e1 127) struct testsuite suite = TESTSUITE_INIT;
be5d88e1 128) int max_jobs = 1, i, ret;
be5d88e1 131) struct option options[] = {
be5d88e1 145) memset(&suite, 0, sizeof(suite));
be5d88e1 146) suite.tests.strdup_strings = suite.failed.strdup_strings = 1;
be5d88e1 148) argc = parse_options(argc, argv, NULL, options,
be5d88e1 151) if (max_jobs <= 0)
be5d88e1 152) max_jobs = online_cpus();
be5d88e1 154) dir = opendir(".");
be5d88e1 155) if (!dir)
be5d88e1 157) while ((d = readdir(dir))) {
be5d88e1 158) const char *p = d->d_name;
be5d88e1 160) if (*p != 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
be5d88e1 161)     !isdigit(p[3]) || !isdigit(p[4]) || p[5] != '-' ||
be5d88e1 162)     !ends_with(p, ".sh"))
be5d88e1 163) continue;
be5d88e1 166) if (!argc) {
be5d88e1 167) string_list_append(&suite.tests, p);
be5d88e1 168) continue;
be5d88e1 171) for (i = 0; i < argc; i++)
be5d88e1 172) if (!wildmatch(argv[i], p, 0)) {
be5d88e1 173) string_list_append(&suite.tests, p);
be5d88e1 174) break;
be5d88e1 177) closedir(dir);
be5d88e1 179) if (!suite.tests.nr)
be5d88e1 181) if (max_jobs > suite.tests.nr)
be5d88e1 182) max_jobs = suite.tests.nr;
be5d88e1 184) fprintf(stderr, "Running %d tests (%d at a time)\n",
be5d88e1 187) ret = run_processes_parallel(max_jobs, next_test, test_failed,
be5d88e1 190) if (suite.failed.nr > 0) {
be5d88e1 191) ret = 1;
be5d88e1 192) fprintf(stderr, "%d tests failed:\n\n", suite.failed.nr);
be5d88e1 193) for (i = 0; i < suite.failed.nr; i++)
be5d88e1 194) fprintf(stderr, "\t%s\n", suite.failed.items[i].string);
be5d88e1 197) string_list_clear(&suite.tests, 0);
be5d88e1 198) string_list_clear(&suite.failed, 0);
be5d88e1 200) return !!ret;
be5d88e1 209) exit(testsuite(argc - 1, argv + 1));

Josh Steadmon	87db61a4 trace2: write discard message to sentinel files
trace2/tr2_dst.c
87db61a4 136) strbuf_setlen(&path, base_path_len);
87db61a4 137) strbuf_addf(&path, ".%d", attempt_count);

Josh Steadmon	83e57b04 trace2: discard new traces if target directory has too many files
trace2/tr2_dst.c
83e57b04 90) ret = 1;
83e57b04 91) goto cleanup;
83e57b04 145) strbuf_release(&path);
83e57b04 151) return 0;

Junio C Hamano	360c7ba3 transport: push codepath can take arbitrary repository
transport.c
360c7ba3 1200) trace2_region_leave("transport_push", "push_submodules", r);

Matthew DeVore	9430147c list-objects-filter: encapsulate filter components
list-objects.c
9430147c 210) ctx->show_object(obj, base->buf, ctx->show_data);

Matthew DeVore	e987df5f list-objects-filter: implement composite filters
list-objects-filter-options.c
e987df5f 311) return;

Matthew DeVore	cf9ceb5a list-objects-filter-options: make filter_spec a string_list
upload-pack.c
cf9ceb5a 148) sq_quote_buf(&buf, spec);

Mischa POSLAWSKY	8b3f33ef ref-filter: initialize empty name or email fields
ref-filter.c
8b3f33ef 1045) return xstrdup("");

Phillip Wood	49697cb7 move run_commit_hook() to libgit and use it there
sequencer.c
49697cb7 1137) arg1 = "commit";
49697cb7 1138) arg2 = commit;

Phillip Wood	a47ba3c7 rebase -i: check for updated todo after squash and reword
sequencer.c
a47ba3c7 3915) res = error_errno(_("could not stat '%s'"),
a47ba3c7 3921) res = -1; /* message was printed */

René Scharfe	59fa5f5a sha1-name: check for overflow of N in "foo^N" and "foo~N"
sha1-name.c
59fa5f5a 1172) return MISSING_OBJECT;
59fa5f5a 1178) return MISSING_OBJECT;

René Scharfe	5cc6a4be http-push: simplify deleting a list item
http-push.c
5cc6a4be 984) prev->next = lock->next;

SZEDER Gábor	c72fc40d path.c: clarify two field names in 'struct common_dir'
path.c
c72fc40d 380) for (p = common_list; p->path; p++) {
c72fc40d 381) const char *path = p->path;

Thomas Gummerer	34933d0e stash: make sure to write refreshed cache
builtin/stash.c
34933d0e 1140) ret = -1;
34933d0e 1141) goto done;

Thomas Gummerer	22184497 factor out refresh_and_write_cache function
read-cache.c
22184497 1487) return -1;
22184497 1491) ret = -1;

William Baker	840cef0c midx: add progress to write_midx_file
midx.c
840cef0c 973) progress = start_progress(_("Writing chunks to multi-pack-index"),


