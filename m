Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72B31207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967221AbdDZUVV (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:21:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:55992 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967220AbdDZUVU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:21:20 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsPwa-1e5WGy1s8e-0123J7; Wed, 26
 Apr 2017 22:21:16 +0200
Date:   Wed, 26 Apr 2017 22:21:15 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 18/26] fast-export: avoid leaking memory in handle_tag()
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <1eda2649781a15264e9995e705d19206185dbbb1.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zDxEl+hWHoObLw8AsANgBhU2PhbUuWiXGyeajAbGMq6xW+B2Sui
 kmH616oSxsRlWlj8ONP5f6DeCO3YrKg0mRzPK07htongnSLOyNEYZQ5+oLZN6151IFNYDDZ
 IqsSfP35pQnELqJHGVnqzL+fo/BrlYbwC/72/ZBkiJxQkRDyoEm4l3+DXQbMZfSSszC5h4T
 nccjl4+5nEukQ8VIF0l6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ETDyQmTefoc=:tAnjDSPKkMXVm8RdLK/zoh
 t+UrQ0uaLegc63VuAy3VLN+YftrB+RxnvqxZOOHVAFez1SsBESw4JKnTk0Ux7iOvHFCb2LxRI
 IY7NvaiMSwc5NJAekmeBIz/1Q0a6MV0tYaNldVlZ7Y0i9HbnSIk+Oakg/PjJg7NT4mKWDO59q
 Tjx0797fuAI4dWdHxUahdAowoDZud27YSQrEeL4Qkl4NKbzMmiImSoeqoMZeUiMLkmuqyPG0y
 RlZwn3jXK2M1suOmEk3/hqKHT70urStmeD+NYZ4nWE2W96/fSgbH6gZsZqN9Z2M4nbBDYHdHV
 fMQAH9jCrh7cHY+Q92OeTJTknu+hEM3aaB8Y+LgHCk/H9VlwEEIIVs6C7VvAsfSDs1xk8E32y
 dCk4lHrnvnpRqJ+cv3v2b6Y8pyIa7MsLgxeGfZf4vc/krS5AUX4T4QMJuO26VE9QLhSM6vtkX
 3OKsYjDLdVkizI/yNFdJMi3TUcakIG5eq4Ioe5qhdg6j19yXs6STLXH6ZaCZGA68W3+qh2Wp8
 UapepNIDB+kuT1BPlE6i9ovIFVFQrRtGJ8QFnn0jNPV6W0GViidUmaNSOnk3IzWswLBHnfpyf
 CzEF2F22ETk6/VJTQMfxTNqUBNQkW/iFKxlhN1Fde8SUDQcGYkgP8t3LQvj4JvaV4SwtzWAtq
 UvF30tl1WXlYUdg6kjnEUFt0ruNmkC0MSkCkEZ4RC6es5TyXhIOObPuiBuzpks0zOy8MeSqqj
 FFOv1UyKVOrvgknXaXkYOjjt82bHfSYwGG8BYeFSCxbFux+jjzg+jYUcq4gwlS9xjOuM8YEv2
 mto+t1a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported by, you guessed it, Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e0220630d00..828d41c0c11 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -765,6 +765,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	       (int)(tagger_end - tagger), tagger,
 	       tagger == tagger_end ? "" : "\n",
 	       (int)message_size, (int)message_size, message ? message : "");
+	free(buf);
 }
 
 static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
-- 
2.12.2.windows.2.800.gede8f145e06


