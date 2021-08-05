Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE20C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28BD60BD3
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbhHEB0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbhHEB0H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:26:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03894C06179B
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:25:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m19so2292408wms.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Ymf7R7rMeOKO93Ypm3exSNjCvOhNIqvGRAWbT0oYvA=;
        b=R7920B05TK1Wd7XWPPChyuX6erKEIkVuiMfT2z6QJzH/opoOUBjxnC+35OgBV4BOMx
         KBLbiprtt6i8EfsI595CKHTLVem6vqEmiNBs7fHYmyd3eMIEHgCmwz53zTmEtVTKw8jo
         sxSXOoJlGvkj+954cQXwvdGt0pq4Lcrg3y8Xw433tZUsV82WN11zEjKPJFlyY5LW3bgt
         6JlywCDyeTGzov8C+pV3AkLrG1ivKPLVEFDSxUvxMy/mVPPD7QVNDwcsQnXFnEFoAzZo
         cUATrG3LaLhEXzW1IhuhM/vo4X9AH0Db5lkTifpK1WtCEnw9vnjaVdap5LsHJJkCBKYq
         fCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Ymf7R7rMeOKO93Ypm3exSNjCvOhNIqvGRAWbT0oYvA=;
        b=Tx9ha87UOWaQoMuVXmUtNcKUaAwwFkxHkhZ56XUEAbUwxvTzCTX1gc1ZoAnmJ72ii/
         YNlQa4lBA6iRdXpGJNrd1fsJJeB8daPRBcQa4adTU9ypKJDbc1fJoS5DO6hybKx2MAMq
         iTrXQR9acuA8xsLr5HzhUCmhxS4YjJuUngQfbC4Jje7PMY3Jut2k0XHUezyEc/wRk99n
         YxdlGaENlqY01lU1ZOEm8OFiROPbgzbzIBUUtaeN28JVvLh/ySZ1X8JcGXJfUQIQng7N
         zrhrvC7B/eBP6Fx9i2BNP2cDtO43PZESmVbh5Sjb9vNO4H1eiA/T0jsbWwTLfoih1DV1
         +V2g==
X-Gm-Message-State: AOAM5306gp61Bzj7nzhIh3v64ECE9jYqpQSpwB+2xu7Hildl10virtDJ
        db7SXKHqVHspiuwL0blmeX4za0zkVtlXHw==
X-Google-Smtp-Source: ABdhPJxdUBDp7siqn3nNfbg2uuFLfv5sKZwlokEy6xS5WlRi/rcoB+4hQFhu0oSvEd9xYzbgdEkcOA==
X-Received: by 2002:a1c:9d4a:: with SMTP id g71mr2177167wme.116.1628126750395;
        Wed, 04 Aug 2021 18:25:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm4120176wru.50.2021.08.04.18.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:25:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/10] serve: move transfer.advertiseSID check into session_id_advertise()
Date:   Thu,  5 Aug 2021 03:25:39 +0200
Message-Id: <patch-v4-06.10-33db6b7cf53-20210805T011823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 6b5b6e422ee (serve: advertise session ID in v2 capabilities,
2020-11-11) the check for transfer.advertiseSID was added to the
beginning of the main serve() loop. Thus on startup of the server we'd
populate it.

Let's instead use an explicit lazy initialization pattern in
session_id_advertise() itself, we'll still look the config up only
once per-process, but by moving it out of serve() itself the further
changing of that routine becomes easier.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/serve.c b/serve.c
index 967bf17d623..26829991333 100644
--- a/serve.c
+++ b/serve.c
@@ -9,7 +9,7 @@
 #include "serve.h"
 #include "upload-pack.h"
 
-static int advertise_sid;
+static int advertise_sid = -1;
 
 static int always_advertise(struct repository *r,
 			    struct strbuf *value)
@@ -35,6 +35,9 @@ static int object_format_advertise(struct repository *r,
 
 static int session_id_advertise(struct repository *r, struct strbuf *value)
 {
+	if (advertise_sid == -1 &&
+	    git_config_get_bool("transfer.advertisesid", &advertise_sid))
+		advertise_sid = 0;
 	if (!advertise_sid)
 		return 0;
 	if (value)
@@ -300,8 +303,6 @@ static int process_request(void)
 /* Main serve loop for protocol version 2 */
 void serve(struct serve_options *options)
 {
-	git_config_get_bool("transfer.advertisesid", &advertise_sid);
-
 	if (options->advertise_capabilities || !options->stateless_rpc) {
 		/* serve by default supports v2 */
 		packet_write_fmt(1, "version 2\n");
-- 
2.33.0.rc0.597.gc569a812f0a

