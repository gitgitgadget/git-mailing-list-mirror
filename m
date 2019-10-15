Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F781F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 00:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJOAMi (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 20:12:38 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45312 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfJOAMi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 20:12:38 -0400
Received: by mail-qt1-f201.google.com with SMTP id r15so19490739qtn.12
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/K9MCbakqwy1ODxBDuo38gjwhMaMgrWxprGnpdjsUPI=;
        b=Nl13JBPIi0AC914yBA99wTarJO/oFPuhYkcJ3B902Us+YnKZdyBCI1lOoFxSA116y0
         Q96EHH8oyUMRGYa/Exf/Yps1nIlJmkAyxSyoW6Q9CJ31DmSQd+f/pcRkbEuWTS8o6Fy8
         SrMd7QHgcLmtFUYPR4PWI/ZmgnBOxYx11A9hw/XAF3/kvuPzmTtXWE0ptzFT3xp9kCqL
         iw/m2c2AYNGaCdZSQAD1yek51UfnqEKA0xWzp/ZneKMavAF/HPo8aft7Mp30rGVGauEV
         aOBJLHlJEZOGYRHZjwBMAeCPmBGkLbnSxZ7j0146ST0Xo5yYRaImBOcVhL+1ZEYu58fB
         mSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/K9MCbakqwy1ODxBDuo38gjwhMaMgrWxprGnpdjsUPI=;
        b=jD+EKk/9E33LJVZPrqoA6iRHsOC7ASKEw4CSE+MsMXygjuil41CSwEVzIthJ9rM61G
         Ce0h97YP7uz2H7sTz1oTlVmf515S/AAs708khuOqT1jNAu1iuLxX2ucTT0dK9DAS8tm9
         27kw46VZm3wY/HIXwZwaIVLsu9PRsGW525mDM1kE6kql9kUm9sO9d4Kk9z2Sw926Q2PM
         G3Gq+xkOLTe1S71miSAR3mQRTtLHzn12BNDD8vrUG7H7E+XT2L3HmXanc+W4Oc6dqSAd
         XbzSuojNJFIbs2pbsdIKcvBFSnmecl9E9PoxD26Z7lxt8jCQBHln4H+/mJVvdDH6HrJF
         UZGw==
X-Gm-Message-State: APjAAAVE2XgF7jnMWo6BVFGxXrZTW16Z2pgKKr9/LdU6FRmRKEUSjzqV
        4eIrUlT6+REp8tUqWJmgiErvHJ4wBLRlWIJF9pxaH4cF9gz9PgsO3/ZcmJi6SQ8Zm4qDZ/9Xb6d
        tsPT/3L0tTDTizgnrn4xvniufM0Ad053ZABhIed5y3qp+IRtJEiju6tpS0OuaONYRomC85ivbq6
        YX
X-Google-Smtp-Source: APXvYqxKn3efam5Fkl7eHtRqbRsMCZJFeg3yQRzlEOiFszgZiPs+kXR57MYEWiUUsadWNES5FucTHpei2civ1jJvyGnb
X-Received: by 2002:ac8:2ccc:: with SMTP id 12mr36433786qtx.49.1571098357070;
 Mon, 14 Oct 2019 17:12:37 -0700 (PDT)
Date:   Mon, 14 Oct 2019 17:12:31 -0700
In-Reply-To: <20190826214737.164132-1-jonathantanmy@google.com>
Message-Id: <20191015001231.97272-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190826214737.164132-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v2] fetch-pack: write fetched refs to .promisor
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The specification of promisor packfiles (in partial-clone.txt) states
that the .promisor files that accompany packfiles do not matter (just
like .keep files), so whenever a packfile is fetched from the promisor
remote, Git has been writing empty .promisor files. But these files
could contain more useful information.

So instead of writing empty files, write the refs fetched to these
files. This makes it easier to debug issues with partial clones, as we
can identify what refs (and their associated hashes) were fetched at the
time the packfile was downloaded, and if necessary, compare those hashes
against what the promisor remote reports now.

