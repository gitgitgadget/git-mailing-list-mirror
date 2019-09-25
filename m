Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0791F463
	for <e@80x24.org>; Wed, 25 Sep 2019 02:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633767AbfIYCEt (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 22:04:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40416 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389401AbfIYCEt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 22:04:49 -0400
Received: by mail-io1-f67.google.com with SMTP id h144so9486470iof.7
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 19:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cmlAnId5uOeqD/XQrHWfTtuselPEYcKCUq1oSjO0Xng=;
        b=VZJjPY3aOLFLrIVIqu3xUfL1DPPW6BCDKuDIjaEItb+Fjvpv0S2VHwPQIT8EcKVU6m
         HTf3w7voLw/avraoh+QfJtTHhgqWfGadA2gswDRp4LQ0/DCnsebHXmg3dnOm3K9DisTF
         uCucROHGPYkPyl+9jcymPlAuN2NXHmubBWS+xepb6GT+mFs+Vy3tlmP7ew25CHOibOUI
         WkzbszEa+gZK3KZS4Cu2cF9UjwA9EkqA3UGLY3wN2kgVV91vcBWjyVZXbulPqdH6KTo8
         j7nLlNYYCfolFePM2sUYvK65CQgQBud99jvHfYiZ+LK97IzhlITenro8BUqVwHbH3zh1
         yaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cmlAnId5uOeqD/XQrHWfTtuselPEYcKCUq1oSjO0Xng=;
        b=nlIXs14DBQ91YR9YF1dQS2+lO1EHC2Z4E+U87eCpxpVQrgHY8n+E0BkMQQXwo03f7M
         DmMoCIGOa2CKzVYdmYXW2V3ocpdcvx5FodJszAoBb8wnxm46hlfUSL+6tE5cp6JWhPLo
         8ZG6aNMCXkerIekaBUJiLDg9pHa105t2E5uwcI1UrJGUMtIFB79Ya/nFd4mk8qsDB8Iq
         GW9OvLzN3QZsjenHTMV5DAQUNQT5M0zjFK/FrdsMohchJeb5MxZBc78Rt+s5hFi+r97I
         TwROwlB14sev4e1h5OR3v2wSxXUM5H+H8bg5RsNvVHalXBOdRaKPEAVOUtYqk9y818mz
         brxA==
X-Gm-Message-State: APjAAAVbS+pZycaUPAIIyqY6nvuGB3uaN44mPxn10QKB8CG5Dj4EcfTB
        Kys7Qd1b/fSCBvMhzTMe07/90ZPAkL8=
X-Google-Smtp-Source: APXvYqyp+tJaD/Uy/Y4FCHlxEDBsmWTqO3SnjAcaB9+Ut1Ex1Yngtt9n5FzQ4Lx8SMfQZwegHsXA8Q==
X-Received: by 2002:a6b:6c06:: with SMTP id a6mr7108886ioh.306.1569377088090;
        Tue, 24 Sep 2019 19:04:48 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id u11sm5341777iof.22.2019.09.24.19.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 19:04:47 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        davvid@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 2/3] diffcore-break: use a goto instead of a redundant if statement
Date:   Tue, 24 Sep 2019 20:01:57 -0600
Message-Id: <20190925020158.751492-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925020158.751492-1-alexhenrie24@gmail.com>
References: <20190925020158.751492-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 diffcore-break.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 875aefd3fe..f6ab74141b 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -286,18 +286,17 @@ void diffcore_merge_broken(void)
 					/* Peer survived.  Merge them */
 					merge_broken(p, pp, &outq);
 					q->queue[j] = NULL;
-					break;
+					goto done;
 				}
 			}
-			if (q->nr <= j)
-				/* The peer did not survive, so we keep
-				 * it in the output.
-				 */
-				diff_q(&outq, p);
+			/* The peer did not survive, so we keep
+			 * it in the output.
+			 */
 		}
-		else
-			diff_q(&outq, p);
+		diff_q(&outq, p);
 	}
+
+done:
 	free(q->queue);
 	*q = outq;
 
-- 
2.23.0

