Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A306F1F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbcG2AoQ (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:44:16 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34258 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbcG2AoO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:44:14 -0400
Received: by mail-pa0-f54.google.com with SMTP id fi15so25641525pac.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 17:44:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tc2RmBh267n/DIIm7cgXbpAxVawiWeBSxx8ZhxcTvQE=;
        b=Vw7OfwUATBQVzyXg/tQWzdYpuRbJM+0dL76bVjwNV5FfANAnjU9GEaNmIQSQZP8SNa
         6fGcml4Yeqj0RQRxyyYZbZsLA/k7Dx8XOqf8i2qRbNpU0WyLQ+5HR6uccwc6o44dC228
         FPX2BajXzaMBYUVXITTDj2FBAyWvswqNNn7K7IN708b7k5FQMzbRPFGBSAQ40prZ96st
         PgPKZCVRcpoQEMrfdnIJS1tTcQdMAjpuYOAogOtsj57mMtXROwqNfIt0mBtGCDl+OpZ5
         1IgmaDFm72AegzmXo1UGczEyWL+ANxE05/bUcf5xuPS49xfU7/U4S89sFQmhLFEYaeDG
         efgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tc2RmBh267n/DIIm7cgXbpAxVawiWeBSxx8ZhxcTvQE=;
        b=YBvYUfPNhR75JbHKZAASZnmXsfdXC76xEpD7c/PifJRW2hoNsbJ3konYe7pdzCvbDl
         nDumZkiGzah6xBp/rmOZQw0kGqTMahWcq0tirgQ3fp6OAyc2GAwADTm8rmHpsty/kBD4
         Ytniq3pa7+2b8PeheRcSAhQrVzqbRwtmM0L3i1SilphKSAHILLLWZTE/YuEv5bzz1Yba
         raVXom1GcTMXdredxAxtswRss1HEXsCmcrDdypjDo+1em0Ejto+ra0WN/Iss9M8Vmk6w
         +vCUGgEliOFwy8jtETkKMhAnnJx97ZpzDCQhJUyvBA3rGAELwkZkShBmK0U8LKqsuJcB
         LPsA==
X-Gm-Message-State: AEkoout2FrRZd9RYpF2YJBB69FEnKwi8uV93hKhyXVFVcUmQdOXhOkDKWjl0KzTPxLLDbG7c
X-Received: by 10.66.181.139 with SMTP id dw11mr64725564pac.2.1469753054021;
        Thu, 28 Jul 2016 17:44:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id d5sm19899408pfc.4.2016.07.28.17.44.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 17:44:13 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/7] submodule update: allow '.' for branch value
Date:	Thu, 28 Jul 2016 17:44:02 -0700
Message-Id: <20160729004409.2072-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.472.g1ffb07c.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This got bigger than expected, but I am happier with the results.

The meat is found in the last patch. (At least what I am interested in; others
may be more interested in the second patch which could be argued to be a real
bug fix to be merged down to maint.)

Thanks Junio for the thourough review of the first patches,
Stefan

Stefan Beller (7):
  t7406: future proof tests with hard coded depth
  submodule update: respect depth in subsequent fetches
  submodule update: narrow scope of local variable
  submodule--helper: fix usage string for relative-path
  submodule-config: keep configured branch around
  submodule--helper: add remote-branch helper
  submodule update: allow '.' for branch value

 builtin/submodule--helper.c | 48 ++++++++++++++++++++++++++++--
 git-submodule.sh            | 11 +++----
 submodule-config.c          | 11 ++++++-
 submodule-config.h          |  1 +
 t/t7406-submodule-update.sh | 71 +++++++++++++++++++++++++++++++++++++++------
 5 files changed, 125 insertions(+), 17 deletions(-)

-- 
2.9.2.472.g1ffb07c.dirty

