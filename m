From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] diff --shortstat --dirstat: remove duplicate output
Date: Sun, 01 Mar 2015 17:08:35 +0100
Message-ID: <54F33983.5090700@drmicha.warpmail.net>
References: <xmqqegp9gyof.fsf@gitster.dls.corp.google.com> <1425195546-15637-1-git-send-email-marten.kongstad@gmail.com> <54F2E931.7020200@web.de> <54F320E9.1000006@drmicha.warpmail.net> <20150301160125.GB5307@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	gitster@pobox.com, johan@herland.net
To: =?windows-1252?Q?M=E5rten_Kongstad?= <marten.kongstad@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 17:08:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YS6Q9-0001oG-J4
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 17:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbbCAQIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2015 11:08:41 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57131 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753436AbbCAQIi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2015 11:08:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E862B2067D
	for <git@vger.kernel.org>; Sun,  1 Mar 2015 11:08:36 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Sun, 01 Mar 2015 11:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=S6cVQP2wNGJsjcZqGlYkTE
	Z34AM=; b=Lp0d8ybeUNWcdzJN4eEpCWq/H3XQzK/hoRdiqof8E7o2tJ1e88udly
	R/VflOn4Hfrt8/OEkt28B2b9anxgq+9ty/A3OMKIfuym9680AF0qATYYeQ82dAC6
	+wVLD2BBe6ZStTeLnA25jnYQHSDjS9MTUdRbJMFWMkTcXfuIZlGS4=
X-Sasl-enc: CL67NqsOGEZiXthbHuGYU7rUY5DvTj/XIG3mFjFeMB5b 1425226117
Received: from localhost.localdomain (unknown [88.71.98.191])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0C5DBC002A3;
	Sun,  1 Mar 2015 11:08:36 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150301160125.GB5307@laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264562>

M=E5rten Kongstad venit, vidit, dixit 01.03.2015 17:01:
> On Sun, Mar 01, 2015 at 03:23:37PM +0100, Michael J Gruber wrote:
> []
>> If I would have had to guess from the documentation: What does "git =
diff
>> --dirstat --shortstat" do? I would have answered: It displays both t=
he
>> dirstat and the shortstat.
>>
>> So, is what you are trying to "fix" a peculiarity of
>> "--dirstat=3Dchanges", or do you simplify prefer --dirstat and --sho=
rtstat
>> to override each other?
>>
>> Maybe I'm overlooking something (and that's not a rhetorical
>> conditional), but if you specify both options when you want the outp=
ut
>> of only one them, the answer would be the obvious one, not a patch,
>> wouldn't it?
>>
>> If there is indeed a good reason to change the behavior it should be
>> documented.
> I interpret the documentation the same way as you do. The problem is
> that the dirstat is displayed twice for --dirstat=3Dchanges (or
> --dirstat=3Dfiles):
>=20
> $ git diff --dirstat=3Dchanges,10 --shortstat v2.2.0..v2.2.1
>  23 files changed, 453 insertions(+), 54 deletions(-)
>   33.5% Documentation/RelNotes/
>   26.2% t/
>   46.6% Documentation/RelNotes/
>   16.6% t/
>=20
> but only once for --dirstat=3Dlines:
>=20
> $ git diff --dirstat=3Dlines,10 --shortstat v2.2.0..v2.2.1
>  23 files changed, 453 insertions(+), 54 deletions(-)
>   33.5% Documentation/RelNotes/
>   26.2% t/
>=20
> This behaviour is either a bug, or an inconsistency not immediately a=
pparent to
> the user.
>=20
> The proposed patch will make the 'changes' and 'files' cases behave l=
ike
> 'lines', i.e. output one shortstat and (only) one dirstat:
>=20
> $ patched-version-of-git diff --dirstat=3Dchanges,10 --shortstat v2.2=
=2E0..v2.2.1
>  23 files changed, 453 insertions(+), 54 deletions(-)
>   46.6% Documentation/RelNotes/
>   16.6% t/
>=20

Thanks for the clarification. That looks worthwhile.

Michael
