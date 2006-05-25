From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Wed, 24 May 2006 23:36:07 -0700
Message-ID: <7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 08:36:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj9SK-0006sK-Ga
	for gcvg-git@gmane.org; Thu, 25 May 2006 08:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWEYGgL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 02:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEYGgK
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 02:36:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29884 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965054AbWEYGgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 02:36:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525063608.ZXTD24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 02:36:08 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m13beysnb2.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Wed, 24 May 2006 23:09:21 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20731>

ebiederm@xmission.com (Eric W. Biederman) writes:

> I clearly would not advertise it.  My problem is that I have
> evidence that someone pulled a given sha1 at some point from 
> some branch on a given repository.  But I don't have that branch.

If that was over rsync (as you mention later), then I would
consider that is an unfortunate unfixable issue.  rsync mirrors
are fundamentally unsafe for git -- Linus and I do not keep
saying rsync should be deprecated without good reasons.

There still might be bugs that breaks this guarantee outside
rsync, but if that is the case we should fix it.

I do not want to rehash the thread around Sep 29th 2005 here.
The entry point of that thread is this message:

	http://marc.theaimsgroup.com/?l=git&m=112795140820665

and the punch line are these two messages:

	http://marc.theaimsgroup.com/?l=git&m=112801874021223
	http://marc.theaimsgroup.com/?l=git&m=112802808030710

I did not realize what I was breaking initially.  I am not
ashamed of having been wrong, but it was embarrassing ;-).

> If I want
> a copy of your pu branch at some point in the past, but you have
> rebased it since that sha1 was published then there will clearly not
> be a path from any current head to that branch.  But if I still have a
> copy of the sha1 I should actually be able to recover the old copy of
> the pu branch from your tree.

Not necessarily.  I occasionally prune after rewinding.  When my
"pu" branch head does not point at the lost commit, the
repository may or may not have that object you happen to know I
used to have anymore.

>> Now, proving that a given SHA1 is the name of an object that
>> exists in the repository is cheap (has_sha1_file()), but proving
>> that the object is reachable from some of our refs can become
>> quite expensive.  That gives this issue a security implication
>> as well -- you can easily DoS the git-daemon that way, for
>> example.
>
> Exactly, which is why I aimed for the cheap test.

But the thing is the cheap test is broken, eh, rather,
propagates brokenness downstream (which is perhaps worse).
