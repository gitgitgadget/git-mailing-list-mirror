Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9325D1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeDXVDm (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:03:42 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38542 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeDXVDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:03:38 -0400
Received: by mail-pg0-f65.google.com with SMTP id b5so11739436pgv.5
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pXUHxhBn+U/ahnw1Hwe6mrTh22cTSoH+YGzNFPqcmVM=;
        b=FueZO/UF4yNjUCyZhMQ7Nz0Z7S/7bseT+1J7juEvFIFs2FamUWY9Oc4r5B5ik6JxMO
         LSp9e9SQOPr4289OlQrpLvjgfkdQPV+WaTTqL+c8uCgZt+vE7dkDDT4r3rMZ/8hK/tnQ
         eEljEGsRGfcZhdSK9bq/S7+OIGrH/T9LHGi6teEt/l1u3MnXCv/H+/DF+iz1kXdxVKq1
         zm3BwDcefVYE6CA+YuAXxs1I4YQ/0JLhtJgk8FkqrMTVx7tmo4XhE+0TZxfdZNhMrnI6
         6XcyA9aZS1P+Z2cXvosovCJ2ZRjE3egi39cgu7XnEKE0hqZ0PJwuW6DqswMy4OcDl0rl
         u2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pXUHxhBn+U/ahnw1Hwe6mrTh22cTSoH+YGzNFPqcmVM=;
        b=IxcTurCgTyyfdI6SGRd9YhxNgG4cfGdSsErHaKhbUwN+EQD+9X0mkX5aoXmFaoYBxu
         tqjHrWeVxMyyhPBMNKhxwugaqjixVhQMA4aYK+nAxIPX49VN1s7qyaFoOBRJ24b1cF6y
         qMHLtCJ6BZaY4auCrAP0YMNhwgO/Mhnv72aNjQ2hD8zu4ij2Y4ncUo3VLPmX25PkLA5n
         ccMiYvj6rkUaACdaoHbKAoTg2GyjCqar1oQHKyT+usGebl3VtKylCFjpSgQ0Li6qwElt
         q4o3GLAt7Qtx9j68MsYUASxaMnWpDS9zCJOYUacVgkebC6R4XjA8O5leQbG0KeGb2MZC
         DBmw==
X-Gm-Message-State: ALQs6tDRLzV0wobj2fDuzIeJvay7e+IXJx+shm+RC4mtNk+9tHyH5GIZ
        4fMTIyPDHWNMLbREGhTUDxI95dYsfU4=
X-Google-Smtp-Source: AIpwx48tufzPgSj9SwaSho9ewJCXoeiuwBJJ99lS7vEglY0oOt3+bwWWyK6bygag8xmNtDkvz8YB8Q==
X-Received: by 10.99.42.137 with SMTP id q131mr21266247pgq.379.1524603816894;
        Tue, 24 Apr 2018 14:03:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l129sm25015584pgl.89.2018.04.24.14.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:03:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/7] diff.c: do not pass diff options as keydata to hashmap
Date:   Tue, 24 Apr 2018 14:03:26 -0700
Message-Id: <20180424210330.87861-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424210330.87861-1-sbeller@google.com>
References: <20180424210330.87861-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we initialize the hashmap, we give it a pointer to the
diff_options, which it then passes along to each call of the
hashmap_cmp_fn function. There's no need to pass it a second time as
the "keydata" parameter, and our comparison functions never look at
keydata.

This was a mistake left over from an earlier round of 2e2d5ac184
(diff.c: color moved lines differently, 2017-06-30), before hashmap
learned to pass the data pointer for us.

Explanation-by: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 1289df4b1f..ce7bedc1b9 100644
--- a/diff.c
+++ b/diff.c
@@ -842,13 +842,13 @@ static void mark_color_as_moved(struct diff_options *o,
 		case DIFF_SYMBOL_PLUS:
 			hm = del_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, key, o);
+			match = hashmap_get(hm, key, NULL);
 			free(key);
 			break;
 		case DIFF_SYMBOL_MINUS:
 			hm = add_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, key, o);
+			match = hashmap_get(hm, key, NULL);
 			free(key);
 			break;
 		default:
-- 
2.17.0.441.gb46fe60e1d-goog

