Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE655C2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5E520740
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLJyVSBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfLZRTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 12:19:30 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:39731 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLZRTa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 12:19:30 -0500
Received: by mail-qk1-f174.google.com with SMTP id c16so19833985qko.6
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 09:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pEF1U1PMRsjMQlrtLrDaCQa3W63si3MMbmnJ3ChhOWk=;
        b=gLJyVSBHVZegv7BM5BPTBQ+b37pAVwxDzp2S7CgYMOBfz0ra2n/KqR0wztVF1C0wZP
         hEgt81PnDbwxOM2MxXsx1/JgDteXsuuY3AqJ4+P0Zsst0THnCoEHcl3VnDcRAWtKSR1u
         Js0Pjx5bUaIm22lW692zWYTxe9ObE5iolUGi4PXDKflCve9cPwm/EMm8Birqfw1ZkRut
         gzpiGuEe2ere4f2ZJQQ2d2fMmQW4/hKav19euBa7JYsqhMe1J4gSRLkonO3pMExkWPM0
         84wUn8QhtxFLEwGqD50yDSNbn1Y+JyX8mhNsUnNpEJoWOUeKTooGT09ZSPMpYbZ6m8fv
         qkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pEF1U1PMRsjMQlrtLrDaCQa3W63si3MMbmnJ3ChhOWk=;
        b=KH5JQOcXPMCZG+hI6iqbzIpAPG92tVFAtfMzZ8Ku6u3VsoCV6+sEMKO1J6iEB1TmNi
         Eo49DuoFOirwyrRur1+lFJK4B/XHJakyAeMwvWRLtWLjnstD0wd7IZolwluPtKq2xuH0
         4gd38JBvFWsXRhim10CySs3nOK58jhiw/QRUwpYRZAKHW2qaqvMtwSba0ltSiJQ2s0Iv
         Yd1Y1dygnmlZ+dSeGT172Mrz5J83tUUbuQmSobxVhBA+z245uxy/f6UVo9PA4vcW+D19
         dBEcYmjsB/j5x+97G8U9cg5C293h0jB8Xbo1fxWg6t8iEmnJta5qiZ4uGlXZEqS6fCfn
         EQ/w==
X-Gm-Message-State: APjAAAVk3Druahd0RzQdmnPLHeErs0+sgwA9kBabBMtlXtoUkM22e9Cg
        aJgcf+AJ64bb8XvHCLbVsWF7F1Pl
X-Google-Smtp-Source: APXvYqxMMiPouhE6vP+ij4oRmnT2rSjiGX71X77Ssf8F7kRP3aLRfK8tct4JUgPm5Lod+eLJGs3mtg==
X-Received: by 2002:a05:620a:108d:: with SMTP id g13mr39069880qkk.121.1577380765341;
        Thu, 26 Dec 2019 09:19:25 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:d596:b1c5:69e0:b2e5? ([2001:4898:a800:1010:86cc:b1c5:69e0:b2e5])
        by smtp.gmail.com with ESMTPSA id z4sm8772085qkz.62.2019.12.26.09.19.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 09:19:24 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (v2.25.0-rc0)
Message-ID: <02febb94-9749-c219-8fae-d109720f4c71@gmail.com>
Date:   Thu, 26 Dec 2019 12:19:24 -0500
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

Here is the test-coverage report for v2.25.0-rc0 against v2.24.1.

I've included the old version of the report because my build definition for
generating a report from a single branch didn't create the commit-by-commit
view correctly. Also, some of these are easier to see in-context with the
other lines in the file.

Thanks,
-Stolee

--------------------------------------------------------

