From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 21:31:57 +0200
Message-ID: <20080702193157.GA21297@leksak.fem-net>
References: <20080702174255.GB16235@cuci.nl> <20080702182510.GC29559@glandium.org> <20080702183701.GE16235@cuci.nl> <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain> <g4gb7a$ket$1@ger.gmane.org> <20080702174255.GB16235@cuci.nl> <20080702182510.GC29559@glandium.org> <g4gho9$g42$1@ger.gmane.org> <20080702143519.GA8391@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 02 21:33:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE84c-0007vQ-T8
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 21:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbYGBTcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 15:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbYGBTcC
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 15:32:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:47592 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752751AbYGBTcA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 15:32:00 -0400
Received: (qmail invoked by alias); 02 Jul 2008 19:31:59 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp019) with SMTP; 02 Jul 2008 21:31:59 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18bUsofmiob3j4Gm9d2chCd16tEk3BhBJ/VUOwDDt
	/HzMs/5jopP97H
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KE83Z-00066Z-Vx; Wed, 02 Jul 2008 21:31:58 +0200
Content-Disposition: inline
In-Reply-To: <20080702183701.GE16235@cuci.nl>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87183>

Hi,

I'm somehow quite confused about the desired workflow but I try an
answer.

Stephen R. van den Berg wrote:
> As far as I understood it, the new git sequencer rewrites history
> proper.  That is timeconsuming by definition, and thus it is *not*
> possible to make a tool based on the sequencer that supports the desired
> iterative-history-rewrite workflow.

If I got the problem right, it is possible.
But you have to rewrite and cannot just fake history, of course.
And, as Michael wrote:
> The currently planned set of commands would need to be amended, but the
> framework should be in place.

...for example, a "pick <commit>" that just picks the _tree_ of the
commit and not the _introduced changes_. (I've never used info/grafts,
but if I get the principle right, such tree-picks could realize a
linear list of info/grafts history fakes.)

Stephen wrote earlier:
> The problem I encounter is that any number of times I have to "edit"
> history in a non-parameterable fashion, in any of the following ways:

Hm, imho sequencer is well-suited for "non-parameterable" stuff.

> - Change parents.

The "pick" instruction (onto the new parent) is your friend.

> - Add merges.

"merge" instruction ;)

> - Change author, committer, commitdate, authordate.

sequencer doesn't allow to change committer data, but this could
be an easy change if you really need that.
The same with the author timestamp, that could only be reused from
an old commit by using -C option on pick.

> - Change the tree (because of conversion errors in the automated
>   conversion process) belonging to a single commit.
> - Retrofit a patch which has to ripple through all of history until
>   the present.

"pause" instruction, and then do manual changes, then
	git sequencer --continue

Stephan has also written:
> Also, having to run the sequencer to dig 20000 commits into the past,
> then change something, then come back up and rewrite all following
> history and relations (parents/tags/merges) will take a sizeable amount
> of time.

I wonder if grafts can be used in combination with sequencer in such a
way that you rewrite foo~20000..foo~19950 and then fake the parents of
foo~19949 to be the rewritten once.

> I need something that can be changed at will, then viewed with
> gitk a second later.

You can run gitk whenever you did "pause" in the sequencer file.
[Btw, an integration of sequencer into gitk is also on the TODO list,
 but that's OT here.]

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
