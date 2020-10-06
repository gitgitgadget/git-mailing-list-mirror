Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56419C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F225620866
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GshtKFHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgJFUie (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgJFUid (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 16:38:33 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31881C061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 13:38:32 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id de3so4197057qvb.5
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SZhmkiq/+ZHUwvcoFUI2WxHIAd6zHptrLi4c0ftfmFI=;
        b=GshtKFHFNBtSZRu6G1QkTDtgVuEgBrMwGDd49eVlBgDtUjuxBjJOGIupQ96NNnYsDx
         h4xsC2zqjCW/4B+hn7KZJ9X1RWcwpvYfugSmzyvrMlgKNxNlFbyRxJHdTpyr67d4wkqr
         scy8Z7Jz495sWACOcWdaxcys1glK+QrXpOXZGg+SG8abePfZoq7YA4lczXOZDfOCsVPI
         W/rWO14cXKlAy2YPzypWdqax99zAXqXDfiq22i2u6AEGTpaNtofvrS4sTsZoTOET9STL
         Fz5jckgxgs+GX9iFqkzqA3+XScCOkIaZpPc8IsWm4Gv15AdtHfmoIthYy1NzFq5AoajJ
         ttUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SZhmkiq/+ZHUwvcoFUI2WxHIAd6zHptrLi4c0ftfmFI=;
        b=p+hiMX2enmmI51sIakujQriMvM2jWgK5lkreEEeGIS4O1JK2bcKBegZx4c3zziHFc9
         lH4fZQPPWdGj3aFGbfdJhGAThKiJ7eZDYP6bU7O0bEs97lxX3kH35393Md4BDcUIPvMU
         9gb0cqUC+I/Qw3v6ybggPym86Hp+41l4wfJSauXqrPq8VgMby2CwgPbwUy7mR1SfkPSO
         Nm5eWSnq64HxyOsmQgE+cI6gMX0vCIFlO266WmyttWj6eYfOGlKHCnI7h+2BpcG6JHNH
         C9PL7vXVbeDGXae+0V9gvUz4c+ZCc9dzs78gMAldee2OOcXdg1W7AWGZpWoUwrQThWaH
         D3pA==
X-Gm-Message-State: AOAM530BqxPXMWAqw+oDSn3z3Y2+oBg4+/8uV2bxIysl3U14h7tyOohz
        9ILBHtMDOlFnxRNDEBie8K4cs6hCZ1ptQw==
X-Google-Smtp-Source: ABdhPJw1J4wa58lfGoQq+qCQTeo0shqh6fGndzlEzm3OU0jZbg4ia42pdmE0Rn6f3Ddi24mQZfczRg==
X-Received: by 2002:a0c:edd0:: with SMTP id i16mr29637qvr.10.1602016709727;
        Tue, 06 Oct 2020 13:38:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:9c01:5453:d4f7:807d? ([2600:1700:e72:80a0:9c01:5453:d4f7:807d])
        by smtp.gmail.com with UTF8SMTPSA id g9sm1572406qkb.106.2020.10.06.13.38.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 13:38:29 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (v2.29.0-rc0)
Message-ID: <5199d2cf-debc-e6d6-e72d-2fad2b22dd58@gmail.com>
Date:   Tue, 6 Oct 2020 16:38:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the test coverage report for v2.29.0-rc0. I haven't sent a test-coverage report
in a while due to some issues with the 'seen' branch timing out, and then I got out of
the habit.

Here is the uncovered code introduced in v2.29.0-rc0 that was edited since v2.28.0.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/v2.29.0-rc0-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/v2.29.0-rc0.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/v2.29.0-rc0.htm

---

Uncovered code in 'v2.29.0-rc0' not in 'v2.28.0'
--------------------------------------------------------

Commits introducing uncovered code:
Aaron Lipman	be5fe200 cmd_bisect__helper: defer parsing no-checkout flag
builtin/bisect--helper.c
be5fe200 906) res = bisect_next_all(the_repository, prefix);

Ævar Arnfjörð Bjarmason	6a83d902 coccinelle: make use of the "type" FREE_AND_NULL() rule
builtin/fast-import.c
6a83d902 995) FREE_AND_NULL(delta);

Brandon Williams	debca9d2 object: rename function 'typename' to 'type_name'
builtin/fast-import.c
debca9d2 2500) type_name(oe->type), command_buf.buf);

brian m. carlson	d7e6b6a8 fast-import: convert internal structs to struct object_id
builtin/fast-import.c
d7e6b6a8 892) fprintf(pack_edges, " %s",
d7e6b6a8 893) oid_to_hex(&t->oid));
d7e6b6a8 2639) oidcpy(&n->oid, &s->oid);

brian m. carlson	ddddf8d7 fast-import: permit reading multiple marks files
builtin/fast-import.c
ddddf8d7 1145) insert_mark(marks, mark, e);

brian m. carlson	912c13d5 fast-import: convert to struct object_id
builtin/fast-import.c
912c13d5 2471) oidcpy(&commit_oid, &s->oid);
912c13d5 2646) } else if (!get_oid(from, &n->oid)) {
912c13d5 2811) oidcpy(&oid, &s->oid);
912c13d5 2939) strbuf_addf(&line, "%s missing\n", oid_to_hex(oid));
912c13d5 3045)     get_oid_hex(buf + strlen("object "), oid))

brian m. carlson	1bdca816 fast-import: add options for rewriting submodules
builtin/fast-import.c
1bdca816 2193) return -1;
1bdca816 3068) return;
1bdca816 3328) die_errno("cannot read '%s'", f);

brian m. carlson	cd85b447 remote-curl: make --force-with-lease work with non-ASCII ref names
remote-curl.c
cd85b447 130) return -1;

brian m. carlson	e6a492b7 pack: convert struct pack_idx_entry to struct object_id
builtin/fast-import.c
e6a492b7 3103) oidcpy(&oid, &e->idx.oid);

brian m. carlson	28d055bd fast-import: make hash-size independent
builtin/fast-import.c
28d055bd 986) && (pack_size + PACK_SIZE_THRESHOLD + s.total_out) > max_packsize)
28d055bd 1083) && (pack_size + PACK_SIZE_THRESHOLD + len) > max_packsize)
28d055bd 2652) if (!buf || size < the_hash_algo->hexsz + 6)
28d055bd 3044) if (size < hexsz + strlen("object ") ||

Clemens Buchacher	98c2924c credentials: unable to connect to cache daemon
builtin/credential-cache.c
98c2924c 79) die_errno("unable to connect to cache daemon");

David Barr	8dc6a373 fast-import: add 'ls' command
builtin/fast-import.c
8dc6a373 3033) buf = gfi_unpack_entry(oe, &size);
8dc6a373 3047) break;
8dc6a373 3101) if (!e)

David Barr	85c62395 fast-import: let importers retrieve blobs
builtin/fast-import.c
85c62395 2917) die_errno("Write to frontend failed");
85c62395 2938) strbuf_reset(&line);
85c62395 2940) cat_blob_write(line.buf, line.len);
85c62395 2941) strbuf_release(&line);
85c62395 2942) free(buf);
85c62395 2943) return;

Derrick Stolee	663b2b1b maintenance: add commit-graph task
builtin/gc.c
663b2b1b 813) return 1;

Derrick Stolee	3103e984 maintenance: initialize task array
builtin/gc.c
3103e984 933) result = 1;

Derrick Stolee	d7514f6e maintenance: take a lock on the objects directory
builtin/gc.c
d7514f6e 904) if (!opts->auto_flag && !opts->quiet)
d7514f6e 907) free(lock_path);
d7514f6e 908) return 0;

