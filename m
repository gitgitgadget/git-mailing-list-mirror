From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 14 May 2005 09:27:27 -0700
Message-ID: <7vu0l5zsb4.fsf@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<20050513224529.GF32232@pasky.ji.cz>
	<7vhdh691gs.fsf@assigned-by-dhcp.cox.net>
	<20050513233354.GK32232@pasky.ji.cz>
	<7vmzqy7k47.fsf@assigned-by-dhcp.cox.net>
	<7voebe63zs.fsf@assigned-by-dhcp.cox.net>
	<20050514150356.GK3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 18:28:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWzUC-0002HD-4h
	for gcvg-git@gmane.org; Sat, 14 May 2005 18:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVENQ1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 12:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbVENQ1d
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 12:27:33 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44528 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262794AbVENQ13 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 12:27:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514162728.MPTB19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 12:27:28 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050514150356.GK3905@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 14 May 2005 17:03:56 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

Now I understand which discussion I was missing ;-).

PB> For humans I'd say "Mode change" instead of "mode" would be better, and
PB> for machines I still think "@" would be better than "#". "#" can occur
PB> quite naturally in some code snippets or whatever pasted to the commit
PB> message, which is extremely unlikely for "@". What are the advantages
PB> of "#"?

Wait a minute.  Aren't we scanning starting from the first
'---\n'?  Why does what's in commit message matter?

And it is not really "Mode change" anymore.  If you used to have
file there and you replaced it with a symlink, that is 100644 to
120000 "mode change".  I experimented with different things in
where I have "# mode: " there and seriously considered to spell
it "# git:" instead, because that is not really mode and it is
something that means something special to git.  Also I tried to
say just "@. " --- it _was_ confusing to human eye, especially
if you are used to reading diffs.

What I think is that this should not really matter much for
human consumption, because mode change is rare and type change
is even more rare.

PB> I like the rest. That's basically what I've imagined, and
PB> without the arrows it's even better. :-)

Here is what I'd propose for you to do.  (1) Take the patch as
is and commit; (2) Change the definition of git_prefix in diff.c
to "\n@. " and commit; (3) If you already took the test suite,
match t/t2000-diff.sh for the "\n@. " format, and commit.  

It will look something like this. thanks to the leading newline,
the output becomes a bit less confusing (without that blank
line, it really is a disaster for human eyes).

    @. 100644 100755 path0
    --- a/path0
    +++ b/path0
    @@ -1,3 +1,3 @@
     Line 1
     Line 2
    -line 3
    +Line 3

    @. 100755 . path1
    --- a/path1
    +++ /dev/null
    @@ -1,3 +0,0 @@
    -Line 1
    -Line 2
    -line 3

