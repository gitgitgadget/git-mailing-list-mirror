From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: RFC: Making submodules "track" branches
Date: Wed, 09 Jun 2010 11:36:47 -0400
Message-ID: <4C0FB50F.3020403@xiplink.com>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com> <201006080912.31448.johan@herland.net> <4C0E6A8A.70608@web.de> <7vbpblruj8.fsf@alter.siamese.dyndns.org> <4C0F3FA9.7000800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 09 17:37:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMNL0-0002nz-6F
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 17:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077Ab0FIPhB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 11:37:01 -0400
Received: from smtp142.dfw.emailsrvr.com ([67.192.241.142]:44739 "EHLO
	smtp142.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183Ab0FIPhA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 11:37:00 -0400
Received: from relay24.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay24.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 14DF934E86C1;
	Wed,  9 Jun 2010 11:37:00 -0400 (EDT)
Received: by relay24.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 9198E34E8867;
	Wed,  9 Jun 2010 11:36:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <4C0F3FA9.7000800@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148789>

On 10-06-09 03:15 AM, Jens Lehmann wrote:
> Am 09.06.2010 01:09, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>> Don't record a commit in the first place, following a branch is not=
 bound
>>> to a special commit, so pretending to do that might do more harm th=
an good.
>>> Just putting the 0-hash there might be the solution.
>>
>> Ugh.  Even though I understand that in some scenarios you would want=
 to
>> say "I don't care what commit is used for this submodule---just use =
the
>> tip of the branch 'fred'", I don't think you want to use 0{40} in th=
e
>> superproject.  I think it would be Ok to add such a note to .gitmodu=
les in
>> the superproject, but I also think we should still record which _exa=
ct_
>> commit was used to test and validate such a commit in the superproje=
ct
>> when it was made.
>=20
> I think we are in violent agreement here.

I too am in this camp.

If a submodule is tracking the tip of a branch, I think it's vital that
checking out the superproject's HEAD@{3 months ago} gives you the submo=
dule
as it was in the superproject 3 months ago.  Back then, it may have bee=
n
tracking a different branch.  It may not have been tracking a branch at=
 all.
 It may have been using a completely different repository altogether.

It's hard for me to see the utility of having the submodule reflect the
tip-of-some-branch-as-of-today when I'm looking at 3-month-old code in =
the
superproject.

AFAICT, =C6var's original proposal does the right thing here, because a
submodule tracking a branch would look dirty in the superproject if the
branch's HEAD doesn't match the commit ID recorded in the superproject.=
  So
"submodule update" would restore the submodule's state to what the
superproject says it should be.

I don't think I mind dirty branch-tracking submodules, but folks seem t=
o find
it distasteful.  However, I believe all the proposals made so far to ad=
dress
it break what I call the superproject's "historical consistency."

I wish I could come up with some way to reconcile clean branch-tracking
submodules with historical consistency, but alas my imagination is so f=
ar too
limited.  :(

		M.
