Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9EA9203EA
	for <e@80x24.org>; Mon, 19 Dec 2016 22:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932319AbcLSWAT (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 17:00:19 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:33574 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbcLSWAR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 17:00:17 -0500
Received: by mail-io0-f174.google.com with SMTP id d9so164276979ioe.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 14:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UssfLtDptTR3ekYJf4ncZILZ08ZqVagpVPoF8L1ZcDs=;
        b=JrfyORpfRKEBavOiZX3npNWJuLHk4OF5+26SvUx8TzEy2ZdNeCjJhjXV4vgQjj3U5O
         NTFn/BlD47qqCogeyrcS0HogtW/LBP5tBXAw8eArXNQQP9FaqKIjsnN6kwG81ZOhpFoS
         5MG5hP5BZ/DgcOe5OVe2KOxsxvioGHSrHC3Gt60WIiB3t4wJJtaldH8ZuUueKvL4jUey
         +9MvtWPsm+IZnwszjbGlqUwlI9g4IjB/31OgQb9batlUPXjtCZMLPhKcPDT1HeFg84CN
         VLqntobYtSCjJDwfTrwHWJEYybUSt8Bpjp2myJrWwdk9uwcAPHBoPbvRBaGiY1VaCOYn
         Prnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UssfLtDptTR3ekYJf4ncZILZ08ZqVagpVPoF8L1ZcDs=;
        b=TfLHz13GXeB2fb3HiWHMpKbeCLwygmn8Ym3aWlPe6bDKmFFy6af+QBxOEmVl8jDTiX
         YWKX0P5iTnu/iA0OhhQvkB47576dwvPkX5jhFwoo9b5weY1ZITozaJPgi8JWg7F1KutP
         kqGmRrwuruTjHTbmmkW9abFLb8jcdqUwfRYwVgnaqzY4WLWVTK1SHC0olW1zh96Hblsz
         rOHinyBuwZYwxOV/pvAdi+64nlEJ+fDKcS1Bl4zWWUOTr7cGw24OQZcVkFvmXG/xdtN3
         0NNGysYFVTuOeK1EBua3DAGRslrIRtLW5XhDf64FEK9cTKiZgf6HZUN9GNiLH8XnfrxO
         zsdQ==
X-Gm-Message-State: AIkVDXK35KvGU6ulaQZI37uPVHLA46xPJRqBUXAccEgQ4ReRzAwQbCfSKYj9cGCM3XbBB+kK
X-Received: by 10.107.159.68 with SMTP id i65mr18249958ioe.153.1482184816979;
        Mon, 19 Dec 2016 14:00:16 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2c2e:3e21:f7c2:2ccc])
        by smtp.gmail.com with ESMTPSA id v74sm9049682ioi.2.2016.12.19.14.00.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 14:00:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com, bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] improve relocate_git_dir to fail into a sane state.
Date:   Mon, 19 Dec 2016 13:57:07 -0800
Message-Id: <20161219215709.24620-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top of sb/submodule-embed-gitdir.
When the absorbing of a git dir fails, try to recover into a sane state,
i.e. try to undo the move of the git dir.

Thanks,
Stefan

Stefan Beller (2):
  dir.c: split up connect_work_tree_and_git_dir
  dir.c: add retry logic to relocate_gitdir

 dir.c       | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 dir.h       |   6 ++--
 submodule.c |   3 +-
 3 files changed, 110 insertions(+), 17 deletions(-)

-- 
2.11.0.rc2.53.gb7b3fba.dirty

