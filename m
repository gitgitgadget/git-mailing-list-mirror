From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Thu, 12 Jun 2008 07:35:43 +0200
Message-ID: <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:37:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fUm-0005PP-BM
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbYFLFfy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 01:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbYFLFfy
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:35:54 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:52939 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbYFLFfx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2008 01:35:53 -0400
Received: from cuzco.lan (185.pool85-53-11.dynamic.orange.es [85.53.11.185])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m5C5ZivZ019828
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 12 Jun 2008 01:35:47 -0400
In-Reply-To: <loom.20080612T042942-698@post.gmane.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84717>

El 12/6/2008, a las 6:32, Eric Raible escribi=F3:

> Nicolas Pitre <nico <at> cam.org> writes:
>
>> As you say, branches are there just for that: keeping changes for
>> months.  Stashes are not meant to be used like that nor should we
>> encourage it.
>
> This unfortunately goes against the recommended usage in John =20
> Wiegley's
> otherwise excellent "Git From the Bottom Up".  I've contacted him =20
> separately to
> make him aware of the collective wisdom of not relying on stashes =20
> for long-term
> storage.

Yes, we shouldn't _encourage_ people to use stashes as a long-term =20
storage mechanism, but neither should we allow old stashes to silently =
=20
disappear as a result of reflog expiry, especially as part of =20
automatic garbage collection. There are two reasons:

(1) Normal reflogs accumulate cruft automatically through normal use =20
and if not cleaned up they'll just grow and grow and grow. On the =20
other hand, for "git stash" to accumulate cruft over the long term the =
=20
user actually has to take action and _abuse_ them. Abuse is less =20
likely because it requires this conscious action, and as the output of =
=20
"git stash list" gets bigger and more unwieldy this will serve to =20
encourage people to clean out their stashes themselves, or not let the =
=20
list grow out of control in the first place. In other words, the size =20
of the stash reflog is unlikely to be a problem.

(2) Automatically expiring normal reflogs is a service to the user, =20
because it's cleaning up something that is automatically generated. =20
Stashes are the result of a concious user decision to create them, so =20
automatically "cleaning them up" is _not_ going to help the user.

So yes, branches _are_ better and more appropriate for long term =20
storage than stashes, but even so I don't think it's right for us to =20
risk throwing away information that the user explicitly stashed and =20
expected Git to look after for them.

Wincent
