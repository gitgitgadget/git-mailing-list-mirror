From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rev-parse, unknown arguments and extended sha1's
Date: Fri, 24 Jun 2005 10:32:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506241026490.11175@ppc970.osdl.org>
References: <20050624122436.GA15182@pc117b.liacs.nl>
 <Pine.LNX.4.58.0506240904240.11175@ppc970.osdl.org> <20050624161718.GA14909@pc117b.liacs.nl>
 <Pine.LNX.4.58.0506240941520.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 19:27:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlrx7-0005Aj-TW
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 19:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbVFXRcq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 13:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbVFXRcq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 13:32:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263395AbVFXRaQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 13:30:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5OHU8jA019357
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Jun 2005 10:30:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5OHU756001578;
	Fri, 24 Jun 2005 10:30:07 -0700
To: Sven Verdoolaege <skimo@liacs.nl>
In-Reply-To: <Pine.LNX.4.58.0506240941520.11175@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 24 Jun 2005, Linus Torvalds wrote:
> 
> Anyway, I think I'll make git-rev-parse have some option to "error out if 
> the result is anything but a single revision number", since this is really 
> the only reason for git-rev-parse in the first place: to make readable 
> scripts.

How about something like

	rev=$(git-rev-parse --default HEAD --revs-only --verify "$@") || exit 1

which now should work correctly.

In particular, the "--default" field is now expanded properly as a
revision, instead of just output raw, so the "HEAD" actually gets
translated into its SHA1 representation (and this also means that you can
now use SHA1 expressions in "default", ie you don't need to do two
git-rev-parse phases to do "--default HEAD^" etc).

The "--verify" thing then checks that the end result isn't a revision
argument (ie "--max-age=.." isn't accepted), and that there's exactly one
revision in the result (ie no ranges or multiple revisions some other
way).

So now you shouldn't need to check the result any more. You know that if
it worked, "rev" will be a nice SHA1 (of course, it might still be an
_invalid_ SHA1, that's a different issue. But it's at least syntactically
ok)

		Linus