Derrick Stolee	4ddc79b2 maintenance: add auto condition for commit-graph task
builtin/gc.c
4ddc79b2 722) static int dfs_on_ref(const char *refname,
4ddc79b2 726) struct cg_auto_data *data = (struct cg_auto_data *)cb_data;
4ddc79b2 727) int result = 0;
4ddc79b2 729) struct commit_list *stack = NULL;
4ddc79b2 732) if (!peel_ref(refname, &peeled))
4ddc79b2 733) oid = &peeled;
4ddc79b2 734) if (oid_object_info(the_repository, oid, NULL) != OBJ_COMMIT)
4ddc79b2 735) return 0;
4ddc79b2 737) commit = lookup_commit(the_repository, oid);
4ddc79b2 738) if (!commit)
4ddc79b2 739) return 0;
4ddc79b2 740) if (parse_commit(commit))
4ddc79b2 741) return 0;
4ddc79b2 743) commit_list_append(commit, &stack);
4ddc79b2 745) while (!result && stack) {
4ddc79b2 748) commit = pop_commit(&stack);
4ddc79b2 750) for (parent = commit->parents; parent; parent = parent->next) {
4ddc79b2 751) if (parse_commit(parent->item) ||
4ddc79b2 752)     commit_graph_position(parent->item) != COMMIT_NOT_FROM_GRAPH ||
4ddc79b2 753)     parent->item->object.flags & SEEN)
4ddc79b2 754) continue;
4ddc79b2 756) parent->item->object.flags |= SEEN;
4ddc79b2 757) data->num_not_in_graph++;
4ddc79b2 759) if (data->num_not_in_graph >= data->limit) {
4ddc79b2 760) result = 1;
4ddc79b2 761) break;
4ddc79b2 764) commit_list_append(parent->item, &stack);
4ddc79b2 768) free_commit_list(stack);
4ddc79b2 769) return result;
4ddc79b2 772) static int should_write_commit_graph(void)
4ddc79b2 777) data.num_not_in_graph = 0;
4ddc79b2 778) data.limit = 100;
4ddc79b2 779) git_config_get_int("maintenance.commit-graph.auto",
4ddc79b2 782) if (!data.limit)
4ddc79b2 783) return 0;
4ddc79b2 784) if (data.limit < 0)
4ddc79b2 785) return 1;
4ddc79b2 787) result = for_each_ref(dfs_on_ref, &data);
4ddc79b2 789) clear_commit_marks_all(SEEN);
4ddc79b2 791) return result;

Dmitry Ivankov	4b4963c0 fast-import: check committer name more strictly
builtin/fast-import.c
4b4963c0 1975) if (strcmp("now", ltgt))

Dmitry Potapov	8db751a8 fast-import: tag may point to any object type
builtin/fast-import.c
8db751a8 2812) type = OBJ_COMMIT;

Elijah Newren	3164e6bd fast-import: fix handling of deleted tags
builtin/fast-import.c
3164e6bd 2904) first_tag = t->next_tag;

Elijah Newren	44c7e1a7 mem-pool: use more standard initialization and finalization
read-cache.c
44c7e1a7 2076) istate->ce_mem_pool = xmalloc(sizeof(*istate->ce_mem_pool));
44c7e1a7 2077) mem_pool_init(istate->ce_mem_pool, 0);
44c7e1a7 2106) mem_pool_init(p->ce_mem_pool,
44c7e1a7 2109) mem_pool_init(p->ce_mem_pool,

Elijah Newren	b8f50e5b fast-import: add support for new 'alias' command
builtin/fast-import.c
b8f50e5b 2623) return 0;

Elijah Newren	a762c8c1 mem-pool: add convenience functions for strdup and strndup
mem-pool.c
a762c8c1 108) char *mem_pool_strndup(struct mem_pool *pool, const char *str, size_t len)
a762c8c1 110) char *p = memchr(str, '\0', len);
a762c8c1 111) size_t actual_len = (p ? p - str : len);
a762c8c1 112) char *ret = mem_pool_alloc(pool, actual_len+1);
a762c8c1 114) ret[actual_len] = '\0';
a762c8c1 115) return memcpy(ret, str, actual_len);

Elijah Newren	f87bf284 mem-pool: use consistent pool variable name
mem-pool.c
f87bf284 118) int mem_pool_contains(struct mem_pool *pool, void *mem)
f87bf284 123) for (p = pool->mp_block; p; p = p->next_block)

Elijah Newren	253fb5f8 fast-import: Improve robustness when D->F changes provided in wrong order
builtin/fast-import.c
253fb5f8 1513) return 1;

Elijah Newren	7ffde293 fast-import: only allow cat-blob requests where it makes sense
builtin/fast-import.c
7ffde293 2329) parse_cat_blob(v);

Emily Shaffer	1411914a bugreport: add uname info
builtin/bugreport.c
1411914a 21) strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
1411914a 23)     errno);

Eric Sunshine	b214ab5a worktree: teach "repair" to fix outgoing links to worktrees
worktree.c
b214ab5a 663) fn = repair_noop;

Eric Sunshine	59d876cc init: make --separate-git-dir work from within linked worktree
builtin/init-db.c
59d876cc 664) die_errno(_("cannot chdir to %s"), mainwt.buf);

Eric Sunshine	07a7f8de format-patch: use 'origin' as start of current-series-range when known
builtin/log.c
07a7f8de 1689) else if (prev_is_range)

Eric Wong	d9545c7f fast-import: implement unpack limit
builtin/fast-import.c
d9545c7f 827) die_errno("Failed seeking to start of '%s'", p->pack_name);
d9545c7f 3465) unpack_limit = limit;

