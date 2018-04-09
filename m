Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295431F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeDIUmQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:42:16 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35072 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754097AbeDIUmO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:42:14 -0400
Received: by mail-it0-f43.google.com with SMTP id v194-v6so12026512itb.0
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r2t3gNfCO6IfUA1bbi+84t+25Sulo05Ekc2cRYNHHm4=;
        b=IyK5XHX1+ySHZqnmS81A0es5ZURuAXiY2sKTNmizME5EaUu1tE+wrM3sUb69qxGEEv
         3x53iAOcfQpyVJzyrCk7l2DQ6xqNGhpIuzY9IEbXnlvfdGiUask9Hn1FJ9dAGIEMoNr+
         /BOaW2R4xAsth4Xcdec0r7EsBzCeCKP29Lw9vwF+3bZD6o86RVictjSM4JsypyPuAL8i
         87El8RWvNRhhAHgl/et/B4W/TcHsJzwvH40r2wjBroX/6F+/y59G4AePd+fOl/Ic4IF0
         wNIzPfRe9608Fd8DN08HOv68DcODcXuDQm9iz4m4yTLIxLjDJIdIt+5B1i2eoBklSpmn
         X0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r2t3gNfCO6IfUA1bbi+84t+25Sulo05Ekc2cRYNHHm4=;
        b=tVauQgSDBM25XL2Pd3+9eT5lc6NMcI9qmeRFk8sQB/VdFUEfkisfOFq5AT8XcJ2Vp6
         umHk6SLXL9+Zqsa60bYDwzXodAcz3JpfAUnculwgLL/ro1Hl4wgvqWL5ZNfNhbnK/lVm
         D07Ovjg0H85MC1NSEaQRZdOTN5vJExZw87UyL+3lhnafqUHHisamD0b19dNBRp1DemE8
         9Xc/Zw2/b93ALCLOo/hGZtbJT2ng5D8IAZP6pYhmamlSsS+tvqNtLag0+l+NljvkpU6L
         MSoggvNF55p2gVP+E8q92ju0nbg8mXs6Rtl+a8EKtC1+9CrtZj3T/0vGpS3wFJqr0MaD
         /irg==
X-Gm-Message-State: ALQs6tBwLnEpBhxMLDLVeptIetmNut5tFY7aG17Xy5BuDXZS66yUBQF+
        Cr/S9J3b2ohr/94zwSqeSxgfFt16
X-Google-Smtp-Source: AIpwx4/s+CGr+/oGAVrtYEr45n8qoKJwGEWvc2Z67f18NmE5XrejGUCCKPwk3hbbWn8pHbnJFTHK3A==
X-Received: by 2002:a24:393:: with SMTP id e141-v6mr1617660ite.17.1523306533289;
        Mon, 09 Apr 2018 13:42:13 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id 134-v6sm98775itl.34.2018.04.09.13.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 13:42:12 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, mastahyeti@gmail.com
Subject: [PATCH 1/8] gpg-interface: handle bool user.signingkey
Date:   Mon,  9 Apr 2018 14:41:22 -0600
Message-Id: <20180409204129.43537-2-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180409204129.43537-1-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The config handler for user.signingkey does not check for a
boolean value, and thus:

  git -c user.signingkey tag

will segfault. We could fix this and even shorten the code
by using git_config_string(). But our set_signing_key()
helper is used by other code outside of gpg-interface.c, so
we must keep it (and we may as well use it, because unlike
git_config_string() it does not leak when we overwrite an
old value).

Ironically, the handler for gpg.program just below _could_
use git_config_string() but doesn't. But since we're going
to touch that in a future patch, we'll leave it alone for
now. We will add some whitespace and returns in preparation
for adding more config keys, though.
---
 gpg-interface.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gpg-interface.c b/gpg-interface.c
index 4feacf16e5..61c0690e12 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -128,13 +128,19 @@ void set_signing_key(const char *key)
 int git_gpg_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "user.signingkey")) {
+		if (!value)
+			return config_error_nonbool(var);
 		set_signing_key(value);
+		return 0;
 	}
+
 	if (!strcmp(var, "gpg.program")) {
 		if (!value)
 			return config_error_nonbool(var);
 		gpg_program = xstrdup(value);
+		return 0;
 	}
+
 	return 0;
 }
 
-- 
2.15.1 (Apple Git-101)

