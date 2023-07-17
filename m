Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B50EB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 20:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjGQU6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGQU6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 16:58:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522DDB2
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 13:58:01 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net [173.48.116.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36HKvpqV005737
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 16:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689627473; bh=PndEeortZpALwYyKPHIbeFrDdn+seyKtShq/eoKzHCQ=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=GcCN7bNg7YOxdBD4IYpq7DZPPYh6ZUVqfH4NGoDqI8VfGcjd27pzEwYCxk6BG7fdT
         apOQHb/YCTTz2RO+fHPFTqMJRZiwfEYtSn9LVe6P9fuKRDEPAp9cJbUFawP20oeHe5
         kQYgEbEClQi/pnSTNJSfFeGQ6OklD1hw/SnQsXbe4Ipk/qSQx6XBrvAB/v9jyCkRw/
         JQ6Q5MzenQOh48e8Hq/pfHv808r3mNKWXScZplyDBdGwwDs8MldEQ+G+MXOBHFQ0Om
         kcmwBbDgU0pN/Iti4mOr/OZQznJDcdCn7LiTD6tTdFV/HzsO6SvOOaQiBkFZqGQ1AK
         OAHuAyfnH7Akg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E555415C026A; Mon, 17 Jul 2023 16:57:50 -0400 (EDT)
Date:   Mon, 17 Jul 2023 16:57:50 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     nick <nick@nicholasjohnson.ch>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: Git Privacy
Message-ID: <20230717205750.GA3901704@mit.edu>
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
 <xmqqlefjpwif.fsf@gitster.g>
 <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
 <xmqqbkgeqw6n.fsf@gitster.g>
 <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
 <1d36d5ce-f452-fc31-6e30-b4ba819de7e4@web.de>
 <xmqqsf9njmc9.fsf@gitster.g>
 <xmqq5y6jjlcs.fsf@gitster.g>
 <CU47D1G1Y1E2.GID9E4XI7W1K@anonymous>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CU47D1G1Y1E2.GID9E4XI7W1K@anonymous>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2023 at 05:36:48AM +0000, nick wrote:
> 
> I hadn't considered it in my other responses, but calling it --privacy
> would be a bad idea for exactly the reasons you laid out. Calling it
> --useless-time would be better.

It might also be worth pointing out that someone still might be able
to figure out information from when a branch gets pushed to a git
repo.  Even if the time in the timestamp is randomized, when someone
sends a pull request to github is not going to be randomize.  Or if
someone pushes their branch to github, and github actions is set up to
automatically kick off regression tests as soon as the branch changes,
this can also leak information about when the push happened.

There are also integration test systems, such as the gce-xfstests's
lightweight test manager, which polls the branch every 15 minutes, and
the moment the branch changes, tests immediately start running and the
timestamp when the test was kicked off is encoded in the testrunid.

Which is why, quite frankly, I'm a bit dubious about the whole "I must
obfuscate the time zone from which I am operating", as something
that's really worth the effort, since it has a lot of downsides, and
if the user is not careful, they may end up leaking information about
when they are active anyway....

					- Ted
