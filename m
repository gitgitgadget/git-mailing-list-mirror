Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A2E1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 22:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965038AbeFNWyg (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 18:54:36 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:55660 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964987AbeFNWyf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 18:54:35 -0400
Received: by mail-yb0-f202.google.com with SMTP id h29-v6so5414755ybj.22
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=s7yXA9aUowxlXYYDSyW/TG4mDCMWvTkNiF/5NiZ5MPQ=;
        b=jc0ahn7deqeMDRAJOew8F0AwumTcLl6nxSsWBMOPWVg2hAmV6wR90waBr18Q0KPYOY
         mK0hdCkPaYqL0wA4STs1i0J3ZHrjD893qpj984BA5qRZsrVoMQ5kAQ2hKuEE5+JnwcA4
         WuqG0TXxBSPA/VFMkIkK0OjOA93TH7StKI66juctLWhmKXQ6+rbYxpiNc3wvv6P19ExY
         fYCtOSCjB8A6UQAQeh6obIG+41BiNm8x015Bu0bnNGNl2odpLg5RhwwqHbChcrMvMfkw
         jVUZrLzHA1pR8KWHOr0GzHXLaENM5X+DAJNIiMFY9N7E+qEJuqeTknuzIcbMuX2AJcwi
         fMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=s7yXA9aUowxlXYYDSyW/TG4mDCMWvTkNiF/5NiZ5MPQ=;
        b=G2xz5rrXT/GP5nPQQ+M6nu24McGlsKelAS75s9eXl7wWwrwol1lEIyHwYSSEhsmX9C
         XJBwUwzjZH3v7TiXNnlfQO9VKAvk9pfaQMBLvn3HAfa2usSw1PsXeHHqh22XRa1suiY0
         BImXCW/a3PPPTNVwATSyTFFi9ILyVIIX3T80BOwFjHZLx5vo+LsbKMoe5jBInj9wxONr
         UWLz4jK87n25glui2lwr6ShgJtau6vVuqqAitbUAoYdBqH1U/HudASRrkAXxfUdtbLTX
         ov7pAm5N0yZA+puEzoY8xueE6HM3HgqsgXpv82pRHk7ar6LI20SRS8IBSYWbbuVVERAe
         H5Hg==
X-Gm-Message-State: APt69E1sKZ/t4M4u2apjpAreQveox29zMtElIZ4nZg9UEAX7qI3angoi
        aMuX2XwOZndp/LdBHBtcLqOZUjeeoidTl5uO/XPffwoJoTNLf8EehIR2QuDOesqO7UoCet25fMc
        /dySQf+yuFaoEiU3qo5gOmvFgkTUH/ksvK6cvYrvc0cmLun2ETb9ZQngUbjP9JAMKoEwevSSEWM
        SB
X-Google-Smtp-Source: ADUXVKIUiLYEvP5bqUo28MszXSwe4qI2/PiA4O8fyNiqHgdGudiUMt9HhuyY7uF4eyY6H+PF1cKKM0phXI1bnqpSV4zu
MIME-Version: 1.0
X-Received: by 2002:a81:4d06:: with SMTP id a6-v6mr1394793ywb.75.1529016874286;
 Thu, 14 Jun 2018 15:54:34 -0700 (PDT)
Date:   Thu, 14 Jun 2018 15:54:22 -0700
In-Reply-To: <cover.1529016350.git.jonathantanmy@google.com>
Message-Id: <5687c0b22bf3b2bdbbe29b09788cc305a89710fc.1529016350.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1529016350.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4
Subject: [PATCH v3 1/7] fetch-pack: split up everything_local()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function everything_local(), despite its name, also (1) marks
commits as COMPLETE and COMMON_REF and (2) invokes filter_refs() as
important side effects. Extract (1) into its own function
(mark_complete_and_common_ref()) and remove
(2).

The restoring of save_commit_buffer, which was introduced in a1c6d7c1a7
("fetch-pack: restore save_commit_buffer after use", 2017-12-08), is a
concern of the parse_object() call in mark_complete_and_common_ref(), so
it has been moved from the end of everything_local() to the end of
mark_complete_and_common_ref().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a320ce987..5c87bb8bb 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -734,12 +734,20 @@ static int add_loose_objects_to_set(const struct object_id *oid,
 	return 0;
 }
 
-static int everything_local(struct fetch_pack_args *args,
-			    struct ref **refs,
-			    struct ref **sought, int nr_sought)
+/*
+ * Mark recent commits available locally and reachable from a local ref as
+ * COMPLETE. If args->no_dependents is false, also mark COMPLETE remote refs as
+ * COMMON_REF (otherwise, we are not planning to participate in negotiation, and
+ * thus do not need COMMON_REF marks).
+ *
+ * The cutoff time for recency is determined by this heuristic: it is the
+ * earliest commit time of the objects in refs that are commits and that we know
+ * the commit time of.
+ */
+static void mark_complete_and_common_ref(struct fetch_pack_args *args,
+					 struct ref **refs)
 {
 	struct ref *ref;
-	int retval;
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
 	struct oidset loose_oid_set = OIDSET_INIT;
@@ -812,7 +820,18 @@ static int everything_local(struct fetch_pack_args *args,
 		}
 	}
 
-	filter_refs(args, refs, sought, nr_sought);
+	save_commit_buffer = old_save_commit_buffer;
+}
+
+/*
+ * Returns 1 if every object pointed to by the given remote refs is available
+ * locally and reachable from a local ref, and 0 otherwise.
+ */
+static int everything_local(struct fetch_pack_args *args,
+			    struct ref **refs)
+{
+	struct ref *ref;
+	int retval;
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const struct object_id *remote = &ref->old_oid;
@@ -829,8 +848,6 @@ static int everything_local(struct fetch_pack_args *args,
 			      ref->name);
 	}
 
-	save_commit_buffer = old_save_commit_buffer;
-
 	return retval;
 }
 
@@ -1053,7 +1070,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
 
-	if (everything_local(args, &ref, sought, nr_sought)) {
+	mark_complete_and_common_ref(args, &ref);
+	filter_refs(args, &ref, sought, nr_sought);
+	if (everything_local(args, &ref)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
@@ -1377,7 +1396,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			for_each_cached_alternate(insert_one_alternate_object);
 
 			/* Filter 'ref' by 'sought' and those that aren't local */
-			if (everything_local(args, &ref, sought, nr_sought))
+			mark_complete_and_common_ref(args, &ref);
+			filter_refs(args, &ref, sought, nr_sought);
+			if (everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
-- 
2.17.0.582.gccdcbd54c4

