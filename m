Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601B620756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbdAQXjD (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:39:03 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34675 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdAQXhb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:37:31 -0500
Received: by mail-qk0-f196.google.com with SMTP id e1so17318007qkh.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=J+pgVhl9SGpfc9XCTo6SFHN6VzONtZwqd8YxH6Tnf/w=;
        b=FhL8qeRR5TyGkje12B7xNH1ETMDKPqWsvDdT1tf0CnBgrPPRHtCWa9ooz6zJKJQpxi
         bcaKaphmV2DYDRORFquorH0DfVaS8VbObjikd69brEoUmAcNLpZXB7NLSlyNN+CbMD0v
         GC+vg9YR8rUo0ZC37sOlPEMgg3IUj5uj21ff+fIm6yplzLyPn79mwwl+EMLHu8otnh11
         dgEQ894kX7ZIDQttXZKYktPuuWI9awoejgZWgXOTvJkIjKIn68+fxxfaCuTwuDHbjEa4
         z9iMJeyo9y322QXsGqptIk5Eqvkblk20XyuXKvbqmoMY7aIBUtDJBr9sZfrXk8boiqaf
         VRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J+pgVhl9SGpfc9XCTo6SFHN6VzONtZwqd8YxH6Tnf/w=;
        b=bZwY1R1V76FDJGqFU7q0I1cIOXTW8vm3ladttxs6l3LLY+g9CPdvg95XTLg/CPrzrB
         BSPWg8OC671tYvMpBzReqteI+HpaNtDzZscipzuQMU6NQdWuEZzDJEcoipQUGiiTGK0z
         dasAnabWhXKgAvvun8e5ILSHlL11C43lcbArk3JMLvwO5oNhxPrOy6jgvBXEfmRcwVPr
         o1uqSWn0iAgrqbRJSAZF+Aingj9JUxRIsVPLu77SbRKfUns9Ys0dY3cYhtf06TZagJod
         yfjTcLHOEWCvAGtjQJ4bmIf9xTQEpDN80dvRaTK9xOr9UHEPblJ6T8p2idfuEbcpzXaH
         PMNw==
X-Gm-Message-State: AIkVDXIUUd7BxjPWSq1pIXaTn8XZMcATmTB33jjwz3LsYpLbIIZGsEjSONZhqqUx+W/EnM/Q
X-Received: by 10.55.168.68 with SMTP id r65mr221671qke.189.1484696250321;
        Tue, 17 Jan 2017 15:37:30 -0800 (PST)
Received: from localhost.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id c1sm3405814qke.36.2017.01.17.15.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 15:37:29 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v6 0/6] Add --format to tag verification
Date:   Tue, 17 Jan 2017 18:37:17 -0500
Message-Id: <20170117233723.23897-1-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

This is the sixth iteration of [1][2][3][4][5], and as a result of the
discussion in [5]. The main goal of this patch series is to bring
--format to git tag verification so that upper-layer tools can inspect
the content of a tag and make decisions based on it.

In this re-woll we:

* Changed the call interface so printing is done outside of verification. 

* Fixed a couple of whitespace issues and whatnot. 

Thanks,
-Santiago

[1] http://public-inbox.org/git/20170115184705.10376-1-santiago@nyu.edu/
[2] http://public-inbox.org/git/20161007210721.20437-1-santiago@nyu.edu/
[3] http://public-inbox.org/git/20160930221806.3398-1-santiago@nyu.edu/
[4] http://public-inbox.org/git/20160922185317.349-1-santiago@nyu.edu/
[5] http://public-inbox.org/git/20160926224233.32702-1-santiago@nyu.edu/
[6] http://public-inbox.org/git/20160607195608.16643-1-santiago@nyu.edu/
[7] http://public-inbox.org/git/20161019203546.dfqmi2czcxopgj6w@sigill.intra.peff.net/
[8] http://public-inbox.org/git/20161019203943.epjxnfci7vcqg4xv@sigill.intra.peff.net/

Lukas Puehringer (3):
  gpg-interface,tag: add GPG_VERIFY_OMIT_STATUS flag
  ref-filter: add function to print single ref_array_item
  builtin/tag: add --format argument for tag -v

Santiago Torres (3):
  builtin/verify-tag: add --format to verify-tag
  t/t7030-verify-tag: Add --format specifier tests
  t/t7004-tag: Add --format specifier tests

 Documentation/git-tag.txt        |  2 +-
 Documentation/git-verify-tag.txt |  2 +-
 builtin/tag.c                    | 38 ++++++++++++++++++++++++++++----------
 builtin/verify-tag.c             | 23 ++++++++++++++++++++---
 gpg-interface.h                  |  5 +++--
 ref-filter.c                     | 27 +++++++++++++++++++++------
 ref-filter.h                     |  7 +++++++
 t/t7004-tag.sh                   | 16 ++++++++++++++++
 t/t7030-verify-tag.sh            | 16 ++++++++++++++++
 tag.c                            |  5 ++++-
 10 files changed, 117 insertions(+), 24 deletions(-)

-- 
2.11.0

