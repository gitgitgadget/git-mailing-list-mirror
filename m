From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH 1/1] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 19:48:35 +1100
Message-ID: <d2e97e800911040048h42ef7193v117773cc528b2361@mail.gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com> 
	<1257283802-29726-2-git-send-email-ahaczewski@gmail.com> <4AF13819.7050306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Andrzej K. Haczewski" <ahaczewski@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 09:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5bY5-00074b-9Y
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 09:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbZKDIsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 03:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbZKDIsu
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 03:48:50 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:55625 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbZKDIst convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 03:48:49 -0500
Received: by pzk26 with SMTP id 26so4556655pzk.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 00:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=L43Dq1RIcql6qMsKBTv2wzlgfQkNZ9xJGVUoYQ5Jfn4=;
        b=Bo8I4U8/A0FAvhKYC9cTAHwJTCAiVqFxrmMj04u1rKdvYr7NfQy5PKTAHH19/n6brL
         coLjapCUDwsQWWp0DQ+D0rcCBCag0ZS5uS9yAfsrenjj+2c9wJF8d3YNiY7cV2OkV1dR
         5vfKyS3PpL8lkf2JQANsBov0nejpLbNcOMBIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=EBFiqCwIeT85Zhmd1g53SkhPqtyFv4i/cIjVkavmiXptiz5lrWFqwd/aOi3Y4mRpT4
         sXFDpWpbr1bdQY/VfVv3iyyYsiA2IU8YCzmdGaTc7Iq7C3nsHVer/Ad/D1SPJFJwbyq2
         VVIIvjD9aLdBpighPdqNH36OtowfYKDwxaAJM=
Received: by 10.115.26.13 with SMTP id d13mr1591888waj.210.1257324535150; Wed, 
	04 Nov 2009 00:48:55 -0800 (PST)
In-Reply-To: <4AF13819.7050306@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132063>

2009/11/4 Johannes Sixt <j.sixt@viscovery.net>:
> Andrzej K. Haczewski schrieb:
>
>> +static __inline int win32_cond_init(win32_cond_t *cond)
>> +{
>> + =C2=A0 =C2=A0 cond->waiters =3D 0;
>> +
>> + =C2=A0 =C2=A0 InitializeCriticalSection(&cond->waiters_lock);
>> +
>> + =C2=A0 =C2=A0 cond->sema =3D CreateSemaphore(NULL, 0, LONG_MAX, NU=
LL);
>
> Wouldn't an Event object be lighter-weight? (I'm only guessing.)

Both events and semaphores resolve to wait-able kernel objects; so
neither is "lighter-weight" than the other.
