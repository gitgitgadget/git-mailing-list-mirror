Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A3B1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbeLTTxy (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:53:54 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:49430 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLTTxy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:53:54 -0500
Received: by mail-qt1-f202.google.com with SMTP id n95so3021284qte.16
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t+llN14ovbM8tDafXb0eB5r35VIhEBUM4Zb9vySk3zk=;
        b=OH9Qq45vac75TyahfEIug4BKXfRhpdEI+DQpo3N/nK51rvkiwZgnHmgrt9zkw09fnY
         kq44MwLe8kkgbawsuXrbhjYT4MW2/l3E00kqsJTFebfr5/nugwvvToF9q1bf7ejK+37R
         5GhqhfQLKsnPywcqcrHvM+E6xqQhovll9zkfqkKlaO2VVYMhgblrE/iZItaMVNsjesEo
         maWXoQ+fePm0yPiVzPpvxI+IITBVvnobKYKZ8DLKIKY27H4AL+E9gTSSVx+i5IGBAqrN
         EAImtAbx4jAp+m77lke7k3ZlcTztEtkoSSQZc4aOxX/SUt2UDF2KqcOefKdsZAtdYTHa
         9Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t+llN14ovbM8tDafXb0eB5r35VIhEBUM4Zb9vySk3zk=;
        b=nV76SUo9GXwxfcm/X0xW78vorITrTulPs77RTKVZXMcYLT0FEjw5QAU0zn1l2NcQ2m
         167WOMGBweVWB27tmtIgkmH3CuiWS2omXzRs9fjrLfSIFDA2KsPGHqv6Xi2pWAfxpMKS
         5NBI8vQN2YvlGOwkRlQEfqMptxFtl3WcRTpOiccUAKE10oZwXVrfNkmZy0O1feBcuFrm
         DPtqPfZ8hjT35xgUUOn3xYIkvlo6YgpHFjUWnGBThaC4Is7ewkmVUR8X3oeydSSQNo1T
         JzACQNz1Ud+e5nJL+TaKqEVweu+v5TbhcPvH23uTykloopJBqVSOyQU24DBOK0R5Ji4d
         6nIw==
X-Gm-Message-State: AA+aEWamEd3bo//OW+pi7HCjWsQxB81VIFSYSpjpZfICIuW7fzXDYgJz
        mBF5BH5vsS6Q7bVkHq0r2OZ5DpIIqH2+KzjQEKdbntOyFQ0PD2UFFYhq4p6bFhSP1mGpGW/Zthd
        N/jeFXzuEi9LwzyR269LEBAOLGY68+WnChtrL2D8GTo3AuF1DtzLmFX+/Ho+2HObMGVfOxgc9UA
        4D
X-Google-Smtp-Source: AFSGD/WjlLBAdm0iY+022giTZsfvX7MPNZz7Qw9xZ3ZZZtL+7b3HqJzkicr4W0wuUmHByQDm2/3wdNbJXTYShkKi5d2v
X-Received: by 2002:a0c:b58d:: with SMTP id g13mr24047743qve.1.1545335633145;
 Thu, 20 Dec 2018 11:53:53 -0800 (PST)
Date:   Thu, 20 Dec 2018 11:53:49 -0800
In-Reply-To: <20181218010811.143608-1-jonathantanmy@google.com>
Message-Id: <20181220195349.92214-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181218010811.143608-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [RFC PATCH] fetch-pack: respect --no-update-shallow in v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While investigating t5537's failure revealed by Aevar's
GIT_TEST_PROTOCOL_VERSION patches [1], I found an answer to my confusion
that I described in [2]. Quoting the relevant part:

> I'm also not sure why this issue only occurs with protocol v2. It's true
> that, when using protocol v0, the server can communicate shallow
> information both before and after "want"s are received, and if shallow
> communication is only communicated before, the client will invoke
> setup_temporary_shallow() instead of setup_alternate_shallow(). (In
> protocol v2, shallow information is always communicated after "want"s,
> thus demonstrating the issue.) But even in protocol v0, writes to the
> shallow file go through setup_alternate_shallow() anyway (in
> update_shallow()), so I would think that the issue would occur, but it
> doesn't.

It turns out that update_shallow() doesn't write pre-"want" shallow
information unless --update-shallow is set. But post-"want" shallow
information is always written regardless of --update-shallow. (So maybe
--update-shallow is not the best name for it, but that is another
issue.)

Which raises the question: in protocol v2, all shallow information is
post-"want", so how should we handle this? My current inclination is to
treat them like v0 pre-"want" information if no depth-like argument is
given by the user (that is, args->deepen is 0), and like v0 post-"want"
information otherwise. (Right now, it is treated always like the
latter.) This patch does it by delaying initialization of the struct
shallow_info until we fully know what's going on, and not only fixes the
bug revealed by t5537, but the bug that [2] fixes as well (eliminating
the need for [2]).

This does mean that there will be some difference in functionality
between v0 and v2: if fetching from a shallow repository with our own
depth arguments, v0 would write shallows resulting from our own depth
arguments but not those that are there because the remote is shallow; v2
would write all shallows. But this is the best solution I can think of
so far.

Any thoughts? The code can be written more clearly but I wanted to
discuss the design first.

[1] https://public-inbox.org/git/20181213155817.27666-1-avarab@gmail.com/
[2] https://public-inbox.org/git/20181218010811.143608-1-jonathantanmy@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c           | 34 ++++++++++++++++++++++++++--------
 t/t5702-protocol-v2.sh | 16 ++++++++++++++++
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 9691046e64..0a89a210b0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1265,8 +1265,11 @@ static int process_acks(struct fetch_negotiator *negotiator,
 }
 
 static void receive_shallow_info(struct fetch_pack_args *args,
-				 struct packet_reader *reader)
+				 struct packet_reader *reader,
+				 struct shallow_info *si)
 {
+	struct oid_array shallows = OID_ARRAY_INIT;
+
 	process_section_header(reader, "shallow-info", 0);
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		const char *arg;
@@ -1275,7 +1278,9 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		if (skip_prefix(reader->line, "shallow ", &arg)) {
 			if (get_oid_hex(arg, &oid))
 				die(_("invalid shallow line: %s"), reader->line);
-			register_shallow(the_repository, &oid);
+			if (args->deepen)
+				register_shallow(the_repository, &oid);
+			oid_array_append(&shallows, &oid);
 			continue;
 		}
 		if (skip_prefix(reader->line, "unshallow ", &arg)) {
@@ -1297,8 +1302,17 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 	    reader->status != PACKET_READ_DELIM)
 		die(_("error processing shallow info: %d"), reader->status);
 
-	setup_alternate_shallow(&shallow_lock, &alternate_shallow_file, NULL);
-	args->deepen = 1;
+	if (args->deepen) {
+		prepare_shallow_info(si, NULL);
+		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
+					NULL);
+	} else {
+		prepare_shallow_info(si, &shallows);
+		if (si->nr_ours || si->nr_theirs)
+			alternate_shallow_file = setup_temporary_shallow(si->shallow);
+		else
+			alternate_shallow_file = NULL;
+	}
 }
 
 static void receive_wanted_refs(struct packet_reader *reader,
@@ -1340,6 +1354,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    int fd[2],
 				    const struct ref *orig_ref,
 				    struct ref **sought, int nr_sought,
+				    struct shallow_info *si,
 				    char **pack_lockfile)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
