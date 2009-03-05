From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: More git bisect modes
Date: Thu, 5 Mar 2009 21:53:41 +0100
Message-ID: <200903052153.41391.chriscool@tuxfamily.org>
References: <43d8ce650903050149u4ca98444w28efceb9084efa68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 21:56:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKbu-0001aL-05
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 21:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbZCEUyi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 15:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbZCEUyi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 15:54:38 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:35704 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754043AbZCEUyh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 15:54:37 -0500
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 3C7184B01E8;
	Thu,  5 Mar 2009 21:54:28 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 4CED74B017B;
	Thu,  5 Mar 2009 21:54:26 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <43d8ce650903050149u4ca98444w28efceb9084efa68@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112342>

Le jeudi 5 mars 2009, John Tapsell a =C3=A9crit :
> Hi,
>
>   Although "git bisect" is called, well, bisect, it would be nice to
> have other modes.
>
> * A completely linear version - check every version.  Particularly
> useful after rebasing to make sure all the commits still compile.

I will answer this one bellow along with the exponential back-off.

> * An allow-for-mistakes-bisect.  This would use a bisection technique
> that would allow for a minimum of 1 mistake when marking a commit goo=
d
> or bad.  This point isn't particularly to help those with fat fingers=
,
> but for bugs that are subtle and for bugs that are caused by multiple
> commits.  (I can go into the details of how to do such a bisect
> later).

Yeah, Ingo Molnar also asked for something like this. But I think it is=
=20
quite complex. I hope it will be easier after the improvements I am=20
currently working on. I hope to send something early next week.

> * An exponential back-off.  Typically I know that HEAD is broken, and
> I don't know when it used to work.  It would be nice to exponentially
> go back through the commits to find the first working commit, then
> bisect from there.

I think your first idea above and this one could be implemented in a ne=
w=20
command called for example "git check".

It could be used it like this:

$ git check COMMAND $(git rev-list HEAD~10..)

that would check out each of the 10 last revisions and run COMMAND on e=
ach=20
one after check out, and at the end it could report about the exit code=
 of=20
command for each of these revisions.

It could be used also with tags like that:

$ git check COMMAND $(git tag |=C2=A0tail -10)

After that a --bisect flag could be implemented. That would automatical=
ly=20
call "git bisect" to bisect if the exit code changed from "bad" to "goo=
d"=20
at one point.

Then if one adds a --expo flag to "git rev-list" that could be used for=
 the=20
exponential back off you want.

>   Before I start working on the code for any of these, do people like
> this?  Would this fit into the 'git bisect' command?

I think it would be usefull, but I don't think the first and last one w=
ould=20
fit well into the "git bisect" command.

Best regards,
Christian.
