From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: handling merge-base failures
Date: Wed, 23 Dec 2009 20:57:51 +0000
Message-ID: <20091223205751.GE13735@dcvr.yhbt.net>
References: <931B0483-7628-488E-BB9F-C40346353149@apple.com> <20091223200936.GA13735@dcvr.yhbt.net> <940F72F6-8FE5-42AE-84A1-8C4A77B57188@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 21:57:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNYHM-0002Fy-7b
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 21:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbZLWU5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 15:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbZLWU5w
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 15:57:52 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53618 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753345AbZLWU5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 15:57:52 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id B1A761F525;
	Wed, 23 Dec 2009 20:57:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <940F72F6-8FE5-42AE-84A1-8C4A77B57188@apple.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135636>

Andrew Myrick <amyrick@apple.com> wrote:
> On Dec 23, 2009, at 12:09 PM, Eric Wong wrote:
> > Andrew Myrick <amyrick@apple.com> wrote:
> >> One of my projects is failing to clone because merge-base is failing
> >> on one of the revisions; the branch is a partial branch, so merge-base
> >> can't find a common ancestor with trunk.  I'd like to catch the
> >> exception that command_oneline should throw when merge-base fails, but
> >> my perl is very rusty and I'm struggling to get git-svn.perl to grok
> >> the Git::Error::Command class.  What is the appropriate way to import
> >> that class?  Or more generally, is there a better solution to handling
> >> this error case?
> > 
> > Hi Andrew,
> > 
> > Git::Error::Command should be imported with the rest of Git.pm
> > 
> > It's a special way of doing exceptions in Perl which I don't see much
> > point of...  Looking at git-send-email as an example, it does this:
> > 
> > 	use Error qw(:try);
> > 	use Git;
> > 
> > 	try {
> > 		# something that will throw
> > 	} catch Git::Error::Command with {
> > 		# error handling
> > 	}
> 
> I looked at git-send-email's example, but I wanted to do a bit more:
> 	
> 	try {
> 		# command_oneline(...);
> 	} catch Git::Error::Command with {
> 		$E = shift;
> 		if ($E->value() == 1) {
> 			# do something
> 		} else {
> 			# do something else
> 		}
> 	}
>  	
> This is used in perl/Git.pm, but when I tried it in git-svn.perl, it
> fails with the error "Can't locate object method 'value' via package
> 'Git::SVN'".

That's strange.  I'm at a bit of a loss here so I'll wait for somebody
with more Perl knowledge than myself.

What happens when you dump @_ in your catch block?

	use Data::Dumper;
	try {
	} catch Git::Error::Command with {
		print STDERR Dumper(\@_);
	}

> Presumably $@ contains the Git::Error::Command object, which leaves me
> in the same spot, unfortunately.
> 
> > But yes, it is Perl after all and TMTOWTDI :)
> 
> Is there ever :)

Yes I'm lost here, too, so in these cases I default to putting
print statements everywhere and Data::Dumper :)

-- 
Eric Wong
