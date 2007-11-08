From: Sergei Organov <osv@javad.com>
Subject: Re: Strange git-show-branch behavior.
Date: Thu, 08 Nov 2007 12:58:38 +0300
Message-ID: <87bqa583e9.fsf@osv.gnss.ru>
References: <871wb79q80.fsf@osv.gnss.ru>
	<20071103182224.GA16345@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:59:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq4AD-0002QE-L5
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbXKHJ6t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 04:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbXKHJ6t
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:58:49 -0500
Received: from javad.com ([216.122.176.236]:4829 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450AbXKHJ6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:58:48 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA89wi093798;
	Thu, 8 Nov 2007 09:58:44 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Iq49m-0006EX-Pj; Thu, 08 Nov 2007 12:58:38 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63987>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> On 2007.11.03 20:46:39 +0300, Sergei Organov wrote:
[...]
>> $ git-show-branch --more=3D9 master mybranch
>> * [master] Go to sleep
>>  ! [mybranch] Some work.
>> --
>> *  [master] Go to sleep
>> *+ [mybranch] Some work.
>> *  [master~2] Some fun.
>> *+ [master~3] Commit message
>> *+ [master~4] Initial commit
>> $
>>=20
>> In this output, why git doesn't show the merge commit having "Merged
>> mybranch" commit message?
>
> Because you didn't pass --sparse.

Well, therefore, provided I have the following history:

          .-F-.  mybranch
         /     \
    A---B---C---D---E  master

the 'D' merge commit is reachable only from 'master', so 'D' is not
shown unless I specify --sparse, right? Rather confusing, I'd say, and
the name 'sparse' for the option suggests that the output will have les=
s
revisions in the output, not more. I mean I even didn't care to look at
the description of --sparse when I first read the manual page in order =
to
find some option to increase number of revs output, while I did look at
the --more.

What is the rationale for skipping such merge commits by default?

Anyway, courtesy to your explanation, I think I will be able to come
with a patch for the 'Documentation/core-tutorial.txt' that seems to
have wrong description for one of its examples.

>>=20
>> Yet another confusion:=20
>>=20
>> $ git-show-branch master mybranch
>> * [master] Go to sleep
>>  ! [mybranch] Some work.
>> --
>> *  [master] Go to sleep
>> *+ [mybranch] Some work.
>> $
>>=20
>> Why does it stop at "Some work." commit? The manual page says: "Usua=
lly
>> the command stops output upon showing the commit that is the common
>> ancestor of all the branches.", so I'd expect it should go down to
>> "Commit message" commit that is the fork point.
>
> Common ancestor means, that the commit is reachable through all refs.
> Let's take a look at your history:
>
>          .-F-.  mybranch
>         /     \
>    A---B---C---D---E  master
>
> There you can see that mybranch can of course reach F, and that maste=
r
> can reach it, too. E -> D -> F. So the output stops at F, not at B.

You are right, this particular confusion was due to my misunderstanding
of the term "common ancestor".

However, shouldn't "*the* common ancestor" in the manual be replaced by
"*a* common ancestor"? I mean that according to git-merge-base, there
could be multiple common ancestors even for 2 commits, so saying "*the*
common ancestor" implies use of particular algorithm to select
*the* common ancestor among all the possibilities, and therefore I'd
expect some explanation of the algorithm being used to get *the* common
ancestor.

--=20
Sergei.
