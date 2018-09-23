Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7679B1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 14:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeIWUxu (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 16:53:50 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:43437 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeIWUxu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 16:53:50 -0400
Received: by mail-qt1-f179.google.com with SMTP id l16-v6so5862883qtq.10
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 07:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lBj26NCcHNX9XLTLsIUcvSX5iCwvC64hCohraW3BBo=;
        b=RtM904TNom/FnX0IyC5+aIkscSzNfR61q3QGRNUjl4kjWpIf5ZqSyvfV0sUvecgwAi
         Owtbo13MTxCYIIC4K3AZd2aV4GXiKhRkSM6jAxBiXao1ik1Y0lUlZcRlVkpJbPqy1Q0T
         FYJT+mIF/vAMEuc1hdGRq7f0QFEYx1xRRUxihjccZZW1VAwg+jql0ZNHvrtfyjYL+pld
         zNUg5ztUkPv7OQaM+d5cNeQ3HaeXLAw2KuGe3s215qXx7y8RFGDqKi0D8/UTxxexSX4w
         R5m3jjok+ndtnjjQl1l+AZ3yfr+FbGBvfDtE7yojV0xEWsqu414R6nFId+JB1pzWdzJ3
         ea5w==
X-Gm-Message-State: ABuFfogze79LJNDC+AIf96bBe/siu1OsLjvxiJjjc7UaelyvjtZxoVAm
        6cJkkQCOVMrk3ejTcphABzQPaL/FJNryouNzEcY=
X-Google-Smtp-Source: ACcGV60XITFyorPK5Vfih1EF8564Ko6i93mQb7/QHUCoRX+G5yalu5D44ONZTsbgUy91ZHj0VipQvON1g3sXTvsfD+I=
X-Received: by 2002:a0c:c503:: with SMTP id x3-v6mr3947097qvi.82.1537714565211;
 Sun, 23 Sep 2018 07:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
In-Reply-To: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 23 Sep 2018 10:55:52 -0400
Message-ID: <CAPig+cTLjThK4CVzfgV=Uk5OumpjhaQD_YNXmg7pNtkkUFiiyQ@mail.gmail.com>
Subject: Re: Import/Export as a fast way to purge files from Git?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 9:05 AM Lars Schneider <larsxschneider@gmail.com> wrote:
> I recently had to purge files from large Git repos (many files, many commits).
> The usual recommendation is to use `git filter-branch --index-filter` to purge
> files. However, this is *very* slow for large repos (e.g. it takes 45min to
> remove the `builtin` directory from git core). I realized that I can remove
> files *way* faster by exporting the repo, removing the file references,
> and then importing the repo (see Perl script below, it takes ~30sec to remove
> the `builtin` directory from git core). Do you see any problem with this
> approach?

A couple comments:

For purging files from a history, take a look at BFG[1] which bills
itself as "a simpler, faster alternative to git-filter-branch for
cleansing bad data out of your Git repository history".

The approach of exporting to a fast-import stream, modifying the
stream, and re-importing is quite reasonable. However, rather than
re-inventing, take a look at reposurgeon[2], which allows you to do
major surgery on fast-import streams. Not only can it purge files from
a repository, but it can slice, dice, puree, and saute pretty much any
attribute of a repository.

[1]: https://rtyley.github.io/bfg-repo-cleaner/
[2]: http://www.catb.org/esr/reposurgeon/
