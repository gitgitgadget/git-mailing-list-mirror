From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: error out when the "upstream" semantics does not make sense
Date: Fri, 06 Apr 2012 09:16:02 +0200
Message-ID: <vpqiphd49fx.fsf@bauges.imag.fr>
References: <7v8vib6pu8.fsf@alter.siamese.dyndns.org>
	<20120405124706.GA3921@sigill.intra.peff.net>
	<7v1uo26ue9.fsf_-_@alter.siamese.dyndns.org>
	<20120405184345.GA6448@burratino>
	<7vlima5591.fsf@alter.siamese.dyndns.org>
	<7vhawy54nd.fsf@alter.siamese.dyndns.org>
	<vpqsjgi53mh.fsf@bauges.imag.fr>
	<7vy5q95354.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 09:16:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG3PC-0000Es-6b
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 09:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab2DFHQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 03:16:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33715 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754756Ab2DFHQP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 03:16:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q367AgPE032750
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Apr 2012 09:10:42 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SG3Ot-0003Qb-3E; Fri, 06 Apr 2012 09:16:03 +0200
In-Reply-To: <7vy5q95354.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 05 Apr 2012 13:34:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Apr 2012 09:10:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q367AgPE032750
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334301044.92991@Wv1OTjYlxe47wYWzERyZLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194852>

Junio C Hamano <gitster@pobox.com> writes:

>> "To push the current branch to this remote, run:
>>
>>   git push <remote> <branch>
>>
>> "
>
> I am afraid that the above advice is a lot worse than leaving it unsaid.
>
> We are in no position to assume that the user wanted the "current"
> semantics when we issue this message.  Otherwise, we would be better off
> switching the default semantics to "current", not "upstream".  But the
> working assumption in this series is that "upstream" is an improvement
> over "current", no?

I'm not sure. I do support "upstream", but I also think that in many
(most?) cases, the user will want to set "upstream" to point to the
branch with the same name. If there is any confusion between "current"
and "upstream", then avoiding situations where they do something
different is not stupid. This is already what we do when there is no
upstream configured at all:

  $ git push origin
  fatal: The current branch master has no upstream branch.
  To push the current branch and set the remote as upstream, use
  
      git push --set-upstream origin master

OTOH, if the user sees this message, he already has several remotes
configured, and we can probably expect him not to be a total newbie.
Then suggesting

  "git push --set-upstream %s %s:<remote-branch-name>", remote->name, branch->name

would make sense.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