add-interactive.c
1daaebca 13) static void init_color(struct repository *r, struct add_i_state *s,
1daaebca 17) char *key = xstrfmt("color.interactive.%s", slot_name);
1daaebca 20) if (!s->use_color)
1daaebca 21) dst[0] = '\0';
1daaebca 22) else if (repo_config_get_value(r, key, &value) ||
1daaebca 23)  color_parse(value, dst))
1daaebca 24) strlcpy(dst, default_color, COLOR_MAXLEN);
1daaebca 26) free(key);
1daaebca 27) }
25ea47af 29) void init_add_i_state(struct add_i_state *s, struct repository *r)
1daaebca 33) s->r = r;
1daaebca 35) if (repo_config_get_value(r, "color.interactive", &value))
1daaebca 36) s->use_color = -1;
1daaebca 38) s->use_color =
1daaebca 39) git_config_colorbool("color.interactive", value);
1daaebca 40) s->use_color = want_color(s->use_color);
1daaebca 42) init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
68db1cbf 43) init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
3d965c76 44) init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
3d965c76 45) init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
3d965c76 46) init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
25ea47af 47) init_color(r, s, "fraginfo", s->fraginfo_color,
bcdd297b 49) init_color(r, s, "context", s->context_color,
bcdd297b 51) init_color(r, s, "old", s->file_old_color,
bcdd297b 53) init_color(r, s, "new", s->file_new_color,
5e82b9e4 55) }
76b74323 82) static void prefix_item_list_clear(struct prefix_item_list *list)
76b74323 84) string_list_clear(&list->items, 1);
76b74323 85) string_list_clear(&list->sorted, 0);
f37c2264 86) FREE_AND_NULL(list->selected);
76b74323 87) }
76b74323 89) static void extend_prefix_length(struct string_list_item *p,
76b74323 92) size_t *len = p->util;
76b74323 94) if (!*len || memcmp(p->string, other_string, *len))
76b74323 95) return;
76b74323 98) char c = p->string[*len];
76b74323 106) if (!c || ++*len > max_length || !isascii(c)) {
76b74323 107) *len = 0;
76b74323 108) break;
76b74323 111) if (c != other_string[*len - 1])
76b74323 112) break;
76b74323 113) }
76b74323 116) static void find_unique_prefixes(struct prefix_item_list *list)
76b74323 120) if (list->sorted.nr == list->items.nr)
76b74323 121) return;
76b74323 123) string_list_clear(&list->sorted, 0);
76b74323 125) list->sorted.items = xmalloc(st_mult(sizeof(*list->sorted.items),
76b74323 126)      list->items.nr));
76b74323 127) list->sorted.nr = list->sorted.alloc = list->items.nr;
76b74323 129) for (i = 0; i < list->items.nr; i++) {
76b74323 130) list->sorted.items[i].string = list->items.items[i].string;
76b74323 131) list->sorted.items[i].util = list->items.items + i;
76b74323 134) string_list_sort(&list->sorted);
76b74323 136) for (i = 0; i < list->sorted.nr; i++) {
76b74323 137) struct string_list_item *sorted_item = list->sorted.items + i;
76b74323 138) struct string_list_item *item = sorted_item->util;
76b74323 139) size_t *len = item->util;
76b74323 141) *len = 0;
76b74323 142) while (*len < list->min_length) {
76b74323 143) char c = item->string[(*len)++];
76b74323 145) if (!c || !isascii(c)) {
76b74323 146) *len = 0;
76b74323 147) break;
76b74323 151) if (i > 0)
76b74323 152) extend_prefix_length(item, sorted_item[-1].string,
76b74323 154) if (i + 1 < list->sorted.nr)
76b74323 155) extend_prefix_length(item, sorted_item[1].string,
76b74323 160) static ssize_t find_unique(const char *string, struct prefix_item_list *list)
76b74323 162) int index = string_list_find_insert_index(&list->sorted, string, 1);
76b74323 165) if (list->items.nr != list->sorted.nr)
76b74323 170) if (index < 0)
76b74323 171) item = list->sorted.items[-1 - index].util;
76b74323 172) else if (index > 0 &&
76b74323 173)  starts_with(list->sorted.items[index - 1].string, string))
76b74323 174) return -1;
76b74323 175) else if (index + 1 < list->sorted.nr &&
76b74323 176)  starts_with(list->sorted.items[index + 1].string, string))
76b74323 177) return -1;
76b74323 178) else if (index < list->sorted.nr)
76b74323 179) item = list->sorted.items[index].util;
76b74323 181) return -1;
76b74323 182) return item - list->items.items;
f37c2264 193) static void list(struct add_i_state *s, struct string_list *list, int *selected,
6348bfba 196) int i, last_lf = 0;
5e82b9e4 198) if (!list->nr)
5e82b9e4 199) return;
5e82b9e4 201) if (opts->header)
1daaebca 202) color_fprintf_ln(stdout, s->header_color,
5e82b9e4 205) for (i = 0; i < list->nr; i++) {
f37c2264 206) opts->print_item(i, selected ? selected[i] : 0, list->items + i,
6348bfba 209) if ((opts->columns) && ((i + 1) % (opts->columns))) {
6348bfba 210) putchar('\t');
6348bfba 211) last_lf = 0;
6348bfba 214) putchar('\n');
6348bfba 215) last_lf = 1;
6348bfba 219) if (!last_lf)
5e82b9e4 220) putchar('\n');
76b74323 243) static ssize_t list_and_choose(struct add_i_state *s,
f37c2264 247) int singleton = opts->flags & SINGLETON;
f37c2264 248) int immediate = opts->flags & IMMEDIATE;
6348bfba 250) struct strbuf input = STRBUF_INIT;
f37c2264 251) ssize_t res = singleton ? LIST_AND_CHOOSE_ERROR : 0;
f37c2264 253) if (!singleton) {
f37c2264 254) free(items->selected);
f37c2264 255) CALLOC_ARRAY(items->selected, items->items.nr);
f37c2264 258) if (singleton && !immediate)
76b74323 261) find_unique_prefixes(items);
6348bfba 266) strbuf_reset(&input);
f37c2264 268) list(s, &items->items, items->selected, &opts->list_opts);
3d965c76 270) color_fprintf(stdout, s->prompt_color, "%s", opts->prompt);
f37c2264 271) fputs(singleton ? "> " : ">> ", stdout);
6348bfba 272) fflush(stdout);
6348bfba 274) if (strbuf_getline(&input, stdin) == EOF) {
6348bfba 275) putchar('\n');
f37c2264 276) if (immediate)
f37c2264 277) res = LIST_AND_CHOOSE_QUIT;
6348bfba 278) break;
6348bfba 280) strbuf_trim(&input);
6348bfba 282) if (!input.len)
6348bfba 283) break;
68db1cbf 285) if (!strcmp(input.buf, "?")) {
68db1cbf 286) opts->print_help(s);
68db1cbf 287) continue;
6348bfba 290) p = input.buf;
6348bfba 292) size_t sep = strcspn(p, " \t\r\n,");
f37c2264 293) int choose = 1;
f37c2264 295) ssize_t from = -1, to = -1;
6348bfba 297) if (!sep) {
6348bfba 298) if (!*p)
6348bfba 299) break;
6348bfba 300) p++;
6348bfba 301) continue;
f37c2264 305) if (*p == '-') {
f37c2264 306) choose = 0;
f37c2264 307) p++;
f37c2264 308) sep--;
f37c2264 311) if (sep == 1 && *p == '*') {
f37c2264 312) from = 0;
f37c2264 313) to = items->items.nr;
f37c2264 314) } else if (isdigit(*p)) {
f37c2264 325) from = strtoul(p, &endp, 10) - 1;
f37c2264 326) if (endp == p + sep)
f37c2264 327) to = from + 1;
f37c2264 328) else if (*endp == '-') {
f37c2264 329) to = strtoul(++endp, &endp, 10);
f37c2264 331) if (endp != p + sep)
f37c2264 332) from = -1;
6348bfba 336) if (p[sep])
6348bfba 337) p[sep++] = '\0';
f37c2264 338) if (from < 0) {
f37c2264 339) from = find_unique(p, items);
f37c2264 340) if (from >= 0)
f37c2264 341) to = from + 1;
f37c2264 344) if (from < 0 || from >= items->items.nr ||
f37c2264 345)     (singleton && from + 1 != to)) {
3d965c76 346) color_fprintf_ln(stdout, s->error_color,
f37c2264 348) break;
f37c2264 349) } else if (singleton) {
f37c2264 350) res = from;
6348bfba 351) break;
f37c2264 354) if (to > items->items.nr)
f37c2264 355) to = items->items.nr;
f37c2264 357) for (; from < to; from++)
f37c2264 358) if (items->selected[from] != choose) {
f37c2264 359) items->selected[from] = choose;
f37c2264 360) res += choose ? +1 : -1;
6348bfba 363) p += sep;
6348bfba 364) }
f37c2264 366) if ((immediate && res != LIST_AND_CHOOSE_ERROR) ||
f37c2264 367)     !strcmp(input.buf, "*"))
5e82b9e4 369) }
6348bfba 371) strbuf_release(&input);
6348bfba 372) return res;
5e82b9e4 385) static void add_file_item(struct string_list *files, const char *name)
5e82b9e4 387) struct file_item *item = xcalloc(sizeof(*item), 1);
5e82b9e4 389) string_list_append(files, name)->util = item;
5e82b9e4 390) }
5e82b9e4 398) static int pathname_entry_cmp(const void *unused_cmp_data,
5e82b9e4 403) const struct pathname_entry *e1 =
5e82b9e4 405) const struct pathname_entry *e2 =
5e82b9e4 408) return strcmp(e1->name, name ? (const char *)name : e2->name);
5e82b9e4 422) static void collect_changes_cb(struct diff_queue_struct *q,
5e82b9e4 426) struct collection_status *s = data;
5e82b9e4 427) struct diffstat_t stat = { 0 };
5e82b9e4 430) if (!q->nr)
5e82b9e4 431) return;
5e82b9e4 433) compute_diffstat(options, &stat, q);
5e82b9e4 435) for (i = 0; i < stat.nr; i++) {
5e82b9e4 436) const char *name = stat.files[i]->name;
5e82b9e4 437) int hash = strhash(name);
5e82b9e4 442) entry = hashmap_get_entry_from_hash(&s->file_map, hash, name,
5e82b9e4 444) if (!entry) {
c08171d1 445) if (s->skip_unseen)
c08171d1 446) continue;
5e82b9e4 448) add_file_item(s->files, name);
5e82b9e4 450) entry = xcalloc(sizeof(*entry), 1);
5e82b9e4 451) hashmap_entry_init(&entry->ent, hash);
5e82b9e4 452) entry->name = s->files->items[s->files->nr - 1].string;
5e82b9e4 453) entry->item = s->files->items[s->files->nr - 1].util;
5e82b9e4 454) hashmap_add(&s->file_map, &entry->ent);
5e82b9e4 457) file_item = entry->item;
c08171d1 458) adddel = s->mode == FROM_INDEX ?
5e82b9e4 459) &file_item->index : &file_item->worktree;
8746e072 460) other_adddel = s->mode == FROM_INDEX ?
8746e072 461) &file_item->worktree : &file_item->index;
5e82b9e4 462) adddel->seen = 1;
5e82b9e4 463) adddel->add = stat.files[i]->added;
5e82b9e4 464) adddel->del = stat.files[i]->deleted;
8746e072 465) if (stat.files[i]->is_binary) {
8746e072 466) if (!other_adddel->binary)
8746e072 467) s->binary_count++;
5e82b9e4 468) adddel->binary = 1;
8746e072 470) if (stat.files[i]->is_unmerged) {
8746e072 471) if (!other_adddel->unmerged)
8746e072 472) s->unmerged_count++;
8746e072 473) adddel->unmerged = 1;
5e82b9e4 476) free_diffstat_info(&stat);
c08171d1 485) static int get_modified_files(struct repository *r,
5e82b9e4 493) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
c08171d1 495) struct collection_status s = { 0 };
5e82b9e4 498) if (discard_index(r->index) < 0 ||
5e82b9e4 499)     repo_read_index_preload(r, ps, 0) < 0)
a8c45be9 502) prefix_item_list_clear(files);
a8c45be9 503) s.files = &files->items;
5e82b9e4 504) hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
c08171d1 506) for (i = 0; i < 2; i++) {
5e82b9e4 508) struct setup_revision_opt opt = { 0 };
c08171d1 510) if (filter == INDEX_ONLY)
c08171d1 511) s.mode = (i == 0) ? FROM_INDEX : FROM_WORKTREE;
c08171d1 513) s.mode = (i == 0) ? FROM_WORKTREE : FROM_INDEX;
c08171d1 514) s.skip_unseen = filter && i;
5e82b9e4 516) opt.def = is_initial ?
5e82b9e4 517) empty_tree_oid_hex() : oid_to_hex(&head_oid);
5e82b9e4 519) init_revisions(&rev, NULL);
5e82b9e4 520) setup_revisions(0, NULL, &rev, &opt);
5e82b9e4 522) rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
5e82b9e4 523) rev.diffopt.format_callback = collect_changes_cb;
5e82b9e4 524) rev.diffopt.format_callback_data = &s;
5e82b9e4 526) if (ps)
5e82b9e4 527) copy_pathspec(&rev.prune_data, ps);
c08171d1 529) if (s.mode == FROM_INDEX)
5e82b9e4 530) run_diff_index(&rev, 1);
5e82b9e4 532) rev.diffopt.flags.ignore_dirty_submodules = 1;
5e82b9e4 533) run_diff_files(&rev, 0);
0c3944a6 536) if (ps)
0c3944a6 537) clear_pathspec(&rev.prune_data);
5e82b9e4 539) hashmap_free_entries(&s.file_map, struct pathname_entry, ent);
8746e072 540) if (unmerged_count)
8746e072 541) *unmerged_count = s.unmerged_count;
8746e072 542) if (binary_count)
8746e072 543) *binary_count = s.binary_count;
a8c45be9 546) string_list_sort(&files->items);
5e82b9e4 548) return 0;
5e82b9e4 551) static void render_adddel(struct strbuf *buf,
5e82b9e4 554) if (ad->binary)
5e82b9e4 555) strbuf_addstr(buf, _("binary"));
5e82b9e4 556) else if (ad->seen)
5e82b9e4 557) strbuf_addf(buf, "+%"PRIuMAX"/-%"PRIuMAX,
5e82b9e4 558)     (uintmax_t)ad->add, (uintmax_t)ad->del);
5e82b9e4 560) strbuf_addstr(buf, no_changes);
5e82b9e4 561) }
76b74323 564) static int is_valid_prefix(const char *prefix, size_t prefix_len)
76b74323 566) return prefix_len && prefix &&
76b74323 572) strcspn(prefix, " \t\r\n,") >= prefix_len &&	/* separators */
76b74323 573) *prefix != '-' &&				/* deselection */
76b74323 574) !isdigit(*prefix) &&				/* selection */
76b74323 575) (prefix_len != 1 ||
76b74323 576)  (*prefix != '*' &&				/* "all" wildcard */
76b74323 577)   *prefix != '?'));				/* prompt help */
f37c2264 586) static void print_file_item(int i, int selected, struct string_list_item *item,
5e82b9e4 589) struct file_item *c = item->util;
5e82b9e4 590) struct print_file_item_data *d = print_file_item_data;
a8c45be9 591) const char *highlighted = NULL;
5e82b9e4 593) strbuf_reset(&d->index);
5e82b9e4 594) strbuf_reset(&d->worktree);
5e82b9e4 595) strbuf_reset(&d->buf);
a8c45be9 598) if (c->prefix_length > 0 &&
a8c45be9 599)     is_valid_prefix(item->string, c->prefix_length)) {
a8c45be9 600) strbuf_reset(&d->name);
a8c45be9 601) strbuf_addf(&d->name, "%s%.*s%s%s", d->color,
a8c45be9 602)     (int)c->prefix_length, item->string, d->reset,
a8c45be9 603)     item->string + c->prefix_length);
a8c45be9 604) highlighted = d->name.buf;
ab1e1ccc 607) if (d->only_names) {
ab1e1ccc 608) printf("%c%2d: %s", selected ? '*' : ' ', i + 1,
ab1e1ccc 610) return;
5e82b9e4 613) render_adddel(&d->worktree, &c->worktree, _("nothing"));
5e82b9e4 614) render_adddel(&d->index, &c->index, _("unchanged"));
a8c45be9 616) strbuf_addf(&d->buf, d->modified_fmt, d->index.buf, d->worktree.buf,
f37c2264 619) printf("%c%2d: %s", selected ? '*' : ' ', i + 1, d->buf.buf);
5e82b9e4 622) static int run_status(struct add_i_state *s, const struct pathspec *ps,
8746e072 626) if (get_modified_files(s->r, NO_FILTER, files, ps, NULL, NULL) < 0)
5e82b9e4 627) return -1;
a8c45be9 629) list(s, &files->items, NULL, &opts->list_opts);
5e82b9e4 630) putchar('\n');
5e82b9e4 632) return 0;
a8c45be9 635) static int run_update(struct add_i_state *s, const struct pathspec *ps,
a8c45be9 639) int res = 0, fd;
8746e072 643) if (get_modified_files(s->r, WORKTREE_ONLY, files, ps, NULL, NULL) < 0)
a8c45be9 644) return -1;
a8c45be9 646) if (!files->items.nr) {
a8c45be9 647) putchar('\n');
a8c45be9 648) return 0;
a8c45be9 651) opts->prompt = N_("Update");
a8c45be9 652) count = list_and_choose(s, files, opts);
a8c45be9 653) if (count <= 0) {
a8c45be9 654) putchar('\n');
a8c45be9 655) return 0;
a8c45be9 658) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
a8c45be9 659) if (fd < 0) {
a8c45be9 660) putchar('\n');
a8c45be9 661) return -1;
a8c45be9 664) for (i = 0; i < files->items.nr; i++) {
a8c45be9 665) const char *name = files->items.items[i].string;
a8c45be9 666) if (files->selected[i] &&
a8c45be9 667)     add_file_to_index(s->r->index, name, 0) < 0) {
a8c45be9 669) break;
a8c45be9 673) if (!res && write_locked_index(s->r->index, &index_lock, COMMIT_LOCK) < 0)
a8c45be9 676) if (!res)
a8c45be9 677) printf(Q_("updated %d path\n",
a8c45be9 680) putchar('\n');
a8c45be9 681) return res;
c54ef5e4 684) static void revert_from_diff(struct diff_queue_struct *q,
c54ef5e4 687) int i, add_flags = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
c54ef5e4 689) for (i = 0; i < q->nr; i++) {
c54ef5e4 690) struct diff_filespec *one = q->queue[i]->one;
c54ef5e4 693) if (!(one->mode && !is_null_oid(&one->oid))) {
c54ef5e4 694) remove_file_from_index(opt->repo->index, one->path);
c54ef5e4 695) printf(_("note: %s is untracked now.\n"), one->path);
c54ef5e4 697) ce = make_cache_entry(opt->repo->index, one->mode,
c54ef5e4 698)       &one->oid, one->path, 0, 0);
c54ef5e4 699) if (!ce)
c54ef5e4 702) add_index_entry(opt->repo->index, ce, add_flags);
c54ef5e4 705) }
c54ef5e4 707) static int run_revert(struct add_i_state *s, const struct pathspec *ps,
c54ef5e4 711) int res = 0, fd;
c54ef5e4 715) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
c54ef5e4 720) struct diff_options diffopt = { NULL };
8746e072 722) if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
c54ef5e4 723) return -1;
c54ef5e4 725) if (!files->items.nr) {
c54ef5e4 726) putchar('\n');
c54ef5e4 727) return 0;
c54ef5e4 730) opts->prompt = N_("Revert");
c54ef5e4 731) count = list_and_choose(s, files, opts);
c54ef5e4 732) if (count <= 0)
c54ef5e4 733) goto finish_revert;
c54ef5e4 735) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
c54ef5e4 736) if (fd < 0) {
c54ef5e4 737) res = -1;
c54ef5e4 738) goto finish_revert;
c54ef5e4 741) if (is_initial)
c54ef5e4 742) oidcpy(&oid, s->r->hash_algo->empty_tree);
c54ef5e4 744) tree = parse_tree_indirect(&oid);
c54ef5e4 745) if (!tree) {
c54ef5e4 747) goto finish_revert;
c54ef5e4 749) oidcpy(&oid, &tree->object.oid);
c54ef5e4 752) ALLOC_ARRAY(paths, count + 1);
c54ef5e4 753) for (i = j = 0; i < files->items.nr; i++)
c54ef5e4 754) if (files->selected[i])
c54ef5e4 755) paths[j++] = files->items.items[i].string;
c54ef5e4 756) paths[j] = NULL;
c54ef5e4 758) parse_pathspec(&diffopt.pathspec, 0,
c54ef5e4 762) diffopt.output_format = DIFF_FORMAT_CALLBACK;
c54ef5e4 763) diffopt.format_callback = revert_from_diff;
c54ef5e4 764) diffopt.flags.override_submodule_config = 1;
c54ef5e4 765) diffopt.repo = s->r;
c54ef5e4 767) if (do_diff_cache(&oid, &diffopt))
c54ef5e4 768) res = -1;
c54ef5e4 770) diffcore_std(&diffopt);
c54ef5e4 771) diff_flush(&diffopt);
c54ef5e4 773) free(paths);
c54ef5e4 774) clear_pathspec(&diffopt.pathspec);
c54ef5e4 776) if (!res && write_locked_index(s->r->index, &index_lock,
c54ef5e4 778) res = -1;
c54ef5e4 780) res = repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0, 1,
c54ef5e4 783) if (!res)
c54ef5e4 784) printf(Q_("reverted %d path\n",
c54ef5e4 788) putchar('\n');
c54ef5e4 789) return res;
ab1e1ccc 792) static int get_untracked_files(struct repository *r,
ab1e1ccc 796) struct dir_struct dir = { 0 };
ab1e1ccc 798) struct strbuf buf = STRBUF_INIT;
ab1e1ccc 800) if (repo_read_index(r) < 0)
ab1e1ccc 803) prefix_item_list_clear(files);
ab1e1ccc 804) setup_standard_excludes(&dir);
ab1e1ccc 805) add_pattern_list(&dir, EXC_CMDL, "--exclude option");
ab1e1ccc 806) fill_directory(&dir, r->index, ps);
ab1e1ccc 808) for (i = 0; i < dir.nr; i++) {
ab1e1ccc 809) struct dir_entry *ent = dir.entries[i];
ab1e1ccc 811) if (index_name_is_other(r->index, ent->name, ent->len)) {
ab1e1ccc 812) strbuf_reset(&buf);
ab1e1ccc 813) strbuf_add(&buf, ent->name, ent->len);
ab1e1ccc 814) add_file_item(&files->items, buf.buf);
ab1e1ccc 818) strbuf_release(&buf);
ab1e1ccc 819) return 0;
ab1e1ccc 822) static int run_add_untracked(struct add_i_state *s, const struct pathspec *ps,
ab1e1ccc 826) struct print_file_item_data *d = opts->list_opts.print_item_data;
ab1e1ccc 827) int res = 0, fd;
ab1e1ccc 831) if (get_untracked_files(s->r, files, ps) < 0)
ab1e1ccc 832) return -1;
ab1e1ccc 834) if (!files->items.nr) {
ab1e1ccc 835) printf(_("No untracked files.\n"));
ab1e1ccc 836) goto finish_add_untracked;
ab1e1ccc 839) opts->prompt = N_("Add untracked");
ab1e1ccc 840) d->only_names = 1;
ab1e1ccc 841) count = list_and_choose(s, files, opts);
ab1e1ccc 842) d->only_names = 0;
ab1e1ccc 843) if (count <= 0)
ab1e1ccc 844) goto finish_add_untracked;
ab1e1ccc 846) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
ab1e1ccc 847) if (fd < 0) {
ab1e1ccc 848) res = -1;
ab1e1ccc 849) goto finish_add_untracked;
ab1e1ccc 852) for (i = 0; i < files->items.nr; i++) {
ab1e1ccc 853) const char *name = files->items.items[i].string;
ab1e1ccc 854) if (files->selected[i] &&
ab1e1ccc 855)     add_file_to_index(s->r->index, name, 0) < 0) {
ab1e1ccc 857) break;
ab1e1ccc 861) if (!res &&
ab1e1ccc 862)     write_locked_index(s->r->index, &index_lock, COMMIT_LOCK) < 0)
ab1e1ccc 865) if (!res)
ab1e1ccc 866) printf(Q_("added %d path\n",
ab1e1ccc 870) putchar('\n');
ab1e1ccc 871) return res;
8746e072 874) static int run_patch(struct add_i_state *s, const struct pathspec *ps,
8746e072 878) int res = 0;
8746e072 880) size_t unmerged_count = 0, binary_count = 0;
8746e072 882) if (get_modified_files(s->r, WORKTREE_ONLY, files, ps,
8746e072 884) return -1;
8746e072 886) if (unmerged_count || binary_count) {
8746e072 887) for (i = j = 0; i < files->items.nr; i++) {
8746e072 888) struct file_item *item = files->items.items[i].util;
8746e072 890) if (item->index.binary || item->worktree.binary) {
8746e072 891) free(item);
8746e072 892) free(files->items.items[i].string);
8746e072 893) } else if (item->index.unmerged ||
8746e072 895) color_fprintf_ln(stderr, s->error_color,
8746e072 897)  files->items.items[i].string);
8746e072 898) free(item);
8746e072 899) free(files->items.items[i].string);
8746e072 901) files->items.items[j++] = files->items.items[i];
8746e072 903) files->items.nr = j;
8746e072 906) if (!files->items.nr) {
8746e072 907) if (binary_count)
8746e072 908) fprintf(stderr, _("Only binary files changed.\n"));
8746e072 910) fprintf(stderr, _("No changes.\n"));
8746e072 911) return 0;
8746e072 914) opts->prompt = N_("Patch update");
8746e072 915) count = list_and_choose(s, files, opts);
8746e072 916) if (count >= 0) {
8746e072 917) struct argv_array args = ARGV_ARRAY_INIT;
1942ee44 918) struct pathspec ps_selected = { 0 };
8746e072 920) for (i = 0; i < files->items.nr; i++)
8746e072 921) if (files->selected[i])
8746e072 922) argv_array_push(&args,
8746e072 923) files->items.items[i].string);
1942ee44 924) parse_pathspec(&ps_selected,
1942ee44 927) res = run_add_p(s->r, &ps_selected);
8746e072 928) argv_array_clear(&args);
1942ee44 929) clear_pathspec(&ps_selected);
8746e072 932) return res;
d7633578 935) static int run_diff(struct add_i_state *s, const struct pathspec *ps,
d7633578 939) int res = 0;
d7633578 943) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
d7633578 945) if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
d7633578 946) return -1;
d7633578 948) if (!files->items.nr) {
d7633578 949) putchar('\n');
d7633578 950) return 0;
d7633578 953) opts->prompt = N_("Review diff");
d7633578 954) opts->flags = IMMEDIATE;
d7633578 955) count = list_and_choose(s, files, opts);
d7633578 956) opts->flags = 0;
d7633578 957) if (count >= 0) {
d7633578 958) struct argv_array args = ARGV_ARRAY_INIT;
d7633578 960) argv_array_pushl(&args, "git", "diff", "-p", "--cached",
d7633578 962)     s->r->hash_algo->empty_tree),
d7633578 964) for (i = 0; i < files->items.nr; i++)
d7633578 965) if (files->selected[i])
d7633578 966) argv_array_push(&args,
d7633578 967) files->items.items[i].string);
d7633578 968) res = run_command_v_opt(args.argv, 0);
d7633578 969) argv_array_clear(&args);
d7633578 972) putchar('\n');
d7633578 973) return res;
8c159044 976) static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
8c159044 980) color_fprintf_ln(stdout, s->help_color, "status        - %s",
8c159044 982) color_fprintf_ln(stdout, s->help_color, "update        - %s",
8c159044 984) color_fprintf_ln(stdout, s->help_color, "revert        - %s",
8c159044 986) color_fprintf_ln(stdout, s->help_color, "patch         - %s",
8c159044 988) color_fprintf_ln(stdout, s->help_color, "diff          - %s",
8c159044 990) color_fprintf_ln(stdout, s->help_color, "add untracked - %s",
8c159044 993) return 0;
a8c45be9 996) static void choose_prompt_help(struct add_i_state *s)
a8c45be9 998) color_fprintf_ln(stdout, s->help_color, "%s",
a8c45be9 1000) color_fprintf_ln(stdout, s->help_color, "1          - %s",
a8c45be9 1002) color_fprintf_ln(stdout, s->help_color, "3-5        - %s",
a8c45be9 1004) color_fprintf_ln(stdout, s->help_color, "2-3,6-9    - %s",
a8c45be9 1006) color_fprintf_ln(stdout, s->help_color, "foo        - %s",
a8c45be9 1008) color_fprintf_ln(stdout, s->help_color, "-...       - %s",
a8c45be9 1010) color_fprintf_ln(stdout, s->help_color, "*          - %s",
a8c45be9 1012) color_fprintf_ln(stdout, s->help_color, "           - %s",
a8c45be9 1014) }
f37c2264 1029) static void print_command_item(int i, int selected,
3d965c76 1033) struct print_command_item_data *d = print_command_item_data;
76b74323 1034) struct command_item *util = item->util;
76b74323 1036) if (!util->prefix_length ||
76b74323 1037)     !is_valid_prefix(item->string, util->prefix_length))
76b74323 1038) printf(" %2d: %s", i + 1, item->string);
3d965c76 1040) printf(" %2d: %s%.*s%s%s", i + 1,
3d965c76 1041)        d->color, (int)util->prefix_length, item->string,
3d965c76 1042)        d->reset, item->string + util->prefix_length);
6348bfba 1043) }
68db1cbf 1045) static void command_prompt_help(struct add_i_state *s)
68db1cbf 1047) const char *help_color = s->help_color;
68db1cbf 1048) color_fprintf_ln(stdout, help_color, "%s", _("Prompt help:"));
68db1cbf 1049) color_fprintf_ln(stdout, help_color, "1          - %s",
68db1cbf 1051) color_fprintf_ln(stdout, help_color, "foo        - %s",
68db1cbf 1053) color_fprintf_ln(stdout, help_color, "           - %s",
68db1cbf 1055) }
f83dff60 1057) int run_add_i(struct repository *r, const struct pathspec *ps)
5e82b9e4 1059) struct add_i_state s = { NULL };
3d965c76 1060) struct print_command_item_data data = { "[", "]" };
6348bfba 1061) struct list_and_choose_options main_loop_opts = {
6348bfba 1068) } command_list[] = {
76b74323 1078) struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
5e82b9e4 1080) struct print_file_item_data print_file_item_data = {
a8c45be9 1084) struct list_and_choose_options opts = {
5e82b9e4 1088) struct strbuf header = STRBUF_INIT;
a8c45be9 1089) struct prefix_item_list files = PREFIX_ITEM_LIST_INIT;
5e82b9e4 1091) int res = 0;
76b74323 1093) for (i = 0; i < ARRAY_SIZE(command_list); i++) {
76b74323 1094) struct command_item *util = xcalloc(sizeof(*util), 1);
76b74323 1095) util->command = command_list[i].command;
76b74323 1096) string_list_append(&commands.items, command_list[i].string)
76b74323 1097) ->util = util;
5e82b9e4 1100) init_add_i_state(&s, r);
3d965c76 1106) if (s.use_color) {
3d965c76 1107) data.color = s.prompt_color;
3d965c76 1108) data.reset = s.reset_color;
a8c45be9 1110) print_file_item_data.color = data.color;
a8c45be9 1111) print_file_item_data.reset = data.reset;
5e82b9e4 1113) strbuf_addstr(&header, "      ");
5e82b9e4 1114) strbuf_addf(&header, print_file_item_data.modified_fmt,
a8c45be9 1116) opts.list_opts.header = header.buf;
5e82b9e4 1118) if (discard_index(r->index) < 0 ||
5e82b9e4 1119)     repo_read_index(r) < 0 ||
5e82b9e4 1120)     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
5e82b9e4 1124) res = run_status(&s, ps, &files, &opts);
6348bfba 1129) i = list_and_choose(&s, &commands, &main_loop_opts);
2e697ced 1130) if (i < 0 || i >= commands.items.nr)
2e697ced 1131) util = NULL;
2e697ced 1133) util = commands.items.items[i].util;
2e697ced 1135) if (i == LIST_AND_CHOOSE_QUIT || (util && !util->command)) {
6348bfba 1136) printf(_("Bye.\n"));
6348bfba 1137) res = 0;
6348bfba 1138) break;
2e697ced 1141) if (util)
76b74323 1142) res = util->command(&s, ps, &files, &opts);
6348bfba 1143) }
a8c45be9 1145) prefix_item_list_clear(&files);
5e82b9e4 1146) strbuf_release(&print_file_item_data.buf);
a8c45be9 1147) strbuf_release(&print_file_item_data.name);
5e82b9e4 1148) strbuf_release(&print_file_item_data.index);
5e82b9e4 1149) strbuf_release(&print_file_item_data.worktree);
5e82b9e4 1150) strbuf_release(&header);
76b74323 1151) prefix_item_list_clear(&commands);
5e82b9e4 1153) return res;

