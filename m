From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: how to check remote git repo for updates without
	pull/fetch
Date: Fri, 19 Dec 2008 08:33:00 -0800
Message-ID: <20081219163300.GT32487@spearce.org>
References: <494BC89F.9070107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ivan Zorin <ivan.a.zorin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 17:34:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDiIx-0002Nq-1I
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 17:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbYLSQdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 11:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbYLSQdE
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 11:33:04 -0500
Received: from george.spearce.org ([209.20.77.23]:37260 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYLSQdB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 11:33:01 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E94BD38210; Fri, 19 Dec 2008 16:33:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <494BC89F.9070107@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103567>

Ivan Zorin <ivan.a.zorin@gmail.com> wrote:
> Hello. I have not very hard question, but I don't know how to better do
> it - could you tell me, please, does exist some way to check remote git
> repository for updates without downloading any essential files? I
> suppose, that such command should just type something like: "already
> updated", if current working tree identical to remote repo, and
> something like "there is some updates in remote repo", if remote repo
> has some new commits and/or branches. Thanks.

There aren't any commands to do it.

What you could do is write a script based upon git ls-remote. A
really simple one might be:

	#!/bin/sh
	remote=$1
	o=.git/remote_cache.$remote
	n=$o.new$$
	git ls-remote $remote >$n
	if [ -f $o ]
	then
		if diff $o $n >/dev/null
		then
			echo "No changes"
		else
			mv $n $o
			echo "Updates available"
	else
		mv $n $o
		echo "New remote remembered..."
	fi

A much more complex one would actually rewrite refs/heads/ to
the correct refs/remotes/ namespace on your local repository and
compare the remote ref values to the local refs/remotes values.

Patches for git fetch --pretend or something might be interesting.
Though I recall a thread about this before on the MLand saying there
was no point.  Its not like you can see how big the download would
be until after its over.

-- 
Shawn.
