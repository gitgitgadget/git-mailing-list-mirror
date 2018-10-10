Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76FF1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 11:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJJSfn (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 14:35:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38211 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJJSfn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 14:35:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so4554859ede.5
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqKEKCih6ggnDworSgTrFg0Aq8aLGwvvF0Now9fxRk4=;
        b=LqII2nisI1ShIbeZ8febGxF5EQHLrfc56HeqL4YQnBhaDm3XvGKcF6rzsjhFxlP9OQ
         6m6wpwPefb1zoqWy4OJazWJC9p+M2z1+B8M+YtpScjrxWuQxzfIt3MRToHm4aPV458SJ
         wggCuWVgxvY8Hcc0gheeiKTWWl2P1KrWVN6QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqKEKCih6ggnDworSgTrFg0Aq8aLGwvvF0Now9fxRk4=;
        b=GNxXaHjIpvSCXmJfWd+0K3U4dilP2BglFOdodcinOp+5qqyqgU1qF+bOsEsBeT2KWj
         cUIAhKOU+/1EOnP8U9+FWjLxoiE29KzT4U8iE9U2JKQEuetuHMZlP2rQdd7732rjLWe6
         Ub7QnJy1edtRVYjkc1KDGJIPmgFog+YUceskt+Z2Zs+AmQlSQIfg+HEbRdnXgpj+QRIG
         Ws/6bgWqQaZez1B//YsSmXzrdTHdmjGhj1DKjeyTC/zTG2JFZCFMwdq9Pwv+jm4lARLw
         19h/iki8QML5nwlwvYx+ZrQw6rjIzHgzhl/hNF3E69RfRKZu6gF5Ro4bPfS5WNL1EbeQ
         BKbA==
X-Gm-Message-State: ABuFfohaK9ImorNlLyjJl79aM6CxvSgomr1Ccc4QYq4dxw6cOCtUsimc
        F54kGOklxBxZySDP7vKtn70/9tAApn4=
X-Google-Smtp-Source: ACcGV60B2j5TDJswA9eMlsVJyalIlPvbWkv0s0jJafiKpBPswdjburXy6RJ4VKhoHvqva2W3QL2eTA==
X-Received: by 2002:a50:95c6:: with SMTP id x6-v6mr39690127eda.113.1539170041913;
        Wed, 10 Oct 2018 04:14:01 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id e10-v6sm4154596ejl.25.2018.10.10.04.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 04:14:00 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 0/3] send-email: Also pick up cc addresses from -by trailers
Date:   Wed, 10 Oct 2018 13:13:48 +0200
Message-Id: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.g084f1d7761
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This has been attempted multiple times before, but I hope that this
can make it in this time around. That *-by addresses are not
automatically Cc'ed certainly still surprises people from time to
time.

I hope that this addresses all the concerns Junio had in
https://lkml.org/lkml/2016/8/31/768 .

For the name, I chose 'misc-by', since that has -by in its name. I am
fine with absolutely any other name (bodyby, body-by, by-trailers,
...). I doubt we can find a short token that is completely
self-explanatory, and note that one has to look in the man page anyway
to know what 'sob' means in this line from 'git send-email -h':

    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.

Rasmus Villemoes (3):
  Documentation/git-send-email.txt: style fixes
  send-email: only consider lines containing @ or <> for automatic
    Cc'ing
  send-email: also pick up cc addresses from -by trailers

 Documentation/git-send-email.txt | 11 +++++++----
 git-send-email.perl              | 19 +++++++++++++------
 2 files changed, 20 insertions(+), 10 deletions(-)

-- 
2.19.1.6.g084f1d7761

