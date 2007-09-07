From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 15:58:34 +0200
Message-ID: <46E1590A.4060504@op5.se>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <46E0EEC6.4020004@op5.se> <Pine.LNX.4.64.0709071155570.28586@racer.site> <46E13C0F.8040203@op5.se> <E4A6490A-ABA9-4383-978E-C7F2E4BC9C23@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 15:58:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITeMA-00024y-GV
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 15:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbXIGN6j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Sep 2007 09:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbXIGN6i
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 09:58:38 -0400
Received: from mail.op5.se ([193.201.96.20]:49502 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965284AbXIGN6i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 09:58:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EEA2519439E;
	Fri,  7 Sep 2007 15:58:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qx4RsbEJEO2w; Fri,  7 Sep 2007 15:58:35 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 1D01219435A;
	Fri,  7 Sep 2007 15:58:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <E4A6490A-ABA9-4383-978E-C7F2E4BC9C23@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58038>

Wincent Colaiuta wrote:
> El 7/9/2007, a las 13:54, Andreas Ericsson escribi=F3:
>=20
>> Johannes Schindelin wrote:
>>> Hi,
>>> On Fri, 7 Sep 2007, Andreas Ericsson wrote:
>>>> Wincent Colaiuta wrote:
>>>>> El 7/9/2007, a las 2:21, Dmitry Kakurin escribi?:
>>>>>
>>>>>> I just wanted to get a sense of how many people share this "Git=20
>>>>>> should
>>>>>> be in pure C" doctrine.
>>>>> Count me as one of them. Git is all about speed, and C is the bes=
t=20
>>>>> choice
>>>>> for speed, especially in context of Git's workload.
>>>>>
>>>> Nono, hand-optimized assembly is the best choice for speed. C is j=
ust
>>>> a little more portable ;-)
>>> I have a buck here that says that you cannot hand-optimise assembly=
=20
>>> (on modern processors at least) as good as even gcc.
>>
>>
>> http://www.gelato.unsw.edu.au/archives/git/0504/1746.html
>>
>> I win. Donate $1 to FSF next time you get the opportunity ;-)
>=20
> Well, you picked a very specific algorithm amenable to that kind of=20
> optimization: small, manageable, with a minimal and well-defined=20
> performance critical section that could be written in assembly. Note =
how=20
> a good chunk of the implementation was still in C. At most I'd give y=
ou=20
> 75 cents for that one. ;-)
>=20

Yes, but that's what I said in the original email as well. C is just so
much more pleasant to write in that the only place you'd (sanely) use
asm is in exactly these tight loops, where the code is likely to be use=
d
and reused until the algorithm it describes is no longer a viable optio=
n
for doing what it was originally designed to do.

It still proves the point though, as surely as n+1 > n for any value of=
 n:
Hand-optimized assembly is faster than compiler-optimized C code.

It might be harder to do properly on some architectures than others (RI=
SC
comes to mind), but it's still possible.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
