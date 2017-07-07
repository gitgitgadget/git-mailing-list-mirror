Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450F620357
	for <e@80x24.org>; Fri,  7 Jul 2017 22:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbdGGWCJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 18:02:09 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34379 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdGGWCI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 18:02:08 -0400
Received: by mail-qt0-f196.google.com with SMTP id m54so5901766qtb.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SexlO+TPgIjSOalgVd8ns88jzMPm8C42TFMu4SsllQI=;
        b=azJUiWg9s2k3um4rVE59XAYhXYluxz1hpExmmDYyq5ldIeiaarGqSW2cPoCk6FiKGD
         Ks8DitzSHGEsfn8nZvc5ictkOoFjsumZ7BfCXrbyNXpvxTuwjme+GRNeGrH8AvJ4EhiB
         RDE41VGAfK5ZS4C08XTejYQ3ILVFV5p0j5FGEEtGhtPWI3EfT+jkWf+igS2UqWx2m5cx
         mtKEjIX9vWUekG/996ksRaSEKNIuz/fwpHPdIQwh30eJS13pc848Bl6vfEQlmYaFodjD
         s7X400PAujtzDelHbEkwU5goatKbHTughbFR2FVGqzmBjgLO+DQlX4C8kOs+lUxa3AaK
         HnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SexlO+TPgIjSOalgVd8ns88jzMPm8C42TFMu4SsllQI=;
        b=YQOhDGhiKMr+X+ISTFrS2cohVKBB9YIuc3fMOT13KcGeGpiL2NrLzqFH4PULQRtxWj
         ArViyxHO7/8/PE7SRIAwQykjHpu+aFqMwtYVbRybbHSqCDNIEPlAiv0wDICAixtEsk4f
         z71y99T5lww1noe2C/LPLcjTbp7HNph7+4FMd+aK17rY0nqUtNPW4oF8QKneVijs3k1U
         /3xp0FCyekLFY9LzwKfY2fyJdK/6BQwuSOoSvxFUPI1TUdWezvuy6hPuRkb56783Na1k
         UNGPEisLWAIqcHmN+hcgh+iAFiCfaawHnCBgFr/cOXevzQArEEe2NOKb3Dv4A4rykm8g
         9XvQ==
X-Gm-Message-State: AKS2vOwbHAmjeUE5WkR+dSN+53FA9ocaI6AFr6XvbL2lc3+W88iEWE+l
        IUXZbknK0rRvKQgqs3s=
X-Received: by 10.237.37.116 with SMTP id w49mr73737649qtc.14.1499464927515;
        Fri, 07 Jul 2017 15:02:07 -0700 (PDT)
Received: from localhost.localdomain (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id j17sm3394100qta.49.2017.07.07.15.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 15:02:06 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Santiago Torres <santiago@nyu.edu>
Subject: [RFC PATCH] t: lib-gpg: flush agent sockets on startup
Date:   Fri,  7 Jul 2017 18:01:59 -0400
Message-Id: <20170707220159.12752-1-santiago@nyu.edu>
X-Mailer: git-send-email 2.13.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

When running gpg-relevant tests, a gpg-daemon is ran for a
trash_directory-specific GNUPGHOME. This daemon creates a unix socket on
the target host, and it will be used on subsequent runs of the same test
script.  Add a call to kill the agent and flush the sockets of the
relevant trash directory.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/lib-gpg.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index ec2aa8f68..22ef2fa87 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -31,6 +31,7 @@ then
 		chmod 0700 ./gpghome &&
 		GNUPGHOME="$(pwd)/gpghome" &&
 		export GNUPGHOME &&
+		gpgconf --kill gpg-agent &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
-- 
2.13.2

