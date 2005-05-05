From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel nightly snapshots..
Date: Thu, 5 May 2005 08:46:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505050834550.2328@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org> 
 <42797F9F.9030002@zytor.com>  <1115303933.16187.135.camel@hades.cambridge.redhat.com>
  <Pine.LNX.4.58.0505050742180.2328@ppc970.osdl.org>
 <1115305813.16187.143.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 17:43:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTiTO-0005QE-6E
	for gcvg-git@gmane.org; Thu, 05 May 2005 17:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVEEPrD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 11:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVEEPpO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 11:45:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:60555 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262136AbVEEPoY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 11:44:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j45FiKU3026358
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 May 2005 08:44:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j45FiJrO023316;
	Thu, 5 May 2005 08:44:19 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115305813.16187.143.camel@hades.cambridge.redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 5 May 2005, David Woodhouse wrote:
> 
> OK, I've changed my 'origin' to an rsync URL referring to the same
> place, to make sure I get tags correctly in future. 2.6.12-rc3-git1 is
> in the process of being built; if the attached script works and
> continues working when invoked from cron, we might even see nightly
> snapshots again as requested...

	RELNAME=`cg-tag-ls | grep -v 'git' | tail -n1 | cut -f1 | sed s/^v//`

this seems to assume that cg-tag-ls outputs things in the right order, 
which I'm not at all sure it does.

It looks like cg-tag-ls just does

	cd .git/refs/tags
	for tag in *; do
		...

which means that the ordering will depend on the shell ordering or 
globbing.

Bash does globbing alphabetically sorted (and documents that), and it's
quite possible that all other shells do too. Even so, that doesn't
actually mean that it would be sorted by release, since v2.6.2 will sort
_after_ v2.6.12.

So this _should_ work for a while, but will eventually (before a -rc10
happens or we get to v2.6.100 ;^) need something better. That something
better probably being to ignore any tags that don't point to commits, and
then sorting by the date of the commit object.

		Linus
