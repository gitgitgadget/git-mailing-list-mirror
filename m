Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B384C208BD
	for <e@80x24.org>; Thu,  3 Aug 2017 09:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbdHCJUB (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37994 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbdHCJT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id y206so1407221wmd.5
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PnbP8C3L1Wl9N3HipGi2kVtoPVpWEw5bgEJQpQYls+o=;
        b=VmuQnKBEqN41dspIhXLnTB2a3uNt2zPw9BNc81reAHHJ7ywIVSsFVXPDzPP7dZkMrT
         A+w0uDA85/v332jVVBU+8aVToaEFebG7v8kliDrWR730dLc3xtzMu3KowEMpHA5MH16W
         0S9C92LEgr5Uj4Y1QPYuybr3NjKBtG5BEochh8qJFtwuVTIouOj5wP13pzvKAZb7chH0
         JS5ZyLNtcXi5OzwgTxfi1vUfeSvna+NReEAgB5NHSCUZiU6Cdc+1vlr9+kdZ8v0LDIrt
         v0MyrKqROsYL+lzzGN2MiqDumd3yNL7EXIrZOZD8qykV9/Tx7hIQd1tN6/fuR/fOFg70
         zSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PnbP8C3L1Wl9N3HipGi2kVtoPVpWEw5bgEJQpQYls+o=;
        b=cqSZBvSs2XdO0SR1fBBH9DD7kRb4HKvF43zDfDsXwkPZYWWQa4PgDwFuLE4FzrXaJy
         acicfZ7TFx6MKFu0x5+atEFJd56g6A8/ya3OXodcjf9j4V3/BMajg36bG/hUdj3p2Z1z
         ktPc+qoSdqYIYVt4XEInxowfXfJjsKOqXXdM7DZOJ+cbH07rbiIaK2sOw8MN0kh58smn
         oN2pgIc7DcYKtS9P3TUx5KdOc0CfM1a5NchrMHrgwp7XPG5tztc4B0VJ1MmMpaiSTlpK
         fhe46KXQ/aIAHVb6S6iBuXLkBUHIkGqFG2G/ksuiXSVBp7iaWRwa8i7IWcHWhV0e7cK+
         nZlg==
X-Gm-Message-State: AIVw112+JIpLienpBDhVx4TuglGiJSwMlm8m/4J3ROmgFxd67xyygU2Y
        Kc8oMtypTRG9LYHY
X-Received: by 10.28.35.73 with SMTP id j70mr660967wmj.94.1501751994997;
        Thu, 03 Aug 2017 02:19:54 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:54 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 14/40] external-odb: accept only blobs for now
Date:   Thu,  3 Aug 2017 11:19:00 +0200
Message-Id: <20170803091926.1755-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The mechanism to decide which blobs should be sent to which
external object database will be very simple for now.
If the external odb helper support any "put_*" instruction
all the new blobs will be sent to it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index 82fac702e8..a4f8c72e1c 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -124,6 +124,10 @@ int external_odb_put_object(const void *buf, size_t len,
 {
 	struct odb_helper *o;
 
+	/* For now accept only blobs */
+	if (strcmp(type, "blob"))
+		return 1;
+
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next) {
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

