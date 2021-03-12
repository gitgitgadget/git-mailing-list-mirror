Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51954C432C3
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 02:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A93A64F87
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 02:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhCLCkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhCLCkg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 21:40:36 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10F6C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 18:40:35 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d20so22958483qkc.2
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 18:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLf8+ggebEbDcbTKo+KGa5SyY6oewYeBeNHJPh5/70k=;
        b=KktAbmB2HSZmYW/afE+27kNTxI/4z5GXRFI/20k26trSOtfLZof8brhYWKKrd2ZyT1
         zQrlRheHz+IfjcUlluSvFzCoy+B8qfhPgrnA489tLLTya8XMssG4fSWpBoGa9pFFKllu
         HWwK6TOR7dpm+lPplgDqdiI3jGgB2gIlebMIHEdXwxbnYDrgpVLgVmhn29nX0LqLHXHl
         zb0OEWL4HChg5vczdHeDURXg1t6OVjcJA1plUDS2layT+r0ewm3Jt587zHH1jqNpCxvE
         YL4NRV6NFlMqX1ywbdSG6j+1p9nEgObq2cdAa4A7rekuAj9Bb0Q//zcrULjRgY7L2YTj
         xKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=fLf8+ggebEbDcbTKo+KGa5SyY6oewYeBeNHJPh5/70k=;
        b=RponoBwODjy3L/8/lyRxXAGNHVeu0aqzHgszjzs3WwhDhkXnRnkGkooEj//z3GQJPH
         BhjDYgn1fc9M2BlHx56/tYtaervfjoDLuEGOwd1Dpkjqq+xPN0iBDsWJ6FbZjig9ijU3
         b396+LGQELcJDFCiAA6eYuS8ZYVRn1FCcImpAQ0gnH2OKm/c/csK9Sa5qoLR/xjeHaSV
         MJd/VO74JO9namDkt62L2nCK3N5M1s+5YHUSIv9DGfK4K4l8b2+O/LPG1kFpz/C19ARs
         +5IIipFzbmr40Z3lgr24vhh0tYjIHvrEhim0+dVIWftTmopVycKFIVUyYPjbpJHjbkGO
         CmoQ==
X-Gm-Message-State: AOAM531vNFG4MVGeaB7AUQLuXkl5wUOQEQcj1fZLOmdatUveMfOq/1Uk
        5dqh1qV3IWbOKag/lBsMYozpMWUR3ag=
X-Google-Smtp-Source: ABdhPJxuZ7WxPDVdceD1u9NGdXRZViZp+EyXAw4ZesJrczsAu8oFKLcpReizWavy/vtPxmA0ux/oWw==
X-Received: by 2002:a37:4895:: with SMTP id v143mr10736963qka.345.1615516834819;
        Thu, 11 Mar 2021 18:40:34 -0800 (PST)
Received: from sidious.home (pool-71-121-201-126.bltmmd.fios.verizon.net. [71.121.201.126])
        by smtp.gmail.com with ESMTPSA id j18sm915339qtl.83.2021.03.11.18.40.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 18:40:34 -0800 (PST)
Sender: John Szakmeister <jszakmeister@gmail.com>
From:   John Szakmeister <john@szakmeister.net>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Junio <gitster@pobox.com>, brian <sandals@crustytoothpaste.net>,
        John Szakmeister <john@szakmeister.net>
Subject: [PATCH v3 0/2]  http: store credential when PKI auth is used
Date:   Thu, 11 Mar 2021 21:40:25 -0500
Message-Id: <20210312024027.33418-1-john@szakmeister.net>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Essentially the same, but rejecting the correcting credential this time.

John Szakmeister (2):
  http: store credential when PKI auth is used
  http: drop the check for an empty proxy password before approving

 http.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.30.1

