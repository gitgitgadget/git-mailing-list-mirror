From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 02/11] Introduce a performance test for git-rebase
Date: Mon, 12 Mar 2012 21:20:17 +0100
Message-ID: <87obs1po5a.fsf@thomas.inf.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
	<e6a6af53264368a25e71719901f3227042e21f5c.1331561353.git.trast@student.ethz.ch>
	<87ipi9yaws.fsf@thomas.inf.ethz.ch>
	<7v399dsiw2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:20:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7BjJ-0004Zj-7W
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 21:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180Ab2CLUUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 16:20:23 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:19853 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755743Ab2CLUUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 16:20:22 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 21:20:21 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 21:20:20 +0100
In-Reply-To: <7v399dsiw2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 12 Mar 2012 12:45:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192941>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> However, it's pretty obvious that 'rebase -f' is slow compared to
>> 'rebase -m'.  So slow in fact that the user would be better off running
>> an *interactive* rebase.
>
> The mention of "-f" got me off track, but does "-m" avoid creating
> new commits when it does not have to?  A side effect "-f" has is to
> replay _all_ the commits, if I recall correctly.

Sorry, my bad.  *All* tests use -f for exactly that reason.

>> Now I'm not really keen on hacking on git-am until it gets back its
>> performance, as for most uses it's probably still fast enough.  But I
>> think one important question is: can we get rid of the
>> git-format-patch|git-am mode of git-rebase, which has historically been
>> a source of pain (see, e.g., the aforementioned 43c2325)?
>
> In the longer term, the right way forward is to try doing less in
> the patch mode in rebase.  For example, the command could make the
> list of commits to be replayed exactly the same way as it does for
> flattening cherry-pick rebase, and instead of running "am", run
> "format-patch --stdout | apply --3way --whitespace=fix --index" and
> commit the result using "commit -C".  That way it can depend on
> "commit -C" and does not have to worry about stupid things like
> 43c2325.

Ah, but that's a trap, or do you have an apply --3way series sitting
somewhere ;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
