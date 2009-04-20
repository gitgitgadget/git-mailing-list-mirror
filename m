From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Windows: Skip fstat/lstat optimization in 
	write_entry()
Date: Tue, 21 Apr 2009 00:17:35 +0200
Message-ID: <81b0412b0904201517v2d842528x59ef7bed85efc014@mail.gmail.com>
References: <49EC2F7C.8070209@viscovery.net>
	 <20090420110302.GB25059@dpotapov.dyndns.org>
	 <81b0412b0904200558w2d506f18i675d5dfb990005ce@mail.gmail.com>
	 <20090420133305.GE25059@dpotapov.dyndns.org>
	 <7vbpqrdnyn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 00:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw1pY-0001wC-In
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 00:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625AbZDTWRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 18:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756497AbZDTWRi
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 18:17:38 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:33097 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552AbZDTWRh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 18:17:37 -0400
Received: by gxk10 with SMTP id 10so1062799gxk.13
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 15:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=H06nAHWx6o+uw8gC3gxB9Y81/IwxVpK5mygUMfP+Z4Y=;
        b=jynZT9UiS7F9z3AQCjT/oPVgXhX9irNVeYxC5dyQVxuRW4FqGkt1jln5isd3g4+n3r
         KHGXOgYtVxbVlSJzTVcX4TNcFKw3jXusIbpfezN8EcR7EpRMiEUIgziKOrGUYkfC27GE
         wPCUXfqs4ldU0xxmtYEGKV2wBP+q8ZsFxDIpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=is3eD9M+fZiq6H1sbVwfJHdCDnYnNFGcIx2m2SBg05UkKUNHsB84v9nYZGB8O0hbgB
         LlgALAnzu42A1OocpwcpHCYqT6fA4tFGMTQJmUBAKL+ziqduU7Kf5kGVPeDZMHA0Uf8U
         Mh5Ovl1kfi0nLIEEftuXr7VDEqFETc8q33xNo=
Received: by 10.150.144.9 with SMTP id r9mr7156472ybd.19.1240265855786; Mon, 
	20 Apr 2009 15:17:35 -0700 (PDT)
In-Reply-To: <7vbpqrdnyn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117041>

2009/4/20 Junio C Hamano <gitster@pobox.com>:
> Dmitry Potapov <dpotapov@gmail.com> writes:
>>
>> If the time passed between the creating file and end of writing to i=
t is
>> small (less than timestamp resolution), you may not notice the probl=
em.
>> The following program demonstrates the problem with fstat on Windows=
=2E
>> (I compiled it using Cygwin). If you remove 'sleep' then you may not
>> notice the problem for a long time.
>
> I take that you mean that Alex's patch does not work as intended. =C2=
=A0...

Yes, it just makes the problem harder to notice by providing a faster f=
stat.
