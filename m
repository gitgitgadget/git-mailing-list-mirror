Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604971F428
	for <e@80x24.org>; Wed,  3 Jan 2018 03:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeACDFf (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 22:05:35 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:42135 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeACDFe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 22:05:34 -0500
Received: by mail-pf0-f174.google.com with SMTP id d23so215369pfe.9
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 19:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id;
        bh=/rUMAy8VIGXIznJXZV+l0mHUgdjA5cgIw4eUa1xCf+o=;
        b=luPgQBemvDP/i3Drb5AjvkgXcgkRsyaEWPXzJJztNRetx9+P0mM4QY0NXAFWnedA4/
         hEKC/u5hu3iLAhToXer0va6oo6+Zw+VyQAqXi49y0POuz84pHuUigxzdGAMdojKOx59x
         I/B3cpVPRW/OOB3oc41dWK/hHhOxO6HmZp4N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/rUMAy8VIGXIznJXZV+l0mHUgdjA5cgIw4eUa1xCf+o=;
        b=UM10pZ4AKYALkG1rTI/wOjy/wXG9pTf7q0zVdqMDIw2YUdcbP+ev/bdIvNyy6txFW1
         TwCKZiyFUsBPFpbQ34SVPuzzOVdSsFEPX95e4n7Bv1jh6MoBoMFeaFppbyXwWYlf2pMu
         JF2A7MgiL8AOP3j2/wBFaJBFtgDn8HMDI8rCHHVFuvwwc2/uGQ6BLelvYqLCnKfu5NvG
         TYqamK17repkTHtFVPYp7qcQNf0sl/ewiev4OgLnQKpfp25OlCfVQYaUyzW9Vod1jVim
         oTxvtN8CQF7DpSMWe9o8kaGiETtdIUr126e4RZqZ5l82ECJkxi+eJgK6kh6nfEXY/Nao
         rEcA==
X-Gm-Message-State: AKGB3mJ+fTy6lA9PlFTRM+JECbethbE4TGsFobb0khCaQQCqxVxW9C8w
        lXIuHDpyr/BDa9oAWi8JHMlUDuCaDLg=
X-Google-Smtp-Source: ACJfBovACnJ2n+/U8OP0SC1RAetcbl7jG5YTAEmuyirPkhwCMu9zy313oFDnAcl+Sz2ROWRfErcvlg==
X-Received: by 10.98.72.130 with SMTP id q2mr98771pfi.99.1514948733435;
        Tue, 02 Jan 2018 19:05:33 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id 82sm107742pfm.136.2018.01.02.19.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 19:05:32 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v2 0/6] Minor fsmonitor bugfixes, use with `git diff`
Date:   Tue,  2 Jan 2018 19:04:50 -0800
Message-Id: <20180103030456.8181-1-alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.31.gddce0adfe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in this reroll:
 - Instead of including dir.h from fsmonitor.h, stop inlining the
   functions that made that necessary.

 - test-dump-fsmonitor sets a config variable soas to be able to
   access the fsmonitor state (after it has been un-split if using the
   split index) from the index without modifying it.  I'm least sure
   of this change, but I'm short on ideas for a cleaner
   implementation.

 - test-dump-fsmonitor now outputs a more concise output, with a
   trailing newline, instead of just patching over the lack of
   trailing newline on the old format.


Somehow patch 6/6 didn't get included in Junio's
av/fsmonitor-updates.  That's really the most useful patch of the
series, and the original impetus for it, as it turns out. :)

Best,
 - Alex


