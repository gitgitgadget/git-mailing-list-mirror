From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Tue, 17 Jun 2008 14:54:01 -0700
Message-ID: <7vej6v683q.fsf@gitster.siamese.dyndns.org>
References: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com>
 <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org> <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com> <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com> <alpine.DEB.1.00.0806132239490.6439@racer> <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com> <200806142359.m5ENxsBI028758
  @mi0.bluebottle.com> <7vabhne15k.fsf@gitster.siamese.dyndns.org> <7vy755c0b2.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806171000400.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:55:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8j91-0000h2-L1
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 23:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870AbYFQVyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 17:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755652AbYFQVyV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 17:54:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250AbYFQVyU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 17:54:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 343371153B;
	Tue, 17 Jun 2008 17:54:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D3F9011539; Tue, 17 Jun 2008 17:54:11 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806171000400.6439@racer> (Johannes
 Schindelin's message of "Tue, 17 Jun 2008 10:05:24 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EFDEBDDC-3CB7-11DD-B079-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85329>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 16 Jun 2008, Junio C Hamano wrote:
> ...
> Isn't this overkill?  I mean, we could just change git-stash to output a 
> warning:
>
> 	Note: your changes have been stored temporarily.  If you need to 
> 	keep them permanently, consider putting them into a branch:
>
> 		git branch stashed-longer stash

You are asking the question to a Wrong Person, as I never asked to have a
nonexpirable stash, but I would hate such a change to waste four lines
of my terminal every time I create a new stash.

Also making a "branch" in the "git branch" sense (iow, a local branch you
can build on top of) is not something you would want anyway, isn't it?
What is the workflow to resume working from there?

	$ git checkout stashed-longer
        $ git reset --soft HEAD^
        $ work more
        $ git commit

and losing the tip with "reset --soft" would be crucial.  Otherwise if you
make commits on top of it by mistake, you will have a funny merge in the
history behind that commit.  IOW

	$ git checkout stashed-longer
        $ work more
        $ git commit --amend

would not work.

Of course,

	$ git stash apply stashed-longer

would work but that is by accident, as at that point what you are feeding
"git stash" command is not really a name of a ref that is a stash.