Han-Wen Nienhuys	4441f427 refs: add GIT_TRACE_REFS debugging mechanism
refs/debug.c
4441f427 22) res = xmalloc(sizeof(struct debug_ref_store));
4441f427 23) be_copy = xmalloc(sizeof(*be_copy));
4441f427 24) *be_copy = refs_be_debug;
4441f427 26) be_copy->name = store->be->name;
4441f427 27) trace_printf_key(&trace_refs, "ref_store for %s\n", gitdir);
4441f427 28) res->refs = store;
4441f427 29) base_ref_store_init((struct ref_store *)res, be_copy);
4441f427 30) return (struct ref_store *)res;
4441f427 33) static int debug_init_db(struct ref_store *refs, struct strbuf *err)
4441f427 35) struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
4441f427 36) int res = drefs->refs->be->init_db(drefs->refs, err);
4441f427 37) trace_printf_key(&trace_refs, "init_db: %d\n", res);
4441f427 38) return res;
4441f427 41) static int debug_transaction_prepare(struct ref_store *refs,
4441f427 45) struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
4441f427 47) transaction->ref_store = drefs->refs;
4441f427 48) res = drefs->refs->be->transaction_prepare(drefs->refs, transaction,
4441f427 50) trace_printf_key(&trace_refs, "transaction_prepare: %d\n", res);
4441f427 51) return res;
4441f427 54) static void print_update(int i, const char *refname,
4441f427 59) char o[GIT_MAX_HEXSZ + 1] = "null";
4441f427 60) char n[GIT_MAX_HEXSZ + 1] = "null";
4441f427 61) if (old_oid)
4441f427 62) oid_to_hex_r(o, old_oid);
4441f427 63) if (new_oid)
4441f427 64) oid_to_hex_r(n, new_oid);
4441f427 66) type &= 0xf; /* see refs.h REF_* */
4441f427 67) flags &= REF_HAVE_NEW | REF_HAVE_OLD | REF_NO_DEREF |
4441f427 69) trace_printf_key(&trace_refs, "%d: %s %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname,
4441f427 71) }
4441f427 73) static void print_transaction(struct ref_transaction *transaction)
4441f427 76) trace_printf_key(&trace_refs, "transaction {\n");
4441f427 77) for (i = 0; i < transaction->nr; i++) {
4441f427 78) struct ref_update *u = transaction->updates[i];
4441f427 79) print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
4441f427 80)      u->type, u->msg);
4441f427 82) trace_printf_key(&trace_refs, "}\n");
4441f427 83) }
4441f427 85) static int debug_transaction_finish(struct ref_store *refs,
4441f427 89) struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
4441f427 91) transaction->ref_store = drefs->refs;
4441f427 92) res = drefs->refs->be->transaction_finish(drefs->refs, transaction,
4441f427 94) print_transaction(transaction);
4441f427 95) trace_printf_key(&trace_refs, "finish: %d\n", res);
4441f427 96) return res;
4441f427 99) static int debug_transaction_abort(struct ref_store *refs,
4441f427 103) struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
4441f427 105) transaction->ref_store = drefs->refs;
4441f427 106) res = drefs->refs->be->transaction_abort(drefs->refs, transaction, err);
4441f427 107) return res;
4441f427 110) static int debug_initial_transaction_commit(struct ref_store *refs,
4441f427 114) struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
4441f427 116) transaction->ref_store = drefs->refs;
4441f427 117) res = drefs->refs->be->initial_transaction_commit(drefs->refs,
4441f427 119) return res;
4441f427 122) static int debug_pack_refs(struct ref_store *ref_store, unsigned int flags)
4441f427 124) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 125) int res = drefs->refs->be->pack_refs(drefs->refs, flags);
4441f427 126) trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
4441f427 127) return res;
4441f427 130) static int debug_create_symref(struct ref_store *ref_store,
4441f427 134) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 135) int res = drefs->refs->be->create_symref(drefs->refs, ref_name, target,
4441f427 137) trace_printf_key(&trace_refs, "create_symref: %s -> %s \"%s\": %d\n", ref_name,
4441f427 139) return res;
4441f427 142) static int debug_delete_refs(struct ref_store *ref_store, const char *msg,
4441f427 145) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 146) int res =
4441f427 147) drefs->refs->be->delete_refs(drefs->refs, msg, refnames, flags);
4441f427 149) trace_printf_key(&trace_refs, "delete_refs {\n");
4441f427 150) for (i = 0; i < refnames->nr; i++)
4441f427 151) trace_printf_key(&trace_refs, "%s\n", refnames->items[i].string);
4441f427 152) trace_printf_key(&trace_refs, "}: %d\n", res);
4441f427 153) return res;
4441f427 156) static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
4441f427 159) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 160) int res = drefs->refs->be->rename_ref(drefs->refs, oldref, newref,
4441f427 162) trace_printf_key(&trace_refs, "rename_ref: %s -> %s \"%s\": %d\n", oldref, newref,
4441f427 164) return res;
4441f427 167) static int debug_copy_ref(struct ref_store *ref_store, const char *oldref,
4441f427 170) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 171) int res =
4441f427 172) drefs->refs->be->copy_ref(drefs->refs, oldref, newref, logmsg);
4441f427 173) trace_printf_key(&trace_refs, "copy_ref: %s -> %s \"%s\": %d\n", oldref, newref,
4441f427 175) return res;
4441f427 183) static int debug_ref_iterator_advance(struct ref_iterator *ref_iterator)
4441f427 185) struct debug_ref_iterator *diter =
4441f427 187) int res = diter->iter->vtable->advance(diter->iter);
4441f427 188) if (res)
4441f427 189) trace_printf_key(&trace_refs, "iterator_advance: (%d)\n", res);
4441f427 191) trace_printf_key(&trace_refs, "iterator_advance: %s (0)\n",
4441f427 194) diter->base.ordered = diter->iter->ordered;
4441f427 195) diter->base.refname = diter->iter->refname;
4441f427 196) diter->base.oid = diter->iter->oid;
4441f427 197) diter->base.flags = diter->iter->flags;
4441f427 198) return res;
4441f427 201) static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
4441f427 204) struct debug_ref_iterator *diter =
4441f427 206) int res = diter->iter->vtable->peel(diter->iter, peeled);
4441f427 207) trace_printf_key(&trace_refs, "iterator_peel: %s: %d\n", diter->iter->refname, res);
4441f427 208) return res;
4441f427 211) static int debug_ref_iterator_abort(struct ref_iterator *ref_iterator)
4441f427 213) struct debug_ref_iterator *diter =
4441f427 215) int res = diter->iter->vtable->abort(diter->iter);
4441f427 216) trace_printf_key(&trace_refs, "iterator_abort: %d\n", res);
4441f427 217) return res;
4441f427 226) debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
4441f427 229) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 230) struct ref_iterator *res =
4441f427 231) drefs->refs->be->iterator_begin(drefs->refs, prefix, flags);
4441f427 232) struct debug_ref_iterator *diter = xcalloc(1, sizeof(*diter));
4441f427 233) base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable, 1);
4441f427 234) diter->iter = res;
4441f427 235) trace_printf_key(&trace_refs, "ref_iterator_begin: %s (0x%x)\n", prefix, flags);
4441f427 236) return &diter->base;
4441f427 239) static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
4441f427 243) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 244) int res = 0;
4441f427 246) oidcpy(oid, &null_oid);
4441f427 247) res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
4441f427 250) if (res == 0) {
4441f427 251) trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
4441f427 254) trace_printf_key(&trace_refs, "read_raw_ref: %s: %d\n", refname, res);
4441f427 256) return res;
4441f427 260) debug_reflog_iterator_begin(struct ref_store *ref_store)
4441f427 262) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 263) struct ref_iterator *res =
4441f427 264) drefs->refs->be->reflog_iterator_begin(drefs->refs);
4441f427 265) trace_printf_key(&trace_refs, "for_each_reflog_iterator_begin\n");
4441f427 266) return res;
4441f427 275) static int debug_print_reflog_ent(struct object_id *old_oid,
4441f427 280) struct debug_reflog *dbg = (struct debug_reflog *)cb_data;
4441f427 282) char o[GIT_MAX_HEXSZ + 1] = "null";
4441f427 283) char n[GIT_MAX_HEXSZ + 1] = "null";
4441f427 284) if (old_oid)
4441f427 285) oid_to_hex_r(o, old_oid);
4441f427 286) if (new_oid)
4441f427 287) oid_to_hex_r(n, new_oid);
4441f427 289) ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
4441f427 291) trace_printf_key(&trace_refs, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
4441f427 293) return ret;
4441f427 296) static int debug_for_each_reflog_ent(struct ref_store *ref_store,
4441f427 300) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 301) struct debug_reflog dbg = {
4441f427 307) int res = drefs->refs->be->for_each_reflog_ent(
4441f427 309) trace_printf_key(&trace_refs, "for_each_reflog: %s: %d\n", refname, res);
4441f427 310) return res;
4441f427 313) static int debug_for_each_reflog_ent_reverse(struct ref_store *ref_store,
4441f427 318) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 319) struct debug_reflog dbg = {
4441f427 324) int res = drefs->refs->be->for_each_reflog_ent_reverse(
4441f427 326) trace_printf_key(&trace_refs, "for_each_reflog_reverse: %s: %d\n", refname, res);
4441f427 327) return res;
4441f427 330) static int debug_reflog_exists(struct ref_store *ref_store, const char *refname)
4441f427 332) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 333) int res = drefs->refs->be->reflog_exists(drefs->refs, refname);
4441f427 334) trace_printf_key(&trace_refs, "reflog_exists: %s: %d\n", refname, res);
4441f427 335) return res;
4441f427 338) static int debug_create_reflog(struct ref_store *ref_store, const char *refname,
4441f427 341) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 342) int res = drefs->refs->be->create_reflog(drefs->refs, refname,
4441f427 344) trace_printf_key(&trace_refs, "create_reflog: %s: %d\n", refname, res);
4441f427 345) return res;
4441f427 348) static int debug_delete_reflog(struct ref_store *ref_store, const char *refname)
4441f427 350) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 351) int res = drefs->refs->be->delete_reflog(drefs->refs, refname);
4441f427 352) trace_printf_key(&trace_refs, "delete_reflog: %s: %d\n", refname, res);
4441f427 353) return res;
4441f427 356) static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
4441f427 363) struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
4441f427 364) int res = drefs->refs->be->reflog_expire(drefs->refs, refname, oid,
4441f427 368) trace_printf_key(&trace_refs, "reflog_expire: %s: %d\n", refname, res);
4441f427 369) return res;

Hariom Verma	b82445dc ref-filter: support different email formats
ref-filter.c
b82445dc 398) return strbuf_addf_ret(err, -1, _("unrecognized email option: %s"), arg);
b82445dc 1087) eoemail = strchr(email, '>');

Hariom Verma	e7601eb5 ref-filter: modify error messages in `grab_objectname()`
ref-filter.c
e7601eb5 384) return strbuf_addf_ret(err, -1, _("unrecognized argument '%s' in %%(%s)"), arg, atom->name);

