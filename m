Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02C61F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbeGPXfc (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:35:32 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:52662 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPXfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:35:32 -0400
Received: by mail-qt0-f202.google.com with SMTP id g7-v6so41907750qtp.19
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/MHEj/r4xmxiztnMbt7H93ohqLeIsnUVVtSSmWOJ1XU=;
        b=lsE/nE1NJT32ZqcHfPdfsds+/4Y4MraxzfGkaipI3TpY2RjKtUvqEht+fKAmmukNW9
         fBXRgD9uNTAnwvCxTbjPr14eJhJNWSq8iuHC2wF/U7bnmr7VQvEUOZr2NeLNReqEfH67
         QvOklmlpobAP78oLTm1lH5t0/YsdPDnghx4l2CMPdvZVMEVmYvVET+4hCFrX9q+nvyPJ
         zf2LPDyjtmZKQyU3PhIq6pLnDYHQYyAjeu0jZuKBuL1Z5O1tQV4FtPdalgh511yrempO
         z4nqhMXnXihyTKP89Mb/Anl2ZPs7rnFNeobdFV7DZ1gm/zvk3K6IHXUxFx9ndGSSzHgJ
         tsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/MHEj/r4xmxiztnMbt7H93ohqLeIsnUVVtSSmWOJ1XU=;
        b=nDIgC8Of5MdI+hU87DNsrYhmA78f9FSHpdkkzr1FE46G0GI3O6x6h3NxtoQFGcvhfX
         qQbPI2Xr5hz5LweFlkFoKsraRZkzWgWwBBYnzjf68xMpTOPAhtlthlIdpBYACJUnTOZQ
         OERwVhVMlXshWowidH/9QJpH/8DLw5hqLCX6VszdrwGJQpEilx2zvmM+HSzmpfnp4AFo
         tBpokZ01cxB012jDWpL4HIGcQ7YzLyZz+/GGz1MDW15pJCzT0PkLepv9sl17x+LwdjFB
         z6J+Yo2SzkvH76YYCxIDpwtPkJf87s3C+aUlK2JXR5zHqpIJzOavdLuAWAMZrYDIpf1W
         YMSQ==
X-Gm-Message-State: AOUpUlExsleqiphqgDPu0BeG7GJkPwVqXo94NZx9JS+3MXGg+lPEyR8g
        m74p44TEoIhXyzmohTM1wi9kibIZyORSkt3+yHwK17mDWBD8npph9tMeDqkCM13sVe1d8o7xavX
        6CYyaQQbOFJSRX/57KS0Ng8UIcOVcxmEeMBgX2I/VxWn6B6ZPmNqQWMb2S8eu
X-Google-Smtp-Source: AAOMgpcYq/vLQZ7x3WME2lAVZYW/ecYAIDW/A6/rtJIkiSpKs66hXhk904RGEs6faDWdeTmhhQmb5qD/VJ+o
MIME-Version: 1.0
X-Received: by 2002:ae9:c118:: with SMTP id z24-v6mr10589087qki.34.1531782357240;
 Mon, 16 Jul 2018 16:05:57 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:05:37 -0700
In-Reply-To: <20180716230542.81372-1-sbeller@google.com>
Message-Id: <20180716230542.81372-5-sbeller@google.com>
References: <20180716230542.81372-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 4/9] diff.c: do not pass diff options as keydata to hashmap
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
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
2.18.0.203.gfac676dfb9-goog

