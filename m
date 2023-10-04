Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2323FE7C4CE
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 15:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243114AbjJDPVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243104AbjJDPVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 11:21:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598C0C4
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 08:21:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690d2e13074so1794076b3a.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696432907; x=1697037707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVLallzDkOOn/QVapkE5m3n1syzHG35ySXXdojkDgfM=;
        b=DIKqKbWEyTiQ32m5DcG9+OycWB4z2bFoGSEGSBk19pTwptLzogQB9q9Dng7xtviENu
         BOi44Qs7EcicGRcpOv5TajP78rZdaobz296Fg96etuZjMOuYQ1SHuUSW8sZh0NiELG8K
         oVrT/OUbJgKvR79hSV4jTuYFNXaiXkPYRenV5TqN/8kErj2bSeSyZc59Mam+Ap5PPr66
         pfZzZTh1vSPEyIedlaTJvl2Gyd6YxxMIo9JCPj0vPsq95/NWqq13kszDVRzUKt4WIXV9
         z8WViDxIcqJaxcVZkczVdVTRJWm6N10FRt8a+cNmrNFvhvcKODHwUghGj+JrMHNenIDQ
         TGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432907; x=1697037707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVLallzDkOOn/QVapkE5m3n1syzHG35ySXXdojkDgfM=;
        b=oR7p/44rD/7q4CMP4AxPcp1DGYwy89ASSBo5eW2zrP0ZC9LPHrGR8cnG4mUn9XRFww
         BkfnRExerH6A4bCxyp6lQ5RLEL4g8/tDjUxDBRzlDcbD7Rwy7clqKGR/vege3NVwd/GQ
         ybM7clhvnrPDSSpv/YImB8pDzML1GV2/Ek33W/XnDYkZ+CiT4YgdoTj1bYzq+VPHekBn
         IHTtKYmncns9WHH1hwqTEU2OfQ5dOmHuEyMOiKMaHVWx2HStyRsp3SfEHpERexLIkfi1
         b006yBeOncoWmUfE6pyivtF5hhm3raC7m8T4+OKIBPZJ/Nwky+GCc2iWhMczcn1CxB0n
         bVkw==
X-Gm-Message-State: AOJu0YzRo5CtmmonSLQvMypqio/PSZYuMhbN9jGdq1XZ1Q6q+K/M0O5m
        sOXBnuwL1WidKlt7fD5u/iJkPVI3j7s=
X-Google-Smtp-Source: AGHT+IHpUmcRv0QR2GBdgFUaIaVYs5GZaBlerhQe2kbDECAcP+r8ZhDjTPMgFSKWsUPNWq+jVg/OKA==
X-Received: by 2002:a05:6a20:3c8b:b0:12c:b10d:693d with SMTP id b11-20020a056a203c8b00b0012cb10d693dmr3097357pzj.6.1696432907582;
        Wed, 04 Oct 2023 08:21:47 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b001c5f0fe64c2sm3838199plh.56.2023.10.04.08.21.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:21:47 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 1/4] transport-helper: no connection restriction in connect_helper
Date:   Wed,  4 Oct 2023 23:21:40 +0800
Message-Id: <e660fc79b64a1bd02bdb1e1ea6f95701ae31a68f.1696432594.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
References: <xmqqil7yq6ms.fsf@gitster.g> <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When commit b236752a (Support remote archive from all smart transports,
2009-12-09) added "remote archive" support for "smart transports", it
was for transport that supports the ".connect" method. The
"connect_helper()" function protected itself from getting called for a
transport without the method before calling process_connect_service(),
which did not work with such a transport.

Later, commit edc9caf7 (transport-helper: introduce stateless-connect,
2018-03-15) added a way for a transport without the ".connect" method
to establish a "stateless" connection in protocol-v2, which
process_connect_service() was taught to handle the "stateless"
connection, making the old safety valve in its caller that insisted
that ".connect" method must be defined too strict, and forgot to loosen
it.

Remove the restriction in the "connect_helper()" function and give the
function "process_connect_service()" the opportunity to establish a
connection using ".connect" or ".stateless_connect" for protocol v2. So
we can connect with a stateless-rpc and do something useful. E.g., in a
later commit, implements remote archive for a repository over HTTP
protocol.

Helped-by: Junio C Hamano <gitster@pobox.com>
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
2.40.1.50.gf560bcc116.dirty

