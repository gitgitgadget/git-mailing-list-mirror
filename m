Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7359C20248
	for <e@80x24.org>; Tue,  2 Apr 2019 05:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDBFim (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 01:38:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37851 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDBFil (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 01:38:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so1594429pgc.4
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 22:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aWF8cnr+kt4eT8S6ah458XvE6sXfjRWCuE5v9sZ4HNc=;
        b=vdN5ik7MiQ1DH4KEYK55mcR0trnQgQHmBoQAgZBanStb7dP23OjRn/5Af8yPpeKkhN
         aGfO9KltdzFAVLuc6hr9AGi9YGJqiJ4cbL/z0+s+cUlcJd4nJ9hkQpaOEN747CgaeTFs
         jXV2LbKg5BwwXH5+JPf/wx9OF6OqLo5kaPn6ZjiaJhsiSpHkR15WMLjoUpobJTL0ZvsD
         FiivdRrzKo8My5dVaKhs7wk0AsaIfU0idJWr3pgcAnpk77mDBIz9DQ/hV6bWyXtbUgj0
         Epa8KBerEhYA3KLkvCuw3FT/lrzfLXzkW3WTXFUOaibZd0UfacGX9y8RAFxOwTLVzhoE
         XFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aWF8cnr+kt4eT8S6ah458XvE6sXfjRWCuE5v9sZ4HNc=;
        b=GjXQMdMEVavA5Eedaaj2CVclD4TA7vrC88LNxuuEfM4gA09tOEiwA9vlXJpCRInQ6H
         yNqeGW3f1m6Tnm4NAeqTz/HRqYYoOucl4t1vZBRvgWDbxXbJ/lUcH7FgLFvf3VzAKoiu
         /yHAEQbF0vwK5TfHzVXn1Eo5clcW4OOcosfrxMfWI7xeuh0y7xB1oT5RoM1cXIKJgF1K
         6yZehIfzI/b36xY55kE3TufswTZ4O0I264mqK5IlvUQpLPIZ5U1A/4GGtK7Upcwjqyyk
         fSBi91nmGN58lCAwyVtTsj7d1OR/lp5r0PKD8WNzqJsP0J37LH28nX6lnuMlm7/JPxa9
         mscg==
X-Gm-Message-State: APjAAAUmzuMj6iekA81YVvRFmDXWr6RO816rXTKdF6u6di51/5uzceEw
        iA5yCwDi+1YYYoUT4gMJBH6EJZBh
X-Google-Smtp-Source: APXvYqxR91MQnwJ0ludk/q19j3d7HjLkhlwSWFSndgqeIuwOzCLb7fJ0DjRsXKsdNDL4BtY2c2XY7Q==
X-Received: by 2002:a65:4bce:: with SMTP id p14mr6300335pgr.376.1554183520866;
        Mon, 01 Apr 2019 22:38:40 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id h184sm26415435pfc.78.2019.04.01.22.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 22:38:40 -0700 (PDT)
Date:   Mon, 1 Apr 2019 22:38:37 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/2] tag: prevent nested tags
Message-ID: <cover.1554183429.git.liu.denton@gmail.com>
References: <cover.1553586707.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553586707.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier in the mailing list, Robert Dailey reported confusion over some
nested tags. [1]

Peff noted that he hasn't seen a tag-to-a-tag in the wild so in most cases,
it'd probably be a mistake on the part of a user. He also suggested we error
out on a nested tag unless "--allow-nested-tag" is provided. [2]

This patchset implements those suggestions.

Changes since v1:

* Squashed patches into two patches, one to clean up tag.c, one to do the rest
* s/recursive/nested/g (so the new option is --allow-nested-tag)
* Add more details to --allow-nested-tag documentation

[1]: https://public-inbox.org/git/CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com/
[2]: https://public-inbox.org/git/20190325144930.GA19929@sigill.intra.peff.net/


Denton Liu (2):
  tag: fix formatting
  tag: prevent nested tags

 Documentation/config/advice.txt |  2 ++
 Documentation/git-tag.txt       | 16 +++++++++++++++-
 advice.c                        |  2 ++
 advice.h                        |  1 +
 builtin/tag.c                   | 30 ++++++++++++++++++++++++++----
 t/annotate-tests.sh             |  2 +-
 t/t0410-partial-clone.sh        |  2 +-
 t/t4205-log-pretty-formats.sh   |  2 +-
 t/t5305-include-tag.sh          |  2 +-
 t/t5500-fetch-pack.sh           |  2 +-
 t/t6302-for-each-ref-filter.sh  |  4 ++--
 t/t7004-tag.sh                  | 12 ++++++++++--
 t/t9350-fast-export.sh          |  4 ++--
 13 files changed, 65 insertions(+), 16 deletions(-)

-- 
2.21.0.741.g2c528c8f87