add-patch.c
7584dd3c 52) static void err(struct add_p_state *s, const char *fmt, ...)
7584dd3c 56) va_start(args, fmt);
7584dd3c 57) fputs(s->s.error_color, stderr);
7584dd3c 58) vfprintf(stderr, fmt, args);
7584dd3c 59) fputs(s->s.reset_color, stderr);
7584dd3c 60) fputc('\n', stderr);
7584dd3c 61) va_end(args);
7584dd3c 62) }
f6aa7ecc 64) static void setup_child_process(struct add_p_state *s,
f6aa7ecc 70) va_start(ap, cp);
f6aa7ecc 71) while ((arg = va_arg(ap, const char *)))
f6aa7ecc 72) argv_array_push(&cp->args, arg);
f6aa7ecc 73) va_end(ap);
f6aa7ecc 75) cp->git_cmd = 1;
f6aa7ecc 76) argv_array_pushf(&cp->env_array,
25ea47af 77)  INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
25ea47af 78) }
25ea47af 80) static int parse_range(const char **p,
25ea47af 85) *offset = strtoul(*p, &pend, 10);
25ea47af 86) if (pend == *p)
25ea47af 87) return -1;
25ea47af 88) if (*pend != ',') {
25ea47af 89) *count = 1;
25ea47af 90) *p = pend;
25ea47af 91) return 0;
25ea47af 93) *count = strtoul(pend + 1, (char **)p, 10);
25ea47af 94) return *p == pend + 1 ? -1 : 0;
25ea47af 97) static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
25ea47af 99) struct hunk_header *header = &hunk->header;
25ea47af 100) const char *line = s->plain.buf + hunk->start, *p = line;
25ea47af 101) char *eol = memchr(p, '\n', s->plain.len - hunk->start);
25ea47af 103) if (!eol)
25ea47af 104) eol = s->plain.buf + s->plain.len;
25ea47af 106) if (!skip_prefix(p, "@@ -", &p) ||
25ea47af 107)     parse_range(&p, &header->old_offset, &header->old_count) < 0 ||
25ea47af 108)     !skip_prefix(p, " +", &p) ||
25ea47af 109)     parse_range(&p, &header->new_offset, &header->new_count) < 0 ||
25ea47af 110)     !skip_prefix(p, " @@", &p))
25ea47af 114) hunk->start = eol - s->plain.buf + (*eol == '\n');
25ea47af 115) header->extra_start = p - s->plain.buf;
25ea47af 116) header->extra_end = hunk->start;
25ea47af 118) if (!s->colored.len) {
25ea47af 119) header->colored_extra_start = header->colored_extra_end = 0;
25ea47af 120) return 0;
25ea47af 124) line = s->colored.buf + hunk->colored_start;
25ea47af 125) eol = memchr(line, '\n', s->colored.len - hunk->colored_start);
25ea47af 126) if (!eol)
25ea47af 127) eol = s->colored.buf + s->colored.len;
25ea47af 128) p = memmem(line, eol - line, "@@ -", 4);
25ea47af 129) if (!p)
25ea47af 132) p = memmem(p + 4, eol - p - 4, " @@", 3);
25ea47af 133) if (!p)
25ea47af 136) hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
25ea47af 137) header->colored_extra_start = p + 3 - s->colored.buf;
25ea47af 138) header->colored_extra_end = hunk->colored_start;
25ea47af 140) return 0;
5906d5de 143) static int is_octal(const char *p, size_t len)
5906d5de 145) if (!len)
5906d5de 146) return 0;
5906d5de 148) while (len--)
5906d5de 149) if (*p < '0' || *(p++) > '7')
5906d5de 150) return 0;
5906d5de 151) return 1;
f6aa7ecc 154) static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
e3bd11b4 156) struct argv_array args = ARGV_ARRAY_INIT;
e3bd11b4 157) struct strbuf *plain = &s->plain, *colored = NULL;
f6aa7ecc 158) struct child_process cp = CHILD_PROCESS_INIT;
510aeca1 159) char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
80399aec 160) size_t file_diff_alloc = 0, i, color_arg_index;
80399aec 161) struct file_diff *file_diff = NULL;
f6aa7ecc 162) struct hunk *hunk = NULL;
e3bd11b4 166) argv_array_pushl(&args, "diff-files", "-p", "--no-color", "--", NULL);
e3bd11b4 167) color_arg_index = args.argc - 2;
f6aa7ecc 168) for (i = 0; i < ps->nr; i++)
e3bd11b4 169) argv_array_push(&args, ps->items[i].original);
e3bd11b4 171) setup_child_process(s, &cp, NULL);
e3bd11b4 172) cp.argv = args.argv;
f6aa7ecc 173) res = capture_command(&cp, plain, 0);
e3bd11b4 174) if (res) {
e3bd11b4 175) argv_array_clear(&args);
e3bd11b4 178) if (!plain->len) {
e3bd11b4 179) argv_array_clear(&args);
f6aa7ecc 180) return 0;
f6aa7ecc 182) strbuf_complete_line(plain);
e3bd11b4 184) if (want_color_fd(1, -1)) {
e3bd11b4 185) struct child_process colored_cp = CHILD_PROCESS_INIT;
e3bd11b4 187) setup_child_process(s, &colored_cp, NULL);
e3bd11b4 188) xsnprintf((char *)args.argv[color_arg_index], 8, "--color");
e3bd11b4 189) colored_cp.argv = args.argv;
e3bd11b4 190) colored = &s->colored;
e3bd11b4 191) res = capture_command(&colored_cp, colored, 0);
e3bd11b4 192) argv_array_clear(&args);
e3bd11b4 193) if (res)
e3bd11b4 195) strbuf_complete_line(colored);
e3bd11b4 196) colored_p = colored->buf;
e3bd11b4 197) colored_pend = colored_p + colored->len;
e3bd11b4 199) argv_array_clear(&args);
f6aa7ecc 202) p = plain->buf;
f6aa7ecc 203) pend = p + plain->len;
f6aa7ecc 204) while (p != pend) {
f6aa7ecc 205) char *eol = memchr(p, '\n', pend - p);
5906d5de 206) const char *deleted = NULL, *mode_change = NULL;
f6aa7ecc 208) if (!eol)
f6aa7ecc 209) eol = pend;
f6aa7ecc 211) if (starts_with(p, "diff ")) {
80399aec 212) s->file_diff_nr++;
80399aec 213) ALLOC_GROW(s->file_diff, s->file_diff_nr,
80399aec 215) file_diff = s->file_diff + s->file_diff_nr - 1;
80399aec 216) memset(file_diff, 0, sizeof(*file_diff));
80399aec 217) hunk = &file_diff->head;
80399aec 218) hunk->start = p - plain->buf;
80399aec 219) if (colored_p)
80399aec 220) hunk->colored_start = colored_p - colored->buf;
510aeca1 221) marker = '\0';
f6aa7ecc 222) } else if (p == plain->buf)
47dc4fd5 225) else if (file_diff->deleted)
47dc4fd5 227) else if (starts_with(p, "@@ ") ||
47dc4fd5 228)  (hunk == &file_diff->head &&
47dc4fd5 229)   skip_prefix(p, "deleted file", &deleted))) {
510aeca1 230) if (marker == '-' || marker == '+')
510aeca1 235) hunk->splittable_into++;
80399aec 237) file_diff->hunk_nr++;
80399aec 238) ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
80399aec 240) hunk = file_diff->hunk + file_diff->hunk_nr - 1;
f6aa7ecc 241) memset(hunk, 0, sizeof(*hunk));
f6aa7ecc 243) hunk->start = p - plain->buf;
e3bd11b4 244) if (colored)
e3bd11b4 245) hunk->colored_start = colored_p - colored->buf;
47dc4fd5 247) if (deleted)
47dc4fd5 248) file_diff->deleted = 1;
47dc4fd5 249) else if (parse_hunk_header(s, hunk) < 0)
25ea47af 250) return -1;
510aeca1 256) marker = *p;
5906d5de 257) } else if (hunk == &file_diff->head &&
5906d5de 258)    skip_prefix(p, "old mode ", &mode_change) &&
5906d5de 259)    is_octal(mode_change, eol - mode_change)) {
5906d5de 260) if (file_diff->mode_change)
5906d5de 263) if (file_diff->hunk_nr++)
5906d5de 271) file_diff->mode_change = 1;
5906d5de 272) ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
5906d5de 274) memset(file_diff->hunk, 0, sizeof(struct hunk));
5906d5de 275) file_diff->hunk->start = p - plain->buf;
5906d5de 276) if (colored_p)
5906d5de 277) file_diff->hunk->colored_start =
5906d5de 278) colored_p - colored->buf;
5906d5de 279) } else if (hunk == &file_diff->head &&
5906d5de 280)    skip_prefix(p, "new mode ", &mode_change) &&
5906d5de 281)    is_octal(mode_change, eol - mode_change)) {
5906d5de 287) if (!file_diff->mode_change)
5906d5de 290) if (file_diff->hunk_nr != 1)
5906d5de 293) if (p - plain->buf != file_diff->hunk->end)
2e408319 297) } else if (hunk == &file_diff->head &&
2e408319 298)    starts_with(p, "Binary files "))
2e408319 299) file_diff->binary = 1;
5906d5de 301) if (file_diff->deleted && file_diff->mode_change)
510aeca1 306) if ((marker == '-' || marker == '+') && *p == ' ')
510aeca1 307) hunk->splittable_into++;
510aeca1 308) if (marker && *p != '\\')
510aeca1 309) marker = *p;
f6aa7ecc 311) p = eol == pend ? pend : eol + 1;
f6aa7ecc 312) hunk->end = p - plain->buf;
e3bd11b4 314) if (colored) {
e3bd11b4 315) char *colored_eol = memchr(colored_p, '\n',
e3bd11b4 316)    colored_pend - colored_p);
e3bd11b4 317) if (colored_eol)
e3bd11b4 318) colored_p = colored_eol + 1;
e3bd11b4 320) colored_p = colored_pend;
e3bd11b4 322) hunk->colored_end = colored_p - colored->buf;
5906d5de 325) if (mode_change) {
5906d5de 326) if (file_diff->hunk_nr != 1)
5906d5de 330) file_diff->hunk->end = hunk->end;
5906d5de 331) if (colored)
5906d5de 332) file_diff->hunk->colored_end = hunk->colored_end;
510aeca1 336) if (marker == '-' || marker == '+')
510aeca1 341) hunk->splittable_into++;
f6aa7ecc 343) return 0;
510aeca1 346) static size_t find_next_line(struct strbuf *sb, size_t offset)
510aeca1 350) if (offset >= sb->len)
510aeca1 354) eol = memchr(sb->buf + offset, '\n', sb->len - offset);
510aeca1 355) if (!eol)
510aeca1 356) return sb->len;
510aeca1 357) return eol - sb->buf + 1;
f6aa7ecc 360) static void render_hunk(struct add_p_state *s, struct hunk *hunk,
25ea47af 363) struct hunk_header *header = &hunk->header;
25ea47af 365) if (hunk->header.old_offset != 0 || hunk->header.new_offset != 0) {
25ea47af 372) unsigned long old_offset = header->old_offset;
25ea47af 373) unsigned long new_offset = header->new_offset;
25ea47af 375) if (!colored) {
25ea47af 376) p = s->plain.buf + header->extra_start;
25ea47af 377) len = header->extra_end - header->extra_start;
25ea47af 379) strbuf_addstr(out, s->s.fraginfo_color);
25ea47af 380) p = s->colored.buf + header->colored_extra_start;
25ea47af 381) len = header->colored_extra_end
25ea47af 382) - header->colored_extra_start;
25ea47af 385) new_offset += delta;
25ea47af 387) strbuf_addf(out, "@@ -%lu,%lu +%lu,%lu @@",
25ea47af 390) if (len)
25ea47af 391) strbuf_add(out, p, len);
25ea47af 392) else if (colored)
25ea47af 393) strbuf_addf(out, "%s\n", GIT_COLOR_RESET);
25ea47af 395) strbuf_addch(out, '\n');
e3bd11b4 398) if (colored)
e3bd11b4 399) strbuf_add(out, s->colored.buf + hunk->colored_start,
e3bd11b4 400)    hunk->colored_end - hunk->colored_start);
e3bd11b4 402) strbuf_add(out, s->plain.buf + hunk->start,
e3bd11b4 403)    hunk->end - hunk->start);
f6aa7ecc 404) }
5906d5de 406) static void render_diff_header(struct add_p_state *s,
5906d5de 415) int skip_mode_change =
5906d5de 416) file_diff->mode_change && file_diff->hunk->use != USE_HUNK;
5906d5de 417) struct hunk *head = &file_diff->head, *first = file_diff->hunk;
5906d5de 419) if (!skip_mode_change) {
5906d5de 420) render_hunk(s, head, 0, colored, out);
5906d5de 421) return;
5906d5de 424) if (colored) {
5906d5de 425) const char *p = s->colored.buf;
5906d5de 427) strbuf_add(out, p + head->colored_start,
5906d5de 428)     first->colored_start - head->colored_start);
5906d5de 429) strbuf_add(out, p + first->colored_end,
5906d5de 430)     head->colored_end - first->colored_end);
5906d5de 432) const char *p = s->plain.buf;
5906d5de 434) strbuf_add(out, p + head->start, first->start - head->start);
5906d5de 435) strbuf_add(out, p + first->end, head->end - first->end);
11f2c0da 440) static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
bcdd297b 443) size_t i = *hunk_index, delta;
11f2c0da 444) struct hunk *hunk = file_diff->hunk + i;
11f2c0da 446) struct hunk_header *header = &merged->header, *next;
bcdd297b 448) if (!use_all && hunk->use != USE_HUNK)
11f2c0da 449) return 0;
11f2c0da 451) *merged = *hunk;
11f2c0da 453) merged->colored_start = merged->colored_end = 0;
11f2c0da 455) for (; i + 1 < file_diff->hunk_nr; i++) {
11f2c0da 456) hunk++;
11f2c0da 457) next = &hunk->header;
bcdd297b 465) if ((!use_all && hunk->use != USE_HUNK) ||
bcdd297b 466)     header->new_offset >= next->new_offset + merged->delta ||
bcdd297b 467)     header->new_offset + header->new_count
bcdd297b 468)     < next->new_offset + merged->delta)
bcdd297b 475) if (merged->start < hunk->start && merged->end > hunk->start) {
bcdd297b 476) merged->end = hunk->end;
bcdd297b 477) merged->colored_end = hunk->colored_end;
bcdd297b 478) delta = 0;
bcdd297b 480) const char *plain = s->plain.buf;
bcdd297b 481) size_t  overlapping_line_count = header->new_offset
bcdd297b 482) + header->new_count - merged->delta
bcdd297b 483) - next->new_offset;
bcdd297b 484) size_t overlap_end = hunk->start;
bcdd297b 485) size_t overlap_start = overlap_end;
bcdd297b 496) for (j = 0; j < overlapping_line_count; j++) {
bcdd297b 497) overlap_next = find_next_line(&s->plain,
bcdd297b 500) if (overlap_next > hunk->end)
bcdd297b 507) if (plain[overlap_end] != ' ')
bcdd297b 515) overlap_start = overlap_end;
bcdd297b 516) overlap_end = overlap_next;
bcdd297b 518) len = overlap_end - overlap_start;
bcdd297b 520) if (len > merged->end - merged->start ||
bcdd297b 521)     memcmp(plain + merged->end - len,
bcdd297b 535) if (merged->end != s->plain.len) {
bcdd297b 536) size_t start = s->plain.len;
bcdd297b 538) strbuf_add(&s->plain, plain + merged->start,
bcdd297b 539)    merged->end - merged->start);
bcdd297b 540) plain = s->plain.buf;
bcdd297b 541) merged->start = start;
bcdd297b 542) merged->end = s->plain.len;
bcdd297b 545) strbuf_add(&s->plain,
bcdd297b 547)    hunk->end - overlap_end);
bcdd297b 548) merged->end = s->plain.len;
bcdd297b 549) merged->splittable_into += hunk->splittable_into;
bcdd297b 550) delta = merged->delta;
bcdd297b 551) merged->delta += hunk->delta;
11f2c0da 554) header->old_count = next->old_offset + next->old_count
11f2c0da 555) - header->old_offset;
bcdd297b 556) header->new_count = next->new_offset + delta
bcdd297b 557) + next->new_count - header->new_offset;
11f2c0da 560) if (i == *hunk_index)
11f2c0da 561) return 0;
11f2c0da 563) *hunk_index = i;
11f2c0da 564) return 1;
80399aec 567) static void reassemble_patch(struct add_p_state *s,
bcdd297b 572) size_t save_len = s->plain.len, i;
25ea47af 573) ssize_t delta = 0;
5906d5de 575) render_diff_header(s, file_diff, 0, out);
5906d5de 577) for (i = file_diff->mode_change; i < file_diff->hunk_nr; i++) {
11f2c0da 578) struct hunk merged = { 0 };
80399aec 580) hunk = file_diff->hunk + i;
bcdd297b 581) if (!use_all && hunk->use != USE_HUNK)
25ea47af 582) delta += hunk->header.old_count
25ea47af 583) - hunk->header.new_count;
bcdd297b 586) if (merge_hunks(s, file_diff, &i, use_all, &merged))
11f2c0da 587) hunk = &merged;
25ea47af 589) render_hunk(s, hunk, delta, 0, out);
bcdd297b 596) strbuf_setlen(&s->plain, save_len);
bcdd297b 598) delta += hunk->delta;
f6aa7ecc 601) }
510aeca1 603) static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
510aeca1 606) int colored = !!s->colored.len, first = 1;
510aeca1 607) struct hunk *hunk = file_diff->hunk + hunk_index;
510aeca1 609) size_t end, colored_end, current, colored_current = 0, context_line_count;
510aeca1 613) if (hunk_index >= file_diff->hunk_nr)
510aeca1 617) if (hunk->splittable_into < 2)
510aeca1 618) return 0;
510aeca1 619) splittable_into = hunk->splittable_into;
510aeca1 621) end = hunk->end;
510aeca1 622) colored_end = hunk->colored_end;
510aeca1 624) remaining = hunk->header;
510aeca1 626) file_diff->hunk_nr += splittable_into - 1;
510aeca1 627) ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr, file_diff->hunk_alloc);
510aeca1 628) if (hunk_index + splittable_into < file_diff->hunk_nr)
510aeca1 629) memmove(file_diff->hunk + hunk_index + splittable_into,
510aeca1 630) file_diff->hunk + hunk_index + 1,
510aeca1 631) (file_diff->hunk_nr - hunk_index - splittable_into)
510aeca1 633) hunk = file_diff->hunk + hunk_index;
510aeca1 634) hunk->splittable_into = 1;
510aeca1 635) memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
510aeca1 637) header = &hunk->header;
510aeca1 638) header->old_count = header->new_count = 0;
510aeca1 640) current = hunk->start;
510aeca1 641) if (colored)
510aeca1 642) colored_current = hunk->colored_start;
510aeca1 643) marker = '\0';
510aeca1 644) context_line_count = 0;
510aeca1 646) while (splittable_into > 1) {
510aeca1 647) ch = s->plain.buf[current];
510aeca1 649) if (!ch)
510aeca1 656) if ((marker == '-' || marker == '+') && ch == ' ') {
510aeca1 657) first = 0;
510aeca1 658) hunk[1].start = current;
510aeca1 659) if (colored)
510aeca1 660) hunk[1].colored_start = colored_current;
510aeca1 661) context_line_count = 0;
510aeca1 671) if (marker != ' ' || (ch != '-' && ch != '+')) {
510aeca1 674) if (ch == '\\')
510aeca1 675) ch = marker ? marker : ' ';
510aeca1 678) if (ch == ' ')
510aeca1 679) context_line_count++;
510aeca1 680) else if (ch == '-')
510aeca1 681) header->old_count++;
510aeca1 682) else if (ch == '+')
510aeca1 683) header->new_count++;
510aeca1 686) marker = ch;
510aeca1 687) current = find_next_line(&s->plain, current);
510aeca1 688) if (colored)
510aeca1 689) colored_current =
510aeca1 690) find_next_line(&s->colored,
510aeca1 692) continue;
510aeca1 702) if (first) {
510aeca1 703) if (header->old_count || header->new_count)
510aeca1 708) header->old_count = context_line_count;
510aeca1 709) header->new_count = context_line_count;
510aeca1 710) context_line_count = 0;
510aeca1 711) first = 0;
510aeca1 712) goto next_hunk_line;
510aeca1 715) remaining.old_offset += header->old_count;
510aeca1 716) remaining.old_count -= header->old_count;
510aeca1 717) remaining.new_offset += header->new_count;
510aeca1 718) remaining.new_count -= header->new_count;
510aeca1 721) hunk[1].header.old_offset =
510aeca1 722) header->old_offset + header->old_count;
510aeca1 723) hunk[1].header.new_offset =
510aeca1 724) header->new_offset + header->new_count;
510aeca1 727) header->old_count += context_line_count;
510aeca1 728) header->new_count += context_line_count;
510aeca1 730) hunk->end = current;
510aeca1 731) if (colored)
510aeca1 732) hunk->colored_end = colored_current;
510aeca1 734) hunk++;
510aeca1 735) hunk->splittable_into = 1;
510aeca1 736) hunk->use = hunk[-1].use;
510aeca1 737) header = &hunk->header;
510aeca1 739) header->old_count = header->new_count = context_line_count;
510aeca1 740) context_line_count = 0;
510aeca1 742) splittable_into--;
510aeca1 743) marker = ch;
510aeca1 747) if (header->old_offset != remaining.old_offset)
510aeca1 750) if (header->new_offset != remaining.new_offset)
510aeca1 753) header->old_count = remaining.old_count;
510aeca1 754) header->new_count = remaining.new_count;
510aeca1 755) hunk->end = end;
510aeca1 756) if (colored)
510aeca1 757) hunk->colored_end = colored_end;
510aeca1 759) return 0;
bcdd297b 762) static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
bcdd297b 764) const char *plain = s->plain.buf;
bcdd297b 767) if (!s->colored.len)
bcdd297b 768) return;
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
bcdd297b 794) static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
bcdd297b 798) strbuf_reset(&s->buf);
bcdd297b 799) strbuf_commented_addf(&s->buf, _("Manual hunk edit mode -- see bottom for "
bcdd297b 801) render_hunk(s, hunk, 0, 0, &s->buf);
bcdd297b 802) strbuf_commented_addf(&s->buf,
bcdd297b 809) strbuf_commented_addf(&s->buf,
bcdd297b 817) strbuf_commented_addf(&s->buf,
bcdd297b 824) if (strbuf_edit_interactively(&s->buf, "addp-hunk-edit.diff", NULL) < 0)
bcdd297b 825) return -1;
bcdd297b 828) hunk->start = s->plain.len;
bcdd297b 829) for (i = 0; i < s->buf.len; ) {
bcdd297b 830) size_t next = find_next_line(&s->buf, i);
bcdd297b 832) if (s->buf.buf[i] != comment_line_char)
bcdd297b 833) strbuf_add(&s->plain, s->buf.buf + i, next - i);
bcdd297b 834) i = next;
bcdd297b 837) hunk->end = s->plain.len;
bcdd297b 838) if (hunk->end == hunk->start)
bcdd297b 840) return 0;
bcdd297b 842) recolor_hunk(s, hunk);
bcdd297b 849) if (s->plain.buf[hunk->start] == '@' &&
bcdd297b 850)     parse_hunk_header(s, hunk) < 0)
bcdd297b 853) return 1;
bcdd297b 856) static ssize_t recount_edited_hunk(struct add_p_state *s, struct hunk *hunk,
bcdd297b 859) struct hunk_header *header = &hunk->header;
bcdd297b 862) header->old_count = header->new_count = 0;
bcdd297b 863) for (i = hunk->start; i < hunk->end; ) {
bcdd297b 864) switch (s->plain.buf[i]) {
bcdd297b 866) header->old_count++;
bcdd297b 867) break;
bcdd297b 869) header->new_count++;
bcdd297b 870) break;
bcdd297b 872) header->old_count++;
bcdd297b 873) header->new_count++;
bcdd297b 874) break;
bcdd297b 877) i = find_next_line(&s->plain, i);
bcdd297b 880) return orig_old_count - orig_new_count
bcdd297b 881) - header->old_count + header->new_count;
bcdd297b 884) static int run_apply_check(struct add_p_state *s,
bcdd297b 887) struct child_process cp = CHILD_PROCESS_INIT;
bcdd297b 889) strbuf_reset(&s->buf);
bcdd297b 890) reassemble_patch(s, file_diff, 1, &s->buf);
bcdd297b 892) setup_child_process(s, &cp,
bcdd297b 894) if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
bcdd297b 897) return 0;
bcdd297b 900) static int prompt_yesno(struct add_p_state *s, const char *prompt)
bcdd297b 903) color_fprintf(stdout, s->s.prompt_color, "%s", _(prompt));
bcdd297b 904) fflush(stdout);
bcdd297b 905) if (strbuf_getline(&s->answer, stdin) == EOF)
bcdd297b 906) return -1;
bcdd297b 907) strbuf_trim_trailing_newline(&s->answer);
bcdd297b 908) switch (tolower(s->answer.buf[0])) {
bcdd297b 909) case 'n': return 0;
bcdd297b 910) case 'y': return 1;
bcdd297b 912) }
bcdd297b 915) static int edit_hunk_loop(struct add_p_state *s,
bcdd297b 918) size_t plain_len = s->plain.len, colored_len = s->colored.len;
bcdd297b 921) backup = *hunk;
bcdd297b 924) int res = edit_hunk_manually(s, hunk);
bcdd297b 925) if (res == 0) {
bcdd297b 927) *hunk = backup;
bcdd297b 928) return -1;
bcdd297b 931) if (res > 0) {
bcdd297b 932) hunk->delta +=
bcdd297b 933) recount_edited_hunk(s, hunk,
bcdd297b 936) if (!run_apply_check(s, file_diff))
bcdd297b 937) return 0;
bcdd297b 941) strbuf_setlen(&s->plain, plain_len);
bcdd297b 942) strbuf_setlen(&s->colored, colored_len);
bcdd297b 943) *hunk = backup;
bcdd297b 952) res = prompt_yesno(s, _("Your edited hunk does not apply. "
bcdd297b 955) if (res < 1)
bcdd297b 956) return -1;
bcdd297b 957) }
9254bdfb 962) static void summarize_hunk(struct add_p_state *s, struct hunk *hunk,
9254bdfb 965) struct hunk_header *header = &hunk->header;
9254bdfb 966) struct strbuf *plain = &s->plain;
9254bdfb 967) size_t len = out->len, i;
9254bdfb 969) strbuf_addf(out, " -%lu,%lu +%lu,%lu ",
9254bdfb 972) if (out->len - len < SUMMARY_HEADER_WIDTH)
9254bdfb 973) strbuf_addchars(out, ' ',
9254bdfb 974) SUMMARY_HEADER_WIDTH + len - out->len);
9254bdfb 975) for (i = hunk->start; i < hunk->end; i = find_next_line(plain, i))
9254bdfb 976) if (plain->buf[i] != ' ')
9254bdfb 977) break;
9254bdfb 978) if (i < hunk->end)
9254bdfb 979) strbuf_add(out, plain->buf + i, find_next_line(plain, i) - i);
9254bdfb 980) if (out->len - len > SUMMARY_LINE_WIDTH)
9254bdfb 981) strbuf_setlen(out, len + SUMMARY_LINE_WIDTH);
9254bdfb 982) strbuf_complete_line(out);
9254bdfb 983) }
9254bdfb 986) static size_t display_hunks(struct add_p_state *s,
9254bdfb 989) size_t end_index = start_index + DISPLAY_HUNKS_LINES;
9254bdfb 991) if (end_index > file_diff->hunk_nr)
9254bdfb 992) end_index = file_diff->hunk_nr;
9254bdfb 994) while (start_index < end_index) {
9254bdfb 995) struct hunk *hunk = file_diff->hunk + start_index++;
9254bdfb 997) strbuf_reset(&s->buf);
9254bdfb 998) strbuf_addf(&s->buf, "%c%2d: ", hunk->use == USE_HUNK ? '+'
9254bdfb 999)     : hunk->use == SKIP_HUNK ? '-' : ' ',
9254bdfb 1001) summarize_hunk(s, hunk, &s->buf);
9254bdfb 1002) fputs(s->buf.buf, stdout);
9254bdfb 1005) return end_index;
80399aec 1026) static int patch_update_file(struct add_p_state *s,
f6aa7ecc 1029) size_t hunk_index = 0;
f6aa7ecc 1033) struct child_process cp = CHILD_PROCESS_INIT;
ade246ef 1034) int colored = !!s->colored.len, quit = 0;
80399aec 1037) if (!file_diff->hunk_nr)
f6aa7ecc 1038) return 0;
f6aa7ecc 1040) strbuf_reset(&s->buf);
5906d5de 1041) render_diff_header(s, file_diff, colored, &s->buf);
f6aa7ecc 1042) fputs(s->buf.buf, stdout);
80399aec 1044) if (hunk_index >= file_diff->hunk_nr)
f6aa7ecc 1045) hunk_index = 0;
80399aec 1046) hunk = file_diff->hunk + hunk_index;
f6aa7ecc 1048) undecided_previous = -1;
f6aa7ecc 1049) for (i = hunk_index - 1; i >= 0; i--)
80399aec 1050) if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
f6aa7ecc 1051) undecided_previous = i;
f6aa7ecc 1052) break;
f6aa7ecc 1055) undecided_next = -1;
80399aec 1056) for (i = hunk_index + 1; i < file_diff->hunk_nr; i++)
80399aec 1057) if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
f6aa7ecc 1058) undecided_next = i;
f6aa7ecc 1059) break;
f6aa7ecc 1063) if (undecided_previous < 0 && undecided_next < 0 &&
f6aa7ecc 1064)     hunk->use != UNDECIDED_HUNK)
f6aa7ecc 1065) break;
f6aa7ecc 1067) strbuf_reset(&s->buf);
25ea47af 1068) render_hunk(s, hunk, 0, colored, &s->buf);
f6aa7ecc 1069) fputs(s->buf.buf, stdout);
f6aa7ecc 1071) strbuf_reset(&s->buf);
f6aa7ecc 1072) if (undecided_previous >= 0)
f6aa7ecc 1073) strbuf_addstr(&s->buf, ",k");
f6aa7ecc 1074) if (hunk_index)
f6aa7ecc 1075) strbuf_addstr(&s->buf, ",K");
f6aa7ecc 1076) if (undecided_next >= 0)
f6aa7ecc 1077) strbuf_addstr(&s->buf, ",j");
80399aec 1078) if (hunk_index + 1 < file_diff->hunk_nr)
f6aa7ecc 1079) strbuf_addstr(&s->buf, ",J");
9254bdfb 1080) if (file_diff->hunk_nr > 1)
d6cf8733 1081) strbuf_addstr(&s->buf, ",g,/");
510aeca1 1082) if (hunk->splittable_into > 1)
510aeca1 1083) strbuf_addstr(&s->buf, ",s");
bcdd297b 1084) if (hunk_index + 1 > file_diff->mode_change &&
bcdd297b 1085)     !file_diff->deleted)
bcdd297b 1086) strbuf_addstr(&s->buf, ",e");
0ecd9d27 1088) if (file_diff->deleted)
0ecd9d27 1089) prompt_mode_type = PROMPT_DELETION;
0ecd9d27 1090) else if (file_diff->mode_change && !hunk_index)
0ecd9d27 1091) prompt_mode_type = PROMPT_MODE_CHANGE;
0ecd9d27 1093) prompt_mode_type = PROMPT_HUNK;
12c24cf8 1095) color_fprintf(stdout, s->s.prompt_color,
80399aec 1098)       (uintmax_t)file_diff->hunk_nr);
12c24cf8 1099) color_fprintf(stdout, s->s.prompt_color,
f6aa7ecc 1101) fflush(stdout);
f6aa7ecc 1102) if (strbuf_getline(&s->answer, stdin) == EOF)
f6aa7ecc 1103) break;
f6aa7ecc 1104) strbuf_trim_trailing_newline(&s->answer);
f6aa7ecc 1106) if (!s->answer.len)
f6aa7ecc 1107) continue;
f6aa7ecc 1108) ch = tolower(s->answer.buf[0]);
f6aa7ecc 1109) if (ch == 'y') {
f6aa7ecc 1110) hunk->use = USE_HUNK;
f6aa7ecc 1112) hunk_index = undecided_next < 0 ?
80399aec 1113) file_diff->hunk_nr : undecided_next;
f6aa7ecc 1114) } else if (ch == 'n') {
f6aa7ecc 1115) hunk->use = SKIP_HUNK;
f6aa7ecc 1116) goto soft_increment;
f6aa7ecc 1117) } else if (ch == 'a') {
80399aec 1118) for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
80399aec 1119) hunk = file_diff->hunk + hunk_index;
f6aa7ecc 1120) if (hunk->use == UNDECIDED_HUNK)
f6aa7ecc 1121) hunk->use = USE_HUNK;
ade246ef 1123) } else if (ch == 'd' || ch == 'q') {
80399aec 1124) for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
80399aec 1125) hunk = file_diff->hunk + hunk_index;
f6aa7ecc 1126) if (hunk->use == UNDECIDED_HUNK)
f6aa7ecc 1127) hunk->use = SKIP_HUNK;
ade246ef 1129) if (ch == 'q') {
ade246ef 1130) quit = 1;
ade246ef 1131) break;
7584dd3c 1133) } else if (s->answer.buf[0] == 'K') {
7584dd3c 1134) if (hunk_index)
7584dd3c 1135) hunk_index--;
7584dd3c 1137) err(s, _("No previous hunk"));
7584dd3c 1138) } else if (s->answer.buf[0] == 'J') {
80399aec 1139) if (hunk_index + 1 < file_diff->hunk_nr)
7584dd3c 1140) hunk_index++;
7584dd3c 1142) err(s, _("No next hunk"));
7584dd3c 1143) } else if (s->answer.buf[0] == 'k') {
7584dd3c 1144) if (undecided_previous >= 0)
7584dd3c 1145) hunk_index = undecided_previous;
7584dd3c 1147) err(s, _("No previous hunk"));
7584dd3c 1148) } else if (s->answer.buf[0] == 'j') {
7584dd3c 1149) if (undecided_next >= 0)
7584dd3c 1150) hunk_index = undecided_next;
7584dd3c 1152) err(s, _("No next hunk"));
9254bdfb 1153) } else if (s->answer.buf[0] == 'g') {
9254bdfb 1157) if (file_diff->hunk_nr < 2) {
9254bdfb 1158) err(s, _("No other hunks to goto"));
9254bdfb 1159) continue;
9254bdfb 1161) strbuf_remove(&s->answer, 0, 1);
9254bdfb 1162) strbuf_trim(&s->answer);
9254bdfb 1163) i = hunk_index - DISPLAY_HUNKS_LINES / 2;
9254bdfb 1164) if (i < file_diff->mode_change)
9254bdfb 1165) i = file_diff->mode_change;
9254bdfb 1166) while (s->answer.len == 0) {
9254bdfb 1167) i = display_hunks(s, file_diff, i);
9254bdfb 1168) printf("%s", i < file_diff->hunk_nr ?
9254bdfb 1171) fflush(stdout);
9254bdfb 1172) if (strbuf_getline(&s->answer,
9254bdfb 1174) break;
9254bdfb 1175) strbuf_trim_trailing_newline(&s->answer);
9254bdfb 1178) strbuf_trim(&s->answer);
9254bdfb 1179) response = strtoul(s->answer.buf, &pend, 10);
9254bdfb 1180) if (*pend || pend == s->answer.buf)
9254bdfb 1181) err(s, _("Invalid number: '%s'"),
9254bdfb 1183) else if (0 < response && response <= file_diff->hunk_nr)
9254bdfb 1184) hunk_index = response - 1;
9254bdfb 1186) err(s, Q_("Sorry, only %d hunk available.",
9254bdfb 1189)     (int)file_diff->hunk_nr);
d6cf8733 1190) } else if (s->answer.buf[0] == '/') {
d6cf8733 1194) if (file_diff->hunk_nr < 2) {
d6cf8733 1195) err(s, _("No other hunks to search"));
d6cf8733 1196) continue;
d6cf8733 1198) strbuf_remove(&s->answer, 0, 1);
d6cf8733 1199) strbuf_trim_trailing_newline(&s->answer);
d6cf8733 1200) if (s->answer.len == 0) {
d6cf8733 1201) printf("%s", _("search for regex? "));
d6cf8733 1202) fflush(stdout);
d6cf8733 1203) if (strbuf_getline(&s->answer,
d6cf8733 1205) break;
d6cf8733 1206) strbuf_trim_trailing_newline(&s->answer);
d6cf8733 1207) if (s->answer.len == 0)
d6cf8733 1208) continue;
d6cf8733 1210) ret = regcomp(&regex, s->answer.buf,
d6cf8733 1212) if (ret) {
d6cf8733 1216) err(s, _("Malformed search regexp %s: %s"),
d6cf8733 1218) continue;
d6cf8733 1220) i = hunk_index;
d6cf8733 1223) render_hunk(s, file_diff->hunk + i, 0, 0,
d6cf8733 1225) if (regexec(&regex, s->buf.buf, 0, NULL, 0)
d6cf8733 1227) break;
d6cf8733 1228) i++;
d6cf8733 1229) if (i == file_diff->hunk_nr)
d6cf8733 1230) i = 0;
d6cf8733 1231) if (i != hunk_index)
d6cf8733 1232) continue;
d6cf8733 1233) err(s, _("No hunk matches the given pattern"));
d6cf8733 1234) break;
d6cf8733 1235) }
d6cf8733 1236) hunk_index = i;
510aeca1 1237) } else if (s->answer.buf[0] == 's') {
510aeca1 1238) size_t splittable_into = hunk->splittable_into;
510aeca1 1239) if (splittable_into < 2)
510aeca1 1240) err(s, _("Sorry, cannot split this hunk"));
510aeca1 1241) else if (!split_hunk(s, file_diff,
510aeca1 1242)      hunk - file_diff->hunk))
510aeca1 1243) color_fprintf_ln(stdout, s->s.header_color,
bcdd297b 1246) } else if (s->answer.buf[0] == 'e') {
bcdd297b 1247) if (hunk_index + 1 == file_diff->mode_change)
bcdd297b 1248) err(s, _("Sorry, cannot edit this hunk"));
bcdd297b 1249) else if (edit_hunk_loop(s, file_diff, hunk) >= 0) {
bcdd297b 1250) hunk->use = USE_HUNK;
bcdd297b 1251) goto soft_increment;
54d9d9b2 1254) const char *p = _(help_patch_remainder), *eol = p;
54d9d9b2 1256) color_fprintf(stdout, s->s.help_color, "%s",
54d9d9b2 1263) for (; *p; p = eol + (*eol == '\n')) {
54d9d9b2 1264) eol = strchrnul(p, '\n');
54d9d9b2 1271) if (*p != '?' && !strchr(s->buf.buf, *p))
54d9d9b2 1272) continue;
54d9d9b2 1274) color_fprintf_ln(stdout, s->s.help_color,
54d9d9b2 1275)  "%.*s", (int)(eol - p), p);
f6aa7ecc 1278) }
80399aec 1281) for (i = 0; i < file_diff->hunk_nr; i++)
80399aec 1282) if (file_diff->hunk[i].use == USE_HUNK)
f6aa7ecc 1283) break;
80399aec 1285) if (i < file_diff->hunk_nr) {
f6aa7ecc 1287) strbuf_reset(&s->buf);
bcdd297b 1288) reassemble_patch(s, file_diff, 0, &s->buf);
25ea47af 1290) discard_index(s->s.r->index);
f6aa7ecc 1291) setup_child_process(s, &cp, "apply", "--cached", NULL);
f6aa7ecc 1292) if (pipe_command(&cp, s->buf.buf, s->buf.len,
25ea47af 1295) if (!repo_read_index(s->s.r))
25ea47af 1296) repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
f6aa7ecc 1300) putchar('\n');
ade246ef 1301) return quit;
f6aa7ecc 1304) int run_add_p(struct repository *r, const struct pathspec *ps)
25ea47af 1306) struct add_p_state s = {
2e408319 1309) size_t i, binary_count = 0;
25ea47af 1311) init_add_i_state(&s.s, r);
f6aa7ecc 1313) if (discard_index(r->index) < 0 || repo_read_index(r) < 0 ||
f6aa7ecc 1314)     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
f6aa7ecc 1315)  NULL, NULL, NULL) < 0 ||
f6aa7ecc 1316)     parse_diff(&s, ps) < 0) {
f6aa7ecc 1317) strbuf_release(&s.plain);
e3bd11b4 1318) strbuf_release(&s.colored);
f6aa7ecc 1319) return -1;
80399aec 1322) for (i = 0; i < s.file_diff_nr; i++)
2e408319 1323) if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
2e408319 1324) binary_count++;
2e408319 1325) else if (patch_update_file(&s, s.file_diff + i))
80399aec 1326) break;
2e408319 1328) if (s.file_diff_nr == 0)
2e408319 1329) fprintf(stderr, _("No changes.\n"));
2e408319 1330) else if (binary_count == s.file_diff_nr)
2e408319 1331) fprintf(stderr, _("Only binary files changed.\n"));
f6aa7ecc 1333) strbuf_release(&s.answer);
f6aa7ecc 1334) strbuf_release(&s.buf);
f6aa7ecc 1335) strbuf_release(&s.plain);
e3bd11b4 1336) strbuf_release(&s.colored);
f6aa7ecc 1337) return 0;