Hariom Verma	2c22e102 ref-filter: 'contents:trailers' show error if `:` is missing
ref-filter.c
2c22e102 356) return -1;

Hariom Verma	905f0a4e ref-filter: add `sanitize` option for 'subject' atom
ref-filter.c
905f0a4e 309) return strbuf_addf_ret(err, -1, _("unrecognized %%(subject) argument: %s"), arg);

Hariom Verma	47d4676a pretty: refactor `format_sanitized_subject()`
pretty.c
47d4676a 857) i++;

Hariom Verma	26bc0aaf ref-filter: add `short` modifier to 'parent' atom
ref-filter.c
26bc0aaf 1023) struct object_id *oid = &parents->item->object.oid;
26bc0aaf 1026) strbuf_addstr(&s, do_grab_oid("parent", oid, &used_atom[i]));

Jacob Keller	7efba5fa format-patch: teach format.useAutoBase "whenAble" option
builtin/log.c
7efba5fa 1505) if (die_on_failure)
7efba5fa 1524) if (die_on_failure)
7efba5fa 1529) return NULL;
7efba5fa 1547) if (die_on_failure) {
7efba5fa 1550) free(rev);
7efba5fa 1551) return NULL;
7efba5fa 1567) free(rev);
7efba5fa 1568) return NULL;
7efba5fa 1577) free(rev);
7efba5fa 1578) return NULL;

Jacob Keller	c0192df6 refspec: add support for negative refspecs
refspec.c
c0192df6 45) return 0;
c0192df6 87) return 0; /* negative refspecs must not be empty */
c0192df6 93) return 0;

remote.c
c0192df6 812) return -1;

Jeff King	f5e3c0b9 credential-cache: close stderr in daemon process
builtin/credential-cache--daemon.c
f5e3c0b9 216) die_errno("unable to point stderr to /dev/null");

Jeff King	d8410a81 fast-import: replace custom hash with hashmap.c
builtin/fast-import.c
d8410a81 60) e2 = container_of(entry_or_key, const struct object_entry, ent);
d8410a81 61) return oidcmp(&e1->idx.oid, &e2->idx.oid);

Jeff King	c33ddc2e date: use strbufs in date-formatting functions
builtin/fast-import.c
c33ddc2e 1977) datestamp(&ident);

Jeff King	22f9b7f3 strvec: convert builtin/ callers away from argv_array name
builtin/am.c
22f9b7f3 1697) strvec_push(&cp.args, am_path(state, "patch"));

builtin/bisect--helper.c
22f9b7f3 228) strvec_clear(&argv);

builtin/bundle.c
22f9b7f3 89) strvec_push(&pack_opts, "--progress");
22f9b7f3 91) strvec_push(&pack_opts, "--all-progress");
22f9b7f3 93) strvec_push(&pack_opts, "--all-progress-implied");

builtin/clone.c
22f9b7f3 832) strvec_push(&args, "--progress");

builtin/describe.c
22f9b7f3 604) strvec_push(&args, "--always");

builtin/fetch.c
22f9b7f3 1562) strvec_push(argv, "-v");

builtin/gc.c
22f9b7f3 580) strvec_push(&repack, "-f");
22f9b7f3 582) strvec_pushf(&repack, "--depth=%d", aggressive_depth);
22f9b7f3 584) strvec_pushf(&repack, "--window=%d", aggressive_window);

builtin/pull.c
22f9b7f3 534) strvec_push(&args, opt_progress);
22f9b7f3 540) strvec_push(&args, opt_append);
22f9b7f3 542) strvec_push(&args, opt_upload_pack);
22f9b7f3 547) strvec_push(&args, opt_prune);
22f9b7f3 557) strvec_push(&args, "--recurse-submodules=on-demand");
22f9b7f3 563) strvec_push(&args, max_children);
22f9b7f3 567) strvec_push(&args, opt_keep);
22f9b7f3 571) strvec_push(&args, opt_unshallow);
22f9b7f3 573) strvec_push(&args, opt_update_shallow);
22f9b7f3 575) strvec_push(&args, opt_refmap);
22f9b7f3 577) strvec_push(&args, opt_ipv4);
22f9b7f3 579) strvec_push(&args, opt_ipv6);
22f9b7f3 581) strvec_push(&args, "--show-forced-updates");
22f9b7f3 583) strvec_push(&args, "--no-show-forced-updates");
22f9b7f3 672) strvec_push(&args, opt_progress);
22f9b7f3 676) strvec_push(&args, opt_diffstat);
22f9b7f3 682) strvec_push(&args, opt_squash);
22f9b7f3 684) strvec_push(&args, opt_commit);
22f9b7f3 686) strvec_push(&args, opt_edit);
22f9b7f3 688) strvec_pushf(&args, "--cleanup=%s", cleanup_arg);
22f9b7f3 696) strvec_push(&args, opt_gpg_sign);
22f9b7f3 877) strvec_push(&args, "--rebase-merges");
22f9b7f3 883) strvec_push(&args, opt_diffstat);
22f9b7f3 887) strvec_push(&args, opt_gpg_sign);
22f9b7f3 889) strvec_push(&args, "--no-autostash");

builtin/rebase.c
22f9b7f3 826) strvec_push(&am.args, opts->gpg_sign_opt);
22f9b7f3 861) strvec_clear(&am.args);
22f9b7f3 872) strvec_split(&format_patch.args,
22f9b7f3 883) strvec_clear(&am.args);
22f9b7f3 905) strvec_clear(&am.args);
22f9b7f3 914) strvec_push(&am.args, "--rerere-autoupdate");
22f9b7f3 916) strvec_push(&am.args, "--no-rerere-autoupdate");
22f9b7f3 918) strvec_push(&am.args, opts->gpg_sign_opt);

builtin/receive-pack.c
22f9b7f3 782) strvec_pushf(&proc->env_array,
22f9b7f3 826) strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
22f9b7f3 2202) strvec_push(&child.args, "--show-resolving-progress");

builtin/remote.c
22f9b7f3 1467) strvec_push(&fetch_argv, "-v");

builtin/repack.c
22f9b7f3 162) strvec_pushf(&cmd->args, "--window=%s", args->window);
22f9b7f3 164) strvec_pushf(&cmd->args, "--window-memory=%s", args->window_memory);
22f9b7f3 166) strvec_pushf(&cmd->args, "--depth=%s", args->depth);
22f9b7f3 168) strvec_pushf(&cmd->args, "--threads=%s", args->threads);
22f9b7f3 170) strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
22f9b7f3 174) strvec_pushf(&cmd->args, "--no-reuse-object");

builtin/replace.c
22f9b7f3 234) strvec_push(&cmd.args, type_name(type));

builtin/submodule--helper.c
22f9b7f3 859) strvec_push(&cpr.args, "--quiet");
22f9b7f3 1454) strvec_push(&cpr.args, "--quiet");
22f9b7f3 2147) strvec_push(&child->args, "--progress");
22f9b7f3 2151) strvec_pushl(&child->args, "--prefix", suc->prefix, NULL);

builtin/worktree.c
22f9b7f3 626) strvec_push(&cp.args, "--quiet");

Jeff King	47beb37b shortlog: match commit trailers with --group
builtin/shortlog.c
47beb37b 243) return;

Jeff King	fe4a0a28 argv-array: add pop function
strvec.c
fe4a0a28 63) return;

Jeff King	f17b0b99 shortlog: de-duplicate trailer values
builtin/shortlog.c
f17b0b99 194) b = container_of(entry_or_key, const struct strset_item, ent);
f17b0b99 195) return strcmp(a->value, b->value);

Jeff King	63d24fa0 shortlog: allow multiple groups to be specified
builtin/shortlog.c
63d24fa0 303)     !strset_check_and_add(&dups, ident.buf))

Jeff King	01968302 fast-import: delay creating leading directories for export-marks
builtin/fast-import.c
01968302 1692) failure |= error_errno("unable to create leading directories of %s",
01968302 1694) return;

Jeff King	ec91ffca verify_repository_format(): complain about new extensions in v0 repo
setup.c
ec91ffca 472) return config_error_nonbool(var);
ec91ffca 517) return -1;
ec91ffca 526) return -1;

