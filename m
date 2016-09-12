Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23741207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 21:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbcILVIq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 17:08:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33404 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932404AbcILVIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 17:08:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id b187so15383351wme.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 14:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nlhz65ju66ZQWdEkq+MadmtuPoi/AgWQUCWMuiji8ZM=;
        b=ikHJSVRq6VFWKOQZhE3RG4v0dcHWBE7IGFd9mysQ4SJNCUS2jcJ9YYvsM0iYIJWBtB
         JPxfEODb3rVGBUKRxbjWTxVmsYa5j5fQ4BvzMsRswW1F818heyvHvhmgwPSIfYiyxbRB
         mVHmueOi0ksj5zJxnfc3AmQqnBWIgl48o7NBHTUr+vfXMRcCiAw+k3FXzqJIzdb+ZO4h
         igo/5HfK5Yh6nfjwWEO+ZJEq0lwB8MLFVVsfie7detZOmK9lc3rQIzL0t8ttDhUxxrfg
         IyS42sC9hp99a5UQ2mafZcFaq8bEsM7oZPF9gqm6o01HGBK/JBFQ7S//WFUBs611kD+s
         EG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nlhz65ju66ZQWdEkq+MadmtuPoi/AgWQUCWMuiji8ZM=;
        b=VBlIcCne0NjwWejD6hn7atIHl+9KVj/BOdyd9PJBcvAIhaF+cp3zP9vo9vJUzxtJPu
         sy49UY4+isE3uI4SbvUL6tx3BFMeVVDQFApueHEl+h56pNuC1zi6eljjeodz5AhLH80K
         RdxQ7PBmU5In3NSP6H5Ewgi1sH7gLZfsa05+0N2mf7gpMY4F8tnn9DKu4G3DTIyd5e13
         JeOFa7PgudSE45Q42pfZxe4onnBUbRjatupB5uaDoaWTVymY9d/OHrQJj2SAQMo60dxS
         EA26G8nKa055R2M9HQsCOPH6g5aqPEkBZp7lCHJ+7fhvxAvDIxMZgmvruLR2MtDFMDsL
         TMGw==
X-Gm-Message-State: AE9vXwMcDL5XP/rSmHmoWwevMUtRvbsoRU2mXHd+nOjBVyS4FTnAakzw+jxNqVNyFnQ7Ww==
X-Received: by 10.28.67.6 with SMTP id q6mr3780978wma.31.1473714524450;
        Mon, 12 Sep 2016 14:08:44 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 190sm19581806wmk.13.2016.09.12.14.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Sep 2016 14:08:43 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/4] git add --chmod: always change the file
Date:   Mon, 12 Sep 2016 22:08:14 +0100
Message-Id: <20160912210818.26282-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160911103028.5492-1-t.gummerer@gmail.com>
References: <20160911103028.5492-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Junio on setting me straight on the change of behaviour in
the previous round.

This round includes a similar change, which does however not change
the behaviour of update-index with repeated arguments.  I still think
the unification of the way git add and git update-index handle chmod
is useful, when we can keep the behaviour with multiple arguments in
update-index the same.

Thomas Gummerer (4):
  add: document the chmod option
  update-index: use the same structure for chmod as add
  read-cache: introduce chmod_index_entry
  add: modify already added files when --chmod is given

 Documentation/git-add.txt     |  7 ++++++-
 builtin/add.c                 | 36 +++++++++++++++++++++++-----------
 builtin/checkout.c            |  2 +-
 builtin/commit.c              |  2 +-
 builtin/update-index.c        | 45 ++++++++++++++++++-------------------------
 cache.h                       | 12 +++++++-----
 read-cache.c                  | 33 +++++++++++++++++++++++--------
 t/t2107-update-index-basic.sh | 13 +++++++++++++
 t/t3700-add.sh                | 21 ++++++++++++++++++++
 9 files changed, 118 insertions(+), 53 deletions(-)

-- 
2.10.0.304.gf2ff484

