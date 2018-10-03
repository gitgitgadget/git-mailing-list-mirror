Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EE851F453
	for <e@80x24.org>; Wed,  3 Oct 2018 11:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeJCSat (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 14:30:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40444 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJCSat (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 14:30:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id t22-v6so3878222lfb.7
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3rm0oGqAtvUXMCdj5IT9Rlzl9WX+0EreiKl6al2Ark=;
        b=JFCSliVu0S3VESGlvCNLEj6tJEcx3zFc+BpIOIW0fyXpTwYWaTYjO9UwLbqOiHpfsb
         TS1Sa+0MMVGpUQD18/Ja8wHjtVNj9K/0+heYv4dkiV190rrE50z3b/IBR+fgJlO0KgXm
         RaMyvwNmcJ+8t2WUcz7OMB3nIjPzjtkJew0fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3rm0oGqAtvUXMCdj5IT9Rlzl9WX+0EreiKl6al2Ark=;
        b=DlvEnslvQEJBqfKj0OPcAKt0TjxbDijdU8r5yWK3NYIDLxFU9yo2U1V7elL2oSzr14
         EIWuaiaU5hHY1uFCMfrtrXomHSoYd+Y5Fy87vr/kJoRiYq3GOuliHJ+E/4f1HfHSN/Fm
         ws1nFdlYe2YD5MDf8yVIs4mrJNkEgPjbO9r4kvBYX7yBsyke5qwSNrMSI3Q/ZJUOGSZw
         ZkRe702McrK35pZVOlJLqNo4tcBUzg/G/CEg6VldxI3FijDvIAFn7SejGMA5N+UEz5OM
         aSOWgRnfz7lqqd4jJiKRKM+eg0nhoGsLYF+veE0GgnY/3eWWi//d9Arl/gYab8MHk2+P
         oTMA==
X-Gm-Message-State: ABuFfojY1nkutR8boW9sESSTHEPqcCCmIjVqshkd4ba24PfrQBeGjdKs
        caQ+OACXgMbyqcJbTOzsUUYOklOnZgwQvA/G
X-Google-Smtp-Source: ACcGV60M626Vju/b1Xq8zov3gIPfDcl6qRuXLKPcSV9mnYPY5j9kf+Ql0LC3vjrgoAgApCW0okcbLg==
X-Received: by 2002:a19:2a12:: with SMTP id f18-v6mr841271lfl.28.1538566966175;
        Wed, 03 Oct 2018 04:42:46 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f22-v6sm279500ljk.11.2018.10.03.04.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 04:42:45 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v3 0/3] alias help tweaks
Date:   Wed,  3 Oct 2018 13:42:39 +0200
Message-Id: <20181003114242.9858-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
References: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2: Added patches 2 and 3, made "git cmd --help" unconditionally (no
config option, no delay) redirect to the aliased command's help,
preserve pre-existing behaviour of the spelling "git help cmd".

v3: Add some additional comments in patch 1 and avoid triggering leak
checker reports. Use better wording in patch 3.

Rasmus Villemoes (3):
  help: redirect to aliased commands for "git cmd --help"
  git.c: handle_alias: prepend alias info when first argument is -h
  git-help.txt: document "git help cmd" vs "git cmd --help" for aliases

 Documentation/git-help.txt |  4 ++++
 builtin/help.c             | 34 +++++++++++++++++++++++++++++++---
 git.c                      |  3 +++
 3 files changed, 38 insertions(+), 3 deletions(-)

-- 
2.19.0