apply.c
b4bbbbd5 2672) match_beginning = 0;

builtin/add.c
f6aa7ecc 199) if (!patch_mode)
f83dff60 200) return !!run_add_i(the_repository, pathspec);
f6aa7ecc 201) if (strcmp(patch_mode, "--patch"))
f6aa7ecc 204) return !!run_add_p(the_repository, pathspec);

builtin/bisect--helper.c
51a0a4ed 177) return -1;

builtin/bundle.c
79862b6b 85) else if (progress == 1)
79862b6b 86) argv_array_push(&pack_opts, "--progress");
79862b6b 87) else if (progress == 2)
79862b6b 88) argv_array_push(&pack_opts, "--all-progress");
79862b6b 90) argv_array_push(&pack_opts, "--all-progress-implied");
2e0afafe 115) return 1;
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

builtin/checkout.c

builtin/clone.c
d89f09c8 753) result = 1;
d89f09c8 1132) return 1;

builtin/commit.c

builtin/fmt-merge-msg.c
72b006f4 511) strbuf_addstr(&sig, "gpg verification failed.\n");

builtin/fsck.c
82ef89b3 64) type = oid_object_info(the_repository, oid, NULL);
82ef89b3 309) printf_ln(_("unreachable %s %s"),
82ef89b3 310)   printable_type(&obj->oid, obj->type),
82ef89b3 311)   describe_object(&obj->oid));
82ef89b3 367) fprintf_ln(stderr, _("Checking %s"), describe_object(&obj->oid));
82ef89b3 425)    printable_type(&obj->oid, obj->type),
82ef89b3 426)    describe_object(&obj->oid));
82ef89b3 439)   describe_object(&commit->object.oid));

