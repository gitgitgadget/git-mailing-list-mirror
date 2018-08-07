Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0944E208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 20:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeHGW2r (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 18:28:47 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:45264 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGW2r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 18:28:47 -0400
Received: by mail-ua0-f201.google.com with SMTP id x17-v6so12294823uap.12
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 13:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x0msd70G43I7LlUsVawsc6erYyR4QBJ6FfohoKWKPLU=;
        b=DQDS+OQaZRB8h0U34FMIta3sLboX2gDMHFv/vNwnMHnNrV7cy8Eb/hjg36buV8MHpD
         0EGhy8yanB1QcCgzfu/UHTIcp9VGegBeKz+ICUwD2nW24L4Y0TRKVthnTfN1SwqhlwXo
         Xhsselr7M8j9mdyfnCxa2JMcgShq3bOHmbK0ePSaW6OksXnUZgMT+mAcwXSdWQIPGWQQ
         ZhLrPrr68va46MyMqwmCXSAT+qmAVn4WKv6vkWCpF11SJvvm7W3l13d7qpH2KGtsSUbM
         YScSAd3yaXCeEPKYvAaqUbpSwB9tgq4bqNJIZVHyZ8nbvYpUQWcGHkovxqw+vTYR1uLx
         04oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x0msd70G43I7LlUsVawsc6erYyR4QBJ6FfohoKWKPLU=;
        b=baAecK7EwxlKl7IpxwWXYJFnCzdmGDVADmVbpqIS0jOSr1vujX5pxA9J4FYcbdWZ/T
         xR/NexWQDl96ErWxFNf3iKwm6o2cf6ROsVqrTaKGe6bTdCw84gk3bTDunUXdvNIZhPax
         lh+RzVIkHvo7lj7sp1M+Ag3JaMysc14FVE4vV4Oj1X7LrM75+4eYZIklbKUtf1hqMhfw
         Em1C0KAydqlzrzRe5RZpCfEKBSTO5RGeSXCxCl1ra9c58+YLELvHStf88fyXZ57wgpm7
         DYAmyTVtgo9jIHgSvYPzoklGjFfiOXfsA9qcWR2uoCkScJjS62tJWZ0YQ4PnO2eR2kWE
         Ve0g==
X-Gm-Message-State: AOUpUlH2s2p5rUn0dgTNhQseCgApzblnKBhEQ1UzhASkgvIxizXm2CE6
        auZZDrr4EAvFzbhzh0I/xF/rcIG2b1+hNvpzGIInGD0lVxeBMKLRrIK+fEevEHv6Gn4wf0JzPzb
        Zzfv4sc8Y6UDMoFwDCZ6k6kvQjzJx9PALMqGsHWVRS/DXqtEZNLfHy+RQmgFcXeFA3JWwQsAaEV
        r0
X-Google-Smtp-Source: AAOMgpdouR4/3C/QW0OP8DrWWM+VA74ROCoXDDUnziacjTN1eac+ZkYDPweZ7kFymHV5YWI1oU7D9+b0qEAXdIDyTWVO
X-Received: by 2002:ab0:301a:: with SMTP id f26-v6mr11590789ual.123.1533672762317;
 Tue, 07 Aug 2018 13:12:42 -0700 (PDT)
Date:   Tue,  7 Aug 2018 13:12:32 -0700
In-Reply-To: <cover.1533672584.git.jonathantanmy@google.com>
Message-Id: <61396b2a73a801f62818ad3b691f75170d2e3919.1533672584.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1533672584.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 2/2] repack: repack promisor objects if -a or -A is set
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, repack does not touch promisor packfiles at all, potentially
causing the performance of repositories that have many such packfiles to
drop. Therefore, repack all promisor objects if invoked with -a or -A.

This is done by an additional invocation of pack-objects on all promisor
objects individually given, which takes care of deduplication and allows
the resulting packfiles to respect flags such as --max-pack-size.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-repack.txt |  5 +++
 builtin/repack.c             | 64 ++++++++++++++++++++++++++++++--
 t/t0410-partial-clone.sh     | 71 ++++++++++++++++++++++++++++++------
 3 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d90e7907f..d05625096 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -40,6 +40,11 @@ OPTIONS
 Note that users fetching over dumb protocols will have to fetch the
 whole new pack in order to get any contained object, no matter how many
 other objects in that pack they already have locally.
++
+Promisor packfiles are repacked separately: if there are packfiles that
+have an associated ".promisor" file, these packfiles will be repacked
+into another separate pack, and an empty ".promisor" file corresponding
+to the new separate pack will be written.
 
 -A::
 	Same as `-a`, unless `-d` is used.  Then any unreachable
diff --git a/builtin/repack.c b/builtin/repack.c
index ca695fa10..a78d2f0aa 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -8,6 +8,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "packfile.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -83,7 +84,7 @@ static void remove_pack_on_signal(int signo)
 
 /*
  * Adds all packs hex strings to the fname list, which do not
- * have a corresponding .keep or .promisor file. These packs are not to
+ * have a corresponding .keep file. These packs are not to
  * be kept if we are going to pack everything into one file.
  */
 static void get_non_kept_pack_filenames(struct string_list *fname_list,
@@ -111,8 +112,7 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 
 		fname = xmemdupz(e->d_name, len);
 
-		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)) &&
-		    !file_exists(mkpath("%s/%s.promisor", packdir, fname)))
+		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
 			string_list_append_nodup(fname_list, fname);
 		else
 			free(fname);
@@ -122,7 +122,7 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
-	const char *exts[] = {".pack", ".idx", ".keep", ".bitmap"};
+	const char *exts[] = {".pack", ".idx", ".keep", ".bitmap", ".promisor"};
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 	size_t plen;
@@ -179,6 +179,58 @@ static void prepare_packed_objects(struct child_process *cmd,
 	cmd->out = -1;
 }
 
