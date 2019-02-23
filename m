Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E53520248
	for <e@80x24.org>; Sat, 23 Feb 2019 13:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfBWNLe (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 08:11:34 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:50134 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBWNLe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 08:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3hB02rLGkxyisfEZpUqgV+HKOz6BPMSDdSiu4NG1AHs=; b=zQcHQX8NHeGIDw4a6KncBPmtmB
        a2+hNuBykk4E87DWHinDJBjHYOBnC8t4F4ePcZcfPtDCZKpA0ILGA8M2uv7Dkyk2eCTvg56EIYgq7
        oSbjWAadxsLEdbNh/GfqLuJmLbQzHNTuLGWZGLVIspjXsJtyK+p9rW7XMPF37gnO0Xtt5BpiL25XQ
        KcSYLw+TmuddIZFPpyiajLjRX9w0w+4iqH6nEndG5/4AvwpF/q8ILWWqzPZZ0f3aolQbdLqmEqwa9
        leNeITUNz56JYJ6vEqBv+lbkDXKjKbwXIj7tGa7ioNLQ971oAqykdcO/XtHG0ojnF5B/d8DbzpyI7
        rpOYA82A==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:59194 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gxX5W-00FwQH-Qj
        for git@vger.kernel.org; Sat, 23 Feb 2019 08:11:32 -0500
Date:   Sat, 23 Feb 2019 08:11:29 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: on fedora, "man gitweb" exists but actual gitweb command is
 missing
Message-ID: <alpine.LFD.2.21.1902230756280.24879@localhost.localdomain>
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


  not so much a git issue as what looks like a fedora packaging issue.
on my updated fedora 29 system, "man gitweb" works:

  GITWEB(1)                    Git Manual                    GITWEB(1)

  NAME
       gitweb - Git web interface (web frontend to Git repositories)

  SYNOPSIS
       To get started with gitweb, run git-instaweb(1) from a Git
       repository. This would configure and start your web server, and
       run web browser pointing to gitweb.
       ... snip ...

and the corresponding man page source file clearly belongs to the
"git" package:

  $ rpm -qf /usr/share/man/man1/gitweb.1.gz
  git-2.20.1-1.fc29.x86_64
  $

but there is no "git instaweb" command:

  $ git instaweb
  git: 'instaweb' is not a git command. See 'git --help'.
  $

it took only a few seconds to determine that fedora bundles that
functionality in two separate packages which are not dependencies of
"git": "gitweb" and "git-instaweb" (output abbreviated):

  $ sudo dnf install git-instaweb
  ...
  Installing:
   git-instaweb
  Installing dependencies:
   gitweb
   perl-CGI

and now "git-instaweb" works fine.

  the question is, is it not inconsistent for fedora's basic "git"
package to include the man page for gitweb, without including the
corresponding functionality? is this something i should submit a
fedora bugzilla report for? or am i misunderstanding something?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
