From: Junio C Hamano <junkio@cox.net>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 07 May 2006 18:27:32 -0700
Message-ID: <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 03:27:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcuXB-0005Aj-8h
	for gcvg-git@gmane.org; Mon, 08 May 2006 03:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWEHB1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 21:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWEHB1e
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 21:27:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:4850 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932246AbWEHB1e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 21:27:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060508012733.ZBAM24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 21:27:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 7 May 2006 17:43:51 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19743>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 7 May 2006, Pavel Roskin wrote:
>> 
>> I'm only concerned that we would be hardcoding the word "branch".  We
>> could need fancy section names for other things in the future.
>
> Fair enough. We could have used some fake section name that you can't 
> generate any other way (in fact, "Branch.$branchname" would be that), but 
> the upside of using "branch" is exactly that you _can_ generate it with 
> the old-style syntax that is acceptable to older git versions too.

Sorry, I do not follow the old-style syntax part.

How about keeping the default syntax as it is (tokens are case
insensitive and alnums only, dot separates tokens into
sections), and when a token that violates that rule needs to be
spelled out, require quoting, so:

	branch.foo	BranCh.FoO	branch.FOO

are the same (section "branch.foo"), and if I have js/fmt.patch
branch, I need to spell the configuration for that branch like
so:

	branch."js/fmt.patch"	or   "branch.js/fmt.patch"        

and the URL variable for that section is

	$ git repo-config '"branch.js/fmt.patch".url'

(BTW, you could even have a variable with dots in it by quoting
the variable name, like "branch.js/fmt.patch"."fetch.option"; I
do not know if it is worth it).

My repository is full of topic branches that are named xx/yyyy.
It is very handy to be able to say "show-branch --topics master
'heads/??/*' next" which would not show my other branches like
"test", "throwaway", "rework", "temp", etc.
