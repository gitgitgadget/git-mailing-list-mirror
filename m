From: Junio C Hamano <junkio@cox.net>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Sat, 13 Aug 2005 00:48:32 -0700
Message-ID: <7vacjmqnu7.fsf@assigned-by-dhcp.cox.net>
References: <20050729081051.GH24895@pasky.ji.cz>
	<20050813041114.GA29412@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 09:48:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3ql9-0000Wi-Ut
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 09:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVHMHsf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 03:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVHMHse
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 03:48:34 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63693 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751285AbVHMHse (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 03:48:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050813074834.DFNR17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 03:48:34 -0400
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050813041114.GA29412@hpsvcnb.fc.hp.com> (Carl Baldwin's
	message of "Fri, 12 Aug 2005 22:11:14 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Carl Baldwin <cnb@fc.hp.com> writes:

> On Fri, Jul 29, 2005 at 08:10:51AM +0000, Petr Baudis wrote:
>> Exactly. I want much more freedom in pushing, the only requirement being
>> that "the to-be-replaced remote head is ancestor of the to-be-pushed
>> local head". I think (am I wrong?) git-send-pack localhead:remotehead
>> would work just fine for me, the only thing I need is the support for
>> different local and remote head names.
>
> Sorry to join the game so late.  I've only read this thread now.

Just in case you have not noticed, the push in 0.99.4 and
onwards does exactly that.  Please see git-push-script.txt in
the Documentation/ directory --- oops, there is no such thing.

Please see git-send-pack.txt instead, and if you feel like it, I
would appreciate a patch to add the missing documentation for
git-push-script ;-).

What's not supported well yet is the opposite --- downloading
multiple refs and dealing with them.

Johannes Schindelin calls this "reverse push", and I think that
is really a good name to describe what it does.  It takes a
remote repository and possibly multiple refs, downloads the
objects to complete the named remote references, and updates the
local refs only if the remote refs are fast forward children of
the local refs being replaced, just like "push" fast forwards
the remote refs using the local refs.  In other words, given
<src> and <dst> repository, the following should do the same
thing:

    On <src> repository machine, with GIT_DIR being the <src> repository:
    $ git push <dst> <ref-local-name>:<ref-remote-name>...

    On <dst> repository machine, with GIT_DIR being the <dst> repository:
    $ git pull <src> <ref-remote-name>:<ref-local-name>...

Johannes posted a script on the list a couple of days ago, which
should work well, except that it was written before the
git-fetch-pack command was updated to natively download from
multiple refs, so it does not know how to fetch multiple refs at
a one go.

-jc
