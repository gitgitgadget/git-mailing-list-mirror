Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244E9C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 09:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E176D20771
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 09:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERcOeGDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCRJ65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:58:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46621 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCRJ65 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 05:58:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id c19so13618124pfo.13
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxY7o2FYqS9xjtq9UsRFL+AJcu1mdPP5rHFHZWG3pfQ=;
        b=ERcOeGDlipUVypVULN++/vAQZBK6x/Uu3OEW92I8KxrUATRRNDMdrfF+QYiyPTWbLu
         2iVy/b4ter1zqyPiXdTIJ47GwPk/G6xREL6Ur/SdHJV2InE2V8q3LRq9tOUU3fJf1Pfs
         DxWwt4fE1ke7DBG6qP//28xAEp2QyIk1t7hI+cQDoRWLU92irnVwzSZqshCldzcjhGdS
         IvsuZd4uGYi/tdK5bNs2nu6zXZnGu7FeQG/+ooh/wXqqLJvbtqFcw3mrWRxVVXYDQMYc
         TC+J8qqQWHdXIFri+JUzqe4PTyoUpXJ2KwihNcgbsHkK3it1JACsnGMdRQ9xrn9P95UG
         w9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxY7o2FYqS9xjtq9UsRFL+AJcu1mdPP5rHFHZWG3pfQ=;
        b=OVPrF2H88ngdtWFJS6jZZ8cP76/rFy1o3wQdfAlR9cloG7tQhNy4Cw5XTsd2JymQNX
         wIfVJMkI/Za3/gVhRzMvFhuff0PYtwckA+FGEZZ6kiXQos1Gqfm9FuqzRtV+qhqCRp9q
         yG1YITfTrUdC0HzGRNOT2BV9FIIYRw6f3Xd4/hKyvt1iR5AiDLSLTijbaodCzp1HfNqk
         zOQTwwnWpal/HTQjTu4lXzo7Ig2B2r+u45EhZ7dplKIHrc4MAHtBec8vysJHZ3AfEFtu
         xpjJPa5h/StWz/y2Blt/5lHWF2eCElAq+zr7FgQjuN0TFve271an1Lzqkba8JWkXguK/
         DQ7Q==
X-Gm-Message-State: ANhLgQ1NgPI2d2S/QHp6FVmgESQc9pQc5Bcuer3iZ6LCXPrKdKlHmunV
        pUMqiI5sFDgJ+UqDDLwLX7kqsdtYpvS9cQ==
X-Google-Smtp-Source: ADFU+vv4aMpnD3kD4d6usStAFr0FR9TZAPoSOJfU8xiZI920bHrYYb/l17iLbda2sA5omFzxWQ6a1Q==
X-Received: by 2002:a63:a069:: with SMTP id u41mr3703752pgn.3.1584525535517;
        Wed, 18 Mar 2020 02:58:55 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id h19sm5856645pfn.205.2020.03.18.02.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:58:54 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 0/1] submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
Date:   Wed, 18 Mar 2020 15:28:41 +0530
Message-Id: <20200318095842.27679-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subcommands in 'submodule--helper.c' which give a callback to other functions
have structures and macros named in the format: 'subcommand_cb' and 'SUBCOMMAND_CB_INIT'
respectively.

The subcommand 'foreach' did not follow this convention and therefore had the naming of
the form: 'struct foreach_cb' and 'CB_FOREACH_INIT'. Rename these to: 'struct foreach_cb'
and 'FOREACH_CB_INIT' respectively.


Shourya Shukla (1):
  submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'

 builtin/submodule--helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.20.1