builtin/reset.c

builtin/sparse-checkout.c
e091228e 85) return 0;
bab3c359 221) return 1;
bab3c359 275) return 1;
190a65f9 337)    strihash(e->pattern) :
af09ce24 352) return;

commit.c

dir.c
96cc8ab5 663) pl->use_cone_patterns = 0;
96cc8ab5 665) goto clear_hashmaps;
190a65f9 676)    strihash(translated->pattern) :
96cc8ab5 689) hashmap_add(&pl->parent_hashmap, &translated->ent);
96cc8ab5 690) hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
96cc8ab5 691) free(data);
96cc8ab5 692) return;
96cc8ab5 698) goto clear_hashmaps;
190a65f9 707)    strihash(translated->pattern) :
96cc8ab5 716) hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
96cc8ab5 717) free(data);
96cc8ab5 718) free(translated);
96cc8ab5 1280) return MATCHED;

fetch-pack.c

fsck.c
73390290 401) fsck_put_object_name(options, &entry.oid, "%s%s/",
73390290 470) fsck_put_object_name(options, oid, "%s^%d",
73390290 473) fsck_put_object_name(options, oid, "%.*s~%d",
73390290 496) fsck_put_object_name(options, &tag->tagged->oid, "%s", name);
7034cd09 630) retval += report(options, oid, OBJ_TREE,
b2f2039c 639) retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
b2f2039c 686) retval += report(options, oid, OBJ_TREE, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
b2f2039c 688) retval += report(options, oid, OBJ_TREE, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
b2f2039c 696) retval += report(options, oid, OBJ_TREE, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
b2f2039c 698) retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
b2f2039c 702) retval += report(options, oid, OBJ_TREE, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");
cc579000 734) return report(options, oid, type,
78543993 750) return report(options, oid, type, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
78543993 757) return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
78543993 761) return report(options, oid, type, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
78543993 767) return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
78543993 771) return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
78543993 779) return report(options, oid, type, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
c5b4269b 798) return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
c5b4269b 800) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
c5b4269b 807) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
c5b4269b 821) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
c5b4269b 827) return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
103fb6d4 854) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
103fb6d4 858) ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
103fb6d4 865) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
103fb6d4 870) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
103fb6d4 874) ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
103fb6d4 880) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
103fb6d4 885) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");
6da40b22 981) return report(options, oid, OBJ_BLOB,
38370253 1003) return report(options, NULL, OBJ_NONE, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
38370253 1014) return report(options, &obj->oid, obj->type,
38370253 1017)       obj->type);
b8b00f16 1050) if (is_promisor_object(oid))
38370253 1052) ret |= report(options,

gpg-interface.c
392b862e 115) *field = NULL;
67a6ea63 184) replace_cstring(field, NULL, NULL);
72b006f4 223) return error_errno(_("could not create temporary file"));
72b006f4 226) error_errno(_("failed writing detached signature to '%s'"),
72b006f4 228) delete_tempfile(&temp);
72b006f4 229) return -1;
72b006f4 244) gpg_status = &buf;

