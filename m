From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Expand the rename(2) workaround in mingw to cover case 
	change in filename
Date: Tue, 9 Jun 2009 08:04:25 +0200
Message-ID: <81b0412b0906082304x750eb8cif3356458829de3bc@mail.gmail.com>
References: <20090608203248.GA22972@blimp.localdomain>
	 <alpine.DEB.1.00.0906082355350.26154@pacific.mpi-cbg.de>
	 <81b0412b0906081508v5435c59cm3faf3ac92a56578c@mail.gmail.com>
	 <4A2DF92D.1080605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 08:04:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDuRm-00087M-Um
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 08:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbZFIGE0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 02:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752914AbZFIGEZ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 02:04:25 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:34763 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZFIGEY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 02:04:24 -0400
Received: by fxm9 with SMTP id 9so2700862fxm.37
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 23:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D5pSM7B3tMhEaqsZqnZRd8OdQBos0/XYPpKZgnoqgio=;
        b=ZILp9CIjYftWuzsWmTq/5gfqim5NqL2CPh9Vypz6q86LjiuRz8fO2c+3VoAuUpIziS
         2RCa0Imem+SUC68yVscgpDzo73l3Flf/Qlynwxub9DMOVxe2FsRpJR88SUWhBsG2CDko
         StTvDMqwhtJK5h2me4qIOR/73FofmGDmIZauU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QXZXh9qOn5ZNdji6u65mokJb2x6ibv7W0AJkAFFGUMxqGneaVPWbkFQM4pZzO/d69K
         vkphV/tpqlUV6QiCJ9aKclETQzcH/yjU7kWmWv30aqr1CZL1hVQizvcCWkO6s92b43Sl
         0DpyeMyxbazyBtw8nruy/aFtPOflkYMXkCTrI=
Received: by 10.204.120.201 with SMTP id e9mr7371915bkr.187.1244527465746; 
	Mon, 08 Jun 2009 23:04:25 -0700 (PDT)
In-Reply-To: <4A2DF92D.1080605@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121140>

2009/6/9 Johannes Sixt <j.sixt@viscovery.net>:
> Alex Riesen schrieb:
>> 2009/6/8 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>> On Mon, 8 Jun 2009, Alex Riesen wrote:
>>>> NOT TESTED. Can't. My Windows broke again. Not even compile-tested=
=2E
>>> Yes, that is pretty easy to see as you first used pold/pnew and the=
n
>>> src/dst.
>>
>> Yep.
>>
>>> I minimally fixed up your patch (it now uses strbuf), and added a
>>> test-case.
>>>
>>> This test-case is actually crucial: it shows that your patch is not
>>> enough: the culprit is this code in builtin-mv.c:167--168:
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (lst=
at(dst, &st) =3D=3D 0) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0bad =3D "destination exists";
>>
>> Ah, thanks. Missed that completely.
>
> That's the reason why I think any work-around for this problem is not
> worth it.

What is the lstat is for, anyway?

> If you want to be cross-platfrom, make up your mind about file names =
in
> advance.

I suspect it is the other way around. Some platforms just hate the idea
of being ported to. Or its designers have poor imagination and never
though about the fact that other platforms exist.
