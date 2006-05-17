From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement git-quiltimport
Date: Tue, 16 May 2006 23:17:23 -0600
Message-ID: <m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
	<m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
	<7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 07:18:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgEQI-0004qs-73
	for gcvg-git@gmane.org; Wed, 17 May 2006 07:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWEQFSI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 01:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWEQFSI
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 01:18:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20107 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932125AbWEQFSH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 01:18:07 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4H5HN2w019155;
	Tue, 16 May 2006 23:17:23 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4H5HNOA019154;
	Tue, 16 May 2006 23:17:23 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 16 May 2006 12:01:27 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20163>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>>    Given the ugliness in -mm making it an error to have an
>>    non-attributed patch would result in people specifying --author
>>    when they really don't know who the author is, giving us much
>>    less reliable information.
>>
>>    Possibly what we need is an option to not make it an error so that
>>    people doing this kind of thing in their own trees have useful
>>    information.
>
> I agree it is probably a good way to error by default, optinally
> allowing to say "don't care".  I do not think Linus would pull
> from such a tree or trees branched from it into his official
> tree, so I do not think we would need to worry about commits
> with incomplete information propagating for this particular
> "gitified mm" usage.  But as a general purpose tool to produce
> "gitified quilt series" tree, we would.
>
> It depends on the expected use of the resulting gitified mm
> tree.
>
> If it is for an individual developer to futz with and tweak
> upon, and the end result from the work leaves such a "gitified
> quilt series" repository only as a patch form, then not having
> to figure out and specify authorship information to many patches
> is probably a plus; the information will not be part of the
> official history recorded elsewhere anyway.

So what we need for this case really is a way to mark the
commit objects in such a way that git-fetch or git-merge
would choke on the commit objects and refuse to merge.
That way the changes could not easily propagate in the wild.
Every user would at least have to specify a non-default option,
that Linus at least would never specify.

This scenario is how I have been primarily using such a tree.

> However, if it is to produce a reference git tree to point
> people at, (i.e. the quiltimport script is run once per a series
> by somebody and the result is published for public use), I would
> imagine we would want to have the attribution straight, so if
> the tool has to "guess", it should either error out or go
> interactive and ask.

Reasonable.  Going interactive is probably the best way since it
appears that the patches do have sufficient information to derive
the user information from.  I know people have at various times
in the past made the Andrews tree available in git form so you
could do things like git-bisect, etc.  So I think we need to address
this issue.  Probably by at least asking Andrew about it.

I will take a look at the policy and see what I can do.  At
the very least the default we be to error on such a tree.

..

A infrastructure question came to me when looking at this:
several of the patches are from a branch with several authors.
How do we specify a commit in git with several authors?

There are cases when you have enough collaboration that even
a single patch could have multiple authors, contributing equally.

Eric