+static int write_oid(const struct object_id *oid, struct packed_git *pack,
+		     uint32_t pos, void *data)
+{
+	int fd = *(int *)data;
+
+	xwrite(fd, oid_to_hex(oid), GIT_SHA1_HEXSZ);
+	xwrite(fd, "\n", 1);
+	return 0;
+}
+
+static void repack_promisor_objects(const struct packed_objects_args *args,
+				    struct string_list *names)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	FILE *out;
+	struct strbuf line = STRBUF_INIT;
+
+	prepare_packed_objects(&cmd, args);
+	cmd.in = -1;
+
+	if (start_command(&cmd))
+		die("Could not start pack-objects to repack promisor objects");
+
+	for_each_packed_object(write_oid, &cmd.in,
+			       FOR_EACH_OBJECT_PROMISOR_ONLY);
+	close(cmd.in);
+
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline_lf(&line, out) != EOF) {
+		char *promisor_name;
+		int fd;
+		if (line.len != 40)
+			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
+		string_list_append(names, line.buf);
+
+		/*
+		 * pack-objects creates the .pack and .idx files, but not the
+		 * .promisor file. Create the .promisor file, which is empty.
+		 */
+		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
+					  line.buf);
+		fd = open(promisor_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+		if (fd < 0)
+			die_errno("unable to create '%s'", promisor_name);
+		close(fd);
+		free(promisor_name);
+	}
+	fclose(out);
+	if (finish_command(&cmd))
+		die("Could not finish pack-objects to repack promisor objects");
+}
+
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
 
@@ -191,6 +243,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		{".pack"},
 		{".idx"},
 		{".bitmap", 1},
+		{".promisor", 1},
 	};
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
@@ -293,6 +346,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
 
+		if (repository_format_partial_clone)
+			repack_promisor_objects(&po_args, &names);
+
 		if (existing_packs.nr && delete_redundant) {
 			if (unpack_unreachable) {
 				argv_array_pushf(&cmd.args,
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 4984ca583..27ba7d201 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -271,28 +271,77 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
 	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
 '
 
-test_expect_success 'gc does not repack promisor objects' '
+test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
 	rm -rf repo &&
 	test_create_repo repo &&
-	test_commit -C repo my_commit &&
+	test_commit -C repo one &&
+	test_commit -C repo two &&
 
-	TREE_HASH=$(git -C repo rev-parse HEAD^{tree}) &&
-	HASH=$(printf "$TREE_HASH\n" | pack_as_from_promisor) &&
+	TREE_ONE=$(git -C repo rev-parse one^{tree}) &&
+	printf "$TREE_ONE\n" | pack_as_from_promisor &&
+	TREE_TWO=$(git -C repo rev-parse two^{tree}) &&
+	printf "$TREE_TWO\n" | pack_as_from_promisor &&
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
 	git -C repo gc &&
 
-	# Ensure that the promisor packfile still exists, and remove it
-	test -e repo/.git/objects/pack/pack-$HASH.pack &&
-	rm repo/.git/objects/pack/pack-$HASH.* &&
-
-	# Ensure that the single other pack contains the commit, but not the tree
+	# Ensure that exactly one promisor packfile exists, and that it
+	# contains the trees but not the commits
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	PROMISOR_PACKFILE=$(sed "s/.promisor/.pack/" <promisorlist) &&
+	git verify-pack $PROMISOR_PACKFILE -v >out &&
+	grep "$TREE_ONE" out &&
+	grep "$TREE_TWO" out &&
+	! grep "$(git -C repo rev-parse one)" out &&
+	! grep "$(git -C repo rev-parse two)" out &&
+
+	# Remove the promisor packfile and associated files
+	rm $(sed "s/.promisor//" <promisorlist).* &&
+
+	# Ensure that the single other pack contains the commits, but not the
+	# trees
 	ls repo/.git/objects/pack/pack-*.pack >packlist &&
 	test_line_count = 1 packlist &&
 	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
-	grep "$(git -C repo rev-parse HEAD)" out &&
-	! grep "$TREE_HASH" out
+	grep "$(git -C repo rev-parse one)" out &&
+	grep "$(git -C repo rev-parse two)" out &&
+	! grep "$TREE_ONE" out &&
+	! grep "$TREE_TWO" out
+'
+
+repack_and_check () {
+	rm -rf repo2 &&
+	cp -r repo repo2 &&
+	git -C repo2 repack $1 -d &&
+	git -C repo2 fsck &&
+
+	git -C repo2 cat-file -e $2 &&
+	git -C repo2 cat-file -e $3
+}
+
+test_expect_success 'repack -d does not irreversibly delete promisor objects' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+
+	git -C repo commit --allow-empty -m one &&
+	git -C repo commit --allow-empty -m two &&
+	git -C repo commit --allow-empty -m three &&
+	git -C repo commit --allow-empty -m four &&
+	ONE=$(git -C repo rev-parse HEAD^^^) &&
+	TWO=$(git -C repo rev-parse HEAD^^) &&
+	THREE=$(git -C repo rev-parse HEAD^) &&
+
+	printf "$TWO\n" | pack_as_from_promisor &&
+	printf "$THREE\n" | pack_as_from_promisor &&
+	delete_object repo "$ONE" &&
+
+	repack_and_check -a "$TWO" "$THREE" &&
+	repack_and_check -A "$TWO" "$THREE" &&
+	repack_and_check -l "$TWO" "$THREE"
 '
 
 test_expect_success 'gc stops traversal when a missing but promised object is reached' '
-- 
2.18.0.597.ga71716f1ad-goog

