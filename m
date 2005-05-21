From: Junio C Hamano <junkio@cox.net>
Subject: Re: updated design for the diff-raw format.
Date: Sat, 21 May 2005 16:18:30 -0700
Message-ID: <7vhdgwdv7d.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 01:17:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZdDg-00048P-KK
	for gcvg-git@gmane.org; Sun, 22 May 2005 01:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVEUXSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 19:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVEUXSg
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 19:18:36 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:21958 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261556AbVEUXSc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 19:18:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521231830.LBKE16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 19:18:30 -0400
To: git@vger.kernel.org
In-Reply-To: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 16:12:57 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(third of the replayed messages)

To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half of copy
 detection.
From: Junio C Hamano <junkio@cox.net>
Date: Sat, 21 May 2005 13:36:25 -0700
Message-ID: <7vfywggvue.fsf@assigned-by-dhcp.cox.net>

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Sat, 21 May 2005, Junio C Hamano wrote:
>> 
>> Once we start to think of it this way, it becomes quite tempting
>> to change the diff-raw format to actually match the above
>> concept.

LT> I agree, and I was going to suggest changing the "raw" diff output for all
LT> the same reasons. So I think you should do it, as the old format was based
LT> on not really knowing where this all would take us. I think your proposed
LT> format is visually nicer, and it's obviously more flexible.

LT> Small suggestion on termination of the thing:
LT>  - add a "inter_name_termination" variable, which defaults to '\t' (the 
LT>    same way "line_termination" defaults to '\n')
LT>  - make "-z" set both "inter_name_termination" _and_ "line_termination" to 
LT>    0.
LT>  - make the spacing be fixed (and add a test for it, so that there is 
LT>    never any confusion): regular spaces between the non-file-names, and 
LT>    "inter_name_termination" before the filenames, and "line_termination" 
LT>    after the second filename.

I am debating myself if I wanted to add this to the above list:

     - omit the inter_name_termination and second path if both
       paths are the same, only when doing human-readable
       (i.e. inter_name_termination != line_termination).

I'm not going to do this immediately though, for two reasons.

Somehow I failed to CC the GIT list the message you are
responding to.  Discussing a change with an impact of this scale
needs to be taken public before going further, so with your
permission I would like to repost both my original ("Once we
start to think of it this way...")  and your response to the GIT
list first.  At least I feel that Petr needs to be in the loop
about this one.

Another reason is that, as I said, I still have problems about
the diffcore interface, namely the lack of interface for the
applications to ask diffcore what the final outcome is.  The
"diff-tree not being to omit its header output when pickaxe says
the result is empty" problem is primarily what bothers me, but I
think we want a more generic interface for the application to
inspect the result (not just emptiness check), probably before
starting to feed the resulting diff list to the external diff.

Note that this interface needs to be inspection only---if the
application wants to further manipulate the result, then we
should extend list of diffcore transformations called from
diff_flush().  Which takes me to another point --- maybe the
list of diffcore transformations called from diff_flush() should
be made stackable, like streams.






