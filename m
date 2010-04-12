From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Mon, 12 Apr 2010 17:13:32 +0200
Message-ID: <4BC3389C.4090807@viscovery.net>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>	 <20100410042609.GA24295@coredump.intra.peff.net>	 <h2x76c5b8581004101510hc1d15f42u7e48dafbc275c998@mail.gmail.com>	 <20100411102255.GB20484@coredump.intra.peff.net>	 <y2s76c5b8581004110706p7b63900aqf90f9c1462a1f637@mail.gmail.com> <q2z76c5b8581004120709t860ff112i5dd057327b94ad0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 17:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1LKZ-00015e-PB
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 17:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab0DLPNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 11:13:37 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37811 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750827Ab0DLPNh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 11:13:37 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O1LKP-0001dX-H2; Mon, 12 Apr 2010 17:13:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 44E9B1660F;
	Mon, 12 Apr 2010 17:13:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <q2z76c5b8581004120709t860ff112i5dd057327b94ad0e@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144740>

Am 4/12/2010 16:09, schrieb Eugene Sajine:
> esajine@ESAJINEWWW /c/git_repos/test2 (topic)
> $ git rebase master
> Current branch topic is up to date.
> <=3D=3D=3D=3D=3D=3D=3D Really? Topic is actually based on next =E2=80=
=93 what does this "up
> to date" mean??

Why should rebase bother? The difference between master and topic are
*two* commits. Since these two are already on top of master in linear
history, you get no advantage by doing a rebase operation. Therefore, y=
ou
see "already up to date".

The fact that the second commit from the tip of topic is also labeled
"next" is absolutely irrelevant to rebase. rebase only looks at the ref=
s
that you tell it about: master and topic (implicitly pointed to by HEAD=
),
nothing else.

What you really want to do, obviously, is:

   git rebase --onto master next topic

No, there is no shorter form to spell this operation.

> esajine@ESAJINEWWW /c/git_repos/test2 (topic)
> $ git rebase -i --onto master topic
> Successfully rebased and updated refs/heads/topic. <=3D=3D=3D BUG =E2=
=80=93 here it
> printed me =E2=80=9Cnoop=E2=80=9D in file to edit, when I exited it s=
hould do nothing,
> but it still did something and I double checked it.

Not a bug.

Your command is the same as

   git rebase -i --onto master topic topic

because you are already on branch topic. Since there are no commits in =
the
range topic..topic, rebase -i told you "noop". This word is perhaps poo=
rly
chosen, because it does not mean "no operation"[*], but "there are no
commits to transfer". But branch 'topic' that you gave as the last
argument (or implicitly by being at branch 'topic') is still transferre=
d
--onto master. This explains the result that you observed.

Of course, if you do not 'reset --hard topic@{1}' at this point, you wi=
ll
ultimately lose the commits on branch topic.

[*] You can get "no operation" by deleting the line "noop".

-- Hannes
