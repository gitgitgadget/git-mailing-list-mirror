Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7241F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbeGRULd (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:11:33 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:34822 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRULd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:33 -0400
Received: by mail-yw0-f202.google.com with SMTP id t189-v6so3080539ywg.2
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=NHM2nBZUjz9dlPOVK4WYYQugHYp34D1YF5yd6SlF5/c=;
        b=ryVPYguSW/0AesTgl7AUuSvoMv9e2fdis2OXTM/WUEUrdwG/Xh08mXe8EjcuTxrLHK
         GrNm8tghMFMY9cJIiQX6CYI4wtJaGzggxQlV77uhIh9jreDK3mMulZkY6HDCpctAU9Ic
         vd/bYPulJ1Wfx7tkum1BCzDfrCFPUBtdQYJfdkpvvgf2GuzXxMsbJ6zaa1Fp08Q6z/NA
         xezVXqsc/6xhT5iijB0V/f+B9Mydoa38Edre3/mbw80v5JpD43OkxQ7ahC7EjjQ0L+hw
         hyDCYHbSiBoLQl6OyuQOndkCcANKsIOiQQaITXiDmTFhHlb6rNj3SlGuXTENlsor910b
         alUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=NHM2nBZUjz9dlPOVK4WYYQugHYp34D1YF5yd6SlF5/c=;
        b=dO8eL/gPgSMjMq0S7rodymR0gXuICw52j4ZZeMStbqKtZzf65tcZh5eP6KFtmLj4LO
         n0Wbmxdw9EUq/rQv0AQP7hsplas2ZN8fA+/SEA2CsTE+iwiqHJHO/ixWdxKxSR4MjZNa
         GQwr5ZCfD4O1rfldKpws3Z3RN1PADnZ9NBceAUA9xqqMAWbUCXQ/wsF5PJw/+cEW9qqR
         o2M8Rm31sicw7aAZZefwNOygTM7CM7ovPAxIfRHelel6FgdagkZtn0ySDkepUSBH/WdH
         U0KDlBlQCLbV3DTPPsNacC+pKCoPQ6TwRUCXSOlJOzi9JcW2i4A/uHk9kLKQtAX9zMGT
         vUfQ==
X-Gm-Message-State: AOUpUlFiiwJ4J10bVCW2UOwwoz6N0DclsOSW9Vqm7/qRaoI9SHuaGYhN
        UD6mhcuze0UX2B40yH80WagK99qFiLNsRceVrJpcSwzcJPYQjskq/rc4R5LrKR96UUqfHd5MqhZ
        Ps53dismPgnoR3ElYPv2eYp8eD/0OdJF/F/JFxeNawCeShRLvD50bp4LhOks7
X-Google-Smtp-Source: AAOMgpc/e8O05DFlOm0K+biFCxf+wbXjvd4oClBCEmeLygwpJ28ax8uzNhQ8WLDc751QLzhEABLqh2hZarpd
MIME-Version: 1.0
X-Received: by 2002:a81:c903:: with SMTP id o3-v6mr2149498ywi.192.1531942333297;
 Wed, 18 Jul 2018 12:32:13 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:31:50 -0700
In-Reply-To: <20180718193156.47365-1-sbeller@google.com>
Message-Id: <20180718193156.47365-5-sbeller@google.com>
References: <20180718193156.47365-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 04/10] diff.c: do not pass diff options as keydata to hashmap
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, rybak.a.v@gmail.com,
        Stefan Beller <sbeller@google.com>
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
2.18.0.233.g985f88cf7e-goog

