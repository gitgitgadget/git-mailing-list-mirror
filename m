Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B0F1F51C
	for <e@80x24.org>; Thu, 17 May 2018 19:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeEQTr0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 15:47:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38673 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeEQTrI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 15:47:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id o76-v6so2586999pfi.5
        for <git@vger.kernel.org>; Thu, 17 May 2018 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OoEaapq5ilS2fr16SU6wjUOVYetPj/x7QFyeMXRWoGI=;
        b=caqh4DKxueX9Qlrn0hFi753nVtiw+gTDiNJIhFkcJjLPTGbaGY7dG7YnMyrsHcY2f9
         6kRc4XY62r5e7qKsPaGwv52Clx8nyJbbqAEWhN2HbY6APZgWhAmxAtdlP57q4gGShLHt
         8qLW12KZ1xyCqTJAl4AN2HW/aBMpKbwglmlWTgD6RAPANHIBvmSxdDcp23pfK/LP/lGo
         Nq5WiaKRFMpAYXiuUZsueRp2Wt0Moo6c+1tosJSIec93dwVHhzy6VY4raHPsClwwja7e
         fxvtl+j2gwGphgiVuwo4GG1SgP9+ad5zPOkzuFNOL5VS7fHVmIXS3/E4TkwSFkIygIiu
         6CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OoEaapq5ilS2fr16SU6wjUOVYetPj/x7QFyeMXRWoGI=;
        b=TZXTyB8cEMU6RknuQFct83SPE3tyaumeqp5YJpduswdZo3uT+NdJL0JUwIwTRnoZyr
         9/7BRpypWUnAa1PZb8VTn5NJRUtttWEAvJluII/lpzaeVUum4KhIkuuiKcJyrecX+iEq
         bcMkUAhMmMHFQvzsjiRsv/8YC3NQ+DixIA+iy6QlXytOzhOEnbb5RF6RfzrSSHGKAnjQ
         osOk8qQlZd7AItcsPtOhL2ksc0KmwrV08fpSQepHW8heG+oq0BG87Ezf67a2Z+tDN9s9
         iYHPEyD5ye2iud2qJmWNH3GBHu5MQIV02a+Gp5HcLimY00sWKuJD0BoJftNgLsIhALm/
         w5+Q==
X-Gm-Message-State: ALKqPwf4tTOCN02xXRaj6txUfI1NTJ/E6sXfoKCiP6ClliuRl62gTGae
        b9pN9t01SfOsyjtSwFTcdZIa8H+zitc=
X-Google-Smtp-Source: AB8JxZpX0UpDqoILNnL1Pfk1F7c8QGApgVumbfZZopjLhrPvVHpS7sXA4IBxuXLv2+w9aqZbSAFTLQ==
X-Received: by 2002:a62:1d52:: with SMTP id d79-v6mr6368707pfd.230.1526586427574;
        Thu, 17 May 2018 12:47:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 69-v6sm12227468pfh.33.2018.05.17.12.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 12:47:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: [PATCH 3/8] diff.c: do not pass diff options as keydata to hashmap
Date:   Thu, 17 May 2018 12:46:48 -0700
Message-Id: <20180517194653.48928-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517194653.48928-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517194653.48928-1-sbeller@google.com>
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
2.17.0.582.gccdcbd54c44.dirty

