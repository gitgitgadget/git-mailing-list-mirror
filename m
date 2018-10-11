Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38BAD1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJLErP (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:15 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:52849 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:14 -0400
Received: by mail-vs1-f74.google.com with SMTP id k1so4030309vso.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FMO/AN4rsMfciY8hDo0JqYkdDtNh7BtAY6W9lRsDdxc=;
        b=Pzd4RXAEgXBbuRLRmtqgknGygygJCj9xbS/9MbFo+uTRKpKPZbkz9ZZqWYXYvm15l8
         F63yzGXSaws3AeF09qBaiGkPxNfV8GXKWp3oZ7Z4b5+H03hi5cShaWMPKbJP19rRnMNN
         nFZKEWNM3PLCowp/nsDPlyLGy24qBz1MtUXzzLdZW1MO4lUKFZDOe0bmqylNqGuEYIah
         WVVHKa2GsMv9knn1++EooS0cHGzZ7EYaMzM8j7yZMWDTj9OJ/MGz2nzX+LVs1V4+qrYB
         aBgislW5iokylBYdDvOUKZIq4QWz/EtxP/DFvPO9n/0tVLSGxgkXdotpzApG5lS/T6c/
         2Fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FMO/AN4rsMfciY8hDo0JqYkdDtNh7BtAY6W9lRsDdxc=;
        b=WEDCCwXvfnLM8T1eMEquZgrwCVUev2W1vbD1/lm2ByK4JvFbTfvQsaw26TrEc+ozgk
         8ONFHjHecKXG2sfPOwecPadqNi+kzSr7BqNA2qdhXpNUCwqjJJqs4aJCh4Gx7gDjd1Op
         2pT743HMgLcMyQNWUPT5EBpMqdun+l1Y1wFAvvIchXPWN7rexRUDi2fDGt/cJVXDYEKd
         8sBtzpBFQGCKltsxkN4VXpS54oO/6oUk+Q/ixTtTc2/VeF0c9hLRnSTkeumCWpg2URS9
         lPJfhTWM+9cXrsC9cJKdQCwfooy/3n49UGoyZmdKcCIF0u1cL8Ntbvern95fGF7h+nVj
         LBQQ==
X-Gm-Message-State: ABuFfohCy2ZQ/Kb/XAcud6tkqFlR/2590q+CzqVygCzwmDmPW0VW5NjY
        rjXN8oRv0nvenrr6I9Zpocy1pek8wQJcC7bsUYQujouqhx9jo+Ol40u/0+VCdkbCL38EBQyGCHE
        53mbgg0L5ei0jqIDYITEo7pWrCimzh6LHkxLXRh5ewYFuHdleDHQjSg/VUTLw
X-Google-Smtp-Source: ACcGV62cvmYT0hTyXbNVOMzYHFgvmYRCPp9NVQpMQOLa1JVFSmEwb5UVC+NEz5z2o7necgwYfuDltU1Mzh4E
X-Received: by 2002:ab0:446:: with SMTP id 64mr3230772uav.0.1539292689923;
 Thu, 11 Oct 2018 14:18:09 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:40 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-6-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 05/19] object: parse_object to honor its repository argument
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8e4b0b6047 (object.c: allow parse_object to handle
arbitrary repositories, 2018-06-28), we forgot to pass the
repository down to the read_object_file.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.c b/object.c
index 51c4594515..61f49d8b99 100644
--- a/object.c
+++ b/object.c
@@ -270,7 +270,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 		return lookup_object(r, oid->hash);
 	}
 
-	buffer = read_object_file(oid, &type, &size);
+	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
 		if (check_object_signature(repl, buffer, size, type_name(type)) < 0) {
 			free(buffer);
-- 
2.19.0

