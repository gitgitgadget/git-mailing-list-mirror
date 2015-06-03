From: edgar.hipp@netapsys.fr
Subject: Re: Proposal for git stash : add --staged option
Date: Wed, 03 Jun 2015 15:32:30 +0200
Message-ID: <3abd6c1640b01ee2c53ef423723480b1@netapsys.fr>
References: <96c00a316c79d9e5a85e199ba7d6f317@netapsys.fr>
 <0082a449b4d1723cb557ac353a04c3af@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 03 15:42:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z08w5-0006z3-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 15:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbbFCNmF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 09:42:05 -0400
Received: from smtp.netapsys.fr ([5.135.55.152]:34495 "EHLO mx01.netapsys.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773AbbFCNmD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 09:42:03 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2015 09:42:03 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx01.netapsys.fr (Postfix) with ESMTP id DB87F3F4E6;
	Wed,  3 Jun 2015 15:32:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx01.netapsys.fr
Received: from mx01.netapsys.fr ([127.0.0.1])
	by localhost (mx01.netapsys.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kxHV_o7s-8Am; Wed,  3 Jun 2015 15:32:30 +0200 (CEST)
Received: from webmail.ovh.netapsys.fr (unknown [5.135.55.138])
	by mx01.netapsys.fr (Postfix) with ESMTPA id 9A5783EC1F;
	Wed,  3 Jun 2015 15:32:30 +0200 (CEST)
In-Reply-To: <0082a449b4d1723cb557ac353a04c3af@www.dscho.org>
X-Sender: edgar.hipp@netapsys.fr
User-Agent: Roundcube Webmail/1.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270682>

Hi again,

just wanted to tell that I have created a solution by doing a few lines=
=20
of scripting:

git-cstash
```
#/bin/sh

git commit -m 'temporary, will be stashed soon'
git stash --include-untracked
git reset HEAD^1
git stash
git stash pop stash@{1}
```

Le 2015-04-22 11:25, Johannes Schindelin a =C3=A9crit=C2=A0:
> Hi Edgar,
>=20
> On 2015-04-22 10:30, edgar.hipp@netapsys.fr wrote:
>=20
>> When you have a lot of unstaged files, and would like to test what
>> happens if you undo some of the changes that you think are unecessar=
y,
>> you would rather keep a copy of those changes somewhere.
>>=20
>> For example
>>=20
>> Changed but not updated:
>>     M config_test.xml
>>     M config_real.xml
>>=20
>> I have changed both config_test.xml and config_real.xml, but I think
>> the changes made in config_test.xml are unnecessary. However, I woul=
d
>> still like to keep them somewhere in case it breaks something.
>>=20
>> In this case for example, I would like to be able to stash only the
>> file config_test.xml
>>=20
>> Eg:
>>=20
>> git add config_test.xml
>> git stash --staged
>>=20
>> So that after this, my git looks like this:
>>=20
>> Changed but not updated:
>>     M config_real.xml
>>=20
>> and my stash contains only the changes introduced in config_test.xml
>>=20
>> `git stash --keep-index` doesn't give the necessary control, because
>> it will still stash everything (and create unnecessary merge
>> complications if I change the files and apply the stash)
>=20
> I often have the same problem. How about doing this:
>=20
> ```sh
> git add config_real.xml
> git stash -k
> git reset
> ```
>=20
> The difference between our approaches is that I keep thinking of the
> staging area as the place to put changes I want to *keep*, not that I
> want to forget for a moment.
>=20
> Having said that, I am sympathetic to your cause, although I would
> rather have `git stash [--patch] -- [<file>...]` that would be used
> like `git add -p` except that the selected changes are *not* staged,
> but stashed instead.
>=20
> Ciao,
> Johannes
