Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB85BC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5053F207C4
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvKakglR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgI1Xnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgI1Xno (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 19:43:44 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2881C061787
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 15:26:43 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e13so1577935pgk.6
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=T5J0dVRK7NQ5m+JnT8Lg3lrrJwBZODdkmxJa147M3xw=;
        b=TvKakglRzmEgI10PIpaE795MtBeHK3Mtz7+QKB8VWteO/AmERM4o7YD/ri08i4aS/+
         jUg9/wlYFOUei6IKSi13k/LZK8dJh09tDl40YyPwQlQxqa2RKN+1BpAb6MYo3s6rRHiu
         Yj79FlWuVli1T3txLVeCjmGmBnUjiqta75oPWSMVvdJsiwZACiY+ooxYnjon3YPAbBcR
         7PDPxs2dQc6y9f/Y8uJ1KRp6xvxK1uScSITAfBhOKq/xMNif3Y9/wbe8iYrZZTaIkVVw
         1eGOs6o0gUwtJSTzj8EKUauEmiI2+MuNFaAcodB7lcgeajO1U9F2LKzQAMOwQC45GlrA
         CE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T5J0dVRK7NQ5m+JnT8Lg3lrrJwBZODdkmxJa147M3xw=;
        b=ZtyrTFtgYlgK/IGXhpp7HBjkmDuLfvDyVtaa7muNF2naT5m7Qs5XPFGO8e6jn8gPH8
         w+vDoAG9gYgh0eKQrB3N3ZpYYePDASzwrf5v3O6v8F2kVuVzpBiH3JYPirUn1TomnI+s
         gJtEazPpbZZCQtltjA53LhXzRKaBjbLLtQEm9fYPSjKq+TgEX16V1H+dooEHMtRjKBVq
         irg+5V5nMClcIruz6i4WWhVZbcljdgCZ3wmkQh5E6DFhNnW1rHsU1jKDbP3vwZhhrL8H
         n/Oyse3ZxFNei5JFSN3b7K8JJFLZ4Ldv4IRrQM1aiSeKXPVqT/3ms0b20P43e88Uofrp
         rpqw==
X-Gm-Message-State: AOAM530YK2++NMAjSRnGIC8zzNLmg5gPCYSxnozLtyugQ63bOA56+4+c
        n4orjvVhF168/6EN+yiTYyMQqcrjzo3XgN2U9wzdocOLha6MuH6tF/rd0E4GQNKYEYRT5YYSVk5
        xxxlgJVaOT1Mmrr5OItQklKnkYAdDqechvoqDcwDWlDOM8pChdoTU6umzIx/5HaieyE2ehu3vNu
        50
X-Google-Smtp-Source: ABdhPJxSGF4t7LvPIImz8oLPUky7uZaOxAdV+0M0Ziv6IORJP8z+FfyzZB7+3LW7u+JPn2KZPOvBSQqBsqMu324QdbWa
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:940c:: with SMTP id
 r12mr46361pjo.1.1601332002769; Mon, 28 Sep 2020 15:26:42 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:26:37 -0700
In-Reply-To: <cover.1601331788.git.jonathantanmy@google.com>
Message-Id: <625e7f148e46c7e09f817ce6ab25f14d4e753f1e.1601331788.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1600743698.git.jonathantanmy@google.com> <cover.1601331788.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v2 1/2] promisor-remote: remove unused variable
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable core_partial_clone_filter_default has been unused since
fa3d1b63e8 ("promisor-remote: parse remote.*.partialclonefilter",
2019-06-25), when Git was changed to refer to
remote.*.partialclonefilter as the default filter when fetching in a
partial clone, but (perhaps inadvertently) there was no fallback to
core.partialclonefilter.

One alternative is to add the fallback, but the aforementioned change
was made more than a year ago and I have not heard of any complaints
regarding this matter. In addition, there is currently no mention of
core.partialclonefilter in the user documentation. So it seems best to
reaffirm that Git will only support remote.*.partialclonefilter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 promisor-remote.c | 5 -----
 promisor-remote.h | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 6530e26f98..3c572b1c81 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -6,7 +6,6 @@
 #include "strvec.h"
 
 static char *repository_format_partial_clone;
-static const char *core_partial_clone_filter_default;
 
 void set_repository_format_partial_clone(char *partial_clone)
 {
@@ -100,10 +99,6 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 	size_t namelen;
 	const char *subkey;
 
-	if (!strcmp(var, "core.partialclonefilter"))
-		return git_config_string(&core_partial_clone_filter_default,
-					 var, value);
-
 	if (parse_config_key(var, "remote", &name, &namelen, &subkey) < 0)
 		return 0;
 
diff --git a/promisor-remote.h b/promisor-remote.h
index 6343c47d18..c7a14063c5 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -9,7 +9,7 @@ struct object_id;
  * Promisor remote linked list
  *
  * Information in its fields come from remote.XXX config entries or
- * from extensions.partialclone or core.partialclonefilter.
+ * from extensions.partialclone.
  */
 struct promisor_remote {
 	struct promisor_remote *next;
-- 
2.28.0.709.gb0816b6eb0-goog

