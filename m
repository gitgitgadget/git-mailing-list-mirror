From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Sun, 25 Apr 2010 00:08:11 +0200
Message-ID: <87tyr0sdv8.fsf@frosties.localdomain>
References: <20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221651590.7232@xanadu.home>
	<87vdbitu9v.fsf@frosties.localdomain>
	<25441792-181D-456D-8182-F33B49209EFF@wincent.com>
	<87aastx6sa.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004231639180.7232@xanadu.home>
	<8739yktuvs.fsf@frosties.localdomain>
	<20100424214024.GA8044@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 00:08:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5nWY-0001vn-Mv
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 00:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab0DXWIN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 18:08:13 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59905 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab0DXWIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 18:08:12 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id DC67415790FD7;
	Sun, 25 Apr 2010 00:08:10 +0200 (CEST)
Received: from [78.43.204.177] (helo=frosties.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1O5nWE-0002Bt-00; Sun, 25 Apr 2010 00:08:10 +0200
Received: from mrvn by frosties.localdomain with local (Exim 4.71)
	(envelope-from <goswin-v-b@web.de>)
	id 1O5nWF-00083t-6L; Sun, 25 Apr 2010 00:08:11 +0200
In-Reply-To: <20100424214024.GA8044@progeny.tock> (Jonathan Nieder's message
	of "Sat, 24 Apr 2010 16:40:25 -0500")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX18/wrvYcJDDNVNsj7/dg/SM3SF5amQkO3CLZhoy
	4ncA0bL22te2JAfP02dwodQ2o9i34gTb1X3JruJgtNBLAmSmkN
	r08ClswvA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145707>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi again,
>
> Goswin von Brederlow wrote:
>
>> so far two people have suggested an alias
>> for this and both have completly failed to achived the desired resul=
t.
>
> I had thought Adam already suggested using =E2=80=98git diff-index --=
cached
> --quiet HEAD=E2=80=99 [1].
>
> You can do so like this:
>
> cat <<-EOF >$HOME/bin/git-ci
> #!/bin/sh
> cleanindex() { git diff-index --cached --quiet HEAD; }

Thanks. That is the missing test.

> if test "$1" !=3D "-h"
> then
> 	echo >&2 usage: git ci &&
> 	exit 129
> fi
> if test "$#" !=3D 0
> then
> 	echo >&2 Please use git commit directly.
> 	if cleanindex
> 	then
> 		echo >&2 '(no staged changes)'
> 	else
> 		git diff --cached --name-status
> 	fi
> 	exit 129
> fi
> if cleanindex
> then
> 	exec git commit -a
> else
> 	exec git commit
> fi
> EOF
> chmod +x $HOME/bin/git-ci
>
> But dense as I am, I still can=E2=80=99t imagine why
>
> echo '[alias] ci =3D commit -a' >>$HOME/.gitconfig
>
> wouldn=E2=80=99t be better in every way (especially if Jakub=E2=80=99=
s
> commit.preserveindex is enabled).

Because with the above test it knows when -a is wrong and won't use it.

>> If you know of a test to check if an index exists or not, preferably=
 one
>> that does consider new files being added or files being removed as
>> "index exists", then please do speak up.
>
> test -e .git/index
>
> I know, not what you meant.  But the condition you are looking for is
> =E2=80=9Cstaged content does not match the last commit=E2=80=9D, not =
=E2=80=9Cthe tool has
> suddenly entered a different mode=E2=80=9D.
>
> Hope that helps,
> Jonathan
>
> [1] Well, he did:
> http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/698001/=
focus=3D145581

Must have overlooked that mail, sorry.