Jeff King	fcd12db6 prefer git_pathdup to git_path in some possibly-dangerous cases
builtin/fast-import.c
fcd12db6 321) free(loc);

Jeff King	d70a9eb6 strvec: rename struct fields
daemon.c
d70a9eb6 495) strvec_pushv(&cld.env_array, env->v);

run-command.c
d70a9eb6 852) execve(argv.v[0], (char *const *) argv.v,

t/helper/test-run-command.c
d70a9eb6 251) arg_offset = args.nr;
d70a9eb6 278) cp.argv = args.v;
d70a9eb6 284) const char *arg = args.v[j + arg_offset];
d70a9eb6 301) (int)j, args.v[j + arg_offset]);

Jeff King	8d2aa8df assert PARSE_OPT_NONEG in parse-options callbacks
parse-options-cb.c
8d2aa8df 108) BUG_ON_OPT_NEG(unset);

Jeff King	b992657e argv-array: add detach function
strvec.c
b992657e 103) return xcalloc(1, sizeof(const char *));

Jeff King	3c078b9c fast-import: clean up pack_data pointer in end_packfile
builtin/fast-import.c
3c078b9c 844) return;

Jeff King	ef8d7ac4 strvec: convert more callers away from argv_array name
column.c
ef8d7ac4 372) strvec_pushf(argv, "--width=%d", opts->width);
ef8d7ac4 374) strvec_pushf(argv, "--indent=%s", opts->indent);

compat/terminal.c
ef8d7ac4 276) strvec_pushl(&cp.args, "infocmp", "-L", "-1", NULL);

connect.c
ef8d7ac4 1236) strvec_push(args, "-6");

daemon.c
ef8d7ac4 490) static int upload_archive(const struct strvec *env)
ef8d7ac4 493) strvec_push(&cld.args, "upload-archive");
ef8d7ac4 803) strvec_clear(&env);
ef8d7ac4 924) strvec_pushf(&cld.env_array, "REMOTE_ADDR=[%s]", buf);
ef8d7ac4 925) strvec_pushf(&cld.env_array, "REMOTE_PORT=%d",

exec-cmd.c
ef8d7ac4 342) strvec_clear(&nargv);

imap-send.c
ef8d7ac4 979) strvec_push(&tunnel.args, srvc->tunnel);

Jeff King	957876f1 combine-diff: handle --find-object in multitree code path
combine-diff.c
957876f1 1464) return 0;
957876f1 1482) free(p);

Jeff King	e2770979 credentials: add "cache" helper
builtin/credential-cache--daemon.c
e2770979 89) return 0;
e2770979 113) return -1;
e2770979 169) return 0;
e2770979 174) if (errno != EINTR)
e2770979 175) die_errno("poll failed");
e2770979 176) return 1;
e2770979 186) return 1;
e2770979 191) close(client);
e2770979 192) return 1;
e2770979 210) die_errno("unable to bind to '%s'", socket_path);
e2770979 222) close(fd);
e2770979 223) }
e2770979 299) return 0;

builtin/credential-cache.c
e2770979 23) die_errno("unable to write to cache daemon");
e2770979 34) die_errno("read error from cache daemon");
e2770979 56) die_errno("unable to start cache daemon");
e2770979 59) die_errno("unable to read result code from cache daemon");
e2770979 74) die_errno("unable to relay credential");

Jeff King	6479ea4a xrealloc: do not reuse pointer freed by zero-length realloc()
wrapper.c
6479ea4a 121) free(ptr);
6479ea4a 122) return xmalloc(0);

Jeff King	f0939a0e trailer: add interface for iterating over commit trailers
trailer.c
f0939a0e 1204) continue; /* not a real trailer */

Jeff King	ae021d87 use skip_prefix to avoid magic numbers
builtin/fast-import.c
ae021d87 3337) if (!git_parse_ulong(option, &v))

Jeff King	8ec6c8d7 credential-cache: report more daemon connection errors
builtin/credential-cache.c
8ec6c8d7 83) die_errno("unable to connect to cache daemon");

Jeff King	71e1b4b6 credentials: add "store" helper
builtin/credential-store.c
71e1b4b6 22) die_errno("unable to open %s", fn);
71e1b4b6 62) die_errno("unable to get credential storage lock");

Jeff King	c972bf4c strvec: convert remaining callers away from argv_array name
midx.c
c972bf4c 1441) strvec_push(&cmd.args, "--delta-islands");

pager.c
c972bf4c 71) static void setup_pager_env(struct strvec *env)
c972bf4c 91) strvec_push(env, argv[i]);
c972bf4c 100) strvec_push(&pager_process->args, pager);
c972bf4c 129) strvec_push(&pager_process.env_array, "GIT_PAGER_IN_USE");

remote-curl.c
c972bf4c 1157) strvec_pushl(&args, "-v", "-v", NULL);
c972bf4c 1163) strvec_push(&args, "--update-shallow");
c972bf4c 1169) strvec_pushf(&args, "--shallow-since=%s", options.deepen_since);
c972bf4c 1171) strvec_pushf(&args, "--shallow-exclude=%s",
c972bf4c 1174) strvec_push(&args, "--deepen-relative");
c972bf4c 1176) strvec_push(&args, "--from-promisor");
c972bf4c 1178) strvec_pushf(&args, "--filter=%s", options.filter);
c972bf4c 1274) strvec_push(&child.args, "--dry-run");
c972bf4c 1302) strvec_push(&args, "--dry-run");
c972bf4c 1306) strvec_push(&args, "--signed=if-asked");
c972bf4c 1310) strvec_push(&args, "--quiet");

sequencer.c
c972bf4c 3680) strvec_push(&cmd.args, opts->gpg_sign);

submodule.c
c972bf4c 690) strvec_pushf(&cp.args, "--src-prefix=%s%s/",
c972bf4c 692) strvec_pushf(&cp.args, "--dst-prefix=%s%s/",
c972bf4c 1790) strvec_push(&cp.args, "-uno");
c972bf4c 1795) strvec_push(&cp.args, "--ignored");

t/helper/test-run-command.c
c972bf4c 75) strvec_pushl(&cp->args, "sh", test, NULL);
c972bf4c 77) strvec_push(&cp->args, "--quiet");
c972bf4c 79) strvec_push(&cp->args, "-i");
c972bf4c 81) strvec_push(&cp->args, "-v");
c972bf4c 83) strvec_push(&cp->args, "-V");
c972bf4c 85) strvec_push(&cp->args, "-x");
c972bf4c 87) strvec_push(&cp->args, "--write-junit-xml");
c972bf4c 223) struct strvec args = STRVEC_INIT;
c972bf4c 244) strvec_clear(&args);
c972bf4c 246) strvec_pushl(&args, "sh", "-c",
c972bf4c 249) strvec_pushl(&args, "test-tool", "run-command",
c972bf4c 257) strvec_push(&args, argv[j]);
c972bf4c 271) strvec_push(&args, buf);
c972bf4c 304) strvec_clear(&args);
c972bf4c 314) strvec_clear(&args);
c972bf4c 341) strvec_pushl(&cp.args,

tmp-objdir.c
c972bf4c 102) strvec_pushf(env, "%s=%s%c%s", key, old, PATH_SEP, val);

transport-helper.c
c972bf4c 448) strvec_pushf(&fastimport->args, "--cat-blob-fd=%d", cat_blob_fd);

upload-pack.c
c972bf4c 309) strvec_pushf(&pack_objects.args, "--filter=%s", buf.buf);

Jeff King	fbff95b6 index-pack: adjust default threading cap
builtin/index-pack.c
fbff95b6 1855) else if (nr_threads < 6)
fbff95b6 1856) nr_threads = 3; /* historic cap */
fbff95b6 1857) else if (nr_threads < 40)
fbff95b6 1858) nr_threads /= 2;
fbff95b6 1860) nr_threads = 20; /* hard cap */

Jeff King	e885a84f drop unused argc parameters
t/helper/test-submodule-nested-repo-config.c
e885a84f 4) static void die_usage(const char **argv, const char *msg)
e885a84f 17) die_usage(argv, "Wrong number of arguments.");
e885a84f 23) die_usage(argv, "Submodule not found.");

