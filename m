Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5BDF1FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 00:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932156AbdBHABi (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 19:01:38 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33192 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754240AbdBHABh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 19:01:37 -0500
Received: by mail-pf0-f177.google.com with SMTP id y143so36883614pfb.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 16:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w9v4MHM+tNtLgZJib8c7G1qJKCqaMnOWshuswRZiS7c=;
        b=ZGtxB4+6A8CJRpSosMsEC39IBfv5ApRrldjtwWTweJLp4Wi4EUYWgzYDkZUIVgIr/+
         iz0xeMMa1gCU7Rj5xzoa0Hgx7lRC3vn2NJY3L7TkmKbZZYriIS9+HWxotoHfR2rDyfPO
         sipZxufE4qb0AhZ/B2FeXl8djG0+DqrONgl4mPGMLNd8NVefpxKkWaLTEmT4epD9td70
         kAtKAuBUv6ws7iIgMUELg5USY7/IGGUxdLxRtENUHqLcTIJ5Eb1QBh3Z7MbAzMNXDH1a
         YupVTP1wRAl7RGuU2cfX2yCLRXvlZ6fbmcBbxLxRQ7eQULUopwWrg3yTrtOJ7JlyEKEY
         0Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w9v4MHM+tNtLgZJib8c7G1qJKCqaMnOWshuswRZiS7c=;
        b=Ai2h77TgUdqax9ys3+uytWNqh2y4PSOnI8FJsVPskfbZPVkJlGOl7NYmCCj80x0Kgv
         SZ44Gl9SE6MRq/F4AxwgSMDSRosiNw+aQwGCB/qIO2ZHr6hSLlaH2blVCzq3KyL84wZq
         nBwAcC8sM0QHTfiLJWahPdJSglq1pMnD9+DZ7vPOXvhYSRy6iCuNkk+E0xYclk2u80Bx
         f9C0QGJfgyfKMW0Sfv4+wd3LuErvjCLT/qDUGQTzkm/jitRMXvBEdEFAsAuPca0SNMb+
         W8E5Pr8MY8LpNsWca6wAlj9VLNXtSY+B+F4xehOnb+kzRLvW01F+6QLyt4eBEevY2MnM
         l5KQ==
X-Gm-Message-State: AIkVDXJjz4oeTRbL5HwIKNj965JTPnXsuM3sLQDXdO7eJAq44RgUDf+Vgq3/OI6a69us0LDd
X-Received: by 10.99.95.16 with SMTP id t16mr23501543pgb.212.1486511667792;
        Tue, 07 Feb 2017 15:54:27 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id 66sm14199771pgg.47.2017.02.07.15.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 15:54:26 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: Re: [RFC 00/14] Allow fetch-pack to send ref names (globs allowed)
Date:   Tue,  7 Feb 2017 15:53:50 -0800
Message-Id: <20170207235350.10718-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looking back at the comments I have received in reply, I think that
there were two major concerns: (i) the case where a server ACKs a client
"have" line and the client forever thinks that the server has it, but it
may not be the case for future servers (or future invocations of the
same server), and (ii) what the client does with 2 "versions" of remote
refs.

For (i), the issue already exists and as far as I can tell, this patch
set does not directly impact it, positively or negatively. The
"have"/"ACK" part of negotiation is kept the same - the only difference
in this patch set is that wants can be specified by name instead of by
SHA-1 hash. This patch set does not help the "have"/"ACK" part of
negotiation, but it helps the "want" part.

For (ii), I have prepared a patch to be squashed, and extended the
commit message with an explanation of what is happening. (The commit
message and the patch are appended to this e-mail).

(There was also some discussion of the client being required to send
exact matches in its "want-ref" lines.)

Please let me know if you have any other opinions or thoughts. It does
seem to me like such a protocol update (or something similar) would help
for large repositories with many ever-changing refs (like refs/changes
in Gerrit or refs/pull in GitHub) - and the creation of a ref would look
like a deletion depending on the order in which we access the servers in
a load-balancing arrangement and the order in which those servers
synchronize themselves. And deletion of refs does not work with the
current protocol, but would work with a protocol that supports wildcards
(like this one).

-- 8< --

fetch: send want-ref and receive fetched refs

Teach fetch to send refspecs to the underlying transport, and teach all
components used by the HTTP transport (remote-curl, transport-helper,
fetch-pack) to understand and propagate the names and SHA-1s of the refs
fetched.

The do_fetch method in builtin/fetch.c originally had only one
remote-local ref map, generated from the already-fetched list of remote
refs. This patch introduces a new ref map generated from the list of
fetched refs. Usages of the list of remote refs or the remote-local ref
map are updated as follows:
 - check_not_current_branch (which checks that the current branch is not
   affected by the fetch) is performed both on the original ref map (to
   die before the fetch if we can, as an optimization) and on the new
   ref map (since the new ref map is the one actually applied).
 - Pruning is done based on the new ref map.
 - backfill_tags (for tag following) is performed using the original
   list of remote refs because the new list of fetched refs is not
   guaranteed to contain tag information. (Since backfill_tags performs
   another fetch, it does not need to be fully consistent with the
   just-returned packfile.)
The list of remote refs and the remote-local ref map are not otherwise
used by do_fetch or any function in its invocation chain (fetch_one and
cmd_fetch).
---
 builtin/fetch.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 87de00e49..b8432394c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1177,6 +1177,20 @@ static int do_fetch(struct transport *transport,
 
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
+	if (fetch_refs(transport, e_rs, e_rs_nr, ref_map, &new_remote_refs)) {
+		free_refs(ref_map);
+		retcode = 1;
+		goto cleanup;
+	}
+	if (new_remote_refs) {
+		free_refs(ref_map);
+		ref_map = get_ref_map(transport->remote, new_remote_refs,
+				      refs, ref_count, tags, autotags);
+		if (!update_head_ok)
+			check_not_current_branch(ref_map);
+		free_refs(new_remote_refs);
+	}
+
 	if (prune) {
 		/*
 		 * We only prune based on refspecs specified
@@ -1192,18 +1206,6 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-	if (fetch_refs(transport, e_rs, e_rs_nr, ref_map, &new_remote_refs)) {
-		free_refs(ref_map);
-		retcode = 1;
-		goto cleanup;
-	}
-	if (new_remote_refs) {
-		free_refs(ref_map);
-		ref_map = get_ref_map(transport->remote, new_remote_refs,
-				      refs, ref_count, tags, autotags);
-		free_refs(new_remote_refs);
-	}
-
 	if (consume_refs(transport, ref_map)) {
 		free_refs(ref_map);
 		retcode = 1;
-- 
2.11.0.483.g087da7b7c-goog

