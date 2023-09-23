Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94A1CE7A88
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 15:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjIWPWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjIWPWN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 11:22:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA270A9
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 08:22:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-692c02adeefso615908b3a.3
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 08:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695482526; x=1696087326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVLallzDkOOn/QVapkE5m3n1syzHG35ySXXdojkDgfM=;
        b=TsX55qL5CvH8pjFKhlsUDrwe8Cnk5vl4hfHvbM9cuiiSVbYba1L9eHMj8IzrVBw9XS
         JhZZ8v4D16vyN4L6Iy1GsAjvW6Crc9MHiZl7VFD6Y6whSOm8tYYGbTFMeZpqRIN5KnnF
         DKiaXjhkxNdIpA6arpV0+41xbQK55Q4fTfjIid1S5ZVfrwE24THW92hHkTtgV2RWozig
         RSOoqUVUsS513fxLfsmez5DNb27uSRU23rl01txjiajGjAQjOBELEeF+UJPzZw6gAhT4
         +2Itet+NJBVMhyY56ktw7IlETuS1LSUH7eMFXhkYSzttXXeC0EHxBr85TMcNF4MxtDN3
         /WvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695482526; x=1696087326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVLallzDkOOn/QVapkE5m3n1syzHG35ySXXdojkDgfM=;
        b=pjOlNijgJ61Z3/hflFxxikU+oh/e4hN1xS+oHyId2TJU0lWCNMInXzN5amgjEkcXKW
         z7WJjsF63gE+3DUTyfhszPFuoNW5RAplkNUvVH09SwrPN3lwEGk2pW5OCWoc5ZdyKOdB
         JQAySa7PkHTzzwV0BTMRJWJHyUcdnSrjfwL3P8B388lpQe8GqNzHzd6U6gfj/XkBm5nL
         /rKTSLzISN4HUNfgTcDdmlCmzcEV6Z3KYPNcMZhf/LEK+19U0cTka6VkCyL8Q3KuhRp4
         u8Y14qwApgg5GhvVImcOxvpqsVmJgrprUucsqiga1BVCue9gp/QllwJ6AaN9yK1JAy0D
         f7kg==
X-Gm-Message-State: AOJu0YxXeXGLpRij62o+BwOw1ryI2IYZGE2eSamyzsRhL5XFglEni/pH
        rWslZHDwWXFCBdgku/tHtiVK0PUtfS0=
X-Google-Smtp-Source: AGHT+IHQObb8l1pGHfxdkcw5k7ZCuknyMvNLGdxkC5YhbvWOEim3ty5qUom0WPUe2c1rqgfZqowIlQ==
X-Received: by 2002:a05:6a00:1a0e:b0:68b:e6e0:5047 with SMTP id g14-20020a056a001a0e00b0068be6e05047mr2017405pfv.14.1695482526446;
        Sat, 23 Sep 2023 08:22:06 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a001d1400b00692acfc4b3csm3084310pfx.136.2023.09.23.08.22.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Sep 2023 08:22:05 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 1/3] transport-helper: no connection restriction in connect_helper
Date:   Sat, 23 Sep 2023 23:21:59 +0800
Message-Id: <20230923152201.14741-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <xmqqy1h2f5dv.fsf@gitster.g>
References: <xmqqy1h2f5dv.fsf@gitster.g>
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