This is implemented by teaching fetch-pack to write its own non-empty
.promisor file whenever it knows the name of the pack's lockfile. This
covers the case wherein the user runs "git fetch" with an internal
protocol or HTTP protocol v2 (fetch_refs_via_pack() in transport.c sets
lock_pack) and with HTTP protocol v0/v1 (fetch_git() in remote-curl.c
passes "--lock-pack" to "fetch-pack").

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Changes from v1:
 - commit message explains scope of change ("it knows the name of the
   pack's lockfile)
 - explained what .promisor contains in comment in builtin/repack.c
 - moved .promisor writing until after we know that index-pack succeeded
---
 builtin/repack.c         |  7 ++++++
 fetch-pack.c             | 47 ++++++++++++++++++++++++++++++++++++----
 t/t5616-partial-clone.sh |  8 +++++++
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 094c2f8ea4..78b23d7a9a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -233,6 +233,13 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		/*
 		 * pack-objects creates the .pack and .idx files, but not the
 		 * .promisor file. Create the .promisor file, which is empty.
+		 *
+		 * NEEDSWORK: fetch-pack sometimes generates non-empty
+		 * .promisor files containing the ref names and associated
+		 * hashes at the point of generation of the corresponding
+		 * packfile, but this would not preserve their contents. Maybe
+		 * concatenate the contents of all .promisor files instead of
+		 * just creating a new empty file.
 		 */
 		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
 					  line.buf);
diff --git a/fetch-pack.c b/fetch-pack.c
index 947da545de..b9e63b52ff 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -754,8 +754,33 @@ static int sideband_demux(int in, int out, void *data)
 	return ret;
 }
 
+static void write_promisor_file(const char *keep_name,
+				struct ref **sought, int nr_sought)
+{
+	struct strbuf promisor_name = STRBUF_INIT;
+	int suffix_stripped;
+	FILE *output;
+	int i;
+
+	strbuf_addstr(&promisor_name, keep_name);
+	suffix_stripped = strbuf_strip_suffix(&promisor_name, ".keep");
+	if (!suffix_stripped)
+		BUG("name of pack lockfile should end with .keep (was '%s')",
+		    keep_name);
+	strbuf_addstr(&promisor_name, ".promisor");
+
+	output = xfopen(promisor_name.buf, "w");
+	for (i = 0; i < nr_sought; i++)
+		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
+			sought[i]->name);
+	fclose(output);
+
+	strbuf_release(&promisor_name);
+}
+
 static int get_pack(struct fetch_pack_args *args,
-		    int xd[2], char **pack_lockfile)
+		    int xd[2], char **pack_lockfile,
+		    struct ref **sought, int nr_sought)
 {
 	struct async demux;
 	int do_keep = args->keep_pack;
@@ -817,7 +842,13 @@ static int get_pack(struct fetch_pack_args *args,
 		}
 		if (args->check_self_contained_and_connected)
 			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
-		if (args->from_promisor)
+		/*
+		 * If we're obtaining the filename of a lockfile, we'll use
+		 * that filename to write a .promisor file with more
+		 * information below. If not, we need index-pack to do it for
+		 * us.
+		 */
+		if (!(do_keep && pack_lockfile) && args->from_promisor)
 			argv_array_push(&cmd.args, "--promisor");
 	}
 	else {
@@ -871,6 +902,14 @@ static int get_pack(struct fetch_pack_args *args,
 		die(_("%s failed"), cmd_name);
 	if (use_sideband && finish_async(&demux))
 		die(_("error in sideband demultiplexer"));
+
+	/*
+	 * Now that index-pack has succeeded, write the promisor file using the
+	 * obtained .keep filename if necessary
+	 */
+	if (do_keep && pack_lockfile && args->from_promisor)
+		write_promisor_file(*pack_lockfile, sought, nr_sought);
+
 	return 0;
 }
 
@@ -1006,7 +1045,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
 	else
 		alternate_shallow_file = NULL;
-	if (get_pack(args, fd, pack_lockfile))
+	if (get_pack(args, fd, pack_lockfile, sought, nr_sought))
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
@@ -1453,7 +1492,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 			/* get the pack */
 			process_section_header(&reader, "packfile", 0);
-			if (get_pack(args, fd, pack_lockfile))
+			if (get_pack(args, fd, pack_lockfile, sought, nr_sought))
 				die(_("git fetch-pack: fetch failed."));
 
 			state = FETCH_DONE;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 79f7b65f8c..eaa33a852b 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -46,6 +46,14 @@ test_expect_success 'do partial clone 1' '
 	test "$(git -C pc1 config --local remote.origin.partialclonefilter)" = "blob:none"
 '
 
+test_expect_success 'verify that .promisor file contains refs fetched' '
+	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	git -C srv.bare rev-list HEAD >headhash &&
+	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
+	grep "$(cat headhash) refs/heads/master" $(cat promisorlist)
+'
+
 # checkout master to force dynamic object fetch of blobs at HEAD.
 test_expect_success 'verify checkout with dynamic object fetch' '
 	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
-- 
2.23.0.700.g56cf767bdb-goog

