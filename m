Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0150BC2BBC7
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 13:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72A420776
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 13:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+7OB8RB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgDMLEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728894AbgDMLEm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 07:04:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA495C0A3BE2
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 03:56:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id c5so4294510pgi.7
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 03:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVRj9KZgH65U5XASh8OVS8CMT6iPHuOQyQSg1o000F0=;
        b=S+7OB8RB5+2XII84+lEma3D7E8LRZ5AwUv5IWWV6Ppvmg09Xga9WBi3UvK0qTQrMj/
         e0m2UrlDXMC2Xzt5p7TH9ypOMe1N6zGcWgOiRsix33Rx47gpNlLAJU8q/r/bXA1r/2IO
         WyQMMG25mG98PKkXIeal+pSM+dKXD0NhxGSs+brBj6mXT+NrY3TLEZ5l1RiV3MYi/7HD
         LLLKKKh+X/e1y8+A9AXQsC7f1qOc2FWw/ptAMt6s/SGmbpVX5cwBqrr1FRca7Gz8iePA
         2jZxlbFWTceqwKgr8QV5WBIFVOghWd1CIUEFWgtMDJALevoNM/MHXPXlVfBS/3OiEcPh
         N0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVRj9KZgH65U5XASh8OVS8CMT6iPHuOQyQSg1o000F0=;
        b=MBluwppwMBvDko9ohW5TalNo2KHlR/7LKvCiiRwS23lt0byHgG9TTUuyOvNOX1tx1H
         gUr0skuf8zNmI2mmE7RD79/2eI4EmhCXhZlXWZYWDImUVDNlkW4jeO8A9Zc5tjSY87R9
         Bv8RW6qglNQdz1E1GLsKk0B61nflwswYyAZV0wQVIB2Vt1fjQH+OW8O0isyYBeY5fFv9
         Sa+TRxLhxDMGkzkHp/k690WAmp2dpVuvwsyc9zV5cOCmqXNNiot1wrYkC0JzYMjVNHF5
         bImB2HYYx7+bBXW6kea+md8ZzTMr4PpSmbsxapoMLjR/5As/wRu1CNKBng0jvymJNBX9
         Ri1w==
X-Gm-Message-State: AGi0PuZtch93NGNWg0IkVH7vlw9fyLjQrCtTRMIkVXl96EzxTp8R5I0f
        kS/boFAPdABbUhpyKoTiWFBknPsj67HvkA==
X-Google-Smtp-Source: APiQypLEyX+cmZyQnp2aRX4aKya1TZrSwIuWfE8jCz7DWSWQ+h8W/gcoppJzHBjcGIDsIOEZqN2OXQ==
X-Received: by 2002:a63:c345:: with SMTP id e5mr15478044pgd.403.1586775361608;
        Mon, 13 Apr 2020 03:56:01 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id p188sm8233544pfg.184.2020.04.13.03.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 03:56:00 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com,
        martin.agren@gmail.com, emilyshaffer@google.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2 0/1] update gitfaq
Date:   Mon, 13 Apr 2020 16:25:28 +0530
Message-Id: <20200413105529.16693-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thank you Junio and Brian for reviewing my patch :)
https://lore.kernel.org/git/20200406181216.5340-1-shouryashukla.oo@gmail.com/

The changes in this version are:
	1. Dropped the gitfaq cleanup patch.
	2. Improved the 'rebasing and merging' section. Added information on when to rebase/merge.
	3. Improved the 'files-in-.gitignore-are-tracked' section. Added significance of `git add` & `git status`.
	4. Improved the 'checking-out' section. Added more description in use cases of `git checkout` as well as introduced
	   `git switch` and `git restore`.
	5. Improvements in sentence formation and the terms used.

Regards,
Shourya Shukla

Shourya Shukla (1):
  gitfaq: append the 'Common Issues' section

 Documentation/gitfaq.txt | 104 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

-- 
2.20.1

