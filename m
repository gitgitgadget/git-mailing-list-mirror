From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: Re: [PATCH] Makefile: fix compilation of test programs under MinGW 
	environment
Date: Sun, 28 Feb 2010 00:40:41 +0300
Message-ID: <63cde7731002271340k5c26e064r8b7cc4a53b435e95@mail.gmail.com>
References: <1267304969-1924-1-git-send-email-michael.lukashov@gmail.com>
	 <7vy6ietlf7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 22:40:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlUP2-0006JQ-KI
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 22:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936228Ab0B0Vkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 16:40:43 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63534 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936082Ab0B0Vkn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Feb 2010 16:40:43 -0500
Received: by wya21 with SMTP id 21so676113wya.19
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 13:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rjdB87x8r28+RVG+aPc8F5pjY6euh3dOpSuvexU1epU=;
        b=mFXOYobrvRSDbWFarvySWpPYkZ5TsSZmSe9uGVxZdnczfqWtpXLkxZv99dz8gII69o
         qaAFqVS/IBzuT6IXXl2yM3azXIW1BxCrsSl8nzLbauuC85RuTpd3ThOuaigLJm6D6Pv8
         cXewJBQKNaaBveBhW+efyf1NdhOUCD5ickZZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tGCdww8KH4Jx9GrFUEQcbDX6OUzr3V1YJffXB+T2NrA3edhKYB+S6OFLb9I8zM2VKM
         jgTGBTPogcyAD+EZ4qzfw9BXsDxCYMqrpN9qEBtxOVIjrZgj7VTrUUeuJD2UOqov7Bqi
         sNokl5SOqJgmYySZCzZNwVeMegMbtE34VtrF4=
Received: by 10.216.89.84 with SMTP id b62mr1604114wef.226.1267306841235; Sat, 
	27 Feb 2010 13:40:41 -0800 (PST)
In-Reply-To: <7vy6ietlf7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141231>

Hi,

On Sun, Feb 28, 2010 at 12:31 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Michael Lukashov <michael.lukashov@gmail.com> writes:
>
>> Commit 225f78c8 (Merge branch 'master' of git://repo.or.cz/alt-git
>> into jn/autodep, 2010-01-26) changed Makefile in such a way that
>> the following error occurs when trying to compile Git under MinGW en=
vironment:
>>
>> =C2=A0 make: *** No rule to make target `test-chmtime', needed by `a=
ll'. =C2=A0Stop.
>>
>> Under Linux it seems there's no difference between two variants.
>
>> -TEST_PROGRAMS :=3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
>> +TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
>
> If the difference were on the RHS of this definition, which does invo=
lve
> $X that is different between the two platforms, I would understand, b=
ut
> your patch looks like it is addressing difference between :=3D vs =3D=
, and
> that is more like a difference of other parts of the Makefile than
> difference between Linux and mingw compilation environment.
>
> Does mingw build add other instances of TEST_PROGRAMS definition to t=
he
> Makefile, or perhaps have other means (e.g. ./build.sh runs make with
> TEST_PROGRAMS set to something else) to affect it?
>

No.

> Or somewhere other than the main makefile, do you have an explicit "m=
ake
> test-chmtime" (not "make test-chmtime.exe") that tries to make sure t=
hat
> the build is done?
>
>

No.

Before commit 225f78c8 definition of TEST_PROGRAMS was:

TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))

After commit 225f78c8 definition of TEST_PROGRAMS changed to

TEST_PROGRAMS :=3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))

And it leads to compilation error.
