From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] t5510: run auto-gc in the foreground
Date: Thu, 05 May 2016 17:14:30 +0200
Message-ID: <20160505171430.Horde.-GuvDpZBfS8VI1Zcfn4bJQI@webmail.informatik.kit.edu>
References: <20160501153743.323-1-szeder@ira.uka.de>
 <alpine.DEB.2.20.1605020859131.9313@virtualbox>
 <20160503015526.Horde.e0uZ0P4BqpNnwx_zmhu3WfE@webmail.informatik.kit.edu>
 <20160503135028.Horde.jeJdKT1kb2NTVAS1HpcsQh2@webmail.informatik.kit.edu>
 <alpine.DEB.2.20.1605040741500.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 05 17:14:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayKzA-0006e1-Nq
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 17:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbcEEPOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 11:14:36 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33915 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753503AbcEEPOf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 May 2016 11:14:35 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ayKz1-0008Sm-BM; Thu, 05 May 2016 17:14:31 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1ayKz0-0004jS-UI; Thu, 05 May 2016 17:14:30 +0200
Received: from x4db01ee5.dyn.telefonica.de (x4db01ee5.dyn.telefonica.de
 [77.176.30.229]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Thu, 05 May 2016 17:14:30 +0200
In-Reply-To: <alpine.DEB.2.20.1605040741500.9313@virtualbox>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1462461271.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293649>


Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Hi G=C3=A1bor,
>
> On Tue, 3 May 2016, SZEDER G=C3=A1bor wrote:
>
>> Quoting SZEDER G=C3=A1bor <szeder@ira.uka.de>:
>>
>> >Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> >
>> > >Hi G=C3=A1bor,
>> > >
>> > >On Sun, 1 May 2016, SZEDER G=C3=A1bor wrote:
>> > >
>> > > >diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> > > >index 38321d19efbe..454d896390c0 100755
>> > > >--- a/t/t5510-fetch.sh
>> > > >+++ b/t/t5510-fetch.sh
>> > > >@@ -682,6 +682,7 @@ test_expect_success 'fetching with auto-gc =
does
>> > > >not lock up' '
>> > > > (
>> > > >  cd auto-gc &&
>> > > >  git config gc.autoPackLimit 1 &&
>> > > >+		git config gc.autoDetach false &&
>> > > >  GIT_ASK_YESNO=3D"$D/askyesno" git fetch >fetch.out 2>&1 &&
>> > > >  ! grep "Should I try again" fetch.out
>> > > > )
>> > >
>> > >Sounds good to me.
>> >
>> >There is something still bothering me, though.
>> >
>> >I take this was a Windows-specific issue; deleting open files on Li=
nux is
>> >no brainer.  According to a comment on the original Git for Windows=
 issue
>> >at github[1], 'git gc' runs in the background by default on =20
>> Windows as well.
>>
>> Ok, having slept on it, it was a false alarm.
>>
>> Though 'git gc --auto' claims "Auto packing the repository in backgr=
ound for
>> optimum performance." on Windows, it does in fact runs in the foregr=
ound.
>
> Thanks for checking. I ran out of time yesterday.
>
>> 'git gc --auto' first prints that message, unless gc.autoDetach is d=
isabled,
>> and then calls daemonize() to go to the background.  However, daemon=
ize() is
>> basically a no-op on Windows, thus 'git gc' will remain in the =20
>> foreground and
>> the sequence I described below is impossible.  Good.
>
> Oh, right. I think this will take a lot of energy to fix: daemonize()=
's
> functionality is not really available, indeed. What *is* available is=
 a
> spawn() that detaches the new process.
>
>> Perhaps it would be worth updating 'git gc' to not lie about going t=
o the
>> background when we can already know in advance that it won't.
>
> Hmm.  https://github.com/git/git/blob/master/builtin/gc.c#L372-L373
> already looks correct (should it really know that we cannot daemonize=
()?
>
> 			if (detach_auto)
> 				fprintf(stderr, _("Auto packing the repository in background for =
=20
> optimum performance.\n"));
> 			else
> 				fprintf(stderr, _("Auto packing the repository for optimum =20
> performance.\n"));

It is only correct as far as the value of the 'gc.autoDetach' config
variable is concerned, which is enabled by default, even on Windows, wh=
ere
it can't go to the background.

> (should it really know that we cannot daemonize()?
> What about other code paths using that function?):

daemonize() is currently only used in the 'git gc --auto' code path and=
 in
'git daemon', which doesn't announce that it is about to go in the
background.  Then there is the WIP index-helper, which will use daemoni=
ze()
as well, but it won't announce that either.

Being the sole callsite that makes such an announcement, I think it sho=
uld
know or at least should check whether "daemonizing" is possible. (as
opposed to e.g. teaching daemonize() to print such messages)


G=C3=A1bor
