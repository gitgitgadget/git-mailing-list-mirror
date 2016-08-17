Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 269161FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 20:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbcHQUs7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 16:48:59 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34105 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbcHQUs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 16:48:58 -0400
Received: by mail-pa0-f43.google.com with SMTP id fi15so39310718pac.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 13:48:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FhxyETdApOPJt/rLhO1y1959Wp4q/VQgLUFUjVTgx0A=;
        b=jWJ+gTCR2TIGqUnIIWukU56jCgx5DcrImlqSfIlC9SprwekmuS9YY244CsrLijn6r/
         7Pu8mFARgoXt0KUtYdc8BOYEVT9ybN9cAcEa59TfYSQOfvlMp8tEraz1/qRrVo+2Vt/d
         3Vl23vdnIWPNwgGh3I7YVl28Y13uaZswvU380xJGvhd2v851AMVYvwWb/JZb9lbmLBZm
         R8c0d0cAzyfzhuN4E3L0az/uAN3LPcDzUaqyBSDsHkrC9czXUY+obLtLZ3j5B0DNfjxD
         SzxpSjVizhu0UB3gzhgVhGiv4026V9Ll+lg5u7aE4sd95ITUivr4OkRIfDBo6YiZGKOw
         3dZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FhxyETdApOPJt/rLhO1y1959Wp4q/VQgLUFUjVTgx0A=;
        b=RFE1dCs3EEBKKgLCMBiTk3ojNGqAvTuKUnQ7lFMZsL6F0Pe4o9QAhMcCsuTaQXWcJZ
         uScg1gFCPzvEbbFTsAvwI/Cau0jg+tmxCjUqlnK3zZCertQZEW5evmYMZZnoD4qvrtI0
         f2bqEt4CEGEwOUsceJyr5Rdh4dotzfl2O81kz5+RrSuf85wU/4HsXSpJAJC67esHhSEy
         PxFvwQY7G4XUtLnDQZPJaYuVR9Y2qT5sclzv23le8d2EsuOKpPSigGBFYTeFMWgqHQmF
         0g1GIuStypO3p16S0Hmg3/FBG7vPPB4cnw2J6ZR2Bm3i8MJcjPNQRiYbYQDcxhQEudoS
         A19Q==
X-Gm-Message-State: AEkoouvsVlaJvkxKlWBZy24CGsIXzQlnZ+dpKF3tUDkVDoJCEwdanjR/6jfe4gUxv+fDZwcX
X-Received: by 10.67.3.197 with SMTP id by5mr77475710pad.119.1471466937454;
        Wed, 17 Aug 2016 13:48:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:dce0:ddd0:eb1f:9744])
        by smtp.gmail.com with ESMTPSA id uz4sm827690pac.13.2016.08.17.13.48.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 Aug 2016 13:48:56 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, iveqy@iveqy.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH] push: change submodule default to check
Date:	Wed, 17 Aug 2016 13:48:48 -0700
Message-Id: <20160817204848.8983-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g525ad04.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When working with submodules, it is easy to forget to push the submodules.
Change the default to 'check' if any existing submodule is present on at
least one remote of the submodule remotes.

This doesn't affect you if you do not work with submodules.
If working with submodules, there are more reports of missing submodules
rather than the desire to push the superproject without the submodules
to be pushed out. Flipping the default to check for submodules is safer
than the current default of ignoring submodules while pushing.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 
 Probably too late for the 2.10 release as I'd propose to keep it in master for
 quite a while before actually doing a release with this.
 
 Thanks,
 Stefan

 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 3bb9d6b..479150a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -22,7 +22,7 @@ static int deleterefs;
 static const char *receivepack;
 static int verbosity;
 static int progress = -1;
-static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules = RECURSE_SUBMODULES_CHECK;
 static enum transport_family family;
 
 static struct push_cas_option cas;
-- 
2.9.2.730.g525ad04.dirty

