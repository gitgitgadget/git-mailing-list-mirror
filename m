From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] completion: Add '--edit-todo' to rebase
Date: Thu, 30 Jul 2015 13:24:03 +0200
Message-ID: <20150730132403.Horde.qnEThoM2W0qI-S5EDFXGDg3@webmail.informatik.kit.edu>
References: <1436786876.6619.0.camel@virtuell-zuhause.de>
 <20150713131107.GC1451@serenity.lan>
 <1064256694.3063.1438019649384.JavaMail.open-xchange@app07.ox.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Thu Jul 30 13:24:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKlwp-0000Lp-7f
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 13:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbbG3LYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jul 2015 07:24:23 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:36428 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750775AbbG3LYW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 07:24:22 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZKlwh-0005ck-IF; Thu, 30 Jul 2015 13:24:19 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZKlwR-0004oi-Jw; Thu, 30 Jul 2015 13:24:03 +0200
Received: from x4db0f48c.dyn.telefonica.de (x4db0f48c.dyn.telefonica.de
 [77.176.244.140]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Thu, 30 Jul 2015 13:24:03 +0200
In-Reply-To: <1064256694.3063.1438019649384.JavaMail.open-xchange@app07.ox.hosteurope.de>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1438255459.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274983>


Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:

> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>> John Keeping <john@keeping.me.uk> hat am 13. Juli 2015 um 15:11 gesc=
hrieben:
>> git-rebase.sh contains:
>>
>> 	if test "$action" =3D "edit-todo" && test "$type" !=3D "interactive=
"
>> 	then
>> 		die "$(gettext "The --edit-todo action can only be used during int=
eractive
>> rebase.")"
>> 	fi
>>
>> I wonder if it's worth doing a similar check here, which presumably
>> means testing if "$dir"/interactive exists.
>
> Good point. Thanks for the hint.

Perhaps the subject line could say "completion: offer '--edit-todo' =20
during interactive rebase" to be a bit more specific.

> contrib/completion/git-completion.bash | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index c97c648..b03050e 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1668,7 +1668,11 @@ _git_rebase ()
> {
> 	local dir=3D"$(__gitdir)"
> 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
> -		__gitcomp "--continue --skip --abort"
> +		if [ -d "$dir"/interactive ]; then

This doesn't work for me, I think it looks for the right file at the =20
wrong place.  During an interactive rebase I have no =20
'.git/interactive' file but a '.git/rebase-merge/interactive', so I =20
never get '--edit-todo'.

After some playing around and a cursory look at the source it seems to =
=20
me that I have '.git/rebase-apply' during a "regular" rebase and =20
'.git/rebase-merge' during an interactive rebase, and git-rebase.sh =20
checks the presence of the 'interactive' file only in =20
'.git/rebase-merge'.  It's not clear to me yet whether it's possible =20
to have a '.git/rebase-merge' without the file 'interactive' in it.  =20
If it is possible, then I'd like to know with which commands and under =
=20
what circumstances.  If it isn't, then we wouldn't have to look for =20
the file at all, because checking the presence of the directory would =20
be enough.


Best,
G=C3=A1bor

> +			__gitcomp "--continue --skip --abort --edit-todo"
> +		else
> +			__gitcomp "--continue --skip --abort"
> +		fi
> 		return
> 	fi
> 	__git_complete_strategy && return
> --
> 2.4.5.windows.1
