Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92EBC1F51C
	for <e@80x24.org>; Tue, 22 May 2018 18:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbeEVSmN (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 14:42:13 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:43795 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbeEVSmM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 14:42:12 -0400
Received: by mail-yw0-f202.google.com with SMTP id p192-v6so10248459ywg.10
        for <git@vger.kernel.org>; Tue, 22 May 2018 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Hgp+TvZHOooL07OsLklZ/6pzWGsSn/92M/wn82ojBCU=;
        b=e5K8ckxo7WFXen6iyUYmxI+pDNe7R7pMwn0qsTbvlVh9Yxa+FmX93oB7b+1aHV2Ad0
         oLnS3bLJX4FRmgEuTZ1BXck4pgF9btp+Q0d7gaVy8xk4g3iQ+GmHlGksEMmHICuTmoL4
         bcTIUPuGhR7GNkVItd04TzDf1Sl9VEPU+2ZgwVMKDSQ8GpbL5MwiKsG9b05RlUQHXaNG
         b4LiElF1norj/0x+XvwA7YUINIsgK5XXDUQfI9WlzBqXd7mlhVFH+LtHfvcW96iLW+lX
         xRiiAH3XTJnDq2+mtzUMa8OV3bwmrSsC80ICAL3fxkDbK5ypjNb5LhBCoRMquh3eKew4
         L2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Hgp+TvZHOooL07OsLklZ/6pzWGsSn/92M/wn82ojBCU=;
        b=XaKYTXQTeDZlf2aog6GT9+o9FOIF5NYJSpGVOzOq4UGcVG58ia1uuB+WZ1RY804W34
         cPTNWhr2cHn4fizdfOD+KQBK0oazRig88A1ZKogCQnbAe96/wNTySeMqw2CVgOJKg9yR
         TxixyB4HFVMx5CxM8CQIokxr09YIM9avp1vqynkdzzCdcqPHF0kEToFzD7hrf7lRXz+M
         C7fXLvJbfO4HguQ3+7xu/VuKgYnPVfpweM5AXSiws/kI9HYEpAtS+8WTrkulvTfQdcEV
         XIEvPmCFHJNLpa43bnAcDNNnbx8Rz909OqDfpEV/eymd1tXFnaGjThrdDwBZ/RwvKXsz
         pl1g==
X-Gm-Message-State: ALKqPwdpkUMeNadRYA6wZaAN//wfWC5kuwKvvo6rzIiQAU2pyzNAXhAF
        PFmsz1TiC0XTSfHLbZ4U/wbIoAS+pc9xgyys6sJhuu6QNENWRruR8ddF/v1QWVazU7OlSi21kYO
        mzjk4kzDGqG7u2azPjC38G7YE25gGlGo/kRGY1E3odo/Z4J0aSfQ7XytAtw==
X-Google-Smtp-Source: AB8JxZpkh94rLM/krd7X9fDcEKg8DAOeb1OL+eadUYzT74cM15hH9JsUdAr7CK1E6UAxcmCF5kLSTK8wc/o=
MIME-Version: 1.0
X-Received: by 2002:a81:d002:: with SMTP id v2-v6mr71156ywi.223.1527014531337;
 Tue, 22 May 2018 11:42:11 -0700 (PDT)
Date:   Tue, 22 May 2018 11:42:04 -0700
In-Reply-To: <20180522184204.47332-1-bmwill@google.com>
Message-Id: <20180522184204.47332-2-bmwill@google.com>
References: <20180521234004.142548-1-bmwill@google.com> <20180522184204.47332-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 2/2] remote-curl: accept compressed responses with protocol v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com,
        bmwill@google.com
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
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

