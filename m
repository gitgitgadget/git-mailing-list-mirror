Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F4F51F597
	for <e@80x24.org>; Wed,  1 Aug 2018 10:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbeHAMEP (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 08:04:15 -0400
Received: from mout.web.de ([212.227.17.12]:47621 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733104AbeHAMEP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 08:04:15 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlniO-1gJrzR3OgC-00ZRFE for
 <git@vger.kernel.org>; Wed, 01 Aug 2018 12:19:09 +0200
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] remote: clear string_list after use in mv()
Message-ID: <553f84f2-7d9d-9a92-d5ca-39bd862ff748@web.de>
Date:   Wed, 1 Aug 2018 12:19:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LaYDu4dyIxAzKLPytDa7I1iwW/MtLUrAGsfgPlKOxZtMIrWAKBZ
 D/SZhBb0hO08i0aQ9+UmkDmIK1rR2+W5EtU1WIVNejATtgZA0P1uSXfvMhBHZMrqK9O8O3f
 Tsx/lSA/jRH/2YR4tyGTq5JdDb34KdW0zfcqCmhpZSV6/fxGl8ngGKemvNeg0iNHFPFgAqQ
 DDmHFA9zqEwWczy2JnrWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sUn87S7dRh8=:U+csHYOR+6eBUVt0v4TnB5
 SwIs3RGkOOZO7rdXYKOmjG2GwgN1Pl0rmu3V/Bul1vP++bXfOsm759udKPTE4Hle2cUEWlEKo
 wrif7ryRFs2hf7y77fN+kRAQC+FQLxpExv/H0rCP8pqJL9ElvvrHxCce5jFmpRisn2fEaEzrw
 5SbQQ/SY3rMKz00fqwWPwNbZGaXQTv+DWLF2RFKT53s9Of61auxS/1YNUvMFoHA+tgp7rGFJ/
 AYnl+8H8lTGisxBrwuYolLSaNPwtGUJPw+lAsbUbYeir49EqinbG8C84eXNG+C6xfx9JNnYjv
 8PwBteiHJoUyHUjwHJZvYx3k/QbqPWAPhtVVXkuGMPrXWRGh8HzHdkekD86o/FXwevZWK8X1Y
 UHJ4h8IhdHQbyIPexUDtpIlLuhmV6MWtyTOj4hNGCBNk3kV56iqGZHBI1j451THQugZ1I7Fb+
 ga0Bazkfboke2XcmDKQLp3PJR/XxluyFSgoX38BsUoIPrfgVNPXAdYv3x9ibQZTJ1NWAdfs8i
 Ll6pJIrdnEbcB4QLMzY6IxKBPLTUaNnFDj0Tpb4dbXvL9rtmSp+dGMjR5q020I5IJ2JOM5cha
 Qw7iF+tT8h1/ZHqmXkrDp3CfwbZYq/B9VSIPLIfnsjwTy6a8O7PFF9hIrxULX1ICB/z5HSThY
 cr7BeJFlVxsMtlUHO1GtP6bfD970oldknTHitiyFN8aedFR+HtTJMOIjRm4MkmKtV19UsPS83
 lF0f14p6lTVVsaXV3EQL+FThBdEvCyiuEo6ZhJ97KrdGsfpF41WxpzO5kqDxtQ4j4MukRutj2
 jphwuxq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch to the _DUP variant of string_list for remote_branches to allow
string_list_clear() to release the allocated memory at the end, and
actually call that function.  Free the util pointer as well; it is
allocated in read_remote_branches().

NB: This string_list is empty until read_remote_branches() is called
via for_each_ref(), so there is no need to clean it up when returning
before that point.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Patch generated with ---function-context for easier review -- that
makes it look much bigger than it actually is, though.

 builtin/remote.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c74ee88690..07bd51f8eb 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -558,23 +558,23 @@ struct rename_info {
 static int read_remote_branches(const char *refname,
 	const struct object_id *oid, int flags, void *cb_data)
 {
 	struct rename_info *rename = cb_data;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
 	int flag;
 	const char *symref;
 
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
 	if (starts_with(refname, buf.buf)) {
-		item = string_list_append(rename->remote_branches, xstrdup(refname));
+		item = string_list_append(rename->remote_branches, refname);
 		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
 					    NULL, &flag);
 		if (symref && (flag & REF_ISSYMREF))
 			item->util = xstrdup(symref);
 		else
 			item->util = NULL;
 	}
 	strbuf_release(&buf);
 
 	return 0;
 }
@@ -607,133 +607,134 @@ static int migrate_file(struct remote *remote)
 static int mv(int argc, const char **argv)
 {
 	struct option options[] = {
 		OPT_END()
 	};
 	struct remote *oldremote, *newremote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT,
 		old_remote_context = STRBUF_INIT;
-	struct string_list remote_branches = STRING_LIST_INIT_NODUP;
+	struct string_list remote_branches = STRING_LIST_INIT_DUP;
 	struct rename_info rename;
 	int i, refspec_updated = 0;
 
 	if (argc != 3)
 		usage_with_options(builtin_remote_rename_usage, options);
 
 	rename.old_name = argv[1];
 	rename.new_name = argv[2];
 	rename.remote_branches = &remote_branches;
 
 	oldremote = remote_get(rename.old_name);
 	if (!remote_is_configured(oldremote, 1))
 		die(_("No such remote: %s"), rename.old_name);
 
 	if (!strcmp(rename.old_name, rename.new_name) && oldremote->origin != REMOTE_CONFIG)
 		return migrate_file(oldremote);
 
 	newremote = remote_get(rename.new_name);
 	if (remote_is_configured(newremote, 1))
 		die(_("remote %s already exists."), rename.new_name);
 
 	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new_name);
 	if (!valid_fetch_refspec(buf.buf))
 		die(_("'%s' is not a valid remote name"), rename.new_name);
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s", rename.old_name);
 	strbuf_addf(&buf2, "remote.%s", rename.new_name);
 	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
 		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
 	git_config_set_multivar(buf.buf, NULL, NULL, 1);
 	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
 	for (i = 0; i < oldremote->fetch.raw_nr; i++) {
 		char *ptr;
 
 		strbuf_reset(&buf2);
 		strbuf_addstr(&buf2, oldremote->fetch.raw[i]);
 		ptr = strstr(buf2.buf, old_remote_context.buf);
 		if (ptr) {
 			refspec_updated = 1;
 			strbuf_splice(&buf2,
 				      ptr-buf2.buf + strlen(":refs/remotes/"),
 				      strlen(rename.old_name), rename.new_name,
 				      strlen(rename.new_name));
 		} else
 			warning(_("Not updating non-default fetch refspec\n"
 				  "\t%s\n"
 				  "\tPlease update the configuration manually if necessary."),
 				buf2.buf);
 
 		git_config_set_multivar(buf.buf, buf2.buf, "^$", 0);
 	}
 
 	read_branches();
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
 		if (info->remote_name && !strcmp(info->remote_name, rename.old_name)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
 			git_config_set(buf.buf, rename.new_name);
 		}
 	}
 
 	if (!refspec_updated)
 		return 0;
 
 	/*
 	 * First remove symrefs, then rename the rest, finally create
 	 * the new symrefs.
 	 */
 	for_each_ref(read_remote_branches, &rename);
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
 		int flag = 0;
 		struct object_id oid;
 
 		read_ref_full(item->string, RESOLVE_REF_READING, &oid, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
 			die(_("deleting '%s' failed"), item->string);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
 
 		if (item->util)
 			continue;
 		strbuf_reset(&buf);
 		strbuf_addstr(&buf, item->string);
 		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
 				rename.new_name, strlen(rename.new_name));
 		strbuf_reset(&buf2);
 		strbuf_addf(&buf2, "remote: renamed %s to %s",
 				item->string, buf.buf);
 		if (rename_ref(item->string, buf.buf, buf2.buf))
 			die(_("renaming '%s' failed"), item->string);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
 
 		if (!item->util)
 			continue;
 		strbuf_reset(&buf);
 		strbuf_addstr(&buf, item->string);
 		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
 				rename.new_name, strlen(rename.new_name));
 		strbuf_reset(&buf2);
 		strbuf_addstr(&buf2, item->util);
 		strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old_name),
 				rename.new_name, strlen(rename.new_name));
 		strbuf_reset(&buf3);
 		strbuf_addf(&buf3, "remote: renamed %s to %s",
 				item->string, buf.buf);
 		if (create_symref(buf.buf, buf2.buf, buf3.buf))
 			die(_("creating '%s' failed"), buf.buf);
 	}
+	string_list_clear(&remote_branches, 1);
 	return 0;
 }
 
-- 
2.18.0