@@ -1407,7 +1422,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		case FETCH_GET_PACK:
 			/* Check for shallow-info section */
 			if (process_section_header(&reader, "shallow-info", 1))
-				receive_shallow_info(args, &reader);
+				receive_shallow_info(args, &reader, si);
+			else
+				prepare_shallow_info(si, NULL);
 
 			if (process_section_header(&reader, "wanted-refs", 1))
 				receive_wanted_refs(&reader, sought, nr_sought);
@@ -1641,13 +1658,14 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		packet_flush(fd[1]);
 		die(_("no matching remote head"));
 	}
-	prepare_shallow_info(&si, shallow);
 	if (version == protocol_v2)
 		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
-					   pack_lockfile);
-	else
+					   &si, pack_lockfile);
+	else {
+		prepare_shallow_info(&si, shallow);
 		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 					&si, pack_lockfile);
+	}
 	reprepare_packed_git(the_repository);
 
 	if (!args->cloning && args->deepen) {
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f2b09ebb8..390a71399d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -471,6 +471,22 @@ test_expect_success 'upload-pack respects client shallows' '
 	grep "fetch< version 2" trace
 '
 
+test_expect_success '2 fetches in one process updating shallow' '
+	rm -rf server client trace &&
+
+	test_create_repo server &&
+	test_commit -C server one &&
+	test_commit -C server two &&
+	test_commit -C server three &&
+	git clone --shallow-exclude two "file://$(pwd)/server" client &&
+
+	# Triggers tag following (thus, 2 fetches in one process)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		fetch --shallow-exclude one origin &&
+	# Ensure that protocol v2 is used
+	grep "fetch< version 2" trace
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 
2.19.0.271.gfe8321ec05.dirty

