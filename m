Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F7720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 23:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLKXt2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 18:49:28 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:45059 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLKXt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 18:49:28 -0500
Received: by mail-qk1-f169.google.com with SMTP id y78so9708730qka.12
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 15:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=2j2GRA1VoOn94gP9jwXG3+K8pGsftlXxYB86QCAujGY=;
        b=cXFBKVcBsGSABWmLWGFtbZAd5PXhUAcLGNIYGsOTDpLmqX4UNm2E7d3ZkIWShglTw2
         7RLNXPjh0YVm46Gx9SOWELyljGt9l2eMApBKeJbCYNJHwFkR8HQVB4NIUH5WlnJHlvGm
         CGdw+dMRicmx+TlxfJ5ESAUiMq/4Q+THf5p/Ev4o/BT5eepqcxlcNOb7Pm4GaDqGdmqx
         6pwkK9d7ll5SMoCUfWNAeuD8hsjV/1BQIXnqvAAIxs8I/Ip/F8dRwczcwohXQFr5GxVG
         lbdA8a5a+xXN0qWUh/tUE4UQTos5CABN6IKC5ISu5+oP14m61JENEe7IZZGMqjdVWEg/
         W2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=2j2GRA1VoOn94gP9jwXG3+K8pGsftlXxYB86QCAujGY=;
        b=BoU1Jne1QtRRTbNZYk36QHXEFIouQXDb0eWKipJF9oxZnmqLqOpj77CXoaL0bjm9VB
         vmsOFNbcg+arNR6HCIxRlSQR67vTkkOykrtskCCbsjG/4pztoTja+jiluJu3OZoNVBxu
         bMH7FG2IqWsdIgduvqShO+TXLKtd36JcCPRz+T/d195UGl9hNGSDiO+99t0FtrY/ByF6
         BYn0LdFB6YvNzTHMS8B5UY5GBwlPF5MsR1zA5FREJzT38xpFjVoUU5gwLVXzL7tsU6Yn
         GwpIndh3lsR+lmmfQgSLeQBww7olYZNTqm1XPGN/Wnfjfd8A9bMCHOuJHdKozsy0aKSi
         wexg==
X-Gm-Message-State: AA+aEWbzT8Fts7MqDHo2lRudoTGWsLzF+o8E2hqQ7jMMhoLQBcW9b5+r
        xPJOpN6oVuX1FlR+2n5ETyEppbPN
X-Google-Smtp-Source: AFSGD/VCOBSmvTCts4Oe+tWtvgCZl70if+CQ06hvoR3zt4lqnDxtAD7l/vLbZSlvjI9zaasMPnVKIw==
X-Received: by 2002:a37:c12:: with SMTP id 18mr15902191qkm.317.1544572166945;
        Tue, 11 Dec 2018 15:49:26 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:fd8f])
        by smtp.gmail.com with ESMTPSA id p75sm9409697qki.90.2018.12.11.15.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 15:49:26 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     kernel-team@fb.com
Subject: [PATCHSET] git-reverse-trailer-xrefs: Reverse map cherry-picks and other cross-references
Date:   Tue, 11 Dec 2018 15:49:04 -0800
Message-Id: <20181211234909.2855638-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Some trailers refer to other commits.  Let's call them xrefs
(cross-references).  For example, a cherry pick trailer points to the
source commit.  It is sometimes useful to build a reverse map of these
xrefs - ie. source -> cherry-pick instead of cherry-pick -> source.

This, e.g, can answer which releases a commit ended up in on
repositories which cherry-picks fixes back from the development
branch.  Let's say the repository looks like the following.

	  D'---E'' release-B
	 /
	C'      E' release-D
       /       /
  A---B---C---D---E master

where the followings cherry-picks took place.

  C -> C'
  D -> D'
  E -> E' -> E''

Using the reverse-mapping in this patchset, we can get the following
annotated log which succinctly shows which commit ended up where.

  $ git log --notes=xref-cherry-picks --oneline | git name-rev --name-only --stdin
  4b165af commit E
  Notes (xref-cherry-picks):
      Cherry-picked-to: release-D
      Cherry-picked-to:   release-B

  82bf1f3 commit D
  Notes (xref-cherry-picks):
      Cherry-picked-to: release-B~1

  364eccf commit C
  Notes (xref-cherry-picks):
      Cherry-picked-to: release-B~2

  ed3adf3 commit B
  ddd1bf2 commit A

This patchset implements generic trailer cross-reference
reverse-mapping and the necessary hooks and samples to keep
cherry-pick reverse-maps up-to-date.

diffstat follows.  Thanks.

 Documentation/git-cherry-pick.txt           |    5 
 Documentation/git-fetch.txt                 |    5 
 Documentation/git-notes.txt                 |    8 
 Documentation/git-reverse-trailer-xrefs.txt |  145 +++++++++++++++
 Documentation/githooks.txt                  |   23 ++
 Makefile                                    |    1 
 builtin.h                                   |    1 
 builtin/fetch.c                             |   72 +++++++
 builtin/reverse-trailer-xrefs.c             |  160 +++++++++++++++++
 builtin/revert.c                            |   14 +
 git.c                                       |    1 
 notes-merge.c                               |    9 
 notes-utils.c                               |    2 
 notes-utils.h                               |    3 
 notes.c                                     |  260 +++++++++++++++++++++++++++-
 notes.h                                     |    9 
 t/t3321-notes-xref-cherry-picks.sh          |  124 +++++++++++++
 templates/hooks--post-cherry-pick.sample    |    8 
 templates/hooks--post-fetch.sample          |   30 +++
 trailer.c                                   |  105 +++++++++++
 trailer.h                                   |   38 ++++
 21 files changed, 1015 insertions(+), 8 deletions(-)

--
tejun

