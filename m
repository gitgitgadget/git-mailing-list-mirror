From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] completion: Add '--edit-todo' to rebase
Date: Fri, 31 Jul 2015 12:16:46 +0200
Message-ID: <20150731121646.Horde.Mk6NzRZAsrRNDCE_y2uEdQ1@webmail.informatik.kit.edu>
References: <1436786876.6619.0.camel@virtuell-zuhause.de>
 <20150713131107.GC1451@serenity.lan>
 <1064256694.3063.1438019649384.JavaMail.open-xchange@app07.ox.hosteurope.de>
 <20150730132403.Horde.qnEThoM2W0qI-S5EDFXGDg3@webmail.informatik.kit.edu>
 <20150730112940.GL14935@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jul 31 12:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL7NL-0004jN-23
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 12:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbbGaKRL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2015 06:17:11 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:41903 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751373AbbGaKRG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 06:17:06 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZL7N9-0005XO-9O; Fri, 31 Jul 2015 12:17:03 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZL7Ms-0006Ly-8K; Fri, 31 Jul 2015 12:16:46 +0200
Received: from x4db1a982.dyn.telefonica.de (x4db1a982.dyn.telefonica.de
 [77.177.169.130]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 31 Jul 2015 12:16:46 +0200
In-Reply-To: <20150730112940.GL14935@serenity.lan>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1438337823.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275042>


Quoting John Keeping <john@keeping.me.uk>:

> On Thu, Jul 30, 2015 at 01:24:03PM +0200, SZEDER G=C3=A1bor wrote:
>>
>> Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:
>>
>>> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
>>> ---
>>>> John Keeping <john@keeping.me.uk> hat am 13. Juli 2015 um 15:11
>> geschrieben:
>>>> git-rebase.sh contains:
>>>>
>>>> 	if test "$action" =3D "edit-todo" && test "$type" !=3D "interacti=
ve"
>>>> 	then
>>>> 		die "$(gettext "The --edit-todo action can only be used during
>> interactive
>>>> rebase.")"
>>>> 	fi
>>>>
>>>> I wonder if it's worth doing a similar check here, which presumabl=
y
>>>> means testing if "$dir"/interactive exists.
>>>
>>> Good point. Thanks for the hint.
>>
>> Perhaps the subject line could say "completion: offer '--edit-todo'
>> during interactive rebase" to be a bit more specific.
>>
>>> contrib/completion/git-completion.bash | 6 +++++-
>>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/contrib/completion/git-completion.bash
>>> b/contrib/completion/git-completion.bash
>>> index c97c648..b03050e 100644
>>> --- a/contrib/completion/git-completion.bash
>>> +++ b/contrib/completion/git-completion.bash
>>> @@ -1668,7 +1668,11 @@ _git_rebase ()
>>> {
>>> 	local dir=3D"$(__gitdir)"
>>> 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
>>> -		__gitcomp "--continue --skip --abort"
>>> +		if [ -d "$dir"/interactive ]; then
>>
>> This doesn't work for me, I think it looks for the right file at the
>> wrong place.  During an interactive rebase I have no
>> '.git/interactive' file but a '.git/rebase-merge/interactive', so I
>> never get '--edit-todo'.

Just noticed another issue here: it looks for a directory, though it =20
should look for a file.


>> After some playing around and a cursory look at the source it seems =
to
>> me that I have '.git/rebase-apply' during a "regular" rebase and
>> '.git/rebase-merge' during an interactive rebase, and git-rebase.sh
>> checks the presence of the 'interactive' file only in
>> '.git/rebase-merge'.  It's not clear to me yet whether it's possible
>> to have a '.git/rebase-merge' without the file 'interactive' in it.
>> If it is possible, then I'd like to know with which commands and und=
er
>> what circumstances.  If it isn't, then we wouldn't have to look for
>> the file at all, because checking the presence of the directory woul=
d
>> be enough.
>
> "git rebase --merge" will use ".git/rebase-merge" without creating th=
e
> "interactive" flag.

Oh, right, thanks.  I should have remembered, I wrote the test of the
prompt script for that case...
(On a related note: is it possible to have a '.git/rebase-apply'
directory, but neither 'rebasing' or 'applying' files within?  The
prompt script has a long if-elif chain with such a branch, and I
remember wondering how I could trigger it for testing.)

Anyway, so this could be something like (modulo likely whitespace damag=
e):

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 07c34ef913..fac01d6985 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1667,7 +1667,10 @@ _git_push ()
   _git_rebase ()
   {
   	local dir=3D"$(__gitdir)"
-	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
+	if [ -f "$dir"/rebase-merge/interactive ]; then
+		__gitcomp "--continue --skip --abort --edit-todo"
+		return
+	elif [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
   		__gitcomp "--continue --skip --abort"
   		return
   	fi


Best,
G=C3=A1bor
