Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365DFC433E9
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 00:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E9964FA7
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 00:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCLAtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 19:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhCLAsw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 19:48:52 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EACC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 16:48:51 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id g185so22728744qkf.6
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 16:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6OZYr+w6fZOm/euoBxVrioYJY068sOfGoEylMtzoAAc=;
        b=FLWdsjUsu3Q3/3jtMzViSIsGOQj6h50E8twLqa8huhyMTJ5QKNU58KbdJCLXEAaEg2
         ro4e1OxSHH11987HYBsVFUd+SkRAbtKqZg+QQoGwQoeB8io+G/UrjtGwFB5HUdwG7rMq
         qYekl8MZQM6NDNs6ZKMgwAFL9iq+zFf7VRnPzVklrnBdP627+F+SH2bEOnIny0wszpMs
         35iUcjLQrvkvfdfDlPH1sUoHh/X7ztbgoEf3TXpQOtPDU2qNJjy3SrIYYQR4GcNFQ7sF
         5VQpwcObDVWjHJFVOu34gVt4WPRhMq6Zy8GLPOEBew2RDqFXSyfIBbRMMUWZnJeBKvIg
         CLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=6OZYr+w6fZOm/euoBxVrioYJY068sOfGoEylMtzoAAc=;
        b=YxYfqkTBXpARPB2iYw97YEBJv2+D1xMReSYUAFj0Umt8FRvaTYgrC0HP6fUM6uE+qE
         yhRw2Pnic/WgOV5+AJP6ADmnY2V7FB45cOTu73CZ4wwxNrsUI9DEb/PdLRn7N1eRitSC
         XbfK/xZw14R6+qrEcSEFV7zFoCy/QwFYyvA3+aakNP1/liDc8b/EnY6a0Pbcpginm98n
         0b4jG+v8OM0eyxiEHS8dZXWeXauCLQwzGJBEm36V2smXnN4W3V2BsPbMUOtxW6SSocvm
         7TOeIU+1OceKYx6cCQ3aNh6SvCDBGADpkns2akIfN/q85hWZNeCfw3ykIjOe0yQOZnbE
         XAZw==
X-Gm-Message-State: AOAM5326lHqUDpopZPcjcOXzCdq7DWIFHgV8UVhz1jl/8i3PKk56w7nS
        vhpEOn0O89MBtKXHsxCWJokepwA0E9M=
X-Google-Smtp-Source: ABdhPJy7740WnBIdZsLUuoGvLB0AiD981wN9USN5lUlsZ+migkqgEPFlqEDKZ6RFo7snFYYDgVdWow==
X-Received: by 2002:a37:4895:: with SMTP id v143mr10431075qka.345.1615510130896;
        Thu, 11 Mar 2021 16:48:50 -0800 (PST)
Received: from sidious.home (pool-71-121-201-126.bltmmd.fios.verizon.net. [71.121.201.126])
        by smtp.gmail.com with ESMTPSA id i5sm3297092qkg.32.2021.03.11.16.48.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 16:48:50 -0800 (PST)
Sender: John Szakmeister <jszakmeister@gmail.com>
From:   John Szakmeister <john@szakmeister.net>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     John Szakmeister <john@szakmeister.net>
Subject: [PATCH v2 0/2] http: store credential when PKI auth is used
Date:   Thu, 11 Mar 2021 19:48:40 -0500
Message-Id: <20210312004842.30697-1-john@szakmeister.net>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's my second attempt at getting the certificate password into the credential
store.  I tested from a working PKI setup and found curl--at least reasonable
recent versions of it--return CURLE_SSL_CERTPROBLEM:

       CURLE_SSL_CERTPROBLEM (58)
              problem with the local client certificate.

It appears there could be another possible error from curl:

       CURLE_SSL_CONNECT_ERROR (35)
              A  problem  occurred  somewhere  in the SSL/TLS handshake. You
              really want the error buffer and read the message there as it
              pinpoints the problem slightly more. Could be  certificates  (file
              formats, paths, permissions), passwords, and others.

This seems less likely to be a bad client password scenario, so I did not look
for this particular error to reject it.

I also added one other small patch to remove the check of a non-empty password
before calling credential_store() for proxy_auth, as credential_store() already
checks for a non-empty password and gracefully handles it when it doesn't.

-John

John Szakmeister (2):
  http: store credential when PKI auth is used
  http: drop the check for an empty proxy password before approving

 http.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.30.1

