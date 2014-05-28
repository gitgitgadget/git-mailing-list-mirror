From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 0/5] replace signal() with sigaction()
Date: Wed, 28 May 2014 10:23:19 +0200
Message-ID: <CABPQNSZqazRLj3iOT1zei6ym6rcv5rzGrhK=O1vCPCh6p-Ad2A@mail.gmail.com>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
 <53859307.8080506@viscovery.net> <53859A44.7040806@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 10:24:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpZ9b-0003ZR-68
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 10:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbaE1IYB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 04:24:01 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:64956 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbaE1IX7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 04:23:59 -0400
Received: by mail-ie0-f169.google.com with SMTP id at1so10054400iec.0
        for <git@vger.kernel.org>; Wed, 28 May 2014 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=KiMzBB12fsOWykLjdkLBuCywX30dYHDVG7EFoWjv/FI=;
        b=QSz0mmsaYRRRgbvwO58RHnfV+cRTtcu7208MJ/HjSMf+mXcr8RlTxpQPyUNAci3DHD
         dWHuBjbo3Xbd+IygkRZxNPzAOXsVRoue05APo7tn1FsCCJ+6LxQnwa9G5S3Mk3V60HH+
         VWYAQxxv6DEWMkg5rjgzt9gMQSgjmtgmT4/mlxcTBMrPImDBumWcQjLIjKYoHuQYMGRO
         dsy5mySR7FyWcZl0K/GGDyrgZSuF4M7dGZ4AuuvxVvBEbo6KMIXEJ+jl5y9a11pVGmOM
         1E/oSjtyXiSrxmv8qNS/YqhA+MwlcJQ516JpKS8qv82tqk9QFtP0nmLPpajWArSJMcBp
         /ugg==
X-Received: by 10.50.225.103 with SMTP id rj7mr40114929igc.42.1401265439181;
 Wed, 28 May 2014 01:23:59 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 28 May 2014 01:23:19 -0700 (PDT)
In-Reply-To: <53859A44.7040806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250273>

On Wed, May 28, 2014 at 10:11 AM, Chris Packham <judge.packham@gmail.co=
m> wrote:
> On 28/05/14 19:40, Johannes Sixt wrote:
>> Am 5/28/2014 8:14, schrieb Jeremiah Mahler:
>>> From signal(2)
>>>
>>>   The behavior of signal() varies across UNIX versions, and has als=
o var=E2=80=90
>>>   ied historically across different versions of Linux.   Avoid  its=
  use:
>>>   use sigaction(2) instead.  See Portability below.
>>>
>>> This patch set replaces calls to signal() with sigaction() in all f=
iles
>>> except sigchain.c.  sigchain.c is a bit more complicated than the o=
thers
>>> and will be done in a separate patch.
>>
>> In compat/mingw.c we have:
>>
>> int sigaction(int sig, struct sigaction *in, struct sigaction *out)
>> {
>>       if (sig !=3D SIGALRM)
>>               return errno =3D EINVAL,
>>                       error("sigaction only implemented for SIGALRM"=
);
>>       if (out !=3D NULL)
>>               return errno =3D EINVAL,
>>                       error("sigaction: param 3 !=3D NULL not implem=
ented");
>>
>>       timer_fn =3D in->sa_handler;
>>       return 0;
>> }
>>
>> Notice "only implemented for SIGALRM". Are adding the missing signal=
s
>> somewhere (here or in a later patch)?
>>
>
> * note: not a windows/mingw programmer *
>
> Will the ones setting SIG_IGN be OK? Presumably we won't get these
> signals on windows anyway so we're already getting what we want.

We'll still emit an useless error unless someone cooks up a fix.
