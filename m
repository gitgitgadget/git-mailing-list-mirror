From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git's Perl scripts can fail if user is configured for perlbrew
Date: Tue, 30 Dec 2014 00:16:34 +0100
Message-ID: <CACBZZX4PDC45jE6y1i-SFY5Qy+CPsBe-OMjfehZRYdqD9pWPaA@mail.gmail.com>
References: <54A085D1.8060407@blackperl.com> <54A159D7.5010307@web.de> <54A1CE4A.7020408@blackperl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Randy J. Ray" <rjray@blackperl.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 00:17:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5jYc-0007mX-7B
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 00:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbaL2XQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2014 18:16:55 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:42811 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaL2XQz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2014 18:16:55 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so43025235obc.2
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 15:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Gy0A2n+ujoOTDMQBHhAuiLL6lJ10XqTVsM6YAbuX+K4=;
        b=bppuzhEuluJ9Qcj4cdEHfgdQFsdlDkzrl+3XZbetXFJoclhIYMUo9yEC3F2iCrI4l0
         DR+8m+gxOwWYjBXKQRDAhSOLVarsOUTYonk/WO2v6BZlnDwklxQGfUOq5kUI5w2/LsAW
         2bGM4CfaMpZy9S9uI6/ugmjPROcKuX9QnP194cg+y40O5zse2WTp1pQ/hEuecBwD20+f
         TWRCSfADRZ3tGMQjpCNMaVqGl1OLIzdTlOFJBmFYI7mPkxTR9CnJAWYddprhAhh5Ebl7
         ydDEJFib6VbDgHq/FsxAWzI3lTVDg++aVvqyWMFptMT2mZzdbeYzbMwRKueQvToCUYVx
         WPmw==
X-Received: by 10.182.58.81 with SMTP id o17mr34551185obq.82.1419895014453;
 Mon, 29 Dec 2014 15:16:54 -0800 (PST)
Received: by 10.76.141.44 with HTTP; Mon, 29 Dec 2014 15:16:34 -0800 (PST)
In-Reply-To: <54A1CE4A.7020408@blackperl.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261896>

On Mon, Dec 29, 2014 at 10:57 PM, Randy J. Ray <rjray@blackperl.com> wr=
ote:
> On 12/29/14, 7:40 AM, Torsten B=C3=B6gershausen wrote:
>>
>> Having problems with different perl installations is not an unknown
>> problem
>> in Git, I would say.
>>
>> And Git itself is prepared to handle this situation:
>>
>> In Makefile I can read:
>> # Define PERL_PATH to the path of your Perl binary (usually
>> /usr/bin/perl).
>>
>> (What Git can not decide is which perl it should use, the one pointe=
d out
>> by $PATH or /usr/bin/perl.)
>>
>> What does
>> "type perl" say ?
>>
>> And what happens when you build and install Git like this:
>> PERL_PATH=3D/XX/YY/perl make install
>>
>> -----------
>> Are you thinking about changing
>> ifndef PERL_PATH
>>         PERL_PATH =3D /usr/bin/perl
>> endif
>> -- into --
>> ifndef PERL_PATH
>>         PERL_PATH =3D $(shell which perl)
>> endif
>> ---
>>
>> At first glance that could make sense, at least to me.
>
>
> The problem in this case is the Perl being used at run-time, not buil=
d-time.
> The building of git is done by the homebrew project in this case, so =
I don't
> have direct control over it.

Correct, but we don't change /usr/bin/perl at runtime, we hardcode
that at compile-time.

Similarly we could hardcode PERL5LIB at compile-time, but we don't, if
we did you wouldn't have this problem.

I.e. the problem is that we're using the system-provided perl with a
custom PERL5LIB set for the benefit of a non-system provided perl
installed after you built Git (or built in a different environment...)
