From: Dominique Quatravaux <domq@google.com>
Subject: Re: [PATCHv2 1/2] rebase -i: optimize the creation of the todo file
Date: Fri, 9 Mar 2012 10:18:57 +0100
Message-ID: <CAJh6GrHMb-H6ktEGGHxMxbZXujKFe=unYzAyS-zoGnfzMfcKQA@mail.gmail.com>
References: <1331214777-9455-1-git-send-email-domq@google.com> <CAFfmPPMt_o1Rg-Pvuh_KpARrASwfYSq74UN3ayp=LVzLJ0oj=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:19:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5vyx-00025J-AE
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 10:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab2CIJTV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 04:19:21 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:58257 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab2CIJTT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 04:19:19 -0500
Received: by wgbds11 with SMTP id ds11so492338wgb.1
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 01:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=flcF3Ad9Wquac5i+SoW2CWtRasBfEMOBYCa8p9vJp5s=;
        b=BNLpXgUOj91QIpTvKcrEzOrfbhd4srCVeXe1gv41hkHtRDYjmE15EXbgw5afFUZT+q
         ocyjU8o5sv0yXncVzFMDXbUssVpc4RDcDa385IeBV9XwTYzk9ISTpkrT1euXoT6vaphr
         UCXH80NBNqgDpTWEMGoHE2eOWobfm4OZKWKbl0bcPtYpLoShVfUzLnWzev2slxLxYM51
         AzgjmykP5DyyajUPfV4oklJAIcv53RmsNOChLQyqMPmZUSq3RI3lcEu8XnsK4+ok6ZJS
         Ot9jQbX4mqHtbOIBzVz8wniL3DoQJB6c0XkmLPD40XjFiCxsuCna9Xttjz6PTMvxdXxC
         ZsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=flcF3Ad9Wquac5i+SoW2CWtRasBfEMOBYCa8p9vJp5s=;
        b=BsNTTbIu4gwxZEv4J3Ye5r4e1nr1vkjfAWM6ULYCkxFyGTGsOlu1vd6mi5z/vQqtJK
         tHrCUPFiJODtncEVhuI7BNy/SG9DOFTWFGcgALZ4qzm/V6Ed/5RNTGrXD0esBwwppOhI
         iu3LOby7NaUZ0zWvSxflVi45FjnjgR+DO4a0mDYOQoSJHILLY2OIh2kCJjR/BDcF5Nq7
         hHri3yAspzVYMU31F7EK/Be3OVWOnipLS1mzHXjvkMz/EetFULyi2dGGID0oUDT28ewH
         kO65eFjRBSo5tv4NRnoU/Osuufzm/kOaGiAwWQAVMY2SXGBxD9JnJXoax5skDA1QslqA
         AG/Q==
Received: by 10.216.138.17 with SMTP id z17mr998541wei.18.1331284757673;
        Fri, 09 Mar 2012 01:19:17 -0800 (PST)
Received: by 10.216.138.17 with SMTP id z17mr998534wei.18.1331284757523; Fri,
 09 Mar 2012 01:19:17 -0800 (PST)
Received: by 10.227.7.138 with HTTP; Fri, 9 Mar 2012 01:18:57 -0800 (PST)
In-Reply-To: <CAFfmPPMt_o1Rg-Pvuh_KpARrASwfYSq74UN3ayp=LVzLJ0oj=A@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQk7aAo947etXdcHLj4LMa/9R04kWLrvS5AJ2dfBpILAbuxCfHzp4pIHcFkCDa/Xru539LuzJJyc4AHnu2n0kkg4xz+KMs5LwERqbCGe3OtbrvsgcG9Wa1m3rjghlo6S1EjPCGnOwHWofZZWHv9wk6D4ns3gAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192697>

On Fri, Mar 9, 2012 at 6:00 AM, David Barr <davidbarr@google.com> wrote=
:
> I do notice however that the output being fed to sed expands like so:
>
> =A0commit >634a5f265ad729b91266de65272e2b5a35d05b1c
> =A0>634a5f265ad729b91266de65272e2b5a35d05b1c 634a5f2 INSTALL: warn [.=
=2E.]
> =A0commit >828ea97de486c1693d6e4f2c7347acb50235a85d
> =A0>828ea97de486c1693d6e4f2c7347acb50235a85d 828ea97 Git 1.7.9
>
> Maybe the format spec and sed command could use a little tuning.

Hmm, from rev-list.c it appears that "oneline" is the only format that =
has git
rev-list output one line per commit:

102 	if (revs->commit_format =3D=3D CMIT_FMT_ONELINE)
103 		putchar(' ');
104 	else
105 		putchar('\n');

[...]

362 		if (revs.commit_format =3D=3D CMIT_FMT_ONELINE)
363 			info.header_prefix =3D "";
364 		else
365 			info.header_prefix =3D "commit ";

I could fix that by using "git log" instead (hence the erroneous log me=
ssage for
this patch, that I'll fix in the next attempt), but I don't know about =
the
implications of that (semantic or performance-wise). On the other hand,=
 I can't
imagine how sed skipping every other "commit 12345abcdef" line could be=
 a
noticeable performance drain. Advice welcome.

--=20
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
