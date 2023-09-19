Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A658CD343F
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 06:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjISGmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 02:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjISGmI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 02:42:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF714102
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 23:42:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c1ff5b741cso49738495ad.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 23:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695105722; x=1695710522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8AbktxMritALT3hoKVw0k6JBaAnVOtK6zmtWZEZmis=;
        b=BHOouDxEFWYUcyHrg4DVbsbEZQjl6Z5SDX4qIebDs2gWmEj/sbXmRpcWefFue8gTTE
         ZIQ5a/MlkSc7YpnPLIbPCeq5NcyO10icmV1PUU3CjRR9uEfxHrCNmCGy8yL2NkQa/Xm0
         YQ4c+VfyaSLjT06ojPnI3YWWkM7HOAt1jEQ25w/b8XbTzSgy3e0tNZGoMnmrv9MRc7XT
         OuCueJ19n/N8dFoIBj3Uobkgn419Uj9G5W+1lwn60HBEtQ2/KG3YCZEAL54vZsmXCFC6
         bIF57Zu71EwyCoaPaKn608W5gP3C++ueCtmmLMNR2FYltapkR//65s+4nddS6TR8KToU
         K0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695105722; x=1695710522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8AbktxMritALT3hoKVw0k6JBaAnVOtK6zmtWZEZmis=;
        b=pIfWQBMEYdSpyA2rN8DJIlzq07UpEkVOmmL6MkGs1R2W9BTuE6LiYUBjKh3KNiWAZl
         IxNsMCrodM8bSNPQVajY1KqdPjuRJ+dMsaOBwe6x5xDeeC9lQ+9W9618VAuB8tCNmBY1
         ldleRIOrUN22caWejVO3eEa3eE6q1hap80apfonMN3mzcyI1uiSzIlh6ZVA8BZUyv7sF
         4K3izWhXF5p1Cbubm9X4L6WGXof86NxCdPdpwUp+8r/LfBnx+ktAxp9Yh6staKmKcoxV
         I8AMB6QWusIvp/9QXzxxDS0We67nUGljlgwvrFehsqAqkg+DhgsOXqNj+vRK0tD9FmO6
         kSYg==
X-Gm-Message-State: AOJu0YyrMM2ghCuAl3P2ZJsDfKOFooqoOAQCuwRt5vznWDiEaAviPjHQ
        EPRcTYWavscPq0Dtazijxkt1eGfNHS0=
X-Google-Smtp-Source: AGHT+IEnMm9e6bkaITnlYPmta0BlPqO/tSQ8QLSihL8iMie3ZlHPmw71PamjTAad4ntz/C0Bda4mew==
X-Received: by 2002:a17:903:26c7:b0:1bf:8779:e03f with SMTP id jg7-20020a17090326c700b001bf8779e03fmr10309121plb.68.1695105721855;
        Mon, 18 Sep 2023 23:42:01 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902cec700b001b89891bfc4sm5286495plg.199.2023.09.18.23.42.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 23:42:01 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 1/2] transport-helper: no connection restriction in connect_helper
Date:   Tue, 19 Sep 2023 14:41:55 +0800
Message-Id: <20230919064156.13892-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

For protocol-v2, "stateless-connection" can be used to establish a
stateless connection between the client and the server, but trying to
establish http connection by calling "transport->vtable->connect" will
fail. This restriction was first introduced in commit b236752a87
(Support remote archive from all smart transports, 2009-12-09) by
adding a limitation in the "connect_helper()" function.

Remove the restriction in the "connect_helper()" function and use the
logic in the "process_connect_service()" function to check the protocol
version and service name. By this way, we can make a connection and do
something useful. E.g., in a later commit, implements remote archive
for a repository over HTTP protocol.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 transport-helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 49811ef176..2e127d24a5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -662,8 +662,6 @@ static int connect_helper(struct transport *transport, const char *name,
 
 	/* Get_helper so connect is inited. */
 	get_helper(transport);
-	if (!data->connect)
-		die(_("operation not supported by protocol"));
 
 	if (!process_connect_service(transport, name, exec))
 		die(_("can't connect to subservice %s"), name);
-- 
2.40.1.49.g40e13c3520.dirty

