Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A96220248
	for <e@80x24.org>; Tue, 26 Mar 2019 07:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfCZHxT (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 03:53:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39462 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbfCZHxS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 03:53:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id b65so1252456plb.6
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pdlFosYJh6AUiqvwITadjpw8nTJTG7O0ZOe0zg1ELR8=;
        b=P9JnkduzWWuyAPCb1c3GdUJx9RDWHj2KXDuj8whRCFfzjyLpx7kvrfQfkL5PuGp9IC
         BmiqeorcDbOi596oAmAwUxt3iqgCz42w3/MHFSIUtjRJF8iwKK6DtPVpfrLEYUwAgDkz
         nD5daHVzbj9OJzI7Kww5EICE4gm004Pm3zJgL1VlG5puTW0WPNhJim1CS0Y8aTzUpZ5O
         8kO0fEAlcqms3oyyf0WcPl0Y3a9P/djeY6XuPgTrbYodWYQilZLGwY6JET6pVN3wBOUR
         B8mDZ/b49Te9+rzHbsxkKZ9PP4YCjdDawwMuYqtqEnN+JGfMyf36EZXskwKgroMqudMC
         w1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pdlFosYJh6AUiqvwITadjpw8nTJTG7O0ZOe0zg1ELR8=;
        b=saQaAiVAYg25tGn56Uit0FY6y6fcpSsIkuPb+CX4gcGvxzUgtfVLpgTP3IGvAUasA1
         uqc05J/7SV+OLPZAznXjXgNSJ+BiohTMyGx7cgCjhXcvTfgh56W4kStLiKqjZXjICzII
         id/H0oWHCfUs6YQzoGEVjJOsaej80qDDnYVoFpx1+9fqlIfRiIetdpmZ6UBXml00PaMZ
         snKnRqHuS8vUM8gn0UeqgWmgJFg02Hgfe+5ekkhTxwavsDM2k5HFk7tbdjJtyBO04YE7
         eOvKb4sF8DUcNN7UIGqPjjlLidGiP3mByK5Dvm9NwI1O1eBqPyfr8yV3m01ge9AlxltX
         4qZw==
X-Gm-Message-State: APjAAAWDcloEOkMFu52ZboojUBeFBCtVIapSfB45yv/cIXvgzL6JIt0L
        7UngcjnqxJ0Ya22uzif1GjuKzBVn
X-Google-Smtp-Source: APXvYqyt0lGQUSCMRfcKVRr3ivMxi6zCbdL1qC4PUB7i3LiYNOLyCXKg1bDJ0bTtdl2dB9gt8TrP2A==
X-Received: by 2002:a17:902:e612:: with SMTP id cm18mr29161318plb.147.1553586797816;
        Tue, 26 Mar 2019 00:53:17 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id k124sm14303651pgc.65.2019.03.26.00.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 00:53:16 -0700 (PDT)
Date:   Tue, 26 Mar 2019 00:53:14 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Robert Dailey <rcdailey.lists@gmail.com>
Subject: [PATCH 0/3] tag: prevent recursive tags
Message-ID: <cover.1553586707.git.liu.denton@gmail.com>
References: <20190325233723.GD23728@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325233723.GD23728@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff said:
> Yeah, that's probably a good idea. Now we just need somebody to write
> the patch...
> 
> -Peff

Hey would you look at that, somebody wrote the patch!

---

Earlier in the mailing list[1], Robert Dailey reported confusion over
some recursive tags.

Peff noted that he hasn't seen a tag-to-a-tag in the wild so in most
cases, it'd probably be a mistake on the part of a user. He also
suggested we error out on a recursive tag unless "--allow-recursive-tag"
is provided.

This patchset implements those suggestions.

[1]: https://public-inbox.org/git/CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com/
[2]: https://public-inbox.org/git/20190325144930.GA19929@sigill.intra.peff.net/


Denton Liu (3):
  tag: prevent recursive tags
  t7004: ensure recursive tag behavior is working
  git-tag.txt: document --allow-recursive-tag option

 Documentation/git-tag.txt      |  7 ++++++-
 advice.c                       |  2 ++
 advice.h                       |  1 +
 builtin/tag.c                  | 30 ++++++++++++++++++++++++++----
 t/annotate-tests.sh            |  2 +-
 t/t0410-partial-clone.sh       |  2 +-
 t/t4205-log-pretty-formats.sh  |  2 +-
 t/t5305-include-tag.sh         |  2 +-
 t/t5500-fetch-pack.sh          |  2 +-
 t/t6302-for-each-ref-filter.sh |  4 ++--
 t/t7004-tag.sh                 | 12 ++++++++++--
 t/t9350-fast-export.sh         |  4 ++--
 12 files changed, 54 insertions(+), 16 deletions(-)

-- 
2.21.0.512.g57bf1b23e1

