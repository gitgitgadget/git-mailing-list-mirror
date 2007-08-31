From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: Buffer overflows
Date: Fri, 31 Aug 2007 14:48:57 +0200
Message-ID: <46D80E39.8060106@fs.ei.tum.de>
References: <1188502009.29782.874.camel@hurina> <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org> <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi> <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com> <6F219888-6F48-4D56-8FA9-BE63EB6E1D95@iki.fi> <3f4fd2640708301534k40f07a1cva90a59d12ace6138@mail.gmail.com> <BD9F3FD0-94EF-4182-A03B-B26B18544894@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Reece Dunn <msclrhd@googlemail.com>, Timo Sirainen <tss@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 14:49:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR5w2-0000Dw-P9
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 14:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbXHaMtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 08:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbXHaMtM
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 08:49:12 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:43043 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964898AbXHaMs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 08:48:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id F22192876D;
	Fri, 31 Aug 2007 14:48:57 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AxyDdxwNK7Wb; Fri, 31 Aug 2007 14:48:57 +0200 (CEST)
Received: from [128.178.149.21] (nslpc6.epfl.ch [128.178.149.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 9B69A2876A;
	Fri, 31 Aug 2007 14:48:57 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <BD9F3FD0-94EF-4182-A03B-B26B18544894@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57165>

Wincent Colaiuta wrote:
>> As an example, do your safe API do null pointer checks. This is
>> because strcpy, strlen and the like don't, which is one of the reasons
>> why they are considered unsafe. But then, if you guarantee that you
>> are not passing a null pointer to one of these API, why take the hit
>> of the additional checks when you know that these are safe.
> Do you really think that comparing a pointer to NULL is going to be a 
> speed hit? I would imagine that on most architectures it boils down to 
> one or two machine code instructions.

The question rather is, why should you bother comparing to a NULL pointer?  To return an error (EINVAL?)?  I'd rather have either a) the caller check or b) the process segfault.  A segfault gives me a nice core file which I can use to hunt the bug.

I also don't see why not checking for NULL pointers is unsafe.  Okay, maybe there are platforms out there which do not crash on a NULL pointer derefence, but I doubt these are consumers of git.  All other platforms are safe by the implicit check of the MMU.

The worst thing is something like

if (ptr == NULL)
	abort();

which only adds code (and thus needs maintenance), but no value whatsoever.  Either the following code tolerates NULL pointers or it will crash and segfault, so why bother panicing before.

Of course I might be totally of track...

cheers
  simon
