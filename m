From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Windows: Skip fstat/lstat optimization in 
	write_entry()
Date: Mon, 20 Apr 2009 15:54:17 +0200
Message-ID: <81b0412b0904200654w1606a31fu227fa535cc14e10d@mail.gmail.com>
References: <49EC2F7C.8070209@viscovery.net>
	 <20090420110302.GB25059@dpotapov.dyndns.org>
	 <81b0412b0904200558w2d506f18i675d5dfb990005ce@mail.gmail.com>
	 <20090420133305.GE25059@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 15:56:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvtyR-0001Wz-Da
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 15:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415AbZDTNyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 09:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755436AbZDTNyT
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 09:54:19 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:35478 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415AbZDTNyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 09:54:18 -0400
Received: by gxk10 with SMTP id 10so529078gxk.13
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cZrtpP3BbANyQbLJaIyVESUcwP1Jb9X3EHClsIPKy9Y=;
        b=FJiZNAKr+6YzL7SVknfZ0Y89+XbUIgx/CS4CJ7OOraIUBhmHLBZiCauZWRAGV+Mx7o
         kz8z9mCZu3TOzcqmrviw3DNPy/mJQuqLL9SSSCYxSWgSmAt2/ej5OXq0vOzaWDxBQRwx
         n01CSvyzYDG507qkt2cT210yIlexy1HilPheU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cMXnFxA3GODEbq9c/AJ4rrxQdzjHPkoKwIfXbquXLP78VoiTEA74PDhpoL9ZpgByZr
         6Se1qQOvS7Y/WKtq3wTqTSM2F1Yrwk0GIyHqBaTC7qBE84sY5e58q+f1OW7BLWUfLy9I
         3tlu7OC3s+pzYRBpFyB6exDypnRvzp9WnRAMc=
Received: by 10.150.133.18 with SMTP id g18mr6420192ybd.57.1240235657313; Mon, 
	20 Apr 2009 06:54:17 -0700 (PDT)
In-Reply-To: <20090420133305.GE25059@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116986>

2009/4/20 Dmitry Potapov <dpotapov@gmail.com>:
> On Mon, Apr 20, 2009 at 02:58:49PM +0200, Alex Riesen wrote:
>> 2009/4/20 Dmitry Potapov <dpotapov@gmail.com>:
>> > The cygwin version has the same problem. (In fact, it is even worse,
>> > because we have an optimized version for lstat/stat but not for fstat,
>> > and they return different values for some fields like i_no). But even
>> > if we used the only Cygwin functions, we would still face the problem,
>> > because Windows returns the wrong values for timestamps (and maybe
>> > even size on FAT?). So I think the following patch should be squashed
>> > on top.
>>
>> I just sent a patch with an "optimized" fstat. I see no problems (at least none
>> like these) with that patch. Timestamps match. Windows XP, yes. But since
>> that MSDN article mentions that it is not guaranteed, I guess I just been lucky.
>
> If the time passed between the creating file and end of writing to it is
> small (less than timestamp resolution), you may not notice the problem.
> The following program demonstrates the problem with fstat on Windows.
> (I compiled it using Cygwin). If you remove 'sleep' then you may not
> notice the problem for a long time.

And the Windows being as slow as it is, the problem can stay undetected for
a long time in a real working code.
