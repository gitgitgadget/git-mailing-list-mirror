From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add a fast version of fstat to cygwin port
Date: Thu, 19 Mar 2009 16:14:31 +0100
Message-ID: <81b0412b0903190814i254ee2d1yc39035e78d7ad3d8@mail.gmail.com>
References: <81b0412b0903190730s40589291iea9a861ddeedcc0@mail.gmail.com>
	 <49C25CAE.6000003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 16:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkJyW-0000wO-2y
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 16:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbZCSPOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 11:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbZCSPOf
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 11:14:35 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:61488 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbZCSPOe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 11:14:34 -0400
Received: by an-out-0708.google.com with SMTP id d14so430123and.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dHzQ5nOQJdZ78mPkl7ev3An39RPDTfOODcRT8XwGvxU=;
        b=KSVR85uIoCB/e6+Jg+9ZVvwT0hYcyFBMp553Rgq27cU2oL7plit1ejtbJQScmBdfcn
         nvKtfHqfjjWZC94YRzSPa4edK7LgHrywD0ofX4Ues/dXJhdyK9/c4RVeReytFhwHsJIQ
         8dSKKnjXR/zRFlLxme77y0Li6lCpbAg5XvArg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Uwl0xXfgv2Lkigm+xi24wexoS7JKKpgHWeQj+RkXjdeHjOCr9kc+Q8yVfGG3PGPLGk
         woNEQo6Ottk1wm4G4FRpWatTRoqVkEQVFieBeHriVnB9e61xSIJeP2GKoT47ilAX3+UJ
         W2Sbox21UI+HUFES/gV/6La4ZtPaP5ITdSLis=
Received: by 10.100.142.15 with SMTP id p15mr407823and.20.1237475671630; Thu, 
	19 Mar 2009 08:14:31 -0700 (PDT)
In-Reply-To: <49C25CAE.6000003@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113779>

2009/3/19 Johannes Sixt <j.sixt@viscovery.net>:
> Alex Riesen schrieb:
>> BTW, why do we have to #undef fstat, but not stat/lstat?
>
> Because stat and lstat are #defined with an argument list, but in tho=
se
> instances where the cygwin version of stat/lstat is meant, they are u=
sed
> *without* argument list (see cygwin_stat/lstat_stub), and no macro
> expansion happens, and therefore we don't need to #undef the macro.
>
> OTOH, do_fstat calls into cygwin's fstat() if the file handle is not =
a
> file and uses an argument list that would cause a macro expansion if =
it
> were not #undef'd:
>
=2E..
>> + =C2=A0 =C2=A0 /* direct non-file handles to cygwin's fstat() */
>> + =C2=A0 =C2=A0 if (GetFileType(fh) !=3D FILE_TYPE_DISK)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fstat(fd, buf);
>
> We never do that for stat/lstat.

I see. Not immediately obvious :)
Thanks!
