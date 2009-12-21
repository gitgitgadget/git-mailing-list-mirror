From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Introduce the GIT_HOME environment variable
Date: Mon, 21 Dec 2009 17:26:05 +0100
Message-ID: <vpqskb49tuq.fsf@bauges.imag.fr>
References: <4B2C0828.4010505@signalbeam.net>
	<20091219013246.GD25474@genesis.frugalware.org>
	<7vhbrnodd9.fsf@alter.siamese.dyndns.org>
	<4B2C5A1A.8000201@signalbeam.net>
	<7vzl5fik3o.fsf@alter.siamese.dyndns.org>
	<20091219153046.GG25474@genesis.frugalware.org>
	<vpqeimq51pq.fsf@bauges.imag.fr>
	<7vskb6bwvu.fsf@alter.siamese.dyndns.org>
	<vpqhbrkd3o6.fsf@bauges.imag.fr>
	<20091221155902.GA22665@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Moe <moe@signalbeam.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 21 17:29:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMl8r-0000ec-BD
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 17:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783AbZLUQ3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 11:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754991AbZLUQ3q
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 11:29:46 -0500
Received: from imag.imag.fr ([129.88.30.1]:35952 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684AbZLUQ3p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 11:29:45 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nBLGQ7oO009596
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Dec 2009 17:26:07 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NMl5C-0000h3-95; Mon, 21 Dec 2009 17:26:06 +0100
In-Reply-To: <20091221155902.GA22665@sigill.intra.peff.net> (Jeff King's message of "Mon\, 21 Dec 2009 10\:59\:02 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 21 Dec 2009 17:26:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135559>

Jeff King <peff@peff.net> writes:

> Are we even close to having this sort of universal support for
> ~/.config?

Definitely not universal as of now. Probably precisely because each
application thinks "I'll take care of $XDG_CONFIG_HOME after others
do" ;-).

> Traditionally, the standard for Unix
> has been for config files to be $HOME/.something. You can argue that
> ~/.config is a better standard, but I don't think git is failing to
> use a standard; it is simply following a different one.

I've probably been unclear about this. I'm not arguing about moving
away from $HOME/.gitconfig as the default (IOW, we're in agreement
here ;-) ). It's there, and the migration path would be much more
painfull than the benefit.

What I'm saying is that _if_ we introduce a variable to point to an
alternate .gitconfig, then we should use something like
$XDG_CONFIG_HOME/git/config and not $GIT_HOME/.gitconfig

I don't have a strong opinion on whether we should introduce such
variable (it seems the only use-case is the one which started this
thread, and it is already solved without it, so ...).

> But we do have such a variable: $HOME. The concept of $GIT_HOME was
> proposed to provide a way to divert _just_ git to a different config
> directory, something that would not be any easier with
> $XDG_CONFIG_HOME.

Right, but I don't see any use-case for this.

The use-case which started this thread was to have several physical
users using the same Unix account, with the desire that each physical
user should be able to use his own editor setups. In this case, you
want your editor and your other applications to follow the schema.

> Anyway, as far as the future of git goes, even if we did want to switch
> to $XDG_CONFIG_HOME, we could not do so suddenly without breaking
> everybody's current setup. Which would mean any implementation of it
> would have to handle both the current and the new proposed locations.
> You can obviously just read from both, but there are a lot of open
> questions, like "which should take precedence?" and "what does git
> config --global --edit do?". I am not opposed to hearing a clever
> proposal that handles all such issues, but I am not going to think too
> hard about it myself. :)

Right, the thing I had in mind was to use $XDG_CONFIG_HOME just like
$GIT_HOME (i.e. use it if it's set), but doing so would suddenly break
the setup of people having already set $XDG_CONFIG_HOME, and having a
$HOME/.gitconfig.

Well, then, I don't know, maybe my proposal wasn't as clever as I
thought ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
