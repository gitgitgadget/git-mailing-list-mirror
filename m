Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B4C1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 22:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfIBWjx (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 18:39:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58504 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727625AbfIBWjx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Sep 2019 18:39:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6959:e43b:5cf6:a465])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9F9A260448;
        Mon,  2 Sep 2019 22:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567463991;
        bh=7vRs5yfsf4MSoKuwg/LI5vUhNURdayDHzdUqQyhG7hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uTRpZbEGWXDzwmyDLWMVQodkNA4P+pC0LoY3IQ7PJz3cWizGAnqXCi0kVD5b+9ZoH
         Bb3zPleuAI5RkOEhb6KgfYCBgYPFK+1ZUQAHdPgfIW9/bD1CXzyXocgWKzWVJ3ys6U
         RYkwTWHXx4yi5ID24x1zc20D1MPmwWl3nCPD/3t9L/0mBclCsuT9ibx05/R8y/VEFq
         M1h+f9GDbQNkI4pzRGhoxAVmWdsGLgckregTDZfj/PujPHfhRspxApzara0olw9tTf
         Nj1LByUBqJ9loZOad9phHKgoRPm8w1FzAIj5ru7RqMNl4ZxFuqRr07odA6siodUqcG
         8iQjeQNU3/xWmIugK/r4vK8IBNiDM5w2OW5ibflii0OKoVnzI6QzMURTwBHJGO3+6x
         /jcdo0Jj9/YjWJ6Wkjn3AJmnkJvbkUn7ZDg2N4SqlrJISC1mDeLH79hR1vrwf2ATOk
         qsRnJzuo9PMWZRmYyzXmzeEmqcJHTyhUyD0J3C6TNv8jxvVyb9M
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 0/2] Honor .gitattributes with rebase --am
Date:   Mon,  2 Sep 2019 22:39:42 +0000
Message-Id: <20190902223944.897504-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734
In-Reply-To: <20190825233340.10894-1-sandals@crustytoothpaste.net>
References: <20190825233340.10894-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes rebase --am honor the .gitattributes file for
subsequent patches when a patch changes it.

Changes from v5:
* Avoid leaking memory from already parsed filter rules.

Changes from v4:
* Wrap lines in apply.c.
* Handle merge and conflict-marker-size attributes.
* Add tests for am and am -3 in addition to rebase.

Changes from v3:
* Check for both addition and removal of .gitattributes files.
* Switch from "test_config" to "git config".

Changes from v2:
* Rename has_path_suffix to ends_with_path_components.

Changes from v1:
* Add has_path_suffix in a separate commit.

brian m. carlson (2):
  path: add a function to check for path suffix
  am: reload .gitattributes after patching it

 apply.c           | 11 ++++++++++
 convert.c         | 21 ++++++++++++++++++-
 convert.h         |  6 ++++++
 ll-merge.c        | 19 +++++++++++++----
 ll-merge.h        |  1 +
 path.c            | 39 +++++++++++++++++++++++++++--------
 path.h            |  3 +++
 t/t3400-rebase.sh | 36 ++++++++++++++++++++++++++++++++
 t/t4150-am.sh     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 174 insertions(+), 14 deletions(-)

Range-diff against v5:
1:  2077a0829e ! 1:  1573fbd82d am: reload .gitattributes after patching it
    @@ convert.c: static void convert_attrs(const struct index_state *istate,
      
     +void reset_parsed_attributes(void)
     +{
    ++	struct convert_driver *drv, *next;
    ++
     +	attr_check_free(check);
     +	check = NULL;
     +	reset_merge_attributes();
    ++
    ++	for (drv = user_convert; drv; drv = next) {
    ++		next = drv->next;
    ++		free((void *)drv->name);
    ++		free(drv);
    ++	}
    ++	user_convert = NULL;
    ++	user_convert_tail = NULL;
     +}
     +
      int would_convert_to_git_filter_fd(const struct index_state *istate, const char *path)
