From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: git add -p and unresolved conflicts
Date: Thu, 29 Mar 2012 03:32:23 +0200
Message-ID: <4F73BBA7.6030009@ira.uka.de>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com> <7vbongyd67.fsf@alter.siamese.dyndns.org> <vpqvclozr7e.fsf@bauges.imag.fr> <4F73632E.1060408@ira.uka.de> <vpqk424zfb1.fsf@bauges.imag.fr> <4F737027.5020503@ira.uka.de> <7vvclotpp7.fsf@alter.siamese.dyndns.org> <4F7395B6.1020506@ira.uka.de> <7vk424s52z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 03:32:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD4EA-00079x-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 03:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758728Ab2C2Bce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 21:32:34 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:42844 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758027Ab2C2Bcd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2012 21:32:33 -0400
Received: from dslb-088-066-020-130.pools.arcor-ip.net ([88.66.20.130] helo=[192.168.2.231])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 465 
	id 1SD4Dw-000588-LG; Thu, 29 Mar 2012 03:32:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120215 Thunderbird/10.0.2
In-Reply-To: <7vk424s52z.fsf@alter.siamese.dyndns.org>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1332984750.189442000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194221>

Am 29.03.2012 01:01, schrieb Junio C Hamano:
> There is a crucial step missing.  After running "cherry-pick --no-com=
mit",
> you would eyeball the result, and typically edit the file.  The confl=
ict
> may not be in the part of the file you are interested in picking, in =
which
> case you may even leave that part as-is.  And then, you would pick wh=
at
> you want to apply to the index during per-hunk interactive patching
> session.

But that changes nothing. To make it clear: We have a file with chunks=20
A, B and C. Only B is conflicting, but the user wants to add A or an=20
edited A=B4 . And maybe also a new edit D.

When he calls "git add -p", he gets presented with B. By picking the=20
"ours" option (aka "<") he gets the version in HEAD, resolving the=20
conflict and thereby allowing the add. Next he will be presented with A=
=20
(or A=B4) where he can type in "y" and C where he can type in "n".

Result: chunk A is added, C not, and B doesn't change from HEAD. Note h=
e=20
had the option to use ">" instead if it was B he wanted to cherry-pick.

The same happens if he further edited somewhere else to produce chunk D=
=2E=20
Again, after resolving the conflict of B, he is presented with A,B and =
D=20
and can add these chunks with "y" or not with "n".

The only case I haven't talked about now is if he edits B, but that is=20
the trivial case because he would normally remove the conflict markers=20
as well and git add -p would work conflict-free after the edit.

> In other words,...
>
>> git init .
>> echo "foo">  bar.txt
>> git add bar.txt
>> git commit -m.
>> git checkout -b new
>> echo "bar">>  bar.txt
>> git commit -am.
>> git checkout master
>> git reset --hard
>> echo "baz">>  bar.txt
>> git commit -am.
>> git cherry-pick --no-commit new
>
> Here, there *will* be "edit bar.txt" before "add -p".
