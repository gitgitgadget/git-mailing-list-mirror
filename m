Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D4C4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 03:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E982D23A1B
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 03:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttGtaSYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgIVDEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 23:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgIVDED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 23:04:03 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CDDC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 20:04:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id f9so1132642pjp.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 20:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Nav9ruYX5IoQSDu938hK2WzbTgq4nFFeMaVC7jH/qVI=;
        b=ttGtaSYFG56LOMiWcuDT5thcvrfyaM/7hotMnLiYfOhRquDyHewEO9kWS+x1HivEp4
         DPNF0nAvhPlgWQCtjsehOh6jF7f7mUPN7qYyGgkK/nx8k8ZyJrMLAcGZyK/Z4+S/6zOp
         CX4v/hlzsqpYcOpAVraEBfaUHokwzqYkJqgVGBJcDle3myBeR2mIMFhfcreqjdQOA+1D
         VI1wAIpY9xmPZNj1/Je2rVClNfObGrN/Fag3sX31f7UZb1vJ5GqidiNGtc5TdITXkI1S
         cs5kuG5YjVNtpJAqlAFn3j1AoO1/84NZKEghi97VI/bkNrMj4A9+1xz7O7/TWHioQjDP
         yp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nav9ruYX5IoQSDu938hK2WzbTgq4nFFeMaVC7jH/qVI=;
        b=ILb3pKKSbTv+08r4B3lVAWvHhWd0OShoxP6vRaBghHzY+2hSyb2kxvtd85TUW9EIsg
         oYZIU5p9XpYrS/kuv9Mor8gFzj/YrWlfhZ1bV/cE4YrG8sLFBkwd59h9oSyHFdR2KNHh
         Ot+ZVbI/4vFucC5czcsXfmG+Bwl3SiTYTxEyZPwhcm0W/0NYmu9HaDOLThVyaAffZitH
         wIwoq6prUaSssdWAhBIN7uVkloDWruqQnebjOOF+REJHRFLkQIUwyrAdXMfOoLvaHR0T
         DI1zd6WUZZiw9VRLaDho4zlgMvsdFycZAHn9L7dt1XWPGl4TKzErNCHJGW2wQX6MB1Uo
         4Gzw==
X-Gm-Message-State: AOAM5316R9R3ZVzLFMt+pQtcqx0rT/N+gTKEtH8XzxW/RWePcu3gZi4y
        RHQ58D0SjL2IoK807u/x0UGQkfW3ik1McxAfXZwjoWhwVIsWwaR0hL+/z8nCC4alI1SeKQx/FCa
        1WweUw/JP+kDVdUdKHTOquiLsNLs9GaxksHXTLzA7alf6+1CfGaXfGG5Z/PZ9ZfWvXfcQ22Zra0
        4k
X-Google-Smtp-Source: ABdhPJxKvBcdU/G40XWtnjpMSi9qK0wCjKrJ5ttl9KS13i/UYAVy9VUzBRRIlEDnnzJmkTHSWBf590yF6YsOWwIZkx9y
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a65:42c9:: with SMTP id
 l9mr1855141pgp.41.1600743842254; Mon, 21 Sep 2020 20:04:02 -0700 (PDT)
Date:   Mon, 21 Sep 2020 20:03:56 -0700
In-Reply-To: <cover.1600743698.git.jonathantanmy@google.com>
Message-Id: <c67a12635d5d0095fdd83cb94d522a2bb311a84c.1600743698.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1600743698.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 1/2] promisor-remote: remove unused variable
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chriscool@tuxfamily.org
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
2.28.0.681.g6f77f65b4e-goog

