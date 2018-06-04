Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65F71F403
	for <e@80x24.org>; Mon,  4 Jun 2018 17:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeFDRaA (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 13:30:00 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45300 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeFDR3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 13:29:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id a22-v6so3181370pfo.12
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JXs6u9Z398TPeN8Oy+ndJVsMHwM+aA777E7fH3lUFcM=;
        b=E9YE5QgGh3kOGlHbjC9lArDqH2YAY8ihe2W8FO2V6q+FmehSLsFe6dDP0iG5kWYfMP
         bediM7GRIjYw/iADY84KbDZLpkzfEkWmWeu4HFZAU9CdUEQOdPW00dMuNzztovd9Cg9L
         GtqomRNw9GI+QSSc8GQF3swBtH/G9fWejaxE78rl6dQ81Qt0OUDCUrbptrRcMgPgrCgZ
         KNQnEQHTR9gtXesv5h9prwS9JFG7dckTuSORSPrHUPqAjzVn/WMoDj8EjD07nv/kD4sI
         py98h1UF50s0iwB1WZ7MhbAFEw6Qi137YmJWClidPJzL/P6KMlZkzRp7fIkg1y6TSL91
         jnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JXs6u9Z398TPeN8Oy+ndJVsMHwM+aA777E7fH3lUFcM=;
        b=Rd6voEdFG3R5Jnb+fWjvsH7Z/92oODhh/NOVeVjLGQ1MrUyAmYOmC6rtAw/qcIk6t2
         SgNmDMTcBbp4rBzQ+SdFj4kqfLQ+C9kVJKu03tnyVldY0rgf9omIfI7wlR8ErTKHmd5I
         rentx4lWzLHG98jcCL7Qgo+k2HdHlEE468NZStxNtaTdoy1zlq41u6+0fvDv349MEZWR
         v6mBezKP8kdxdW/T6i24cPwOE+bBNfXtCRGbBneJAiv6iFjr9AIKp/IzsLrkyNBjIMP/
         Vswy0e35XKZ15vYvbfhzrBOWBhSYUwnJqF2hB6iNK3wikjkAoYw/r+Uh2Z7eFf6EEiDY
         rfYA==
X-Gm-Message-State: APt69E0JSLAVXRqWi0h4WqxryWvMtc+3YA0S3Y9OzqNfyeV81g5bV7eT
        2gIHrJViC0VUfEF+bRFkgP3fTA3c1f8=
X-Google-Smtp-Source: ADUXVKK8EEQw1px3o8T3myM6purwSErrm2HfOMvCP53xDwm/z/nOk/hZXICuILvEp5a09C2S6Cj5Ww==
X-Received: by 2002:a62:40dc:: with SMTP id f89-v6mr1154032pfd.194.1528133392959;
        Mon, 04 Jun 2018 10:29:52 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x2-v6sm4491994pfn.11.2018.06.04.10.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 10:29:51 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        bmwill@google.com
Subject: [PATCH 5/6] fetch-pack: move common check and marking together
Date:   Mon,  4 Jun 2018 10:29:35 -0700
Message-Id: <02577402adaf0d109f74e59486d8a23f6ae68663.1527894919.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1527894919.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This enables the calculation of was_common and the invocation to
mark_common() to be abstracted into a single call to the negotiator API
(to be introduced in a subsequent patch).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index ec92929bc..54dd3feb8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -499,11 +499,14 @@ static int find_common(struct data *data, struct fetch_pack_args *args,
 				case ACK_continue: {
 					struct commit *commit =
 						lookup_commit(result_oid);
+					int was_common;
 					if (!commit)
 						die(_("invalid commit %s"), oid_to_hex(result_oid));
+					was_common = commit->object.flags & COMMON;
+					mark_common(data, commit, 0, 1);
 					if (args->stateless_rpc
 					 && ack == ACK_common
-					 && !(commit->object.flags & COMMON)) {
+					 && !was_common) {
 						/* We need to replay the have for this object
 						 * on the next RPC request so the peer knows
 						 * it is in common with us.
@@ -520,7 +523,6 @@ static int find_common(struct data *data, struct fetch_pack_args *args,
 					} else if (!args->stateless_rpc
 						   || ack != ACK_common)
 						in_vain = 0;
-					mark_common(data, commit, 0, 1);
 					retval = 0;
 					got_continue = 1;
 					if (ack == ACK_ready)
-- 
2.17.0.768.g1526ddbba1.dirty

