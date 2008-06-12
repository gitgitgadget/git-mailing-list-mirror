From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Thu, 12 Jun 2008 14:46:58 -0700
Message-ID: <7vhcbyz5pp.fsf@gitster.siamese.dyndns.org>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org> <tTKBrUhaELJElLgsC8Wvr60D-bMFtfyvc87q5ZYW35M@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 12 23:48:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ueT-0008NF-Kh
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 23:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbYFLVrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 17:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbYFLVrT
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 17:47:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbYFLVrS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 17:47:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E462039ED;
	Thu, 12 Jun 2008 17:47:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 05F3739E7; Thu, 12 Jun 2008 17:47:06 -0400 (EDT)
In-Reply-To: <tTKBrUhaELJElLgsC8Wvr60D-bMFtfyvc87q5ZYW35M@cipher.nrlssc.navy.mil> (Brandon
 Casey's message of "Thu, 12 Jun 2008 16:27:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 201B431E-38C9-11DD-BD06-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84802>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> The fact that this caveat is not mentioned anywhere in the stash
> documentation or anywhere in the commit log related to git-stash.sh makes
> me think that this idea of 'a limited amount of time' was possibly not a
> design decision but merely a side effect of stashes being implemented using the
> reflog. Of course I didn't pay any attention to the discussions about stash
> back when it was implemented, so I may definitely be wrong.

I do not deeply care either way, but perhaps

 http://thread.gmane.org/gmane.comp.version-control.git/50737/focus=50863 

and yes use of reflog was more or less conscious thing and the mechanism
is very much temporary in nature (see the use case stated in the starting
thread).

> it were true that if I were to create a stash today, and then be surprised 30
> days from now when I do a 'stash list' and find the stash is still there.
> Something along the lines of:
>
>    $ git stash save my work
>    # wait 30 days
>    $ git stash list
>    stash@{0}: WIP on master: my work
>
>    # and if my reaction were something like:
>    # hmm, that's strange, what is that stash still doing there? It's been 30 days,
>    # it should be gone.

We could prune before running "git stash list", but why bother?  The fact
you can see it is like a bonus.
