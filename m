From: Ed Avis <eda@waniasset.com>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 3 Jun 2015 09:55:05 +0000 (UTC)
Message-ID: <loom.20150603T114527-151@post.gmane.org>
References: <loom.20150603T104534-909@post.gmane.org> <20150603090654.GD32000@peff.net> <loom.20150603T110826-777@post.gmane.org> <20150603093514.GF32000@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 11:55:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z05OJ-0004yL-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 11:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbbFCJzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 05:55:15 -0400
Received: from plane.gmane.org ([80.91.229.3]:44044 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbbFCJzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 05:55:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z05OA-0004pr-Hx
	for git@vger.kernel.org; Wed, 03 Jun 2015 11:55:10 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 11:55:10 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 11:55:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:38.0) Gecko/20100101 Firefox/38.0 Cyberfox/38.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270675>

Jeff King <peff <at> peff.net> writes:

>I would say the more "usual" way to use checkout like this
>is to give specific paths. I.e., run "git status", say "oh, I need to
>restore the contents of 'foo', but not 'bar'", and run "git checkout
>foo". That works regardless of the type of change to "foo" and "bar".

That seems fine - a specific file is named and you clearly want to alter
the contents of that file.  By analogy, 'rm foo' will silently delete it,
but if you specify a directory to delete recursively you need the -r flag.
OK, it's not a perfect analogy because the purpose of rm is to delete data
and nothing else ;-).

If my personal experience is anything to go by, newcomers may fall into the
habit of running 'git checkout .' to restore missing files.  In the old days
I would often delete a file and then run 'cvs update' or 'svn update' to
restore it.  That would fetch a fresh copy from the repository, and while
it might do some kind of diff/patch operation on modified files, it would
not simply throw away local changes.

'git checkout .' seems like the analogous command, but it has much sharper
edges.  I still think it should be safer by default, but if you decide
against that then perhaps you need to create some way to restore missing
files and not overwrite others.  'git checkout --no-overwrite'?  Then it
could even be added to .gitconfig as the default for those who like it.

I have to say that as a newcomer to git I do not like the idea of creating
a special undo log for git.  It would just be yet another concept to learn
and another thing to add to the list of 'where is git hiding my data this
time?'.  And the time when it would be useful - after some bungled operation
that lost data - is just the time when the user is already confused and
adding another semi-hidden stash of objects to the mix would befuddle them
further.  If there is to be a backup made of local changes that get lost,
and I agree it is a good idea, then it should be something stupid and
completely obvious, such as saving the old file as 'foo.before_checkout.1'.

-- 
Ed Avis <eda@waniasset.com>
