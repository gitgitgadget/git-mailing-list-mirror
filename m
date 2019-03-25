Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FD320248
	for <e@80x24.org>; Mon, 25 Mar 2019 20:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfCYUng (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 16:43:36 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:43382 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfCYUng (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 16:43:36 -0400
Received: by mail-yw1-f73.google.com with SMTP id r8so15693934ywh.10
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X2CKljOSxegj7v86sgBh2zIn4ktZLszsvZFiC+Yl6Os=;
        b=l7TNOpyOFh63/wfUp+QUldSQV10RM/i5c0fI7vljcfR2Op0PiHgxMa6Ul3eaEoAJlw
         +5zbQvViytcZyOd6y1iJT/QSrwtLN3huap66S2O/nmWbbW5L6b7WPLSzNi+0gJWzdvq/
         /42XJPeE3t94dWY4VuLc/WvXqMu1GlH2LXnpd8Q0cG/AvNZqebN3XtEYFK6K4+aknYZJ
         62Gn9oCilgljXBt5pa678b+4Jca8kfum2805wPGopgABlffKSEUB5SrRSwm/wX8eFILJ
         Esmoe5+RJEOQ1uMzc2dOpT5rXGpgi1IwW/FyO9dJUh6o+cCP+ZYFEAJDfDoPFBDEbKlI
         9gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X2CKljOSxegj7v86sgBh2zIn4ktZLszsvZFiC+Yl6Os=;
        b=hyyQERa06jnNmcensaqlvVbC6R33YphTjtsOlo5nV48LO0YRGhe6p41XSb8PLyDDC5
         53+v2FLfUiKK8ZZTEtxh6SbRhcVrWqSjEFxg+nU1zO7GHx+un+hl1FsOHuNvYGMCr2Et
         pNpqOsKF8mAkFqvteXkVbkIRyQue5ag99BWTUyi1fnxrFCDzU6U/9rUYhhMOB8aNnyQt
         a5N5wiP3Gev/Gqb3LQNR34yPTKC/iyRgJKMxo+QBJVvr30FFKQsBrbuT9UZ5dWJ7tC16
         DfsKvbNcd98r1R9j1Y/KCyJXQVEVz2f0tyOCdofMqycC2xI5Pij0hCh8DXPR5TqGXFor
         /Qgg==
X-Gm-Message-State: APjAAAVz0BsySVJx0NnLiJBJXRMr112zD4VuAiI2aF97fUhattcgLy50
        KM6Q5H1oLUZhNF9fEirztAsLtzcgWNub3+Oy4zT+esWwa7RpBNqbbTe0rl6ykpsHkvtrEE7L+iR
        aAZAyabrchTRJ4mcXGAtuJtG9o28ggDm9+JoFHjl1x/PymMY+y0wkTzG/JstuoatlHq2apCIWUj
        qH
X-Google-Smtp-Source: APXvYqwlt4rdPzexQ3e8ap5jkwaGXeamWNo+r+YpWptsWbqv/U16ofD4RB0U5/4itgYMDkHYm8/SqMJiA89/Hy6eHleE
X-Received: by 2002:a81:56d7:: with SMTP id k206mr3852092ywb.305.1553546615245;
 Mon, 25 Mar 2019 13:43:35 -0700 (PDT)
Date:   Mon, 25 Mar 2019 13:43:23 -0700
In-Reply-To: <cover.1553546216.git.jonathantanmy@google.com>
Message-Id: <c4d2f409e246cce02ebfdb8c7110e3700d066ec8.1553546216.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1553546216.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH 2/2] fetch-pack: respect --no-update-shallow in v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In protocol v0, when sending "shallow" lines, the server distinguishes
between lines caused by the remote repo being shallow and lines caused
by client-specified depth settings. Unless "--update-shallow" is
specified, there is a difference in behavior: refs that reach the former
"shallow" lines, but not the latter, are rejected. But in v2, the server
does not, and the client treats all "shallow" lines like lines caused by
client-specified depth settings.

Full restoration of v0 functionality is not possible without protocol
change, but we can implement a heuristic: if we specify any depth
setting, treat all "shallow" lines like lines caused by client-specified
depth settings (that is, unaffected by "--no-update-shallow"), but
otherwise, treat them like lines caused by the remote repo being shallow
(that is, affected by "--no-update-shallow"). This restores most of v0
behavior, except in the case where a client fetches from a shallow
repository with depth settings.

This patch causes a test that previously failed with
GIT_TEST_PROTOCOL_VERSION=2 to pass.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a0eb268dfc..672c79c91a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1253,9 +1253,13 @@ static int process_acks(struct fetch_negotiator *negotiator,
 }
 
 static void receive_shallow_info(struct fetch_pack_args *args,
-				 struct packet_reader *reader)
+				 struct packet_reader *reader,
+				 struct shallow_info *si)
 {
-	int line_received = 0;
+	struct oid_array *shallows;
+	int unshallow_received = 0;
+
+	shallows = xcalloc(1, sizeof(*shallows));
 
 	process_section_header(reader, "shallow-info", 0);
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
@@ -1265,8 +1269,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		if (skip_prefix(reader->line, "shallow ", &arg)) {
 			if (get_oid_hex(arg, &oid))
 				die(_("invalid shallow line: %s"), reader->line);
-			register_shallow(the_repository, &oid);
-			line_received = 1;
+			oid_array_append(shallows, &oid);
 			continue;
 		}
 		if (skip_prefix(reader->line, "unshallow ", &arg)) {
@@ -1279,7 +1282,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 				die(_("error in object: %s"), reader->line);
 			if (unregister_shallow(&oid))
 				die(_("no shallow found: %s"), reader->line);
-			line_received = 1;
+			unshallow_received = 1;
 			continue;
 		}
 		die(_("expected shallow/unshallow, got %s"), reader->line);
@@ -1289,11 +1292,35 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 	    reader->status != PACKET_READ_DELIM)
 		die(_("error processing shallow info: %d"), reader->status);
 
