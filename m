From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0 of 7] [resend] - Improve handling remotes, origin, submodules
Date: Mon, 04 Feb 2008 13:40:44 -0800
Message-ID: <7v1w7sjt7n.fsf@gitster.siamese.dyndns.org>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>
	<alpine.LSU.1.00.0802032237320.7372@racer.site>
	<47A68C01.9000600@gmail.com>
	<alpine.LSU.1.00.0802041443420.7372@racer.site>
	<30e4a070802040924g550671ccsb11108c71c99e378@mail.gmail.com>
	<7vbq6wjxx1.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0802042027470.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM94R-00066q-54
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbYBDVkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbYBDVkx
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:40:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755292AbYBDVkw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:40:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DF9B24A30;
	Mon,  4 Feb 2008 16:40:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 49CD14A2E;
	Mon,  4 Feb 2008 16:40:46 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802042027470.8543@racer.site> (Johannes
	Schindelin's message of "Mon, 4 Feb 2008 20:47:26 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72575>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> AFAICT "clone -o" was meant _only_ for this scenario:
>
> You have a slow connection, but someone can provide you with a thumb 
> drive, having the current repository.
>
> You clone it from the thumb drive, but of course you want to use your 
> (slow) connection for subsequent updates (i.e. you want to have a 
> different default remote).
>
> What you do is
>
> 	$ git clone -o thumbdrive /media/usbdisk/that-repository.git/
>
> Then, to be able to update from your preferred remote quickly, you add the 
> proper remote:
>
> 	$ git remote add --fetch origin git://git.kernel.org/shlub.git/
>
> In my understanding, this scenario is the only reason to live for clone's 
> -o option, and it would be actively wrong for it to change the _name_ of 
> the default remote to "thumbdrive".

Then we should fix "git-clone".

If you do the first command, I am reasonably sure that you would
get:

	[branch "master"]
        	remote = thumbdrive

in your .git/config.  You may want to occasionally go back to
thumbdrive for sneakernetting, so I do not think we should
remove [remote "thumbdrive"] section the clone would leave, but
the above "master branch would interact with thumbdrive
repository" should not be there.

And that corrected behaviour and the intended use of -o should
be documented.
