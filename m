From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Mon, 12 Apr 2010 17:47:08 +0200
Message-ID: <4BC3407C.10701@viscovery.net>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>	 <20100410042609.GA24295@coredump.intra.peff.net>	 <h2x76c5b8581004101510hc1d15f42u7e48dafbc275c998@mail.gmail.com>	 <20100411102255.GB20484@coredump.intra.peff.net>	 <y2s76c5b8581004110706p7b63900aqf90f9c1462a1f637@mail.gmail.com>	 <q2z76c5b8581004120709t860ff112i5dd057327b94ad0e@mail.gmail.com>	 <4BC3389C.4090807@viscovery.net> <w2t76c5b8581004120828p8e1e5c49m7bcc53c8c3e68d06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 17:47:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Lr3-00009y-M5
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 17:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab0DLPrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 11:47:12 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8132 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0DLPrK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 11:47:10 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O1Lqu-0006lQ-IF; Mon, 12 Apr 2010 17:47:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 520131660F;
	Mon, 12 Apr 2010 17:47:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <w2t76c5b8581004120828p8e1e5c49m7bcc53c8c3e68d06@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144743>

Am 4/12/2010 17:28, schrieb Eugene Sajine:
> On Mon, Apr 12, 2010 at 11:13 AM, Johannes Sixt <j.sixt@viscovery.net=
> wrote:
>> Am 4/12/2010 16:09, schrieb Eugene Sajine:
>>> esajine@ESAJINEWWW /c/git_repos/test2 (topic)
>>> $ git rebase master
>>> Current branch topic is up to date.
>>> <=3D=3D=3D=3D=3D=3D=3D Really? Topic is actually based on next =E2=80=
=93 what does this "up
>>> to date" mean??
>>
>> Why should rebase bother? The difference between master and topic ar=
e
>> *two* commits. Since these two are already on top of master in linea=
r
>> history, you get no advantage by doing a rebase operation. Therefore=
, you
>> see "already up to date".
>=20
> You lost me completely...
> Rebase means change the base of the commit, change the fork point.

Rebase is meant to change the fork point for a history like this:

  --o--o--A--o--o--B  <-- master
           \
            o
             \
              o       <-- topic

topic forks from master at commit A; you use rebase to create history t=
hat
looks like this:

  --o--o--A--o--o--B     <-- master
                    \
                     o
                      \
                       o <-- topic

(OK, you knew that already.)

> Current fork point for topic is next. I want it to be master. What is
> up to date here???

You are already in the second situation above. The fact that you labele=
d
one commit "next" in between, like this:

  --o--o--A--o--o--B     <-- master
                    \
                     o   <-- next
                      \
                       o <-- topic

does not change the meaning of the command "git rebase master" in the
slightest: topic is "up to date" with respect to master.

> The message is poorly worded for sure.
>=20
> I know that the form i have to use is:
>=20
> git rebase --onto master next topic
>=20
> but it is just because topic is not direct descendant of master, isn'=
t it?

Watch out the wording that you use: "descendant of" has a well-defined
meaning in git, in particular, topic *is* a direct descendant of master=
=2E

What you wanted to say is: "but it is just because I have accidentally
begun to commit 'topic' on top of 'next', but I didn't want to do that"=
=2E

And yes, you are right, because of this you need --onto in the rebase c=
ommand.

> Come on! Please, please, explain me why it behaves DIFFERENTLY:
>=20
> esajine@ESAJINEWWW /c/git_repos/test2 (topic)
> $ git rebase --onto master topic
> First, rewinding head to replay your work on top of it...
> fatal: Not a range.
> Nothing to do.
>                 <=3D=3D=3D=3D=3D=3D=3D=3D topic..HEAD is not a range,=
 agreed
>=20
>=20
> esajine@ESAJINEWWW /c/git_repos/test2 (topic)
> $ git rebase -i --onto master topic
> Successfully rebased and updated refs/heads/topic. <=3D=3D=3D BUG =E2=
=80=93 here it
> printed me =E2=80=9Cnoop=E2=80=9D in file to edit, when I exited it s=
hould do nothing,
> but it still did something and I double checked it.

A historical accident, so to say. The implementor of interactive rebase
felt the "noop" behavior was useful, and I agree, FWIW.

-- Hannes
