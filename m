From: Andreas Ericsson <ae@op5.se>
Subject: Re: git rebase --skip
Date: Thu, 08 Nov 2007 11:32:08 +0100
Message-ID: <4732E5A8.3020101@op5.se>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net> <20071108102412.GA31187@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 11:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq4ga-0003cU-Rm
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 11:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbXKHKcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 05:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbXKHKcN
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 05:32:13 -0500
Received: from mail.op5.se ([193.201.96.20]:57636 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005AbXKHKcM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 05:32:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AB5DB1F0870B;
	Thu,  8 Nov 2007 11:32:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YuNbVwd4kP1D; Thu,  8 Nov 2007 11:32:04 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 2A91B1F0870A;
	Thu,  8 Nov 2007 11:32:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071108102412.GA31187@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63992>

Bj=F6rn Steinbrink wrote:
> On 2007.11.07 22:23:10 -0500, Jeff King wrote:
>> On Wed, Nov 07, 2007 at 11:21:05PM +0100, Mike Hommey wrote:
>>
>>> I use git-rebase quite regularly, and I haven't used git-rebase --s=
kip
>>> after a failed merge without first resetting the working tree. I wa=
s
>>> wondering if it wouldn't make sense to automatically do the reset w=
hen
>>> running git-rebase --skip.
>> I have often been annoyed by this behavior, too, and I can't think o=
f
>> any situation where you _wouldn't_ want the reset to happen.  But I
>> would be more comfortable hearing confirmation from others that they
>> can't think of such a situation.
>=20
> Let's take this history:
>=20
>       C---D---E topic
>      /
>     A---B master
>=20
> You then do:
> git rebase master topic
>=20
> Now D causes conflicts, because B did a similar change, but not quite
> the same, maybe having a bug. So you want to keep parts of D, but it'=
s
> no longer the same commit semantically and the original commit messag=
e
> would be bogus. So you resolve the conflicts and do:
>=20
> git commit
> git rebase --skip
>=20
> Because you replaced D with a new different commit, instead of really
> just rebasing it. With plain --continue, you'd have to go back and fi=
x
> the commit message once the rebase is complete. And --continue after =
the
> commit is a no-go, too, because rebase will complain that there's
> nothing left to produce the rebased D commit.
>=20
> And now imagine that you forget to commit but instead just --skip.
> Ouch, all the work is lost, time to restart the rebase. With the curr=
ent
> behaviour, rebase won't just throw away your stuff.
>=20

How about if the state to skip was stashed, the patch reapplied and the
differences compared. If they were identical, go ahead and force the
reset --hard, otherwise abort. That way, --skip will dwim only when
it's safe, and all the lost work can be automagically created by
just re-applying the patch again?

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
