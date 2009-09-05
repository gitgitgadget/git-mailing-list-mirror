From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Error with git svn show-ignore: forbidden access
Date: Fri, 4 Sep 2009 22:57:08 -0700
Message-ID: <20090905055708.GA22272@dcvr.yhbt.net>
References: <551f769b0909010246u524599bcoc5b227f4a6279259@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 07:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjoH0-0004gi-Bt
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 07:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbZIEF5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 01:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbZIEF5H
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 01:57:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39105 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbZIEF5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 01:57:06 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id CEEB41F585;
	Sat,  5 Sep 2009 05:57:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <551f769b0909010246u524599bcoc5b227f4a6279259@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127776>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> Hi,
> 
> with git version 1.6.4:
> 
> $ git svn show-ignore > .gitignore
> RA layer request failed: Server sent unexpected return value (403
> Forbidden) in response to PROPFIND request for
> '/repos/XXX/YYY/ZZZ/trunk/aaa' at /usr/lib/git-core/git-svn line 2243
> 
> Is git svn show-ignore making request to the svn server?

Hi Yann,

Yes, git svn has to read the svn:ignore property remotely since it
doesn't do anything with it when it fetches.  Do you have read
permissions to /repos/XXX/YYY/ZZZ/trunk/aaa on that repo?

> I tried also with the --no-minimize-url option but get as answer:
> $ git svn --no-minimize-url show-ignore
> Unknown option: no-minimize-url
> 
> Thanks for the help

For everything besides initialization/clone, git svn reads the url in
your $GIT_CONFIG.  --minimize-url is only used for the initial setup.

You can edit it to move the URL down/up a level if you edit your
corresponding fetch/branches/tags lines:

before:

	[svn-remote "svn"]
		url = http://example.com/
		fetch = project/trunk:refs/remotes/trunk
		branches = project/branches/*:refs/remotes/*
		tags = project/tags/*:refs/remotes/tags/*

after:

	[svn-remote "svn"]
		url = http://example.com/project
		fetch = trunk:refs/remotes/trunk
		branches = branches/*:refs/remotes/*
		tags = tags/*:refs/remotes/tags/*

-- 
Eric Wong
