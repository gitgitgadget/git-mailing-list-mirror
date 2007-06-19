From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Mon, 18 Jun 2007 18:37:35 -0700
Message-ID: <7v645kyba8.fsf@assigned-by-dhcp.pobox.com>
References: <f2t6na$5bi$1@sea.gmane.org>
	<11821227322913-git-send-email-frank@lichtenheld.de>
	<Pine.LNX.4.64.0706190151160.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 03:37:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Sf5-0005Fl-0P
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 03:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758912AbXFSBhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 21:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757653AbXFSBhh
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 21:37:37 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61162 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757326AbXFSBhg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 21:37:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070619013737.VUKK4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Jun 2007 21:37:37 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DDdb1X0041kojtg0000000; Mon, 18 Jun 2007 21:37:35 -0400
In-Reply-To: <Pine.LNX.4.64.0706190151160.4059@racer.site> (Johannes
	Schindelin's message of "Tue, 19 Jun 2007 01:55:24 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50439>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As for the FIXME: If you have a config like this:
>
> 	[core]
> 		Some = where
> 		over
> 		the = core.rainbow
>
> git-config -z would output something like this:
>
> 	core.some\0where\0core.over\0core.the\0core.rainbow\0
>
> Right?
>
> As you can see, it is quite hard for a parser to find out what is key, and 
> what is value. That FIXME is _exactly_ about this dilemma.
>
> IIRC I stated once that -z should output a value of "true" for these 
> cases, since they only make sense as booleans. But AFAIR nothing 
> conclusive came out of that thread.

I do not remember the thread, but I think that may make sense.
"over = 1", "over = true" etc. cannot be canonicalized to "true"
without knowing core.over is boolean, but core.over by itself
without any assignment cannot be anything but a boolean.

Another possibility, though, is to say:

	core.some\0where\0core.over\0\0core.the\0core.rainbow\0
