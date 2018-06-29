Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134E31F516
	for <e@80x24.org>; Fri, 29 Jun 2018 00:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030274AbeF2AUY (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 20:20:24 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:36798 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030260AbeF2AUV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 20:20:21 -0400
Received: by mail-yw0-f201.google.com with SMTP id 202-v6so6322334ywo.3
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 17:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=UYgwGxGrE62QsNdir1VoeOfhjqAJsQ0vZ1J5dg+ME+Q=;
        b=dr28AA60nBx9FpGNGHsyKgJzHPs7ILVlrJxlvs+4Wp2J8r+5bUtS9PXKTM3ZNEQIER
         DyLAhoaSYwWgw67iRu/KBGWm/lqh0wrUkWpftStJ24yTm+BZhzpU6PL6/0/j0y9nPzCH
         35j57wFS2E9MTvnSlC180CUs8WwjJ9LH9tHqK2U3yQq9C5Xkr3P85ge5/tHwI4Y1SKh5
         gY4q9j3VLOuh3AAmlHgmyeLT+w+LbEbbtTaBwvI/dFDqnyhTSyf6+ulETWXlteJfLtqx
         /W0TPoW8XdxU6klTaapSpbkhq8zOv38ZjRUl05sk3ZASmrCuRObjPm/0EJVa5NLygOFo
         36nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=UYgwGxGrE62QsNdir1VoeOfhjqAJsQ0vZ1J5dg+ME+Q=;
        b=SHk5T4I/Wetevid1YoKuU2pEWa12suKZQLsRkMZEcHbtGH71UZjum/Xxjl3ecANjRI
         dBxigWOOgy4x9e78YloLWa4zFPvRCNCQpv6zsNZpsLpng9t7TbJA0nsO85/wu4KmGhDK
         wyTqumovnb6EyKXPV2ls3YQbQAuzMBO25hA7R/o3Q83eUjTAE331EbqDmrK03EJXAnbj
         8UrXfqxhYWWN1e3/6O+CFwT/cRYbxzIFz5j7cHpIfzOOCT/jTsj6nIav6BiDbH7CSR3b
         9dzaeW6Qt1qLK5GlqBvBJFDFzSYpvd+q0u2OHbCFapjjOudBcDSpghYtTxheWrKFus2M
         0VVQ==
X-Gm-Message-State: APt69E2y3HMHLMTjQIOXzl7UCg1wGamS/SzXWl19wdTM/INbTw71iYyx
        5MHI7eXhVyO2tKgZmAMN0ognGQSrAlNI
X-Google-Smtp-Source: AAOMgpfSQE4Hm5Fh2JLx8kFxn3Vbsu83HyhZSg6rKP5YiFiugQPVmTxzjuoe9Nqwgp3j0ONkVx+V6C53xZc3
MIME-Version: 1.0
X-Received: by 2002:a25:690b:: with SMTP id e11-v6mr2594168ybc.30.1530231621138;
 Thu, 28 Jun 2018 17:20:21 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:19:53 -0700
In-Reply-To: <20180629001958.85143-1-sbeller@google.com>
Message-Id: <20180629001958.85143-5-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com> <20180629001958.85143-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v4 4/9] diff.c: do not pass diff options as keydata to hashmap
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org, bmwill@google.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 1289df4b1f9..ce7bedc1b92 100644
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
2.18.0.399.gad0ab374a1-goog

