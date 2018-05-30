Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8921F42D
	for <e@80x24.org>; Wed, 30 May 2018 17:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeE3RDL (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 13:03:11 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:40565 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753855AbeE3RDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 13:03:09 -0400
Received: by mail-pf0-f174.google.com with SMTP id f189-v6so9337733pfa.7
        for <git@vger.kernel.org>; Wed, 30 May 2018 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KzFTTNESR3B72P7dif1lq347zU+mEP6n8p/SZzEQ2SQ=;
        b=klUZKiHDrmaMYMl7RkpX01q6sqP3dX+YzsQRmo7l1k4UZyl0ER5oXpoG36I4rkOAir
         ctaALhQVOzNIsbDQkAwK1KFRuXYdGH6VrIJNT19vAaM8quwRei1CbM45CK2d4nJDF/CE
         CO/e7A0n+UG9yoL9iV3nDIs0byztneTW5gNrBHRhQ20F+X/seMu50+i+FmdaWctkyNbV
         FQHrM1cqYfIEanEUukLyRccRH27+7CboUAKmc1LhJuX7uBFqt9Kl8GsA/FovaVl2WPIT
         b0/L+cTFeoolOHzV+FH5xg/yT6EnIehVQP4GzY6vzNL8Pb5o/nw6n+i7Q2g6DcA4+O9Q
         1iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KzFTTNESR3B72P7dif1lq347zU+mEP6n8p/SZzEQ2SQ=;
        b=tkFHVhblo4QoBeDKbYkwFHN4OpK2htKeZ7Qpo1ihsU+ngDuPPNPMs+qmXtJ03yjFFl
         vp/O9iJKyCqPLKeTALHvcdaY4vFntA0oYUEfDsNK6wPeCzCBgvlNuEWvbmQnXb7IRb19
         MFVbND5Iw0ewUIADnrp0LBV1vqRQxhntmZ5f3E+eg3iA+qtllbOn/Hb9O/LxmWMq+xrf
         SUzpl8epVKPyxOUwVwfwEH3kptDYda8olYd6zLkcbzghZ2zNMPh0cyeZ1exopQ0glR+H
         k4U128raZaYsfZuk08JThWNlAsNmRb3eumYsEOF9XSCYh8b5rSG4Kfu+50eW/5cef7OI
         1vdA==
X-Gm-Message-State: ALKqPwdoU7oBwc7jyLZM17POL+hjCw/XnAvogI0MTGoLJM+uYvPUQJ5o
        OaQDCA3siKRFJI/N0xd3r0rmTUW8IXg=
X-Google-Smtp-Source: ADUXVKLp45FyoDxYx1Ojm3y2H8XAVxXsZFCG9yqiZoEUgJUpy7OHLh5d5/mGk2e16NA03KsZkaJRSQ==
X-Received: by 2002:a62:1a4e:: with SMTP id a75-v6mr3519962pfa.84.1527699787957;
        Wed, 30 May 2018 10:03:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b29-v6sm64803718pfh.155.2018.05.30.10.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 10:03:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] sequencer.c: free author variable when merging fails
Date:   Wed, 30 May 2018 10:03:01 -0700
Message-Id: <20180530170302.191176-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180530170302.191176-1-sbeller@google.com>
References: <20180530170302.191176-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This was a deliberate oversight in f241ff0d0a9 (prepare the builtins for a
libified merge_recursive(), 2016-07-26)

 sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 72b4d8ecae3..5c93586cc1c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1771,8 +1771,10 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 &head, &msgbuf, opts);
-		if (res < 0)
+		if (res < 0) {
+			free(author);
 			return res;
+		}
 		res |= write_message(msgbuf.buf, msgbuf.len,
 				     git_path_merge_msg(), 0);
 	} else {
-- 
2.17.1.1185.g55be947832-goog

