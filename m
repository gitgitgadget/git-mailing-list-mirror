Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27CE820179
	for <e@80x24.org>; Mon,  4 Jul 2016 17:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbcGDRjw (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 13:39:52 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:48839 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbcGDRjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 13:39:51 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id u64HdkY1006744;
	Mon, 4 Jul 2016 20:39:47 +0300
Date:	Mon, 4 Jul 2016 20:39:46 +0300
From:	Konstantin Khomoutov <kostix+git@007spb.ru>
To:	shawn wilson <ag4ve.us@gmail.com>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: split directories into branches
Message-Id: <20160704203946.3ac8d3205c08bfaee9a93a46@domain007.com>
In-Reply-To: <CAH_OBieCcx0_=vuZgoJ8GrZhhReEAhnjrz2pQwbwGgPFww4JmQ@mail.gmail.com>
References: <CAH_OBieCcx0_=vuZgoJ8GrZhhReEAhnjrz2pQwbwGgPFww4JmQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, 4 Jul 2016 12:45:39 -0400
shawn wilson <ag4ve.us@gmail.com> wrote:

> I've got a chef cookbook repo where everyone started developing
> cookbooks in a single dev branch (not project specific). Minus a few
> edge cases, it should be fairly simple to split this up into feature
> branches based on /cookbooks/<feature>.
> 
> I tried:
> $ git filter-branch --subdirectory-filter cookbooks/<feature>--
> <feature> And
> $ git subtree split --prefix cookbooks/<feature> -b <feature>
> 
> Which both seem to do the same thing (haven't looked at the subtree
> bash - guessing it does exactly the filter-branch). The issue is that
> it removes the directory tree (so obviously merges wouldn't work). I'm
> thinking some type of filter-branch --index-filter with a cherry pick
> (or similar) should work...?

To achieve what you're after I used `git subtree split` followed by
`git filter-branch --tree-filter ...` which moved all the files under
the directory hierarchy `git subtree split` removes.

I'd love if `git subtree split` had an option to preserve the prefix
(even better would be to have another option to rewrite the prefix)
because that would greatly simplify another use case for `git subtree`:
moving "a directory" with its full history from one repository into
another.  Presently, the user is able to split that directory out from
the source repository but when they subtree-merge it back in the new
repository, they are puzzled by the fact `git log` invoked on the new
history with the pathname prefix designating the "inserted" directory
does not traverse past the merge point which brought that directory in.

I know Git tracks content, not files (and directory) but still many
folks have "stable" directories for their files, assign certain
semantics to them etc.  I've needed such transfers myself, and this
topic has been raised more than once by folks over there on the
git-users mailing list.
