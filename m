Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856DC1F51C
	for <e@80x24.org>; Mon, 21 May 2018 23:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeEUXkN (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 19:40:13 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:56086 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeEUXkL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 19:40:11 -0400
Received: by mail-ua0-f201.google.com with SMTP id y25-v6so12295406ual.22
        for <git@vger.kernel.org>; Mon, 21 May 2018 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Hgp+TvZHOooL07OsLklZ/6pzWGsSn/92M/wn82ojBCU=;
        b=NU6+9K7pDrarnItwtPqTxyol1UWdKWacR5DiWTcBib/VPjj4dHYkw057NPbe85qfSv
         wMFaVNEZNnMQvyOH2qDxpT43MfX2j+3LrjhQSEAME5ilIpcXIHzGQf/mDyJUsjyqAXAQ
         YWp79aDtj5PHW4Qndl+q2t8lc1vIEovLKOIHiveGy8aeNdvjjj8VLgzPUzVCsj71RaGp
         jrnTRcIe/g483zmlg14l/F/PkZqkm99dAY8DIDMpOx62tVhT9yVeSRDzliZNl85fjEW9
         aHp+WFRM0Pnhi+AO84DEE+qh76YmfQMlA8+hfxp+mdEk+JZbJbalRVCwD8WBG2/EmIdl
         5tXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Hgp+TvZHOooL07OsLklZ/6pzWGsSn/92M/wn82ojBCU=;
        b=G0v24ol8HYDbvSJlLdZ2TxM5KCHdVeM1U/H1LIjmeAYUKUmD+s16eUJ7pQjZwO8I85
         fQXC08HAnrWyufLtYqN3BGm+91EzsUBHqm9saY7SZWVd/H3zbdH5h67ENsAWePfT/q4a
         BsKNGBfsWvHl3KxNz0hxO4vFnQ+TXzmPv3WTJDlGMaCDYVZGxqsQ9VjVr6FIwR9DqujD
         ftNdNTzWyyDsYfBjR7PNfXm0gjtZTIe9FaNwsXcszUwHzoer3+etdF1L1sPK8kfSBLag
         WkbAkSD9DJjIUZD4HZy/237OZaa5S+6v4bCaErNPYzSM0aikyJqqKWc/f2m25Un/eFL6
         122A==
X-Gm-Message-State: ALKqPwd/AzOimX4rLpSIAH53g6xdxZiD+ZEqRWehZ8bD6me40cbWQFgq
        KRyfnxAznuAWUaRniSa3ibuuwP7NbzcHLOHq5VTjP8JqxwOO2xZtDCiZAodUsooGOhpxFqSPE0O
        jLeQ68iIJxadcAqXafFrhHwY9dVUEY271obeauaNPUy5iblPmxq7DEQi6dQ==
X-Google-Smtp-Source: AB8JxZpZ1HuCSJbqtQdAD67qjmOpkUjLfpWT9QLh5ByTuHJt8ljOzuu7bTQiMqu5otKznwAx0CCfZC4Z9B8=
MIME-Version: 1.0
X-Received: by 2002:ab0:80a:: with SMTP id a10-v6mr12118264uaf.2.1526946010671;
 Mon, 21 May 2018 16:40:10 -0700 (PDT)
Date:   Mon, 21 May 2018 16:40:04 -0700
In-Reply-To: <20180521234004.142548-1-bmwill@google.com>
Message-Id: <20180521234004.142548-2-bmwill@google.com>
References: <20180521234004.142548-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 2/2] remote-curl: accept compressed responses with protocol v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Configure curl to accept compressed responses when using protocol v2 by
setting `CURLOPT_ENCODING` to "", which indicates that curl should send
an "Accept-Encoding" header with all supported compression encodings.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/remote-curl.c b/remote-curl.c
index 565bba104..99b0bedc6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1259,6 +1259,7 @@ static int proxy_request(struct proxy_state *p)
 
 	slot = get_active_slot();
 
+	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, p->service_url);
-- 
2.17.0.441.gb46fe60e1d-goog

