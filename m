Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82AAC636D4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjBBJpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjBBJpB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:45:01 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02639659D
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:44:32 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h16so1099824wrz.12
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWiYexL7LMeUZ3YiAnb4rCGHnEv0h+K9CVMnd7y+q/o=;
        b=QVVBD2rE1LE0GE5iyY+oCyUQvTJWNzO5Cscd1bq+ZOhSmIJ8DCUs+rZ/5SGQ+ljpok
         Xdbw76jBPvuAG7dgXSevOo+5at68+jIxOWPfGN3taxR+b7z5coLQL60B0gSBfmtDbwC6
         TFZyhdYeFX/NbBy1Ei1u4doRIaUqbUYwcs3VOAJOl1KfeR1kek9+ohn2dHX2evoJc7Go
         9XRpJJYZMkPHCD63WNN4wGheom2X56L5bI1hg6CTZeTYAqrtElBtF+0uXC2NwSOaFGN7
         nMzzyXJhh6d39+Rt26GTCOp/SNnIPuOJgEVk6I6OHrFFfLnJaVfT9t66oJ9sY8G2VAAE
         y5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWiYexL7LMeUZ3YiAnb4rCGHnEv0h+K9CVMnd7y+q/o=;
        b=Rh1vihWzlpnICx+D5+hjWXGkNt45bPA8yH8YMdfmPpERrTNLMPTcWazmbE7CtGvmCy
         3X7UPUd+CnIJqZ9YAwxsyofkVV1AmPXpP7l0cevppVA+Rdb9GSV3gKVFHNBJ6IYXzNgj
         IDJF3WlQJ8ZEBrmP6nj1Qj5pFJHcr0yj7wXZGWezyKGZ8UC+6YoTQdtmFrMCq/0TjTYr
         HUaA/rq53sFw2XkpA2M3/SqjYSjnuvWKzRfnKm0kscRd5oLcOi/O33ZpmFv7DxUnafUp
         6oiak5NhiRU++X66M3rjRgFFdTS0wK4gVHpsRwLe0X9/2CM+Ehvpy4i5Wq81nKd2F+mA
         iAeA==
X-Gm-Message-State: AO0yUKV5P3iCsFJOjZX8NuYNd22N7aWKedlV4m/nVg7Hiz7PSPMHZ4G5
        u9CxKFEPcScRjLO0FuVCCRany7Lria0tuker
X-Google-Smtp-Source: AK7set8e/Zoo/kU6r1sfJ9GpkOCz9a4bNyFogazAOGCcyEHJXkA2Qp02nbXnYabs4xnEKoFTvv/6WQ==
X-Received: by 2002:adf:fe86:0:b0:2bf:f6b7:7a63 with SMTP id l6-20020adffe86000000b002bff6b77a63mr5883411wrr.0.1675331065071;
        Thu, 02 Feb 2023 01:44:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0029e1aa67fd2sm19487938wrx.115.2023.02.02.01.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:44:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] imap-send doc: the imap.sslVerify is used with imap.tunnel
Date:   Thu,  2 Feb 2023 10:44:13 +0100
Message-Id: <patch-v2-2.6-1dfee9bf08e-20230202T093706Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This documentation added in [1] claims that imap.{host,port,sslVerify}
is ignored if imap.tunnel is set. That's correct in the first two
cases, but not for imap.sslVerify.

When we're using the tunnel feature we'll call ssl_socket_connect()
with a 3rd "verify" argument set to the value of the "imap.sslVerify"
config if we're on the !preauth path. There is also a call to
ssl_socket_connect() that's specific to the non-tunnel
codepath.

Perhaps the documentation added in [1] was written for an earlier
version of [2] (which was introduced in the same series). There is an
earlier version of the patch on-list[3] where there's still a "FIXME"
comment indicating that we should read the config in the future before
setting "SSL_VERIFY_PEER", which is what we'll do if "imap.sslVerify"
is set.

1. c82b0748e53 (Documentation: Improve documentation for
   git-imap-send(1), 2008-07-09)
2. 684ec6c63cd (git-imap-send: Support SSL, 2008-07-09)
3. https://lore.kernel.org/git/1096648c0806010829n71de92dcmc19ddb87da19931d@mail.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/imap.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/config/imap.txt b/Documentation/config/imap.txt
index 06166fb5c04..96b1c0927d8 100644
--- a/Documentation/config/imap.txt
+++ b/Documentation/config/imap.txt
@@ -26,8 +26,7 @@ imap.port::
 
 imap.sslverify::
 	A boolean to enable/disable verification of the server certificate
-	used by the SSL/TLS connection. Default is `true`. Ignored when
-	imap.tunnel is set.
+	used by the SSL/TLS connection.
 
 imap.preformattedHTML::
 	A boolean to enable/disable the use of html encoding when sending
-- 
2.39.1.1392.g63e6d408230

