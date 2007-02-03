From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Sat, 03 Feb 2007 01:27:04 -0800
Message-ID: <7v64aj7frr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070201234706.GP17617@mellanox.co.il>
	<Pine.LNX.4.63.0702020050190.18870@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz3xmju9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702021146440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz3wdjxu.fsf@assigned-by-dhcp.cox.net> <eq1j8i$rtv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 10:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDHAy-0005yq-GQ
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 10:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946415AbXBCJ1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 04:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946416AbXBCJ1I
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 04:27:08 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:48244 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946415AbXBCJ1H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 04:27:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203092704.ULKF1343.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 3 Feb 2007 04:27:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JxT41W00G1kojtg0000000; Sat, 03 Feb 2007 04:27:04 -0500
In-Reply-To: <eq1j8i$rtv$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	03 Feb 2007 10:06:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38558>

Jakub Narebski <jnareb@gmail.com> writes:

>> I did not find anything MS'esque in what MST did in his patch,
>> though.  I think it is a reasonable thing to ask for from a
>> clone.  For example, if you are coming from CVS or have used
>> Cogito, cloning a single branch is not an unusual operation at
>> all.
>
> But when we clone whole repository we could have download whole
> object database of cloned repo as-is (perhaps packing loose objects
> in smart/git-aware transports).

I think your point is if you have branches A and B, cloning A+B
as a whole is a lot less expensive than cloning A and then B
separately.  While that is true, I do not think that reasoning
would apply to somebody, especially behind a slow link, who is
only interested in A.  She does not want to pay the cost of A+B,
when she only wants A, even if A+B is much less expensive than
twice the cost of getting A.

Also, if she later gets interested in B, git fetch will make the
"what's common" optimization.  It won't be like cloning A and
then fetching B into the same repository later would be twice as
expensive compared to the case where you start from a clone as a
whole.  The overall transfer cost would probably be comparable.

> By the way, there was discussed idea about marking pu-like branches
> as being rewound (non-fast forwarding) in the config file, and somehow
> transferring this information for git-clone for it to have '+' for
> some refspecs. What happened to that idea? Was it abandoned...

Well, I would not call some idle talk without a concrete design
(preferably with a proof-of-concept code, but that is not an
absolute requirement) "idea".  Something that did not even start
cannot get abandoned ;-).

I thought that it would not hurt to have something like that,
but because in 1.5.0 "git clone" creates fetch configuration of
'forcing' kind by default, I do not think it makes that much of
a difference.
