Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE7AC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 12:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224DB2072E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 12:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGyJc9lG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgCVMqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 08:46:37 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:44693 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgCVMqh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 08:46:37 -0400
Received: by mail-pf1-f180.google.com with SMTP id b72so6028590pfb.11
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9Iww0U+JXU2Kp9ewoxD2P0Q1pOez5sgQk5HeCa+n8k=;
        b=QGyJc9lGngLwa0J/nabmYpklHI+jnbMedJdt4kMnEz4Bc8QN8sXgCEgKWP9hLwm9od
         HXPoU11leKhhtrCJ1tM3vXaJE2ilma5HR3nvIDMIqY3y6yDoGOgjTAIr1InUQtlK5Gwo
         Qjac23qd5jTGYlHSNJepopA1vxga2IrXMr10Bzn17J9ozbFeEqDbCLxBgeWwWzvSb3nA
         DVbxk1RMotYxH1F/a94WPqJQxrWnJ/zp5v8tF8RJz69nEOKn+9nJm/jA2XxROWqTXcjW
         pAcCoY+9AQvzUnzcyxU6i3vHhbd/L+bEaGmzuuWdFNt0qB0J0rJf5/drYQhgIoNqDu7Y
         hNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9Iww0U+JXU2Kp9ewoxD2P0Q1pOez5sgQk5HeCa+n8k=;
        b=H+iOtFOhRSdAcp7lss41Rfg2NrRLrsXYsFG9QVDA/5kogRFr6vTBeJhALfzb06Ci79
         /cOcuy1ObuRYYUwpbNvQVwOz04gyqTxo9HSyxhdiWWVVaneeWeQe+tWN+M0tD+Ws+kJO
         ddYGn1i/Krt7dhgLUyOgFZ9X4EZKsYVu84iiMmifAhyCT7/7qDvRWvEVcHiu6Py9Ga56
         KN6TgBnLtVagXRkMLA0zCfT+wHE0uSF2+h0Dv4NbKoqJZuz9sgj2PGg6MkZmKP7naSuR
         Jd2059b/jiNjTlJh0ACYZkNYuuRNMdtqbpNAOQiU5FBY35+0I8z46MNxi2NJijL1ZpOR
         M5HA==
X-Gm-Message-State: ANhLgQ2/q1oyrH1Go0SNqjqoBNalzvrEmLaI0E4mkP1c/Td/sQjMaaGO
        qzbwBdoKIhst05xhvk8RJqS21ybsI+U=
X-Google-Smtp-Source: ADFU+vs9xN+tnuZKzU8V33Q5AgzqKdN0cmbMjijLClpZo71qnQQgyQmpoVjiSNnJDVswTWjScCakgw==
X-Received: by 2002:a65:5a4f:: with SMTP id z15mr16955840pgs.103.1584881195989;
        Sun, 22 Mar 2020 05:46:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:4071:2285:47f0:d986:c5b7:2058:d4bd])
        by smtp.gmail.com with ESMTPSA id o65sm4129211pfg.187.2020.03.22.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 05:46:35 -0700 (PDT)
From:   Shanthanu <shanthanu.s.rai9@gmail.com>
To:     git@vger.kernel.org
Cc:     Shanthanu <shanthanu.s.rai9@gmail.com>
Subject: [GSoC][PATCH 0/1] Microproject Submission
Date:   Sun, 22 Mar 2020 18:16:18 +0530
Message-Id: <20200322124619.30853-1-shanthanu.s.rai9@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.28.g7fcb965970
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello! I am submitting this patch as part of my GSoC application.

Shanthanu (1):
  t9116: avoid using pipes

 t/t9116-git-svn-log.sh | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

-- 
2.26.0.rc2.28.g7fcb965970

