From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] Blame functionality for jgit
Date: Mon, 12 Jan 2009 13:55:16 -0800
Message-ID: <20090112215516.GN10179@spearce.org>
References: <3d045c7e0901111223j43a69402s28a59612212943f3@mail.gmail.com> <20090112174232.GJ10179@spearce.org> <3d045c7e0901121317j4ccd9515vbc7a44abc8ae5356@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Manuel Woelker <manuel.woelker@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUm3-0002uh-Kp
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbZALVzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756458AbZALVzS
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:55:18 -0500
Received: from george.spearce.org ([209.20.77.23]:40434 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756262AbZALVzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 16:55:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6AA9E38210; Mon, 12 Jan 2009 21:55:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <3d045c7e0901121317j4ccd9515vbc7a44abc8ae5356@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105398>

Manuel Woelker <manuel.woelker@gmail.com> wrote:
> On Mon, Jan 12, 2009 at 6:42 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> 
> That sounds like a good plan. For now I am not all that concerned
> about performance myself (premature optimization and all that), but in
> the long run - and especially with rename/copy detection that will
> definitely a factor for usability.

Yea, I know.  Premature optimization is the root of all evil.
But we've also learned the hard way that Java is slow as snot
compared to C git.  The only way we can even stay close is to
optimize the hell out of the tight inner sections, and very often
that means using byte[] and avoiding upconverting to String to as
late as we possibly can.

Performance *is* a feature in Git.  Its not a "nice to have",
its a requirement.  The old history view for example was too damn
slow using Commit, requiring minutes on one of my systems to render
egit.git history.  Using RevCommit its subsecond response time.

I just wanted to point out that we care quite a bit about speed, and
that given our input (raw byte[] from the pack) we need to be able
to quickly make decisions without upconverting to String, otherwise
blame performance will be so bad that its completely unusable.

> > I think eventually we'll have a BSD licensed LCS [...]
> 
> While trying to look up the Myers diff algorithm I found a diff
> implementation in Apache wicket (cf.
> http://wicket.sourceforge.net/apidocs/wicket/util/diff/myers/package-summary.html
> ). This one is under an Apache license, is that any better? It's truly
> kind of sad that you need a degree in law these days to get any work
> done in this license jungle. I just happen to strongly oppose the
> reinvention of circular transportation-enabling devices...

Yea, even the ASF has trouble deciding if the Apache License and
the GPL can get along:

  "The Apache Software Foundation is still trying to determine if
  this version of the Apache License is compatible with the GPL."

  http://www.apache.org/licenses/

The Apache License doesn't play nice with GPLv2 apparently, but is
OK with GPLv2, at least according to the FSF.

Anyway.  The Apache License is roughly the new style BSD, but with
patent protection clauses built in.  I think we can consume code
under the Apache License and redistribute it without any trouble
for us, our any of our downstream consumers.

> I'll keep you posted on new developments

Looking forward to it.

-- 
Shawn.
