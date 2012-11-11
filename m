From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Sun, 11 Nov 2012 17:46:32 +0100
Message-ID: <509FD668.20609@lsrfire.ath.cx>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com> <03ED9D50D1F64467863C051959CFC433@PhilipOakley> <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
To: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:46:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXagP-0008J1-7F
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab2KKQqi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 11:46:38 -0500
Received: from india601.server4you.de ([85.25.151.105]:43645 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab2KKQqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:46:38 -0500
Received: from [192.168.2.105] (p4FFDA0BC.dip.t-dialin.net [79.253.160.188])
	by india601.server4you.de (Postfix) with ESMTPSA id DD76CE0;
	Sun, 11 Nov 2012 17:46:35 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209399>

Am 10.11.2012 22:13, schrieb Jean-Jacques Lafay:
> Le samedi 10 novembre 2012 21:00:10 UTC+1, Philip Oakley a =E9crit :
>
>     From: "Jean-Jacques Lafay" <jeanjacq...@gmail.com <javascript:>>
>     Sent: Saturday,
>     November 10, 2012 5:36 PM
>      > In large repos, the recursion implementation of contains(commi=
t,
>      > commit_list)
>      > may result in a stack overflow. Replace the recursion with a l=
oop to
>      > fix it.
>      >
>      > Signed-off-by: Jean-Jacques Lafay <jeanjacq...@gmail.com
>     <javascript:>>
>
>     This is a change to the main git code so it is better to submit i=
t to
>     the main git list at g...@vger.kernel.org <javascript:> (plain te=
xt,
>     no HTML, first
>     post usually has a delay ;-)
>
>     It sounds reasonable but others may have opinions and comments.
>
>     Have you actually suffered from the stack overflow issue? You onl=
y
>     suggest it as a possibility, rather than a real problem.
>
>     Philip
>
>
> Yes, it actually crashed on me, and since the call is made by
> GitExtension while browsing the commit history, it was quickly annoyi=
ng
> to have windows popping a "git.exe stopped working" message box at my
> face every time I clicked on a line of the history ;-)  (well, you ca=
n
> sort of work around it by having the "file tree" or "diff" tab active=
)
>
> Coincidentally, as I was having a glance at the recent topics, I saw
> that someone else experienced it.
>
> However, I couldn't reproduce it on Linux : where the windows
> implementations crashes at a ~32000 depth (*not* exactly 32768, mind
> you), on linux it happily went through 100000 commits. I didn't take
> time to look much further, but maybe on my 64 bit Linux VM, the proce=
ss
> can afford to reserve a much bigger address range for the stack of ea=
ch
> thread than the 1Mb given to 32 bit processes on windows.
> Jean-Jacques.

I can reproduce it on Linux (Debian testing amd64) with ulimit -s 1000=20
to reduce the stack size from its default value of 8MB.

After reverting ffc4b8012d9a4f92ef238ff72c0d15e9e1b402ed (tag: speed up=
=20
--contains calculation) the test passes even with the smaller stack, bu=
t=20
it makes "git tag --contains" take thrice the time as before.

Ren=E9
