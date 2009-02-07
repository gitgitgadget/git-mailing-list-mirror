From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Better regexp for SHA-1 committag match
Date: Sat, 7 Feb 2009 11:07:32 +0100
Message-ID: <200902071107.33428.jnareb@gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de> <200902061126.18418.jnareb@gmail.com> <9b18b3110902070122r3397888aqcaebfcf3e6d40d51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster@gmx.de>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 11:14:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVkCP-00046P-TM
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 11:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbZBGKGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 05:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbZBGKGk
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 05:06:40 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:60313 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbZBGKGj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 05:06:39 -0500
Received: by fxm13 with SMTP id 13so1700636fxm.13
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 02:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AwRz9FysV4KYeyR9j1Ot07erOHzrotAR9eZ3mMZwkGE=;
        b=IlvflH6PF1ilqrrbGFvsjKAVlt3W75l9n/UdCZsB1OarEJyCuogec58yVIoEn9Hc0e
         Gblcpsv2QBkv8gBEHGFOriTJodGi06s4kyCpyZ7v+9Ah7LV8TVUNmhjQX/5ZqhesQNGZ
         LV/k8jvDn0LXdtnnBlIu3iHPDjD+8I9waGZTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=E9ZmBQvRh9FcJmgYV7smqLUfpCAqw5/auQe9FC73dctYKEhW5lZ5lj0b1BhOgKnEjo
         pK7LcbFxo/j/IxIU0r2D8soor229ZJBhqF/G+vA54dGABn8EmxtPPZqAKObVnOnLjMcY
         2Cw3T+ijGVjBVRMkrKVZwCYWnDGzlqJWP9w/I=
Received: by 10.223.114.208 with SMTP id f16mr2165696faq.91.1234001197263;
        Sat, 07 Feb 2009 02:06:37 -0800 (PST)
Received: from ?192.168.1.13? (abwn77.neoplus.adsl.tpnet.pl [83.8.237.77])
        by mx.google.com with ESMTPS id e11sm2780919fga.30.2009.02.07.02.06.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 02:06:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <9b18b3110902070122r3397888aqcaebfcf3e6d40d51@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108838>

On Sat, 7 Feb 2009, demerphq wrote:
> 2009/2/6 Jakub Narebski <jnareb@gmail.com>:
>> Dnia pi=B1tek 6. lutego 2009 10:49, Rafael Garcia-Suarez napisa=B3:
>>> 2009/2/6 Jakub Narebski <jnareb@gmail.com>:

>>>> Make SHA-1 regexp to be turned into hyperlink (the SHA-1 committag=
)
>>>> to match word boundary at the beginning and the end.  This way we
>>>> reduce number of false matches, for example we now don't match
>>>> 0x74a5cd01 which is hex decimal (for example memory address),
>>>> but is not SHA-1.
>>>
>>> Further suggestion: you could also turn the final \b into (\b|\@),
>>
>> You meant \b -> \b(?!\@), didn't you?  Word boundary _not_ followed
>> by '@', and not word boundary _OR_ '@' as you wrote...
>=20
> Since \b(?!\@) is effectively two zero width negative assertions in a
> row you could simplify by saying:
>=20
>   (?![^\w\@])

I don't know if "sth\b" is effectively "sth(!?[^\w])"... perhaps it is.

>=20
> and that way you can easily add the '.' case as well.

We cannot add '.' case, because it there can be legitimate SHA-1 match
ending sentence, e.g.

     ... at commit 8457bb9e.

--=20
Jakub Narebski
Poland
