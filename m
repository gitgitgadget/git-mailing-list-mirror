From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Mon, 02 Feb 2009 23:50:05 +1300
Message-ID: <1233571805.20131.358.camel@maia.lan>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
	 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
	 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
	 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
	 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
	 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
	 <20090131095622.6117@nanako3.lavabit.com>
	 <7v63juzz9m.fsf@gitster.siamese.dyndns.org>
	 <1233459475.17688.128.camel@maia.lan>
	 <7vbptlsuyv.fsf@gitster.siamese.dyndns.org>
	 <1233558035.20131.72.camel@maia.lan>
	 <7v1vuhkzmp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 11:53:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTwQy-0007Og-8P
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 11:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbZBBKuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 05:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbZBBKub
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 05:50:31 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:36874 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbZBBKub (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 05:50:31 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 9852521D964; Mon,  2 Feb 2009 23:50:14 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 7F0F121D5DF;
	Mon,  2 Feb 2009 23:50:03 +1300 (NZDT)
In-Reply-To: <7v1vuhkzmp.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108077>

On Mon, 2009-02-02 at 00:32 -0800, Junio C Hamano wrote:
> > The other affects
> > a small number of users who are doing something which is labeled in many
> > places as a bad thing to want to do.
> 
> Sorry, but I do not agree with this.
> 
> What is bad is to push into a repository that is used for editing.  That
> is labelled as a bad thing to want to do.
> 
> It is often the easiest to push and then run "reset --hard" (perhaps from
> the post-update script) to propagate your change to a repository that is
> not usually used for editing.  E.g. that has always been the way I update
> my private repository at k.org that I use for final testing before pushing
> out the results that I built and tested on my personal machine.  People
> who have live web pages served from a checkout do that, too.  It is not a
> bad thing to do at all, and you can find many instructions with google
> without spending a lot of time to do exactly that.
> 
>     http://kerneltrap.org/mailarchive/git/2008/7/1/2315924
>     http://utsl.gen.nz/git/post-update

Heh, thanks for referring me to my own script ;-)

I think a "repository that is used for editing" can be practically
defined as one which does not have any dirty local files.  Or, if there
are dirty local files then they are none of the files which would be
changed by the push, or none of them would be changed by the push.
Similar to the check that 'git merge' does.

With that definition, if receive.denyCurrentBranch is set to "update" it
could be pretty much automagic, perhaps even good enough behaviour to
consider making it the default.  This kind of behaviour is what my
post-update hook tries to achieve, but it really needs a corresponding
piece in the update hook, and I didn't code all of the conditions above
into it.

Sam.
