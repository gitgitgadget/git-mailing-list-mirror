From: =?ISO-8859-1?Q?Cl=E1udio_Louren=E7o?= <pt.smooke@gmail.com>
Subject: Re: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 21:48:06 +0100
Message-ID: <CAMUXYmUg12z8LUcFKwjH0Utrvxx0fa5Sne0u9adgoZ=oooBbig@mail.gmail.com>
References: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
	<20120611202132.Horde.dPo1XHwdC4BP1jcsTvSBaFA@webmail.minatec.grenoble-inp.fr>
	<CAA3EhH+iD-sS-3Sg4HJDHgs4Deg2=qbCuJD4UwZWtGQsKbV5aA@mail.gmail.com>
	<7vaa097k3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Leila <muhtasib@gmail.com>, konglu@minatec.inpg.fr,
	git@vger.kernel.org, Renato Neves <nevrenato@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 22:48:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBX4-0005bg-E2
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116Ab2FKUsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 16:48:09 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:39102 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab2FKUsH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 16:48:07 -0400
Received: by weyu7 with SMTP id u7so2370285wey.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hBKgPawgjaDj7hVG6pN2DGmACNvQq97HCrsud+cvLQ4=;
        b=gdBuYX3Qn15EHQefoaTHYfmkfwNGUWN9T7ipnsZbwNP3H1QAQU+ccMYqxmHALdb/X/
         kUSPab46xudX3X+H4GNG2tQVdC+hurPRiq0RYq3MEe5UHXS8lNG98JP5Npo1IijZCoMd
         0S9/caRHRN+DYN/Tip9je0KlCC2GjLlrTukURHOVAWoMqftrUenxAVXFFCNJGuswblhN
         ijKdUBQ8NAZRT31kR4Mk517t7wfyPYwC7nXzLgg+XGAi6uYwJm8wP3444M5RvbWL8mHu
         WmVH4K+t9uq1e8+sNRXW2O8UlKxMlRJOxjebrCE/LSYM0EQYj87/a7lSSE61dww0VpRh
         3PwQ==
Received: by 10.216.195.12 with SMTP id o12mr7551690wen.194.1339447686376;
 Mon, 11 Jun 2012 13:48:06 -0700 (PDT)
Received: by 10.194.28.231 with HTTP; Mon, 11 Jun 2012 13:48:06 -0700 (PDT)
In-Reply-To: <7vaa097k3q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199726>

=46irst of all, thank you all for your attention.
The link for alloy is http://alloy.mit.edu/alloy/  Feel free to take a
look, but this is not the point. We just want to understand what are
the pre-conditions that have to be satisfied to perform checkout.

We have done some tests and we concluded that it is possible to checkou=
t if:

for each file that is on index, but not on the last commit, we have
two cases when it is possible to checkout (from master) to branch b

   first: the file is not on the commit pointed by branch b

   second: the file is on the commit pointed by branch b, and it has
the same content as the file on index, or, the file of both commits
(master and b) have the same content

The deleted files from index, are just ignored (we think the bug comes
from here).

Are our assumptions corrects? Is there any place were we can see such
specifications?



On Mon, Jun 11, 2012 at 7:56 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Leila <muhtasib@gmail.com> writes:
>
>> When you create a branch, it will contain everything committed on th=
e
>> branch you created it from at that given point. So if you commit mor=
e
>> things on the master branch like you have done (after creating b),
>> then switch to branch b, they won't appear. This is the correct
>> behavior. Does that answer your question?
>
> If there were "git commit" immediately before the "git checkout b"
> to check out the branch "b", then something/f1 would be among the
> data committed to the branch "master", and it is perfectly fine to
> remove it in order to check out branch "b" that does not have the
> directory "something" or file in it "something/f1".
>
> But if there is "something/f1" that is not yet committed, the
> command should have refused to check out the branch "b", which I
> think is what Cl=E1udio is talking about. =A0It looks like a bug to m=
e.
>
>>
>>
>> On Mon, Jun 11, 2012 at 2:21 PM, =A0<konglu@minatec.inpg.fr> wrote:
>>>
>>> Cl=E1udio Louren=E7o <pt.smooke@gmail.com> a =E9crit :
>>>
>>>
>>>> The project was going pretty fine, till we start modeling the chec=
kout
>>>> operation. We are with some problems finding useful information ab=
out
>>>> the properties that have to be satisfied when the "git checkout" i=
s
>>>> performed. We have concluded that if everything that is on index i=
s
>>>> commited then we have no problems making checkout.
>>>> The problem is when we have something on index that is not updated
>>>> with the last commit. We cannot find a general property that says =
when
>>>> checkout can be performed. We have even found some files that are
>>>> lost, like in this case:
>>>>
>>>> smooke =A0teste $ git init
>>>> Initialized empty Git repository in /home/smooke/Dropbox/teste/.gi=
t/
>>>> smooke =A0teste $ touch f
>>>> smooke =A0teste $ echo a > f
>>>> smooke =A0teste $ git add f
>>>> smooke =A0teste $ git commit -m 'first commit'
>>>> [master (root-commit) dab04b9] first commit
>>>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>>> =A0create mode 100644 f
>>>> smooke =A0teste $ git branch b
>>>> smooke =A0teste $ touch something
>>>> smooke =A0teste $ echo b > something
>>>> smooke =A0teste $ git add something
>>>> smooke =A0teste $ git commit -m 'something added'
>>>> [master 9f2b8ad] something added
>>>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>>> =A0create mode 100644 something
>>>> smooke =A0teste $ git rm something
>>>> rm 'something'
>>>> smooke =A0teste $ mkdir something
>>>> smooke =A0teste $ cd something/
>>>> smooke =A0something $ touch f1
>>>> smooke =A0something $ echo c > f1
>>>> smooke =A0something $ cd ..
>>>> smooke =A0teste $ git add something/f1
>>>> smooke =A0teste $ git checkout b
>>>> Switched to branch 'b'
>>>> smooke =A0teste $ ls
>>>> f
>>>> smooke =A0teste $ git checkout master
>>>> Switched to branch 'master'
>>>> smooke =A0teste $ ls
>>>> f =A0something
>>>> smooke =A0teste $ cat something
>>>> b
>>>
>>>
>>> What do you mean by "lost files" ? Are you talking about "something=
"
>>> that doesn't appear on branch 'b' ?
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
