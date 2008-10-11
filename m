From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] correct verify_path for Windows
Date: Sun, 12 Oct 2008 00:58:52 +0200
Message-ID: <81b0412b0810111558vb69be00if4842fa91d777c3b@mail.gmail.com>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com>
	 <20081004233945.GM21650@dpotapov.dyndns.org>
	 <B985AE98-F6E2-4C23-8D34-5A22A9F89FA7@gmail.com>
	 <20081007032623.GX21650@dpotapov.dyndns.org>
	 <48EAFF23.1020607@viscovery.net>
	 <20081011163310.GZ21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Joshua Juran" <jjuran@gmail.com>,
	"Giovanni Funchal" <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 01:00:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KonRO-00042z-2i
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 01:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694AbYJKW6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 18:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754669AbYJKW6y
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 18:58:54 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:57962 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbYJKW6y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 18:58:54 -0400
Received: by yx-out-2324.google.com with SMTP id 8so309921yxm.1
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 15:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Q2Umyjgl4sSw2sQHaXrlKPIBCUXAmJVqsI9q95Ez8ps=;
        b=Vxr7mKyy26DJMtOvzAViXQog1bYpUzXG6F7WlSNuj2yJSz30HG2meRagnh1/8cQGA7
         AR74G0xly6Emh2KeveJEKdLWtkGxpoefi10wYrgPZCUgx3rdporAcYvuw1H9Cb45Dvzv
         bvPfDq0S1opYWPQgHJyZ6FQtt7x10AbZsRqdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Sa0flFBeSh+57Bvx6cVvCWo/xRf9bulLbgFgRAWnXV9wppe29kKkCdNo1uBtu427CJ
         2XIff39eIk8KZ0GhMzBFnRIpDqUYelPD7Ib6tV16BwbEn9LsBIkMyRVDf24VUPfm7yk7
         PoUOANh2X6yPu3aEDKaE/lMKcNWn8L0G6+zcQ=
Received: by 10.100.253.5 with SMTP id a5mr4135126ani.74.1223765932938;
        Sat, 11 Oct 2008 15:58:52 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Sat, 11 Oct 2008 15:58:52 -0700 (PDT)
In-Reply-To: <20081011163310.GZ21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97997>

2008/10/11 Dmitry Potapov <dpotapov@gmail.com>:
>> > +   /* On Windows, file names are case-insensitive */
>> > +   case 'G':
>> > +           if ((rest[1]|0x20) != 'i')
>> > +                   break;
>> > +           if ((rest[2]|0x20) != 't')
>> > +                   break;
>>
>> We have tolower().
>
> I am aware of that, but I am not sure what we gain by using it. It seems
> it makes only code bigger and slow.

It does? Care to look into git-compat-util.h?

> ... As to readability, I don't see much
> improvement... Isn't obvious what this code does, especially with the
> above comment?

You want to seriously argue that "a | 0x20" is as readable as "tolower(a)"?
For the years to come? With a person who does not even know what ASCII is?
Ok, I'm exaggerating. But the point is: it is not us who will be
reading the code.
And even if they do this just to remove Windows quirks it is well worth to
use a bit more of english language so that they don't need a second look.
As to comment: it is just additional info. It can't be checked by compiler
if you make and accidental typo in your code (like, for example, accidentally
putting an extra pipe in that expression, should happen to that emacs users
from time to time).

BTW, is it such a critical path? Can't the code be unified and do
without #ifdef?
