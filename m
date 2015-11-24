From: =?windows-1252?Q?Carlos_Mart=EDn_Nieto?= <cmn@dwim.me>
Subject: Re: branch --set-upstream-to unexpectedly fails with "starting point ... is no branch"
Date: Tue, 24 Nov 2015 17:58:45 +0100
Message-ID: <12A15BA3-11C2-426A-87D6-421BA9708A51@dwim.me>
References: <5652F2D2.3050902@syntevo.com> <15ED3D48-282B-44EF-98C6-EA59F18D633E@dwim.me> <56536224.3050306@syntevo.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 20:37:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1JPA-0002TO-EE
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 20:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbbKXThK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2015 14:37:10 -0500
Received: from hessy.dwim.me ([78.47.67.53]:42228 "EHLO hessy.dwim.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083AbbKXThH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2015 14:37:07 -0500
Received: from [192.168.44.85] (unknown [195.82.63.198])
	by hessy.dwim.me (Postfix) with ESMTPSA id 662C280411;
	Tue, 24 Nov 2015 20:37:03 +0100 (CET)
In-Reply-To: <56536224.3050306@syntevo.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281623>


On 23 Nov 2015, at 19:59, Marc Strapetz <marc.strapetz@syntevo.com> wro=
te:

> On 23.11.2015 18:04, Carlos Mart=EDn Nieto wrote:
>> Hello Mark,
>>=20
>> On 23 Nov 2015, at 12:04, Marc Strapetz <marc.strapetz@syntevo.com> =
wrote:
>>=20
>>> There is a strange "branch --set-upstream-to" failure for "clones" =
which haven't been created using "git clone" but constructed using "git=
 init", "git remote add" and "git fetch".
>>>=20
>>> Following script first creates a "main" repository and then constru=
cts the clone. Finally, in the clone branches origin/1 and origin/2 wil=
l be present, however it's not possible to invoke "git branch --set-ups=
tream-to" for origin/2 (it works fine for origin/1).
>>>=20
>>> I guess the behavior is related to following line in .git/config:
>>>=20
>>> fetch =3D refs/heads/1:refs/remotes/origin/1
>>>=20
>>> However, I don't understand what's the problem for Git here? Defini=
tely the error "starting point 'origin/2' is not a branch" is wrong.
>>>=20
>>=20
>> That is indeed the issue. The configuration which is stored in the c=
onfiguration is a remote+branch pair. If there is no fetch refspec conf=
igured which would create the =91origin/2=92 remote-tracking branch, th=
e command does not know which remote and branch that would correspond t=
o.
>=20
> Thanks, Carlos, I understand now.
>=20
> My goal is to have a clone which will only fetch specific branches, s=
o I guess I have to stick with "refs/heads/1:refs/remotes/origin/1" for=
 the beginning and for every new branch X add another "refs/heads/X:ref=
s/remotes/origin/X"? Or is there a better way?

If you want fine-grained control over what gets downloaded, you=92ll ne=
ed to restrict either the configured refspecs or the ones which git-fet=
ch gets.

You can configure the individual refspecs so a =91git fetch=92 call wil=
l download the ones you want, giving you the issue you mention here; or=
 you can configure the default refspec, but always pass explicit instru=
ctions to git-fetch, like =91git fetch refs/heads/1 refs/heads/2=92. Ne=
wer git versions (past 1.9.3 I think) will update the remote-tracking b=
racnhes when you do it this way.

Both of these are annoying in their own way. The second way might be pr=
eferable if the fetching is done by a script. But if you absent-mindedl=
y run a lone =91git fetch=92, then you=92ll download all branches.

Cheers,
   cmn
