From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a test-case for git-apply trying to add an ending line
Date: Tue, 23 May 2006 21:59:13 -0700
Message-ID: <7v8xosqaqm.fsf@assigned-by-dhcp.cox.net>
References: <20060523214836.22628.2179.stgit@localhost.localdomain>
	<7vd5e4z2je.fsf@assigned-by-dhcp.cox.net>
	<7vhd3gxm73.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605231905470.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 06:59:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FilSo-0001pr-C1
	for gcvg-git@gmane.org; Wed, 24 May 2006 06:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWEXE7P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 00:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWEXE7P
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 00:59:15 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:3810 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932568AbWEXE7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 00:59:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524045914.NMVX24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 00:59:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605231905470.5623@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 23 May 2006 19:08:01 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20664>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 23 May 2006, Junio C Hamano wrote:
>
>> The issue is if we can reliably tell if there is such an EOF
>> context by looking at the diff.  Not having the same number of
>> lines that starts with ' ' in the hunk is not really a nice way
>> of doing so (you could make a unified diff that does not have
>> trailing context at all), and I do not offhand think of a good
>> way to do so.
>
> We can. Something like this should do it.
>
> (The same thing could be done for "match_beginning", perhaps).

But this is exactly what I said I had trouble with in the above.

In the extreme case, wouldn't this make git apply to refuse to
apply a self generated patch with 0-line context?  IOW,

        $ git checkout -- foo ;# reset to indexed version
	$ edit foo
        $ git diff -U0 >P.diff
        $ git checkout -- foo ;# reset to indexed version
        $ git apply <P.diff

would fail, even though it _should_ cleanly apply.

I'd admit that trying to apply a patch without context like the
above example _is_ insane, and I realize that I am making this
problem unsolvable by refusing the heuristics to consider that
the patch is anchored at the end when we do not see any trailing
context.  But somehow it feels wrong...
