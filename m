From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Mon, 8 Dec 2008 08:10:49 -0800
Message-ID: <20081208161049.GB31551@spearce.org>
References: <493A6CEC.4060601@tuffmail.com> <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com> <493C1F36.7050504@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Grzegorz Kossakowski <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:12:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9iiO-00070b-Ad
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 17:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbYLHQKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 11:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753183AbYLHQKv
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 11:10:51 -0500
Received: from george.spearce.org ([209.20.77.23]:54433 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbYLHQKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 11:10:50 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id F023A38200; Mon,  8 Dec 2008 16:10:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <493C1F36.7050504@tuffmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102548>

Grzegorz Kossakowski <grek@tuffmail.com> wrote:
> Peter Harris pisze:
> >> What if A was not fair and has rewritten a few commits coming from B so they contain malicious code?
> >> How we can detect something like that and how C be sure that what he merges is really work
> >> attributed by correct names?
> > 
> > If C doesn't trust A, C should not pull from A. C should pull only
> > from (trusted) B. Presumably B knows who (of A and B) did which work,
> > and B's repository can be trusted?
> > 
> > If neither of A or B can be trusted, then you have problems that a
> > computer cannot solve for you.
> 
> Yep, I was having in mind the case when both A and B are untrusted. I don't want my computer to
> check if something coming from A or B is safe or not I just want to know which bits are coming from
> A and which from B.
> 
> This is really important for us because of legal reasons.

ASF probably has issues similar to that of the Android project.

In Android we built Gerrit[1] to handle this validation of identity
for us, and to keep track of the contributor agreements each
individual and corporation has signed.  Changes aren't accepted
into Gerrit unless the user has an accepted CLA in the data store.

*1* http://review.source.android.com/

Gerrit 2 is actively under development and is being ported off of
Google App Engine, into a pure Java webapp.  I'm running it under
Jetty, but it should work just as well under Tomcat.  :-)

If the ASF becomes more committed to supporting Git, Gerrit may be
a good way to answer some of the questions you are having about
validating identity of changes.  Plus its a handy source code
review tool.
 
> > You could maybe use signed tags ("git help tag") - each contributor
> > could sign a certain tree state, [...]
> 
> The question is why Git doesn't sign all commits by default but only tags? Creating tags all the
> time is rather tedious process and seems to have no sense, right?

Yea, its tedious to unlock your GnuPG key every time you make a
commit.  Especially if you are just rebasing a series or something
to fix a minor mistake 5 commits back before uploading somewhere.
 
> Does it mean that with current Git design it's the best to not use advanced features of Git like
> tree merging but simply go with posting e-mails with patches instead if contributors cannot be trusted?

Most Git projects rely on patches sent to an email list, with
a single maintainer applying them to to his/her repository, and
publishing the result.  The maintainer is thus forced to keep track
of the CLAs (if the project uses such things) and just trust the
From address of the message.

CLAs in the kernel and in git itself are less enforced than say
what ASF or Android requires.

Some Git projects give write access to the master repository to
multiple trusted parties; SAMBA and X.org are good examples of this
sort of strategy.  But I think in these cases those who have write
access are also very long standing members of the development
community who have known each other in person for many years,
perhaps far longer than a DVCS concept has existed.  So trust
between those with direct write access is slightly less of an
issue for these projects.

So long story short, I think Gerrit may be worth the ASF's time,
if Git is a serious consideration for replacing SVN.  But while a
project is based in SVN I think the best you can do with Git is
publish an automatically updated git-svn mirror and permit only
use of "git svn dcommit" to upload back into the SVN repository.

-- 
Shawn.