graph.c
0195285b 422) REALLOC_ARRAY(graph->old_mapping, graph->column_capacity * 2);
fbccf255 905) graph_line_write_column(line, col, '|');

http.c
4d17fd25 417) string_list_clear(&extra_http_headers, 0);

log-tree.c
72b006f4 461) show_sig_lines(opt, status, "No signature\n");
72b006f4 535) } else if (verify_message.len <= gpg_message_offset)

midx.c
840cef0c 973) progress = start_progress(_("Writing chunks to multi-pack-index"),

pack-objects.c
f66e0401 122) if (pack->in_pack)
f66e0401 125) ALLOC_ARRAY(pack->in_pack, pack->nr_alloc);

path.c
c72fc40d 386) for (p = common_list; p->path; p++) {
c72fc40d 387) const char *path = p->path;

pathspec.c

progress.c
44a4693b 308) return start_progress_delay(title, total, get_default_delay(), 1);

revision.c
0aa0c2b2 3202) static void reset_topo_walk(struct rev_info *revs)
0aa0c2b2 3204) struct topo_walk_info *info = revs->topo_walk_info;
0aa0c2b2 3206) clear_prio_queue(&info->explore_queue);
0aa0c2b2 3207) clear_prio_queue(&info->indegree_queue);
0aa0c2b2 3208) clear_prio_queue(&info->topo_queue);
0aa0c2b2 3209) clear_indegree_slab(&info->indegree);
0aa0c2b2 3210) clear_author_date_slab(&info->author_date);
0aa0c2b2 3212) FREE_AND_NULL(revs->topo_walk_info);
0aa0c2b2 3213) }
0aa0c2b2 3220) reset_topo_walk(revs);

