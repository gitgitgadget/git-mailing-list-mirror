From: Plamen Totev <plamen.totev@abv.bg>
Subject: Re: Git grep does not support multi-byte characters (like UTF-8)
Date: Tue, 7 Jul 2015 21:08:21 +0300 (EEST)
Message-ID: <663318203.435786.1436292501411.JavaMail.apache@nm32.abv.bg>
References: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
	<CACsJy8BH_QJss57uMJNE=ojNT5vBWKN=eEdrBBS38g6As-UH6A@mail.gmail.com>
	<775251698.1328032.1436259534851.JavaMail.apache@nm31.abv.bg> <xmqqr3ok3qad.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 20:08:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCXHj-0003ln-BU
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 20:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbbGGSHz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2015 14:07:55 -0400
Received: from smtp-out.abv.bg ([194.153.145.99]:41121 "EHLO smtp-out.abv.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932407AbbGGSHy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 14:07:54 -0400
Received: from nm32.abv.bg (nm32.ni.bg [192.168.151.8])
	by smtp-out.abv.bg (Postfix) with ESMTP id 256BE14EC15;
	Tue,  7 Jul 2015 21:07:40 +0300 (EEST)
DomainKey-Signature: a=rsa-sha1; s=smtp-out; d=abv.bg; c=simple; q=dns;
	b=yVeH1UHs4+/9TbqKhpOfwNpU4/61kgGOcSClIIawgbI1zME22ygTkhLdRUyytY/dn
	GXvDT6ULy8fd8wnitqlScL+jqb87fk9VqoHsIRJSQQYeOA8uRaI5iogf/2fFjvTrgHU
	FqbhhAKD1w1h2dv9f77NT5kYVF7A1bHT/DMNxhM=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=abv.bg; s=smtp-out;
	t=1436292460; bh=1wdlnEg8O/Y2DKpLY8TDHfhtSuVYDyfd/MKg5fBJ62o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:DKIM; b=m1BVY4
	z7ndJjsLnQVlqOPoCKzCT6a/cBCn2QCWeGxMKjZLEUYHhlhwxcz/dMqyep+a1iUL8Cr
	VBcsMslKKDUeX+mhDE0zt6auO5rSN3xNu+xaz/BGYbju1HiPXJM9XlSOyZwi8vPE5/X
	2vOoWiUlg8mT+65SZfFI1ax/qxiE7pw=
Received: from nm32.abv.bg (localhost.localdomain [127.0.0.1])
	by nm32.abv.bg (Postfix) with ESMTP id 64F2B22A02C;
	Tue,  7 Jul 2015 21:08:21 +0300 (EEST)
In-Reply-To: <xmqqr3ok3qad.fsf@gitster.dls.corp.google.com>
X-Mailer: AbvMail 3.0
X-Originating-IP: 95.111.52.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273590>

Junio C Hamano <gitster@pobox.com> writes:

> Plamen Totev <plamen.totev@abv.bg> writes:=C2=A0
>=C2=A0
> > pickaxe search also uses kwsearch so the case insensitive search wi=
th=C2=A0
> > it does not work (e.g. git log -i -S). Maybe this is a less of a=C2=
=A0
> > problem here as one is expected to search for exact string (hence=C2=
=A0
> > knows the case)=C2=A0
>=C2=A0
> You reasoned correctly, I think. Pickaxe, as one of the building=C2=A0
> blocks to implement Linus's ultimate change tracking tool [*1*],=C2=A0
> should never pay attention to "-i". It is a step to finding the=C2=A0
> commit that touches the exact code block given (i.e. "how do you=C2=A0
> drill down?" part of $gmane/217 message).=C2=A0
>=C2=A0
> Thanks.=C2=A0
>=C2=A0
> [Footnote]=C2=A0
> *1* http://article.gmane.org/gmane.comp.version-control.git/217

Now that I read the link again and gave the matter a thought I'm not so=
 sure.
In some contexts the case of the words does not matter. In SQL for exam=
ple.
Let's consider a SQL script file that contains the following line:

select name, address from customers;

At some point we decide to change the coding style to:

SELECT name, address FROM customers;

What should pickaxe search return - the first commit where the line is =
introduced
or the commit with the refactoring? From this point of view I think the=
 -i switch makes sense.
The SQL is not the only case insensitive language - BASIC and Pascal co=
me into my mind=C2=A0
(those two I was using while I was in the high school :)).

Also I think it makes sense (maybe even more?) for natural languages.
=46or example after editing a text a sentence could be split into two.
Then the first word of the second sentence may change its case.
Of course the natural languages always =C2=A0complicate the things a bi=
t.
An ultimate tracking tools should be able to handle typo fixes, punctua=
tion changes, etc.

But I'm getting a bit off-topic. What I wanted to say is that in some c=
ontexts it makes sense
(at least to me) to have case insensitive pickaxe search.
Or I'm missing something and there is a better tools to use is such cas=
es?

Regards,
Plamen Totev
