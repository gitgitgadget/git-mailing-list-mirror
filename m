From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Thu, 05 Jul 2007 15:44:23 +0200
Message-ID: <vpqd4z7q820.fsf@bauges.imag.fr>
References: <46893F61.5060401@jaeger.mine.nu>
	<20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46895EA4.5040803@jaeger.mine.nu>
	<20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<vpq7ipittl2.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707022205210.4071@racer.site>
	<vpqoditkc23.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707031308170.4071@racer.site>
	<vpqir91hagz.fsf@bauges.imag.fr>
	<20070704200806.GA3991@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jul 05 15:45:26 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Re8-0002ae-2v
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 15:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605AbXGENpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 09:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757794AbXGENpU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 09:45:20 -0400
Received: from imag.imag.fr ([129.88.30.1]:41250 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331AbXGENpT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 09:45:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l65DiNCT027206
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2007 15:44:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I6Rd9-0004Qm-Jn; Thu, 05 Jul 2007 15:44:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I6Rd9-0002gV-HQ; Thu, 05 Jul 2007 15:44:23 +0200
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Yann Dirson <ydirson@altern.org>, Christian Jaeger <christian@jaeger.mine.nu>,  git@vger.kernel.org
In-Reply-To: <20070704200806.GA3991@efreet.light.src> (Jan Hudec's message of "Wed\, 4 Jul 2007 22\:08\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 05 Jul 2007 15:44:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51675>

Jan Hudec <bulb@ucw.cz> writes:

>> What's wrong with the behavior of "hg rm"?
>> What's wrong with the behavior of "svn rm"?
>> What's wrong with the behavior of "bzr rm"?
>> (no, I won't do it with CVS ;-) )
>> 
>> None of these commands have the problem that git-rm has.
>
> Hm. They all behave roughly the same: They unversion the file and unlink it,
> unless it is modified, in which case they unversion it and leave it
> alone.

Yes. Roughly, they'll ask you a --force flag whenever you'd risk
data-loss. bzr gives you the choice between --force and --keep (that
would be --cached in git) if the file doesn't match HEAD.

> Now git has the extra complexity that index contains also content of the
> file. But the behaviour can be easily adapted like this (HEAD = version in
> HEAD, index = version in index, tree = version in tree):
                                  ^^^^- I suppose you meant "version"
                                        here since you don't use
                                        "tree" after.

>  - if (HEAD == index && index == version) unversion and unlink

Just to be more precise:

   - if (HEAD == index && index == version) unversion and
       * if (--cached is not given) unlink
       * else do nothing

>  - else if (HEAD == index || index == version) unversion
>  - else print message and do nothing
>
> Would you consider that a sane behaviour?

To me, that's a sane behavior.

It makes a few senarios easy and safe, like this:

  $ git add <whatever>
  # Ooops, no, I didn't want to version this one :-(
  $ git rm some-file
  # Cool, I just cancelled my mistake without loosing anything ;-)
  
One benefit is: you don't have to use "-f" for a non-dangerous
senario. That seems stupid, but for the plain "rm" command, the "-rf"
is hardcoded in the fingers of many unix users, and I know several
people having lost data by typing it a bit too mechanically (with a
typo behind, like forgetting the "*" in "*~" ;-).

I'll try writting patch for that if people agree that this is saner
that the current behavior.

-- 
Matthieu
