Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325C3C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05445206DA
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAQN91HA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgDMOJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgDMOJd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 10:09:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D6C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:09:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w11so4473983pga.12
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVRj9KZgH65U5XASh8OVS8CMT6iPHuOQyQSg1o000F0=;
        b=DAQN91HADNk4F4clKwsZHMGAvHZaoNC/ay7CIREqLfOpkQMMPrCloozrqt4afm6AJt
         hhZ87VxItgNAxnDNkRa225GogDGqwIjsdMi7ezq6gr9Z686hl1Gc8XgFaUhIwREJWH4Y
         5cu/YQ3Ay/1DbRmjDfYBuuTghAPh+NGETuAHFBcFtKG97h61VBx0jsjbySq554NxMWX5
         6Z5Vak7Lw2jPcV2xcii8cCMWsa2esrxG18O3UaoIsRO2+UuYGB64GaUBBbNHmGGFPTWu
         o/+8Y6AQWWBcY/gpbUYYj2D72Jl99UpNfs+oN0Hojmpte9IyB6+WfUzXS2eeiydglrqX
         q2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVRj9KZgH65U5XASh8OVS8CMT6iPHuOQyQSg1o000F0=;
        b=CEhq1m7SasIjA4rvL4vBNvGjI5wY3Mnw0zCzBB4wkoBiKT/D4VMOTmG8a8Hha5Ge1A
         +Yrg2qL1JJfu6ktnYnJRir8cJrQQeOVpkW6aAxNz5OR+P7BXQ9osx8qbSmOCK1mNLAZu
         D0Y9TqgwNqeHXh03rvyTWaTHnz10yRS/XSXlL53JdGpeGDfx07uDVGeyOuMFJkLR9Dxk
         o7urovDikind0deLLoL/KNHdR92YR6BdUjrjgdd0+uiH3Qz9za1zhVSpClZlhE/xQ3QO
         n1OPZaUcDws/DCzMGwqZHfbYYt0tRzDuX3Ilbab7ieA6bMbvmP0GLzqtmL9m8fZokTQb
         QUkg==
X-Gm-Message-State: AGi0PuYjm69ssyJFH9GmI7TMmIiCiVSGKP0VdjKtPNWT3j6t3QsrfiiT
        IiKwoODzXUX/fDo/5LJZUh05Pv0DSP1kRA==
X-Google-Smtp-Source: APiQypJJq89wrv8adQaImgzBcSlxZ9fLgJ3W5OaSdyPHOownGtMpNeQLvK1jznplyXskmo8Txv2XtA==
X-Received: by 2002:a62:144b:: with SMTP id 72mr2319427pfu.246.1586786972253;
        Mon, 13 Apr 2020 07:09:32 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id l71sm3353233pge.3.2020.04.13.07.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 07:09:31 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2 0/1] update gitfaq
Date:   Mon, 13 Apr 2020 19:39:17 +0530
Message-Id: <20200413140918.4778-1-shouryashukla.oo@gmail.com>
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

