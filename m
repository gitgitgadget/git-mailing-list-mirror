From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 04 Dec 2008 23:25:18 +0100
Message-ID: <493858CE.1030601@fs.ei.tum.de>
References: <49382612.3010207@fs.ei.tum.de> <m3hc5jivjo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 23:26:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Mee-0007XK-Jw
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 23:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756265AbYLDWZX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2008 17:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756092AbYLDWZX
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 17:25:23 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:34748 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbYLDWZW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2008 17:25:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id BF1311C25E;
	Thu,  4 Dec 2008 23:25:20 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qPKd6epkspOf; Thu,  4 Dec 2008 23:25:19 +0100 (CET)
Received: from [192.168.10.11] (dyn.144-85-212-018.dsl.vtx.ch [144.85.212.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 9367B1C0F1;
	Thu,  4 Dec 2008 23:25:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (X11/20081021)
In-Reply-To: <m3hc5jivjo.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102370>

Jakub Narebski wrote:
> Shouldn't it be
>=20
> + directory=3D      pass it through git-apply
>=20
> to have it aligned like the rest of it?
>=20
> By the way, your patch looks whitespace damaged, although only contex=
t
> for the above chunk was wrapped...

Thunderbird must have pummeled it.  No clue why it does that though.=20
Black magic software.

>> @@ -155,8 +156,9 @@ do
>>   		;;
>>   	--resolvemsg)
>>   		shift; resolvemsg=3D$1 ;;
>> -	--whitespace)
>> -		git_apply_opt=3D"$git_apply_opt $1=3D$2"; shift ;;
>> +	--whitespace|--directory)
>> +		quot=3D$(echo "$2" | sed -e "s/'/'\\\''/g")
>=20
> Why not simply use "git rev-parse --sq"?

What I need is to convert $2 into a form suitable for quoting, does git=
=20
rev-parse --sq do that?

>> +		git_apply_opt=3D"$git_apply_opt $1=3D'$quot'"; shift ;;
>>   	-C|-p)
>>   		git_apply_opt=3D"$git_apply_opt $1$2"; shift ;;
>>   	--)
>> @@ -454,7 +456,7 @@ do
>>
>>   	case "$resolved" in
>>   	'')
>> -		git apply $git_apply_opt --index "$dotest/patch"
>> +		eval git apply $git_apply_opt --index '"$dotest/patch"'
 >
 > Why eval?

I quoted the above variable, so I now need to unquote it, that's done b=
y eval.

--=20
   <3 the future  +++  RENT this banner advert  +++   ASCII Ribbon   /"=
\
   rock the past  +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1 =
 +++     Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
