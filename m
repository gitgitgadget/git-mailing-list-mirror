From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Any tips for improving the performance of cloning large repositories?
Date: Fri, 16 Dec 2011 18:37:14 +0000
Message-ID: <CAJ-05NNcORg2H_j3g-h-eDXuuGit_hNH6PG9tNq30QJwJMAPWg@mail.gmail.com>
References: <CAJ-05NPP7aCcr_SYxLYk8U1entDMv0aF2Me3cTGmOLjYqFKUOA@mail.gmail.com>
	<hbf.20111216yufz@bombur.uio.no>
	<hbf.20111216zcin@bombur.uio.no>
	<201112161414.pBGEExLJ006769@no.baka.org>
	<CAJ-05NPbRmyx=a+U7BK4rNShBgaXj+g-Bwc1aBDDb3N0VPBW=A@mail.gmail.com>
	<7vzkesigw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Seth Robertson <in-gitvger@baka.org>,
	Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 19:37:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbcep-0007Nc-TU
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 19:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760483Ab1LPShT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 13:37:19 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49864 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760276Ab1LPShP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 13:37:15 -0500
Received: by ghbz12 with SMTP id z12so2553982ghb.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 10:37:14 -0800 (PST)
Received: by 10.50.219.135 with SMTP id po7mr10374542igc.11.1324060634563;
 Fri, 16 Dec 2011 10:37:14 -0800 (PST)
Received: by 10.42.174.136 with HTTP; Fri, 16 Dec 2011 10:37:14 -0800 (PST)
In-Reply-To: <7vzkesigw9.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: f0krSAd337kc4y85RYXsQg2MwIc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187299>

On 16 December 2011 17:08, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Bennee <kernel-hacker@bennee.com> writes:
>
>> Well that's counter intuitive....
>>
>> =C2=A0- reverting the original repo to one big pack speeds up the cl=
one
>> =C2=A0- adding a --local --reference mirror slows it down
>
> Neither is. Read what "--local" says in the help text of clone. It
> disables the git aware clever optimization.

OK that's not how I read the man page:

       --local, -l
           When the repository to clone from is on a local machine,
this flag bypasses the normal "git aware" transport
           mechanism and clones the repository by making a copy of
HEAD and everything under objects and refs directories.

So this says it skips "git aware" (whatever that means)

           The files under .git/objects/ directory are hardlinked to
save space when possible. This is now the default when
           the source repository is specified with /path/to/repo
syntax, so it essentially is a no-op option. To force
           copying instead of hardlinking (which may be desirable if
you are trying to make a back-up of your repository),
           but still avoid the usual "git aware" transport mechanism,
--no-hardlinks can be used.

And this says that objects on the local file-system are hardlinked
(rather than copied) which I assumed was a optimal approach.

       --no-hardlinks
           Optimize the cloning process from a repository on a local
filesystem by copying files under .git/objects
           directory.

I'm not sure how this is an optimization? This means more copying
rather than linking right?

--=20
Alex, homepage: http://www.bennee.com/~alex/
http://www.half-llama.co.uk