Jeff King	f6d8942b strvec: fix indentation in renamed calls
builtin/rebase.c
f6d8942b 873)      opts->git_format_patch_opt.buf);

daemon.c
f6d8942b 926)      ntohs(sin6_addr->sin6_port));

remote-curl.c
f6d8942b 1172)      options.deepen_not.items[i].string);

Jiang Xin	63518a57 New capability "report-status-v2" for git-push
send-pack.c
63518a57 183) if (!once++)
63518a57 185) ret = -1;
63518a57 186) continue;
63518a57 223) ret = -1;
63518a57 224) break;
63518a57 241)     hint->status != REF_STATUS_OK &&
63518a57 242)     hint->status != REF_STATUS_REMOTE_REJECT) {
63518a57 440) else if (server_supports("report-status"))

transport-helper.c
63518a57 839) state->hint = find_ref_by_name(remote_refs, refname);
63518a57 895) continue;
63518a57 900) for (report = ref->report; report; report = report->next) {
63518a57 901) private = apply_refspecs(&data->rs,
63518a57 902)  report->ref_name
63518a57 905) if (!private)
63518a57 906) continue;
63518a57 907) update_ref("update by helper", private,
63518a57 908)    report->new_oid
63518a57 912) free(private);

Jiang Xin	31e8595a receive-pack: new config receive.procReceiveRefs
builtin/receive-pack.c
31e8595a 246) return config_error_nonbool(var);
31e8595a 394) return 0;
31e8595a 1911) continue;

Jiang Xin	15d3af5e receive-pack: add new proc-receive hook
builtin/receive-pack.c
15d3af5e 1124) return code;
15d3af5e 1132) if (use_sideband)
15d3af5e 1133) finish_async(&muxer);
15d3af5e 1134) return code;

t/helper/test-proc-receive.c
15d3af5e 136) usage_msg_opt("Too many arguments.", proc_receive_usage, options);

Jim Meyering	5a7b1b57 fast-import: Don't use a maybe-clobbered errno value
builtin/fast-import.c
5a7b1b57 1705) int saved_errno = errno;

Johan Herland	a8dd2e7d fast-import: Add support for importing commit notes
builtin/fast-import.c
a8dd2e7d 2504) if (type < 0)
a8dd2e7d 2506) if (type != OBJ_BLOB)

Johannes Schindelin	40db58b8 fast-import: Fix compile warnings
builtin/fast-import.c
40db58b8 1892) (unsigned long)(length - n));

Johannes Schindelin	c5aa6db6 argv_array: offer to split a string by whitespace
strvec.c
c5aa6db6 72) to_split++;

Jon Griffiths	a6e5e286 credential-cache--daemon: refactor check_socket_directory
builtin/credential-cache--daemon.c
a6e5e286 247) die_errno("unable to create directories for '%s'", dir);
a6e5e286 249) die_errno("unable to mkdir '%s'", dir);

Jonathan Nieder	dc01f59d fast-import: treat SIGUSR1 as a request to access objects early
builtin/fast-import.c
dc01f59d 430) static void checkpoint_signal(int signo)
dc01f59d 432) checkpoint_requested = 1;
dc01f59d 433) }

Jonathan Nieder	5edde510 fast-import: filemodify after M 040000 <tree> "" crashes
builtin/fast-import.c
5edde510 1495) load_tree(root);

Jonathan Nieder	c27e559d fast-import: leakfix for 'ls' of dirty trees
builtin/fast-import.c
c27e559d 3182) release_tree_content_recursive(leaf.tree);

Jonathan Tan	f08cbf60 index-pack: make quantum of work smaller
builtin/index-pack.c
f08cbf60 424) list_for_each_prev(pos, &done_head) {
f08cbf60 425) struct base_data *b = list_entry(pos, struct base_data, list);
f08cbf60 426) if (b->retain_data || b == retain)
f08cbf60 427) continue;
f08cbf60 428) if (b->data) {
f08cbf60 429) free_base_data(b);
f08cbf60 430) if (base_cache_used <= base_cache_limit)
f08cbf60 431) return;
f08cbf60 435) list_for_each_prev(pos, &work_head) {
f08cbf60 436) struct base_data *b = list_entry(pos, struct base_data, list);
f08cbf60 437) if (b->retain_data || b == retain)
f08cbf60 438) continue;
f08cbf60 439) if (b->data) {
f08cbf60 440) free_base_data(b);
f08cbf60 441) if (base_cache_used <= base_cache_limit)
f08cbf60 442) return;
f08cbf60 925) base_cache_used += c->size;
f08cbf60 941) base_cache_used += c->size;

Jonathan Tan	ee47243d pack-objects: no fetch when allow-{any,promisor}
builtin/pack-objects.c
ee47243d 3065) if (!has_object(the_repository, &obj->oid, 0) && is_promisor_object(&obj->oid))

Jonathan Tan	f24c30e0 wt-status: tolerate dangling marks
builtin/show-branch.c
f24c30e0 744) if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))

Jonathan Tan	1d8d9cb6 sha1-file: introduce no-lazy-fetch has_object()
sha1-file.c
1d8d9cb6 2000) return 0;

Jonathan Tan	7ca3c0ac promisor-remote: lazy-fetch objects in subprocess
promisor-remote.c
7ca3c0ac 35) die_errno(_("promisor-remote: could not write to fetch subprocess"));
7ca3c0ac 37) die_errno(_("promisor-remote: could not write to fetch subprocess"));
7ca3c0ac 41) die_errno(_("promisor-remote: could not close stdin to fetch subprocess"));

Jonathan Tan	cbe566a0 negotiator/noop: add noop fetch negotiator
negotiator/noop.c
cbe566a0 6) static void known_common(struct fetch_negotiator *n, struct commit *c)
cbe566a0 9) }
cbe566a0 21) static int ack(struct fetch_negotiator *n, struct commit *c)

Jonathan Tan	5c3b801d fetch-pack: do not lazy-fetch during ref iteration
fetch-pack.c
5c3b801d 126) return NULL;

Jonathan Tan	e5b94213 fetch: avoid reading submodule config until needed
submodule-config.c
e5b94213 780) if (config->max_children)
e5b94213 781) *(config->max_children) =
e5b94213 782) parse_submodule_fetchjobs(var, value);
e5b94213 785) if (config->recurse_submodules)
e5b94213 786) *(config->recurse_submodules) =
e5b94213 787) parse_fetch_recurse_submodules_arg(var, value);

Junio C Hamano	6c526148 csum-file: introduce sha1file_checkpoint
builtin/fast-import.c
6c526148 1157) truncate_pack(&checkpoint);

Junio C Hamano	e0ad9574 Merge branch 'bc/sha-256-part-3'
builtin/verify-pack.c
e0ad9574 22) strvec_push(argv, "--verify-stat-only");

setup.c
e0ad9574 497) return config_error_nonbool(var);

Junio C Hamano	6854689e Merge branch 'ar/fetch-ipversion-in-all'
builtin/fetch.c
6854689e 1568) strvec_push(argv, "--ipv4");
6854689e 1570) strvec_push(argv, "--ipv6");

Junio C Hamano	ebcfb379 write_idx_file: introduce a struct to hold idx customization options
builtin/fast-import.c
ebcfb379 3455) if (pack_idx_opts.version > 2)

Junio C Hamano	9ed104e5 ident: say whose identity is missing when giving user.name hint
ident.c
9ed104e5 359) break;
9ed104e5 401) ident_env_hint(whose_ident);
9ed104e5 418) ident_env_hint(whose_ident);
9ed104e5 424) ident_env_hint(whose_ident);

Junio C Hamano	55bb5c91 zlib: wrap deflate side of the API
builtin/fast-import.c
55bb5c91 997) git_deflate_init(&s, pack_compression_level);
55bb5c91 1002) while (git_deflate(&s, Z_FINISH) == Z_OK)
55bb5c91 1004) git_deflate_end(&s);

