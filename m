Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B29C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 13:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbjDZNPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 09:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbjDZNPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 09:15:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13F0170D
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 06:15:13 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso5619912b3a.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 06:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682514913; x=1685106913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywDYLIK8FfV298Ci3hKkrEUQuaXxHjTQ/G524Ogy8zk=;
        b=lHpgihkCEXm8WKKqgGjva1TzFjXY2r/tRR5C8lZUxDgxlF1ouhYF+6UcUYwChF37Lk
         EeX3XPtowLwwgd5QAL9sMMRT1Z5FxomLdqX0zXsgoQZXMElZp4F2rnrh4r8j3LyITvlE
         qoBRABZ0uqVcHCrVUSov4Xe4d4Kqp7s5OVcV4NtvEADLgJN1Of1a9uMUUQ+FU8H8NfDl
         osEL9CITjNYRKlgjtdZFmfCGcVMdVMut3Ju6VnOACvyTC6O2DuwdYI0VPqhndPMaax3t
         DGJL48eJZLPXP4bSKoRakMpTXR7syKYSCTjyUUAnaP+ooCcD9EslWNO0hB/ol0vVizjm
         tpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682514913; x=1685106913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywDYLIK8FfV298Ci3hKkrEUQuaXxHjTQ/G524Ogy8zk=;
        b=Mt0RSfehTatvI8xqmV+S3VT/Jrl7t0RnzDDxr8qrJawb7tCNqlU2SbB70qVNiPTTQB
         7ApHDevGJ7uYd4WK17a3qDXvc+3IMKgntwtZCUK1ZCbqZ72ZLtZYpkaQz8gebJwVXMzN
         bFjHj2X28IGOddcLqvZjTpRea2fcx9VwEHb9sO31G1g7Seog3/oDVo6COGuVRaZ/nP4Y
         HQP53VUgDG9D7DjKpheq3oK19EKgsVhsLA/tAYhGVtZ3u3OTbHl5IDD4a/3MGTSCDBKs
         HenqR7Qc9wD38D+gWIz4Ra0QhWD+sy+LAlNCuKWdE9s0KSVIpWo0fPXwZJ+RYqoJ9VzZ
         g/QA==
X-Gm-Message-State: AAQBX9cQUrMh3l8FWbPHnrbkJnHAy7PxAjDoi1SEZnHn7IGmgx+GOu0+
        TDph0L5IK6c28ez7QkfTNF/5H/32dwEdRUIriYw=
X-Google-Smtp-Source: AKy350ZuFz1w4xFwm9Iz7/Enq+OR8AyvZXZi4kqBz2pctaUmZKFXdEeGLYGfHrQO+Q98M6c/sPha9Q==
X-Received: by 2002:a05:6a20:4394:b0:f0:2501:349b with SMTP id i20-20020a056a20439400b000f02501349bmr24382470pzl.25.1682514913249;
        Wed, 26 Apr 2023 06:15:13 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id m9-20020a629409000000b00639eae8816asm11173693pfe.130.2023.04.26.06.15.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Apr 2023 06:15:12 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     git@vger.kernel.org
Cc:     Han Xin <hanxin.hx@bytedance.com>, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] negotiator/default: avoid stack overflow
Date:   Wed, 26 Apr 2023 21:15:02 +0800
Message-Id: <cover.1682513384.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682473718.git.hanxin.hx@bytedance.com>
References: <cover.1682473718.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series avoid stack overflow in negotiator/default.c and memory leak
in negotiator/skipping.c.

Changes since v2:
* Rewrite the commit link in the typical format.
* Fix the incorrect check for the COMMON bit introduced in v2.

Han Xin (2):
  negotiator/default: avoid stack overflow
  negotiator/skipping: fix some problems in mark_common()

 negotiator/default.c  | 39 +++++++++++++++++++++++++++++----------
 negotiator/skipping.c | 22 +++++++++++++++-------
 2 files changed, 44 insertions(+), 17 deletions(-)

Range-diff against v2:
1:  935be72eb9 ! 1:  0e69d70805 negotiator/default: avoid stack overflow
    @@ Commit message
         recursive function calls. Avoid this by instead recursing using a
         heap-allocated data structure.
     
    -    This is the same case as [1].
    -
    -    1. 4654134976f (negotiator/skipping: avoid stack overflow, 2022-10-25)
    +    This is the same case as 4654134976f (negotiator/skipping: avoid
    +    stack overflow, 2022-10-25)
     
         Reported-by: Xin Xing <xingxin.xx@bytedance.com>
         Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
2:  abbb1bc0b3 ! 2:  8b5c92a4d5 negotiator/skipping: fix some problems in mark_common()
    @@ Metadata
      ## Commit message ##
         negotiator/skipping: fix some problems in mark_common()
     
    -    Fixed the following problems:
    +    The mark_common() method in negotiator/skipping.c was converted
    +    from recursive to iterative in 4654134976f (negotiator/skipping:
    +    avoid stack overflow, 2022-10-25), but there is some more work
    +    to do:
     
         1. prio_queue() should be used with clear_prio_queue(), otherwise there
            will be a memory leak.
    @@ negotiator/skipping.c: static int clear_marks(const char *refname, const struct
       */
      static void mark_common(struct data *data, struct commit *seen_commit)
      {
    -@@ negotiator/skipping.c: static void mark_common(struct data *data, struct commit *seen_commit)
    + 	struct prio_queue queue = { NULL };
    + 	struct commit *c;
    + 
    ++	if (seen_commit->object.flags & COMMON)
    ++		return;
    ++
    + 	prio_queue_put(&queue, seen_commit);
    ++	seen_commit->object.flags |= COMMON;
      	while ((c = prio_queue_get(&queue))) {
      		struct commit_list *p;
    - 		if (c->object.flags & COMMON)
    +-		if (c->object.flags & COMMON)
     -			return;
    -+			continue;
    - 		c->object.flags |= COMMON;
    +-		c->object.flags |= COMMON;
    ++
      		if (!(c->object.flags & POPPED))
      			data->non_common_revs--;
      
    @@ negotiator/skipping.c: static void mark_common(struct data *data, struct commit
     +			continue;
      		for (p = c->parents; p; p = p->next) {
     -			if (p->item->object.flags & SEEN)
    -+			if (p->item->object.flags & SEEN || p->item->object.flags & COMMON)
    - 				prio_queue_put(&queue, p->item);
    +-				prio_queue_put(&queue, p->item);
    ++			if (!(p->item->object.flags & SEEN) ||
    ++			    (p->item->object.flags & COMMON))
    ++				continue;
    ++
    ++			p->item->object.flags |= COMMON;
    ++			prio_queue_put(&queue, p->item);
      		}
      	}
     +
-- 
2.40.0

