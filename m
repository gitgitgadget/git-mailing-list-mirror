From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 08 Jun 2005 22:15:58 -0700
Message-ID: <7vzmu0t8j5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
	<7voeag1j9y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081757170.2286@ppc970.osdl.org>
	<7vll5kxolo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081936370.2286@ppc970.osdl.org>
	<7vfyvsuoz3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506082145160.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 07:12:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgFKo-0001WD-Fn
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 07:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVFIFQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 01:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVFIFQF
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 01:16:05 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40405 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262271AbVFIFQA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 01:16:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609051558.EFMK550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 01:15:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506082145160.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 8 Jun 2005 21:54:50 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Wed, 8 Jun 2005, Junio C Hamano wrote:
>> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
>> 
LT> Yeah, ok, so the fact that we allow missing things in the
LT> index (which was debatable to start with) makes for
LT> exceptions.
>> 
>> Not just that.  Another big difference is that we allow _extra_
>> things in the index in two-tree case (i.e. local additions).
>> But I do not think these exceptions are necessarily bad.

LT> Well, they'd be bad in a three-way merge.

No question about it.  I am not proposing to conditionally
accept extra entries in 3-way case.

But when "read-tree -m H I-mixed-with-H M" 3-way merge is
emulating "read-tree -m H M", it does not need to accept any
extra entries in the cache, because in this case "our head" tree
is "I-mixed-with-H", which by definition contains everything in
the current cache (remember, "I-mixed-with-H" is built by
looking at each path and if it has stage0 then copy it to stage2
otherwise if it has stage1 then copy it to stage2, after reading
the index file into stage0, H into stage1, and M into stage 3).

And after such "3-way merge emulating 2-way fast-forward," you
can commit---the commit will have a single parent, M, and the
difference it contains is the changes the user made while he was
working off of H, rebased to M.

Of course this all assumes that we have a perfectly working
three-way merge ;-).

