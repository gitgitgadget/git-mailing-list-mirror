Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FFE11F453
	for <e@80x24.org>; Thu, 18 Oct 2018 10:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeJRSA5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 14:00:57 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:9293 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbeJRSA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 14:00:57 -0400
Received: from lindisfarne.localdomain ([92.26.121.144])
        by smtp.talktalk.net with SMTP
        id D56VgJF7wbZX5D56bgkniC; Thu, 18 Oct 2018 11:00:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539856840;
        bh=qcO8uT6qlWdpq8hnKAb9IGHAvBf6ulOBV0ppYsK22hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=HoFIXllElPFjs/+ak8Fo/6yd524gRnFk6qWvvLETS6ZkzV+9wFdooJOHSTzXHWFe2
         JVz0Uze/KAwQ4OQ18wCAHNocJLf6dUAsoHY3F8l6BPpGfot3y4SNOpxpx/t+9lrnZ1
         0vVphh4UTyjG/eOooTl8NF0oaa+PbuOy9tSA4ahk=
X-Originating-IP: [92.26.121.144]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=AM9PLn0bJgvrHi3wmEITIQ==:117
 a=AM9PLn0bJgvrHi3wmEITIQ==:17 a=evINK-nbAAAA:8 a=iuGNbSBixgLDAZXCjX4A:9
 a=Rec5rrDYx8vbGTIn:21 a=xiwGAYr_WY-bbt1J:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/5]  am/rebase: share read_author_script()
Date:   Thu, 18 Oct 2018 11:00:18 +0100
Message-Id: <20181018100023.7327-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912101029.28052-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOAwwLff8WBt/ztaCL87nDQ5dAMOYZ2QOIENjiLX6MJ8bctqZBxE/Pkb5T92on9DbkdNH+1dOv8e+eCzji2gOpgOySWOeWqnihPJ9bfwNn9hD4cRd6pQ
 hCAB7uUKBEeLwTJ8yvHEefhVCOVZJagAif6NYSPpZaCHclnyv0e3sRFYX/gEAVe795UaYm+UfK4qS9iBv7Ihbn+On0nJEeeqGLLl2f7vTBcm+S2+IPQdUv1v
 hALVKtyd9u0HNBlifdd95ixBpXNiDTmViMyjXuUGO+5wW3/7zsmECSRqDo2FXRJ9SFgMb5En2LYT0ljAK2QJyJWJ4MQVLTodHGSni9sKbwg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Eric for his feedback on v1. I've rerolled based on
that. Patches 1 & 2 are new and try to address some of the concerns
Eric raised, particularly the error handling for a badly edited author
script. See the notes on patches 4 & 5 for the changes to those (they
were previously 2 & 3).

v1 cover letter:

This is a follow up to pw/rebase-i-author-script-fix, it reduces code
duplication and improves rebase's parsing of the author script. After
this I'll do another series to share the code to write the author
script.

Phillip Wood (5):
  am: don't die in read_author_script()
  am: improve author-script error reporting
  am: rename read_author_script()
  add read_author_script() to libgit
  sequencer: use read_author_script()

 builtin/am.c |  60 ++--------------
 sequencer.c  | 192 ++++++++++++++++++++++++++++++++-------------------
 sequencer.h  |   3 +
 3 files changed, 128 insertions(+), 127 deletions(-)

-- 
2.19.0

