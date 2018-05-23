Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369671F51C
	for <e@80x24.org>; Wed, 23 May 2018 18:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934141AbeEWSvz (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 14:51:55 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:35952 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbeEWSvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 14:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9prToPELuo0qz9xoBm4NvAYQhE7gOsen+LC9JZ0H8YQ=; b=lw3wHzwqA+hRz6VARSIbBnUJJ7
        jGit6oiMpdVOB+Vvxbl23+RLmoEy4t1fwknj+gWyJbRvVtEpGNgZOOzq5Zk/sQPBGl3xEm7NTVxdD
        l6B8+Unwj24FBnzGy7XvtW2SuyNUnijal4ptfgOFuMSMxMV+cKF0WEmROqPUVdOL/gytl5Gds02/3
        n1GLrgi9IlxzNicImPMXbvAHBjZxJ0hZAI1FnwKwAoU6cjQEPqrGYnd0kHVY75gZmtF9RP/kQziJY
        Gq6U6ZFOkIl8gagabVjOSdD52YYcd9P+QBdks8wNwH3G4vauQqypfCgUj0xfyQr8AZ02D91fGixn8
        L/6EHAEQ==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:50928 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fLYrU-00C0ZU-Up
        for git@vger.kernel.org; Wed, 23 May 2018 14:51:50 -0400
Date:   Wed, 23 May 2018 14:50:12 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: "git grep" and "working tree" vs "working directory"
Message-ID: <alpine.LFD.2.21.1805231434010.28811@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  more puzzling terminology, this time in the man page for "git grep".
the SYNOPSIS shows, at the very end, the clearly optional
"[<pathspec>...]",

    git grep ...
           ... snip ...
           [--] [<pathspec>...]

but nowhere in the man page is there an explanation as to the default
value used if there is no pathspec, and here's why that's confusing.

  first, what is the proper phrase for the *entire* checked out repo?
working tree? working directory? either? and is that the proper phrase
to use *regardless* of where you happen to be located, perhaps in a
subdirectory?

  i did a quick test and, if i don't supply a pathspec, then "git
grep" (quite reasonably) recursively searches only the *current*
working directory (example from linux kernel source repo):

  $ cd scripts
  $ git grep -il torvalds --
  checkstack.pl
  get_maintainer.pl
  package/mkdebian
  $

however, if you peruse the very first part of the OPTIONS section of
that man page, you read:

  --cached
      Instead of searching tracked files in the working tree,
      search blobs registered in the index file.

  --no-index
      Search files in the current directory that is not managed by Git.

  --untracked
      In addition to searching in the tracked files in the
      working tree, search also in untracked files.

  ... snip ...

note how a couple of those options are described as searching "the
working tree", when they clearly(?) do no such thing if you happen to
be located in a subdirectory.

  also, at the bottom of that section, one reads:

  <pathspec>...
      If given, limit the search to paths matching at least one
      pattern. Both leading paths match and glob(7) patterns are supported.

      For more details about the <pathspec> syntax, see the pathspec
      entry in gitglossary(7).

but, again, what if <pathspec> is *not* given? then what?

  finally, the first example has the same problem:

  git grep 'time_t' -- '*.[ch]'
      Looks for time_t in all tracked .c and .h files in the
      working directory and its subdirectories.

in "the working directory"?

  what is the proper terminology to be used here?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