-	if (line_received) {
+	if (args->deepen || unshallow_received) {
+		/*
+		 * Treat these as shallow lines caused by our depth settings.
+		 * In v0, these lines cannot cause refs to be rejected; do the
+		 * same.
+		 */
+		int i;
+
+		for (i = 0; i < shallows->nr; i++)
+			register_shallow(the_repository, &shallows->oid[i]);
+		oid_array_clear(shallows);
+		free(shallows);
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
 		args->deepen = 1;
+	} else if (shallows->nr) {
+		/*
+		 * Treat these as shallow lines caused by the remote being
+		 * shallow. In v0, remote refs that reach these objects are
+		 * rejected (unless --update-shallow is set); do the same.
+		 */
+		prepare_shallow_info(si, shallows);
+		if (si->nr_ours || si->nr_theirs)
+			alternate_shallow_file =
+				setup_temporary_shallow(si->shallow);
+		else
+			alternate_shallow_file = NULL;
 	} else {
+		free(shallows);
 		alternate_shallow_file = NULL;
 	}
 }
@@ -1337,6 +1364,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    int fd[2],
 				    const struct ref *orig_ref,
 				    struct ref **sought, int nr_sought,
+				    struct shallow_info *si,
 				    char **pack_lockfile)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
@@ -1411,7 +1439,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		case FETCH_GET_PACK:
 			/* Check for shallow-info section */
 			if (process_section_header(&reader, "shallow-info", 1))
-				receive_shallow_info(args, &reader);
+				receive_shallow_info(args, &reader, si);
 
 			if (process_section_header(&reader, "wanted-refs", 1))
 				receive_wanted_refs(&reader, sought, nr_sought);
@@ -1653,7 +1681,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 			BUG("Protocol V2 does not provide shallows at this point in the fetch");
 		memset(&si, 0, sizeof(si));
 		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
-					   pack_lockfile);
+					   &si, pack_lockfile);
 	} else {
 		prepare_shallow_info(&si, shallow);
 		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
-- 
2.21.0.155.ge902e9bcae.dirty

