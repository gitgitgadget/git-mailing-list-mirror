Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E72391F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeDCSbx (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:31:53 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:37726 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeDCSbw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:31:52 -0400
Received: by mail-yb0-f171.google.com with SMTP id u5-v6so6608795ybf.4
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aRQdry9rXfuM+WI3py1C8WYolZKVGxwxc3N//Na+ZW0=;
        b=oPZWha80dkN7G6ZAFp/STCFU6Irx92F6kqEUoGs8Lvgk1Ts7kJ95iXcFbnDD6xbFGq
         1/JlchUSiNKNFVFBSIBIaIxr4HjLfoZLU8+KivcxTeKJ38gDg4hzPzayNTj25eVIOquN
         603yhOZj8hhDayUGLtf43JzmRXhmDdajJt24L1RD6spuOaxWpXcjNsIlQAqZqyKr2Zqu
         2a8iNgXvXkFxmVgB7oAhdRazEdmj7sn4CE8kdLnekU9VKao1GyHxO6eXJjDthfDcyuFE
         mBa6BZAEZH2RtUrYpv1Vm5Pw3juJArclzwZBWup2cgGWhbsAYsY/8xJylAzijquOtNEM
         KBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aRQdry9rXfuM+WI3py1C8WYolZKVGxwxc3N//Na+ZW0=;
        b=K+K3UJk5lD/3bPe+X876IDDgfsDx8QpxgheiQj87srNAaCFC3zJU/cOf/VTL4GvGDE
         QyurfqVaFxcOGMU6RS34JGDpoRfaE5KsA0Rs5cwqcLR7zURh9Sb/naMyeZrtR0BfgeJ2
         F0ru7acdp4sqO6sPr+FMvhBpWcEtVuEeGbDRXn7qUkUEIJv6H25u7vLGaznwWnUn+0Ue
         OHmfEFJ/hySk0Y5bUPJh1YzpFBUC5j1KirgT6N/Yz2nZhUV7PSpRSs5obd+GvkJeISy6
         UU6GVmFt7Ki1qrGp2jn5SlALKm7WACqdJQcTHXeNO4eIP1GgMoPTNlVuaEo+8QqerW9Z
         XpaA==
X-Gm-Message-State: ALQs6tDb1fyM5wtuC+kwQKeaHrHfQrQnQbdHSBMRZhz32PpqV2dYam2H
        ZBy9kHTkVfs5QzlE/xzKn+E3Y4igHyHJa90EIWt2brtSRYg=
X-Google-Smtp-Source: AIpwx4+U1wt/OIWh6m3WDE33zlpatlgFTw4chfNs2bTsZY5DOJvnSdOkO+wUGZQbc0j8XZQj+aVUii9sP5IXoynJI/k=
X-Received: by 2002:a25:2782:: with SMTP id n124-v6mr3189982ybn.307.1522780311396;
 Tue, 03 Apr 2018 11:31:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 3 Apr 2018 11:31:50 -0700 (PDT)
In-Reply-To: <20180403165143.80661-5-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com> <20180403165143.80661-5-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Apr 2018 11:31:50 -0700
Message-ID: <CAGZ79kYt0VaLN=97+BT-T28W5bpTsach4XcB0_-p3ac5h1Vdgg@mail.gmail.com>
Subject: Re: [PATCH 4/6] commit: use generations in paint_down_to_common()
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 9:51 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
> Define compare_commits_by_gen_then_commit_date(), which uses generation
> numbers as a primary comparison and commit date to break ties (or as a
> comparison when both commits do not have computed generation numbers).
>
> Since the commit-graph file is closed under reachability, we know that
> all commits in the file have generation at most GENERATION_NUMBER_MAX
> which is less than GENERATION_NUMBER_UNDEF.
>
> This change does not affect the number of commits that are walked during
> the execution of paint_down_to_common(), only the order that those
> commits are inspected. In the case that commit dates violate topological
> order (i.e. a parent is "newer" than a child), the previous code could
> walk a commit twice: if a commit is reached with the PARENT1 bit, but
> later is re-visited with the PARENT2 bit, then that PARENT2 bit must be
> propagated to its parents. Using generation numbers avoids this extra
> effort, even if it is somewhat rare.


This patch (or later in this series) may want to touch
Documentation/technical/commit-graph.txt, that mentions this in
the section of Future Work:

- After computing and storing generation numbers, we must make graph
  walks aware of generation numbers to gain the performance benefits they
  enable. This will mostly be accomplished by swapping a commit-date-ordered
  priority queue with one ordered by generation number. The following
  operations are important candidates:

    - paint_down_to_common()
    - 'log --topo-order'

The paint down to common is only internal, not exposed to the user
for ordering, i.e. the topological ordering is still ordering commits in
a branch adjacent?

Thanks,
Stefan