Junio C Hamano	76ea93cc fast-import.c: Fix big-file-threshold parsing bug
builtin/fast-import.c
76ea93cc 3350) return 0;

Junio C Hamano	88910c99 quote_path: give flags parameter to quote_path()
builtin/clean.c
88910c99 217) quote_path(path->buf, prefix, &quoted, 0);
88910c99 241) quote_path(path->buf, prefix, &quoted, 0);
88910c99 1057) qname = quote_path(item->string, NULL, &buf, 0);

Junio C Hamano	225a6f10 zlib: wrap deflateBound() too
builtin/fast-import.c
225a6f10 1000) s.avail_out = git_deflate_bound(&s, s.avail_in);

Junio C Hamano	6e6029a8 fmt-merge-msg: allow merge destination to be omitted again
fmt-merge-msg.c
6e6029a8 29) return config_error_nonbool(key);

Junio C Hamano	4d0cc224 fast-import: count --max-pack-size in bytes
builtin/fast-import.c
4d0cc224 3338) return 0;
4d0cc224 3339) if (v < 8192) {
4d0cc224 3341) v *= 1024 * 1024;
4d0cc224 3342) } else if (v < 1024 * 1024) {
4d0cc224 3344) v = 1024 * 1024;
4d0cc224 3346) max_packsize = v;

Lin Sun	dbd8c09b mergetool: allow auto-merge for meld to follow the vim-diff behavior
builtin/config.c
dbd8c09b 99) new_type = TYPE_BOOL_OR_STR;
dbd8c09b 258) int v = git_parse_maybe_bool(value_);
dbd8c09b 259) if (v < 0)
dbd8c09b 260) strbuf_addstr(buf, value_);
dbd8c09b 262) strbuf_addstr(buf, v ? "true" : "false");
dbd8c09b 425) int v = git_parse_maybe_bool(value);
dbd8c09b 426) if (v < 0)
dbd8c09b 427) return xstrdup(value);
dbd8c09b 429) return xstrdup(v ? "true" : "false");

Martin Ågren	8f7e3de0 wt-status: print to s->fp, not stdout
wt-status.c
8f7e3de0 1859) fprintf(s->fp, " %s%c", it->string, 0);

Matheus Tavares	bda959c4 packfile: fix memory leak in add_delta_base_cache()
packfile.c
bda959c4 1487) free(base);

Michael Forney	ea3f7e59 revision: use repository from rev_info when parsing commits
revision.c
ea3f7e59 1058) if (repo_parse_commit(revs->repo, p) < 0)

Michael Haggerty	9e903316 credential-cache--daemon: use tempfile module
builtin/credential-cache--daemon.c
9e903316 297) delete_tempfile(&socket_file);

Mike Hommey	0df32457 fast-import: do less work when given "from" matches current branch head
builtin/fast-import.c
0df32457 2600) release_tree_content_recursive(b->branch_tree.tree);
0df32457 2601) b->branch_tree.tree = NULL;

Miriam Rubio	7b4de74b bisect--helper: introduce new `write_in_file()` function
builtin/bisect--helper.c
7b4de74b 97) return error_errno(_("cannot open file '%s' in mode '%s'"), path, mode);
7b4de74b 101) int saved_errno = errno;
7b4de74b 102) fclose(fp);
7b4de74b 103) errno = saved_errno;
7b4de74b 104) return error_errno(_("could not write to file '%s'"), path);

Nguyễn Thái Ngọc Duy	26604f9f credential-cache--daemon.c: use warning_errno()
builtin/credential-cache--daemon.c
26604f9f 185) warning_errno("accept failed");
26604f9f 190) warning_errno("dup failed");

Nguyễn Thái Ngọc Duy	d3b4705a sha1-file.c: remove the_repo from read_object_with_reference()
builtin/fast-import.c
d3b4705a 2648) char *buf = read_object_with_reference(the_repository,
d3b4705a 2649)        &n->oid,

Nguyễn Thái Ngọc Duy	6c223e49 fast-import.c: use error_errno()
builtin/fast-import.c
6c223e49 320) error_errno("can't write crash report %s", loc);
6c223e49 1698) failure |= error_errno("Unable to write marks file %s",
6c223e49 1714) failure |= error_errno("Unable to write file %s",

Nicolas Pitre	3fc366bd fast-import: start using struct pack_idx_entry
builtin/fast-import.c
3fc366bd 1155) e->idx.offset = 1; /* just not zero! */

Noam Postavsky	7f4d4746 credential-cache: new option to ignore sighup
builtin/credential-cache--daemon.c
7f4d4746 294) signal(SIGHUP, SIG_IGN);

Paul Tan	cb2c2796 git-credential-store: support multiple credential files
builtin/credential-store.c
cb2c2796 103) return;
cb2c2796 131) return;
cb2c2796 170) string_list_append(&fns, file);

Phillip Wood	a3894aad rebase -i: support --ignore-date
sequencer.c
a3894aad 1448) goto out;
a3894aad 1453) goto out;
a3894aad 1479) goto out;

Phillip Wood	7573cec5 rebase -i: support --committer-date-is-author-date
sequencer.c
7573cec5 4498) return -1;
7573cec5 5395) goto cleanup;

Phillip Wood	ce910287 add -p: fix checking of user input
add-patch.c
ce910287 1508) if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
ce910287 1513) if (permitted & ALLOW_GOTO_NEXT_HUNK)
ce910287 1518) if (permitted & ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK)
ce910287 1523) if (permitted & ALLOW_GOTO_NEXT_UNDECIDED_HUNK)

Phillip Wood	75a009dc add -p: fix editing of intent-to-add paths
add-patch.c
75a009dc 1398) undecided_previous = i;
75a009dc 1399) break;
75a009dc 1421) permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
75a009dc 1422) strbuf_addstr(&s->buf, ",k");
75a009dc 1484) if (file_diff->hunk_nr) {
75a009dc 1485) for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
75a009dc 1486) hunk = file_diff->hunk + hunk_index;
75a009dc 1487) if (hunk->use == UNDECIDED_HUNK)
75a009dc 1488) hunk->use = USE_HUNK;
75a009dc 1490) } else if (hunk->use == UNDECIDED_HUNK) {
75a009dc 1491) hunk->use = USE_HUNK;
75a009dc 1500) } else if (hunk->use == UNDECIDED_HUNK) {
75a009dc 1501) hunk->use = SKIP_HUNK;

Pierre Habouzit	eec813cf fast-import was using dbuf's, replace them with strbuf's.
builtin/fast-import.c
eec813cf 998) s.next_in = (void *)dat->buf;
eec813cf 999) s.avail_in = dat->len;

Pranit Bauva	517ecb31 bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
builtin/bisect--helper.c
517ecb31 529) return res;
517ecb31 533) return error_errno(_("could not open '%s' for appending"),
517ecb31 537) return error_errno(_("failed to write to '%s'"), git_path_bisect_log());
517ecb31 586) return BISECT_FAILED;

Pranit Bauva	09535f05 bisect--helper: reimplement `bisect_autostart` shell function in C
builtin/bisect--helper.c
09535f05 827) fprintf_ln(stderr, _("You need to start by \"git bisect "
09535f05 830) if (!isatty(STDIN_FILENO))
09535f05 831) return -1;
09535f05 838) yesno = git_prompt(_("Do you want me to do it for you "
09535f05 840) res = tolower(*yesno) == 'n' ?
09535f05 841) -1 : bisect_start(terms, empty_strvec, 0);
09535f05 843) return res;

Prathamesh Chavan	e83e3333 submodule: port submodule subcommand 'summary' from shell to C
builtin/submodule--helper.c
e83e3333 1091) missing_dst = 1;
e83e3333 1142) strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s and %s\n",
e83e3333 1143)     displaypath, oid_to_hex(&p->oid_src),
e83e3333 1144)     oid_to_hex(&p->oid_dst));
e83e3333 1149)     oid_to_hex(&p->oid_dst));
e83e3333 1271) return -1;
e83e3333 1275) return -1;
e83e3333 1319) return 0;

Randall S. Becker	f64b6a1f bugreport.c: replace strbuf_write_fd with write_in_full
builtin/bugreport.c
f64b6a1f 178) die_errno(_("unable to write to %s"), report_path.buf);

