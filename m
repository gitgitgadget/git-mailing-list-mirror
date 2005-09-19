From: Junio C Hamano <junkio@cox.net>
Subject: Re: What to expect after GIT 0.99.7
Date: Mon, 19 Sep 2005 01:25:21 -0700
Message-ID: <7vwtldsbv2.fsf@assigned-by-dhcp.cox.net>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net>
	<7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
	<7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net>
	<pan.2005.09.19.07.35.56.960375@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 10:26:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHGyL-0004ZT-7f
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 10:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVISIZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 04:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVISIZZ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 04:25:25 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7063 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932370AbVISIZX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 04:25:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919082522.WRGD23678.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 04:25:22 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.09.19.07.35.56.960375@smurf.noris.de> (Matthias
	Urlichs's message of "Mon, 19 Sep 2005 09:35:59 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8846>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> Hi, Junio C Hamano wrote:
>
>> * Perhaps a tool to revert a single file to pre-modification
>>   state?  git-cat-file blob `git-ls-files | grep foo` >foo or
>>   git-cat-file blob `git-ls-tree HEAD foo` >foo?  What should
>>   the command be called?  git-revert is taken so is
>>   git-checkout.
>
> git-checkout can be extended to accept filenames, which would have the
> additional benefit of enabling me to get any revision, not just HEAD.
>
> So can git-reset.
>
> I agree with Anton's "git clean"; with an optional -r <commit>
> argument, that would be a better solution.

It probably is because I am BK untainted, but 'git clean' sounds
as if it would do 'git-ls-files --others | xargs rm -f'.

I used to do 'cvs update -p foo.c >foo.c', and extending
git-checkout may be familiar to cvs migrants.  The most
roundabout way (albeit with perhaps least typing) is:

    git-tar-tree HEAD | tar xf - foo.c

I originally talked about reverting file(s) in the working tree,
but I wonder if reverting a cache (eh, index) entry to the state
in a committed tree is useful.  read-tree with a pathspec to
overwrite index entries for specified paths while leaving others
intact.  We could think of it as undoing git-update-index.
