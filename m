From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: GIT_CONFIG - what's the point?
Date: Fri,  1 Apr 2016 19:28:25 +0200
Message-ID: <1459531705-31906-1-git-send-email-szeder@ira.uka.de>
References: <CAL20dLDkmjpXdmHv0MdoUEe43s9TjqrOLS2ud8HHGCF2vahWNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthew Persico <matthew.persico@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:28:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am2sO-00064k-N7
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 19:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbcDAR2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 13:28:49 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:51901 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751284AbcDAR2s (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2016 13:28:48 -0400
Received: from x590daaf8.dyn.telefonica.de ([89.13.170.248] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1am2sF-00022v-LM; Fri, 01 Apr 2016 19:28:45 +0200
X-Mailer: git-send-email 2.8.0.50.gcd27284
In-Reply-To: <CAL20dLDkmjpXdmHv0MdoUEe43s9TjqrOLS2ud8HHGCF2vahWNQ@mail.gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1459531725.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290565>

> Let me explain my scenario. I have an nfs mounted home directory. It
> is used across multiple machines. I use different colored xterms for
> each machine. But that means that the one set of colors in my one
> .gitconfig file don't work against all my screen backgrounds. I'm
> trying to find a way to tune the git colors per login. The ability to
> set colors in an environment variable (like most UNIX utils support)
> would be the easiest way to do this. Failing that, I was hoping that
> by setting GIT_CONFIG per login, I could tune the color schemes with
> different config files.
> 
> Since that is not how GIT_CONFIG is used, I have simply decided to
> squint where necessary, or open up a neutral colored xterm for the
> diff, regardless of machine.
> 
> Yes, I could probably do diffs in many other ways, but git diff at the
> command line is usually the most expedient.
> 
> Unless I wanted to define a GIT_CONFIG_OVER environment variable upon
> login, place inside it the appropriate -c<name>=<value> overrides for
> colors, and then define a bash function git as
> 
> git () {
>    $(which git) $GIT_CONFIG_OVER "$@"
>    return $?
> }
> 
> which seems silly.

Yeah, that 'return $?' at the end of the function does indeed seem
silly :)  (sorry, couldn't resist...)

You could use machine-specific config includes instead of that
GIT_CONFIG_OVER environment variable.  I.e. store machine-specific
color configuration in ~/.gitcolors.<machine> or something and define
the shell function as:

git () {
        command git -c include.path=~/.gitcolors.$HOSTNAME "$@"
}

The impact on your .bashrc would be much smaller than with the
GIT_CONFIG_OVER approach.
You could even turn this into an alias, if you want.