René Scharfe	24b75faf connected: use buffered I/O to talk to rev-list
connected.c
24b75faf 143) if (errno != EPIPE && errno != EINVAL)
24b75faf 144) error_errno(_("failed write to rev-list"));
24b75faf 145) err = -1;

René Scharfe	bcd2c5ee read-cache: fix mem-pool allocation for multi-threaded index loading
read-cache.c
bcd2c5ee 2104) p->ce_mem_pool = xmalloc(sizeof(*istate->ce_mem_pool));

René Scharfe	2947a793 archive: add --add-file
archive.c
2947a793 345) err = error_errno(_("could not read '%s'"), path);
2947a793 352) break;
2947a793 513) string_list_clear_func(&args->extra_files,
2947a793 515) return 0;
2947a793 519) return -1;

René Scharfe	a698d67b upload-pack: use buffered I/O to talk to rev-list
upload-pack.c
a698d67b 661) if (cmd_in)
a698d67b 662) fclose(cmd_in);

Ronnie Sahlberg	3f09ba75 fast-import.c: use a ref transaction when dumping tags
builtin/fast-import.c
3f09ba75 1662) goto cleanup;
3f09ba75 1671) goto cleanup;

Ronnie Sahlberg	de7e86f5 fast-import.c: change update_branch to use ref transactions
builtin/fast-import.c
de7e86f5 1630) ref_transaction_free(transaction);
de7e86f5 1632) strbuf_release(&err);
de7e86f5 1633) return -1;

Ryan Zoeller	a0abe5e3 parse-options: add --git-completion-helper-all
parse-options.c
a0abe5e3 736) return show_gitcomp(options, 1);

Sergey Organov	d01141de diff: get rid of redundant 'dense' argument
diff-lib.c
d01141de 362) show_combined_diff(p, 2, revs);

Shawn O. Pearce	d9ee53ce Implemented automatic checkpoints within fast-import.
builtin/fast-import.c
d9ee53ce 990) e->pack_id = pack_id + 1;
d9ee53ce 994) if (delta) {

Shawn O. Pearce	820b9310 Dump all refs and marks during a checkpoint in fast-import.
builtin/fast-import.c
820b9310 991) cycle_packfile();

Shawn O. Pearce	60b9004c Use atomic updates to the fast-import mark file
builtin/fast-import.c
60b9004c 1700) return;
60b9004c 1706) rollback_lock_file(&mark_lock);
60b9004c 1709) return;

Shawn O. Pearce	5eef828b fast-import: Stream very large blobs directly to pack
builtin/fast-import.c
5eef828b 1063) die_errno("cannot truncate pack to skip duplicate");
5eef828b 1085) cycle_packfile();
5eef828b 1153) e->type = OBJ_BLOB;
5eef828b 1154) e->pack_id = MAX_PACK_ID;
5eef828b 1156) duplicate_count_by_type[OBJ_BLOB]++;

Shawn O. Pearce	b6f3481b Teach fast-import to recursively copy files/directories
builtin/fast-import.c
b6f3481b 720) return NULL;
b6f3481b 727) b->tree = dup_tree_content(a->tree);
b6f3481b 1576) return 0;
b6f3481b 1582) return 0;

Shawn O. Pearce	afde8dd9 Fixed segfault in fast-import after growing a tree.
builtin/fast-import.c
afde8dd9 1424) release_tree_content_recursive(e->tree);

Shawn O. Pearce	5d6f3ef6 Corrected buffer overflow during automatic checkpoint in fast-import.
builtin/fast-import.c
5d6f3ef6 1001) s.next_out = out = xrealloc(out, s.avail_out);

Shawn O. Pearce	63e0c8b3 Support RFC 2822 date parsing in fast-import.
builtin/fast-import.c
63e0c8b3 1920) return -1;
63e0c8b3 1978) break;

Shawn O. Pearce	463acbe1 Added tree and commit writing to fast-import.
builtin/fast-import.c
463acbe1 640) l->next_avail = f->next_avail;
463acbe1 1227) return NULL;
463acbe1 1456) return 0;
463acbe1 2032) e = active_branches;
463acbe1 2033) active_branches = e->active_next_branch;

Shawn O. Pearce	bdf1c06d fast-import: Hide the pack boundary commits by default.
builtin/fast-import.c
bdf1c06d 891) if (t->pack_id == pack_id)

Shawn O. Pearce	2f6dc35d fast-import: Fail if a non-existant commit is used for merge
builtin/fast-import.c
2f6dc35d 2654) free(buf);

Shawn O. Pearce	8acb3297 Generate crash reports on die in fast-import
builtin/fast-import.c
8acb3297 305) fprintf(rpt, "%u", b->pack_id);
8acb3297 322) return;

Shawn O. Pearce	69e74e74 Correct packfile edge output in fast-import.
builtin/fast-import.c
69e74e74 2860) t->pack_id = MAX_PACK_ID;

Shawn O. Pearce	bb23fdfa Teach fast-import to honor pack.compression and pack.depth
builtin/fast-import.c
bb23fdfa 3450) if (max_depth > MAX_DEPTH)
bb23fdfa 3451) max_depth = MAX_DEPTH;

Stefan Beller	0df8e965 cache.h: add repository argument to oid_object_info
builtin/fast-import.c
0df8e965 2502) enum object_type type = oid_object_info(the_repository, &oid,

Sverre Rabbelier	9c8398f0 fast-import: add option command
builtin/fast-import.c
9c8398f0 3500) usage(fast_import_usage);

Sverre Rabbelier	0f6927c2 fast-import: put option parsing code in separate functions
builtin/fast-import.c
0f6927c2 3284) if (max_depth > MAX_DEPTH)
0f6927c2 3286) }
0f6927c2 3309) fclose(pack_edges);
0f6927c2 3361) show_stats = 1;

SZEDER Gábor	87d01c85 credential-store: don't pass strerror to die_errno()
builtin/credential-store.c
87d01c85 67) die_errno("unable to write credential store");

SZEDER Gábor	17e6275f commit-graph: simplify chunk writes into loop
commit-graph.c
17e6275f 1821) return -1;

Tanay Abhra	536900e5 fast-import.c: replace `git_config()` with `git_config_get_*()` family
builtin/fast-import.c
536900e5 3454) pack_idx_opts.version = indexversion_value;
536900e5 3456) git_die_config("pack.indexversion",
536900e5 3460) max_packsize = packsizelimit_value;

Taylor Blau	809e0327 builtin/commit-graph.c: introduce '--max-new-filters=<n>'
builtin/commit-graph.c
809e0327 175) *to = -1;

Taylor Blau	b9ea2147 list_objects_filter_options: introduce 'list_object_filter_config_name'
list-objects-filter-options.c
b9ea2147 23) break;
b9ea2147 36) break;

Taylor Blau	6dd3456a upload-pack.c: allow banning certain object filter(s)
upload-pack.c
6dd3456a 1078) die_if_using_banned_filter(data);

Taylor Blau	5b01a4e8 upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'
upload-pack.c
5b01a4e8 1259) strbuf_release(&buf);
5b01a4e8 1260) return config_error_nonbool(var);

Taylor Blau	59f0d507 bloom: encode out-of-bounds filters as non-empty
bloom.c
59f0d507 294) init_truncated_large_filter(filter);

Taylor Blau	ab14d067 commit-graph: pass a 'struct repository *' in more places
fuzz-commit-graph.c
ab14d067 14) g = parse_commit_graph(the_repository, (void *)data, size);

Taylor Blau	98bb7961 commit-graph: rename 'split_commit_graph_opts'
commit-graph.c
98bb7961 2218) ctx->oids.alloc = opts->max_commits;

Taylor Blau	312cff52 bloom: split 'get_bloom_filter()' in two
bloom.c
312cff52 296) if (computed)
312cff52 297) *computed |= BLOOM_TRUNC_LARGE;

Thomas Rast	0721c314 Use die_errno() instead of die() when checking syscalls
builtin/fast-import.c
0721c314 793) die_errno("cannot create keep file");
0721c314 796) die_errno("failed to write keep file");


