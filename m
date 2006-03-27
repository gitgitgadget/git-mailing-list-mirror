From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 08:52:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603270848200.15714@g5.osdl.org>
References: <20060326014946.GB18185@pasky.or.cz>  <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
 <e06fl8$p9f$1@sea.gmane.org>  <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
  <e06hts$1ne$1@sea.gmane.org>  <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
  <e5bfff550603261122m5e680c62ye1290f3e601e947e@mail.gmail.com> 
 <Pine.LNX.4.64.0603261422280.15714@g5.osdl.org> 
 <e5bfff550603262147t3aec8da6p6bf2a333e2d35f1d@mail.gmail.com> 
 <Pine.LNX.4.64.0603270005330.15714@g5.osdl.org>
 <e5bfff550603270319w20796918wc8f8fe30a6c5627@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 18:53:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNuxl-00023k-Fm
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 18:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWC0QxA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 11:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWC0Qw7
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 11:52:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6577 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751111AbWC0Qw6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 11:52:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2RGqtDZ024741
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Mar 2006 08:52:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2RGqq80021564;
	Mon, 27 Mar 2006 08:52:53 -0800
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603270319w20796918wc8f8fe30a6c5627@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18084>



On Mon, 27 Mar 2006, Marco Costalba wrote:
> >
> > And that's the point. Almost always, we're interested in the _recent_
> > stuff. The fact that it takes longer to get the old history  is not very
> > important. You generally don't ask "what changed in this file" for a file
> > that hasn't changed in five years.
> 
> We could run git-rev-list with a time range specifier (changes of last
> year as example) by default so to have fast results and run all time
> history _only_  on request.

Yes.

However, what I've been meaning to do (but just haven't had the time and 
energy for so far) is to fix "git-rev-list" with a path limiter.

Right now that always causes things to be totally serialized, and the 
revision walking will first look up _all_ the history (well, it will prune 
out the merges) before starting to output stuff.

So right now in order for "git-whatchanged" to be fast and incremental, it 
doesn't do any path limiting with git-rev-list at ALL, and does it all in 
git-diff-tree. Which is horrid.

> I still think the problem with annotation is that you don't see
> patches that _remove_ lines of code, you need the whole diff for this.

Well, that's just another reason "annotate" sucks.

If you select a range of lines, my suggested tool _would_ show you lines 
that got removed there, and git-whatchanged does it quite well.

I really think "annotate" is _fundamentally_ a broken operation. It's not 
what any sane developer actually wants, and it has serious limitations (ie 
it depends on whole history, and it cannot show removals well).

		Linus
