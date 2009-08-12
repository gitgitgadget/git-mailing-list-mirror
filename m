From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC for 1.7: Do not checkout -b master origin/master on clone
Date: Tue, 11 Aug 2009 19:45:22 -0700
Message-ID: <7v8whpda2l.fsf@alter.siamese.dyndns.org>
References: <4A818B90.9050206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 04:45:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb3qO-0004O4-L5
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 04:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbZHLCpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 22:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755541AbZHLCpb
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 22:45:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbZHLCpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 22:45:31 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 939727A09;
	Tue, 11 Aug 2009 22:45:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E15057A08; Tue, 11 Aug
 2009 22:45:28 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 33B8FB08-86EA-11DE-89E9-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125645>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> One common source of confusion for newcomers is the fact that master is
> given such a special treatment in git. While it is certainly okay and
> helpful to set up a default branch in a new repository (git init) it is
> not at all clear why it should be treated specially in any other
> situation, such as:
>
> - Why is master the only local branch which git clone sets up (git
> checkout -b master origin/master)?

As you know it is not strictly "master".  It is the primary branch at the
cloned repository, which by convention is master", but whatever remote end
points at with its HEAD.

We check out that primary branch to make it easy for people to work with
the simplest kind of CVS/SVN-like settings, which I suspect is 99% of
peoples' projects.  Single "trunk" that is checked out immediately after
cloning from a distribution point (read: a bare repository) ready to be
used.

> - Why does git svn set up a local branch with an svn upstream which is
> determined by latest svn commit at the time of the first git svn fetch?

I do not have comments on design decisions in git-svn, other than trusting
that Eric would exercise good design tastes to make things coherent with
the git native workflow when the consistency makes sense.

> ..., and git clone
> sets up a local branch according to HEAD (and does some other guess work
> when cloning bare repos), which means that git clone shows the same
> "random" behaviour...

It is because you are cloning from a repository that is used actively to
build new history, flipping the HEAD left and right.  That is where the
randomness comes from.  IOW, a repository with an active work tree.

If you are cloning because you have your own private working area and you
would want to get another private working area to work simultaneously, you
have "clone -n && checkout -t origin/whatever".  Also if you are doing
this on a local machine (which is somewhat common), there is new-workdir
script in contrib/.  But this is _not_ the most common case we should
optimize the usability of "clone" for.
