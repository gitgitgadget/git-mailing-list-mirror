From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 06:26:28 +0200
Message-ID: <4851F6F4.8000503@op5.se>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 06:27:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K70st-0005OC-5s
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 06:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbYFME0g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 00:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbYFME0g
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 00:26:36 -0400
Received: from mail.op5.se ([193.201.96.20]:57697 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbYFME0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 00:26:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B85D41B80085;
	Fri, 13 Jun 2008 06:23:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WxNBpprugfIm; Fri, 13 Jun 2008 06:23:05 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id EDEC41B8004E;
	Fri, 13 Jun 2008 06:23:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84827>

Wincent Colaiuta wrote:
> El 12/6/2008, a las 6:32, Eric Raible escribi=F3:
>=20
>> Nicolas Pitre <nico <at> cam.org> writes:
>>
>>> As you say, branches are there just for that: keeping changes for
>>> months.  Stashes are not meant to be used like that nor should we
>>> encourage it.
>>
>> This unfortunately goes against the recommended usage in John Wiegle=
y's
>> otherwise excellent "Git From the Bottom Up".  I've contacted him=20
>> separately to
>> make him aware of the collective wisdom of not relying on stashes fo=
r=20
>> long-term
>> storage.
>=20
> Yes, we shouldn't _encourage_ people to use stashes as a long-term=20
> storage mechanism, but neither should we allow old stashes to silentl=
y=20
> disappear as a result of reflog expiry, especially as part of automat=
ic=20
> garbage collection. There are two reasons:
>=20
> (1) Normal reflogs accumulate cruft automatically through normal use =
and=20
> if not cleaned up they'll just grow and grow and grow. On the other=20
> hand, for "git stash" to accumulate cruft over the long term the user=
=20
> actually has to take action and _abuse_ them. Abuse is less likely=20
> because it requires this conscious action, and as the output of "git=20
> stash list" gets bigger and more unwieldy this will serve to encourag=
e=20
> people to clean out their stashes themselves, or not let the list gro=
w=20
> out of control in the first place. In other words, the size of the st=
ash=20
> reflog is unlikely to be a problem.
>=20
> (2) Automatically expiring normal reflogs is a service to the user,=20
> because it's cleaning up something that is automatically generated.=20
> Stashes are the result of a concious user decision to create them, so=
=20
> automatically "cleaning them up" is _not_ going to help the user.
>=20

I agree.

> So yes, branches _are_ better and more appropriate for long term stor=
age=20
> than stashes, but even so I don't think it's right for us to risk=20
> throwing away information that the user explicitly stashed and expect=
ed=20
> Git to look after for them.
>=20

Why are branches better and more appropriate?
Is it because the developer who first thought of stashes didn't think t=
hey'd
be used for any halflong period of time?
Is it because there are actions you can do on a branch that you can't d=
o on
a stash?

Who's to say what's appropriate and not? If I explicitly tell a system =
to
save something for me I damn well expect it to be around when I ask tha=
t
same system to load it for me too.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