send-pack.c
ad7a4032 582) receive_status(&reader, remote_refs);

sequencer.c
c068bcc5 840) free(kv.items[date_i].util);
cbd8db17 890) return NULL;
08187b4c 903) return NULL;
08187b4c 920) argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
cbd8db17 989) return -1;
49697cb7 1211) arg1 = "commit";
49697cb7 1212) arg2 = commit;
cbd8db17 1428) goto out;
cbd8db17 1432) goto out;
2d05ef27 1459) goto out;
08187b4c 1508) res = -1;
08187b4c 1509) goto out;
cbd8db17 2603) opts->allow_ff = 0;
cbd8db17 2604) opts->committer_date_is_author_date = 1;
08187b4c 2608) opts->allow_ff = 0;
08187b4c 2609) opts->ignore_date = 1;
08187b4c 3639) push_dates(&cmd, opts->committer_date_is_author_date);
cd552227 4648) strbuf_addstr(buf, "rev-");
cd552227 4649) strbuf_add_unique_abbrev(buf, oid, default_abbrev);
867bc1d2 4673) }
393adf7a 5272) goto cleanup;

strbuf.c
b38dd9e7 1129) int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
b38dd9e7 1132) char *path2 = NULL;
b38dd9e7 1133) int fd, res = 0;
b38dd9e7 1135) if (!is_absolute_path(path))
b38dd9e7 1136) path = path2 = xstrdup(git_path("%s", path));
b38dd9e7 1138) fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
b38dd9e7 1139) if (fd < 0)
b38dd9e7 1140) res = error_errno(_("could not open '%s' for writing"), path);
b38dd9e7 1141) else if (write_in_full(fd, buffer->buf, buffer->len) < 0) {
b38dd9e7 1142) res = error_errno(_("could not write to '%s'"), path);
b38dd9e7 1143) close(fd);
b38dd9e7 1144) } else if (close(fd) < 0)
b38dd9e7 1145) res = error_errno(_("could not close '%s'"), path);
b38dd9e7 1147) strbuf_reset(buffer);
b38dd9e7 1148) if (launch_editor(path, buffer, env) < 0)
b38dd9e7 1149) res = error_errno(_("could not edit '%s'"), path);
b38dd9e7 1150) unlink(path);
b38dd9e7 1153) free(path2);
b38dd9e7 1154) return res;

