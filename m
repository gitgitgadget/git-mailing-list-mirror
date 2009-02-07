From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] gitweb: Better regexp for SHA-1 committag match
Date: Sat, 7 Feb 2009 14:30:22 +0100
Message-ID: <9b18b3110902070530s70c93813se529ee7ab69b1f7e@mail.gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de>
	 <200902061126.18418.jnareb@gmail.com>
	 <9b18b3110902070122r3397888aqcaebfcf3e6d40d51@mail.gmail.com>
	 <200902071107.33428.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 14:32:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVnHy-0005MS-DE
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 14:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbZBGNaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 08:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbZBGNaY
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 08:30:24 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:41946 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbZBGNaY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2009 08:30:24 -0500
Received: by qyk4 with SMTP id 4so1753769qyk.13
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 05:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VfSpDMe90HfBnI9yFwHReWK7IOrmWPf6t41Ygf240+U=;
        b=Rh5zQog81NOF857TK0d0rMDyppwBEgqNLhT7bvgi+Kgdr8YbGlzAVuk6L8xhTX0edB
         +3ybdgeWM6e1YJwT92utemlvroaFsFn6TdNFM1draRAdphCYl9/pvAYi9fH7fjNkDl6L
         qPQpd7dIHtsc33b3hEubL+bxrL/XWqOnMxODA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P3TXJjg0fRQ1hRdePfvcKnqqOatZBEg9ucfa8ka3roN28oci/GPx5w9Tad2f/4f6HN
         PAW0hIQllpqYR+oBxWJysEduWtzkyL9JizMJHFm5sRDFTIecDMLZcG1kT7TeYazX5QHV
         +9iPhac1PNt9GnnUz0q/kPuTydgYXYjF2p+hM=
Received: by 10.214.215.14 with SMTP id n14mr4178969qag.19.1234013422646; Sat, 
	07 Feb 2009 05:30:22 -0800 (PST)
In-Reply-To: <200902071107.33428.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108848>

2009/2/7 Jakub Narebski <jnareb@gmail.com>:
> On Sat, 7 Feb 2009, demerphq wrote:
>> 2009/2/6 Jakub Narebski <jnareb@gmail.com>:
>>> Dnia pi=B1tek 6. lutego 2009 10:49, Rafael Garcia-Suarez napisa=B3:
>>>> 2009/2/6 Jakub Narebski <jnareb@gmail.com>:
>
>>>>> Make SHA-1 regexp to be turned into hyperlink (the SHA-1 committa=
g)
>>>>> to match word boundary at the beginning and the end.  This way we
>>>>> reduce number of false matches, for example we now don't match
>>>>> 0x74a5cd01 which is hex decimal (for example memory address),
>>>>> but is not SHA-1.
>>>>
>>>> Further suggestion: you could also turn the final \b into (\b|\@),
>>>
>>> You meant \b -> \b(?!\@), didn't you?  Word boundary _not_ followed
>>> by '@', and not word boundary _OR_ '@' as you wrote...
>>
>> Since \b(?!\@) is effectively two zero width negative assertions in =
a
>> row you could simplify by saying:
>>
>>   (?![^\w\@])
>
> I don't know if "sth\b" is effectively "sth(!?[^\w])"... perhaps it i=
s.

Sorry, my bad, that is double negation, I meant (?![\w\@])

On of the ways you can express \b is as:
(?:(?<=3D\w)(?!\w)|(?<=3D\W)(?!\W)|\A)

But the point here is you are looking for the end of a hex sequence,
so you can just use the "end of string" bit of the alternation which
is: (?!\w).

>>
>> and that way you can easily add the '.' case as well.
>
> We cannot add '.' case, because it there can be legitimate SHA-1 matc=
h
> ending sentence, e.g.
>
>     ... at commit 8457bb9e.

/(?<!\w)([a-fA-F0-9]+)(?!(?:\.\w|[\w@]))/

:-)

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
