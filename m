From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-pack-refs --prune
Date: Thu, 21 Sep 2006 00:02:15 -0700
Message-ID: <7v64fhd7ns.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
	<Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
	<7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609180934360.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 09:02:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQIZf-0003Qb-T2
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 09:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWIUHCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 03:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWIUHCQ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 03:02:16 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:56990 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750751AbWIUHCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 03:02:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921070215.HKHU6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 03:02:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qv211V0031kojtg0000000
	Thu, 21 Sep 2006 03:02:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609180934360.4388@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 18 Sep 2006 09:47:33 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27457>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 18 Sep 2006, Junio C Hamano wrote:
>> 
>> I am not sure I got the locking right, hence this RFC.
>
> It looks correct (the important part to check is that the SHA1 of the ref 
> you remove still matches the SHA1 of the object you packed).
>
> That said, we should fix it up a bit, notably
>
>  - we should _not_ prune refs that are indirect.
>
>  - we should probably avoid even trying to prune stuff that was already 
>    packed.
>
> The way to fix both these problems at once would be to add a flag to the 
> "for_each_ref()", which says whether it followed a link, or whether it was 
> already packed, so that we wouldn't pack symlinks at all, and we wouldn't 
> add already-packed refs to the "keeprefs" list.
>
> But that requires a sligh semantic extension to "do_for_each_ref()" (and 
> "struct ref_list" needs a flag to say whether it was looked up through a 
> symlink).

Ok, so I did these and the result is a 4-patch series.