t/helper/test-read-graph.c
4bd0593e 23) die_errno(_("Could not open commit-graph '%s'"), graph_name);
4bd0593e 27) return 1;

t/helper/test-run-command.c
eea4a7f4 331) static int inherit_handle(const char *argv0)
eea4a7f4 333) struct child_process cp = CHILD_PROCESS_INIT;
eea4a7f4 338) xsnprintf(path, sizeof(path), "out-XXXXXX");
eea4a7f4 339) tmp = xmkstemp(path);
eea4a7f4 341) argv_array_pushl(&cp.args,
eea4a7f4 343) cp.in = -1;
eea4a7f4 344) cp.no_stdout = cp.no_stderr = 1;
eea4a7f4 345) if (start_command(&cp) < 0)
eea4a7f4 349) close(tmp);
eea4a7f4 350) if (unlink(path))
eea4a7f4 353) if (close(cp.in) < 0 || finish_command(&cp) < 0)
eea4a7f4 356) return 0;
eea4a7f4 359) static int inherit_handle_child(void)
eea4a7f4 361) struct strbuf buf = STRBUF_INIT;
eea4a7f4 363) if (strbuf_read(&buf, 0, 0) < 0)
eea4a7f4 365) printf("Received %s\n", buf.buf);
eea4a7f4 366) strbuf_release(&buf);
eea4a7f4 368) return 0;
eea4a7f4 379) exit(inherit_handle(argv[0]));
eea4a7f4 381) exit(inherit_handle_child());

tag.c
228c78fb 152) FREE_AND_NULL(item->tag);

usage.c
116d1fa6 16) fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
116d1fa6 17) abort();
116d1fa6 22) *p = '\0'; /* vsnprintf() failed, clip at prefix */

Commits introducing uncovered code:
Alban Gruin	393adf7a sequencer: directly call pick_commits() from complete_action()
Alexandr Miloslavskiy	24e4750c pathspec: add new function to parse file
Alexandr Miloslavskiy	bebb5d6d add: support the --pathspec-from-file option
Alexandr Miloslavskiy	64bac8df reset: support the `--pathspec-from-file` option
Daniel Ferreira	5e82b9e4 built-in add -i: implement the `status` command
Derrick Stolee	bab3c359 sparse-checkout: create 'init' subcommand
Derrick Stolee	96cc8ab5 sparse-checkout: use hashmaps for cone patterns
Derrick Stolee	af09ce24 sparse-checkout: init and set in cone mode
Derrick Stolee	190a65f9 sparse-checkout: respect core.ignoreCase in cone mode
Derrick Stolee	416adc87 sparse-checkout: update working directory in-process for 'init'
Derrick Stolee	e091228e sparse-checkout: update working directory in-process
Derrick Stolee	72918c1a sparse-checkout: create 'disable' subcommand
Derrick Stolee	94c0956b sparse-checkout: create builtin with 'list' subcommand
Derrick Stolee	4bd0593e test-tool: use 'read-graph' helper
Derrick Stolee	d89f09c8 clone: add --sparse mode
Derrick Stolee	44a4693b progress: create GIT_PROGRESS_DELAY
Hans Jerry Illikainen	392b862e gpg-interface: refactor the free-and-xmemdupz pattern
Hans Jerry Illikainen	67a6ea63 gpg-interface: limit search for primary key fingerprint
Hans Jerry Illikainen	72b006f4 gpg-interface: prefer check_signature() for GPG verification
James Coglan	0195285b graph: rename `new_mapping` to `old_mapping`
James Coglan	fbccf255 graph: automatically track display width of graph lines
Jeff King	5afc4b1d fsck: only provide oid/type in fsck_error callback
Jeff King	82ef89b3 fsck: don't require object structs for display functions
Jeff King	78543993 fsck: don't require an object struct for fsck_ident()
Jeff King	a59cfb32 fsck: unify object-name code
Jeff King	b2f2039c fsck: accept an oid instead of a "struct tree" for fsck_tree()
Jeff King	cc579000 fsck: don't require an object struct in verify_headers()
Jeff King	c5b4269b fsck: accept an oid instead of a "struct commit" for fsck_commit()
Jeff King	103fb6d4 fsck: accept an oid instead of a "struct tag" for fsck_tag()
Jeff King	6da40b22 fsck: accept an oid instead of a "struct blob" for fsck_blob()
Jeff King	38370253 fsck: don't require an object struct for report()
Jeff King	b8b00f16 fsck: drop blob struct from fsck_finish()
Jeff King	f66e0401 pack-objects: avoid pointless oe_map_new_pack() calls
Jeff King	73390290 fsck: use oids rather than objects for object_name API
Jeff King	228c78fb commit, tag: don't set parsed bit for parse failures
Jeff King	78d50148 parse_tag_buffer(): treat NULL tag pointer as parse error
Jeff King	ad7a4032 send-pack: check remote ref status on pack-objects failure
Johannes Schindelin	d7633578 built-in add -i: re-implement the `diff` command
Johannes Schindelin	1942ee44 built-in add -i: wire up the new C code for the `patch` command
Johannes Schindelin	c54ef5e4 built-in add -i: re-implement `revert` in C
Johannes Schindelin	ab1e1ccc built-in add -i: re-implement `add-untracked` in C
Johannes Schindelin	0c3944a6 add-interactive: make sure to release `rev.prune_data`
Johannes Schindelin	a8c45be9 built-in add -i: implement the `update` command
Johannes Schindelin	8746e072 built-in add -i: implement the `patch` command
Johannes Schindelin	f83dff60 Start to implement a built-in version of `git add --interactive`
Johannes Schindelin	c08171d1 built-in add -i: allow filtering the modified files list
Johannes Schindelin	4d17fd25 remote-curl: unbreak http.extraHeader with custom allocators
Johannes Schindelin	f37c2264 built-in add -i: prepare for multi-selection commands
Johannes Schindelin	76b74323 built-in add -i: show unique prefixes of the commands
Johannes Schindelin	b38dd9e7 strbuf: add a helper function to call the editor "on an strbuf"
Johannes Schindelin	bcdd297b built-in add -p: implement hunk editing
Johannes Schindelin	68db1cbf built-in add -i: support `?` (prompt help)
Johannes Schindelin	25ea47af built-in add -p: adjust hunk headers as needed
Johannes Schindelin	6348bfba built-in add -i: implement the main loop
Johannes Schindelin	116d1fa6 vreportf(): avoid relying on stdio buffering
Johannes Schindelin	2e697ced built-in add -i: offer the `quit` command
Johannes Schindelin	eea4a7f4 mingw: demonstrate that all file handles are inherited by child processes
Johannes Schindelin	2e0afafe Add git-bundle: move objects and references by archive
Johannes Schindelin	b4bbbbd5 apply --allow-overlap: fix a corner case
Johannes Schindelin	54d9d9b2 built-in add -p: only show the applicable parts of the help text
Johannes Schindelin	12c24cf8 built-in add -p: color the prompt and the help text
Johannes Schindelin	0ecd9d27 built-in add -p: show different prompts for mode changes and deletions
Johannes Schindelin	d6cf8733 built-in add -p: implement the '/' ("search regex") command
Johannes Schindelin	ade246ef built-in add -p: implement the 'q' ("quit") command
Johannes Schindelin	7584dd3c built-in add -p: offer a helpful error message when hunk navigation failed
Johannes Schindelin	9254bdfb built-in add -p: implement the 'g' ("goto") command
Johannes Schindelin	2e408319 built-in add -p: show helpful hint when nothing can be staged
Johannes Schindelin	47dc4fd5 built-in add -p: handle deleted empty files
Johannes Schindelin	80399aec built-in add -p: support multi-file diffs
Johannes Schindelin	510aeca1 built-in add -p: implement the hunk splitting feature
Johannes Schindelin	e3bd11b4 built-in add -p: show colored hunks by default
Johannes Schindelin	5906d5de built-in app -p: allow selecting a mode change as a "hunk"
Johannes Schindelin	f6aa7ecc built-in add -i: start implementing the `patch` functionality in C
Johannes Schindelin	11f2c0da built-in add -p: coalesce hunks after splitting them
Johannes Schindelin	867bc1d2 rebase-merges: move labels' whitespace mangling into `label_oid()`
Junio C Hamano	7034cd09 Sync with Git 2.24.1
Matthew Rogers	cd552227 rebase -r: let `label` generate safer labels
Mike Hommey	0aa0c2b2 revision: free topo_walk_info before creating a new one in init_topo_walk
Phillip Wood	49697cb7 move run_commit_hook() to libgit and use it there
Phillip Wood	2d05ef27 sequencer: fix empty commit check when amending
Robin H. Johnson	79862b6b bundle-create: progress output control
Robin H. Johnson	73c3253d bundle: framework for options before bundle file
Rohit Ashiwal	08187b4c rebase -i: support --ignore-date
Rohit Ashiwal	c068bcc5 sequencer: allow callers of read_author_script() to ignore fields
Rohit Ashiwal	cbd8db17 rebase -i: support --committer-date-is-author-date
Slavica Đukić	8c159044 built-in add -i: implement the `help` command
Slavica Đukić	3d965c76 built-in add -i: use color in the main loop
Slavica Đukić	1daaebca built-in add -i: color the header in the `status` command
SZEDER Gábor	c72fc40d path.c: clarify two field names in 'struct common_dir'
Tanushree Tumane	51a0a4ed bisect--helper: avoid use-after-free
William Baker	840cef0c midx: add progress to write_midx_file


