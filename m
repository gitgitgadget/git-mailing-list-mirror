From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Thu, 25 May 2006 11:59:58 -0600
Message-ID: <m1bqtmdly9.fsf@ebiederm.dsl.xmission.com>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
	<7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
	<m1lksqdook.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605251024320.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 20:01:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjK98-0008QT-39
	for gcvg-git@gmane.org; Thu, 25 May 2006 20:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWEYSBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 14:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWEYSBF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 14:01:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30880 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030302AbWEYSBB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 14:01:01 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4PHxx5Y010698;
	Thu, 25 May 2006 11:59:59 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4PHxwfT010697;
	Thu, 25 May 2006 11:59:58 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605251024320.5623@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 25 May 2006 10:28:47 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20751>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 25 May 2006, Eric W. Biederman wrote:
>> 
>> My basic argument is that starting a pull with a commit that is not a
>> reference is no worse than staring a pull from a broken repository.  The
>> same checks that protects us should work in either case.
>
> I think Junio reacted to the subject line, which was somewhat badly 
> phrased. You're not looking to transfer random objects, you're looking to 
> _start_ a branch at any arbitrary known point.

Probably, but if I understood enough to get the subject line right the
first time I probably would have understood enough to just send
a patch :)

> However, Junio's point is probably that the "any valid SHA1" might 
> actually point to a broken tree, even if it exists on the server.
>
> Of course, in that case hopefully git-rev-list exits with an error, and 
> the server doesn't generate any pack at all rather than generating a 
> broken one.
>
> However, there's a (questionable) security issue: what if the server 
> doesn't _want_ to expose certain branches? Arguably, if you know the top 
> SHA1, you likely know all that it contains, but it may be a valid argument 
> to say that if the SHA1 isn't an exported branch, you shouldn't 
> necessarily be able to follow it.

Agreed and I mentioned this one earlier.

However the only way the above scenario can even happen in a useful
manner is with a shared object store for several repositories.  Otherwise
you couldn't access the data you don't want to share.

I can't think of a valid argument against not sharing an entire
repository except David Woodhouse's bandwidth concern.
Of course what was wanted there was a test a limit to how far
back in the history you could look for a common commit, which
is something different.

In general it is much easier to guarantee that either a repository is
shared or it is not.  Making a guarantee that objects that
"git-fsck-objects --unreachable --full" identifies will never be
downloaded is difficult, and probably not worth encouraging
people to do.

That said it is easy to keep the current behavior as an option,
so the security policy issue shouldn't limit the technical discussion.

Eric
