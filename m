From: demerphq <demerphq@gmail.com>
Subject: Re: General support for ! in git-config values
Date: Thu, 2 Feb 2012 01:16:38 +0100
Message-ID: <CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
	<20120201184020.GA29374@sigill.intra.peff.net>
	<CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
	<7v62fq2o03.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 01:16:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RskM1-000707-VX
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 01:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438Ab2BBAQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 19:16:40 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37299 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab2BBAQj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 19:16:39 -0500
Received: by wics10 with SMTP id s10so1355522wic.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 16:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=59x+hh25CDPVpoNPeI0FSAC6DMumUsNXGJfsMT/SBtI=;
        b=FNfgMCdjKzcewFEyd9LS4H/6CA888Lh3qyBoG8vtalkD96sNyj8H0lHQPJ9+PiR6ub
         OxdWgTHpzwPmd6L+T+BmdPo+AwVb/GMKo54kqLKJ0kH+n1Ez0MdJb/MdB0UPPSV01pvc
         qjOXuN/+J++s1ZQ+s9C806kqOZOdbxofo+6+o=
Received: by 10.180.92.73 with SMTP id ck9mr1126490wib.2.1328141798424; Wed,
 01 Feb 2012 16:16:38 -0800 (PST)
Received: by 10.216.174.145 with HTTP; Wed, 1 Feb 2012 16:16:38 -0800 (PST)
In-Reply-To: <7v62fq2o03.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189559>

On 1 February 2012 23:21, Junio C Hamano <gitster@pobox.com> wrote:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>
>>> I.e., everything pertaining to "!" happens after we get the config
>>> string. So what is it that you want "git config --with-exec" to do?
>>
>> I agree that that's how it should work, I just suggested --with-exec
>> in case anyone complained about the backwards compatibility issue of
>> changing the meaning of "!" for existing configs.
>
> Now you made me utterly confused.
>
> What "backwards compatibility" issue do you have in mind? =A0If I nam=
e
> myself '!me' with "user.name =3D !me", do I suddenly break backwards
> compatibility of Git with previous versions somehow? If so how?

(I am piping up because =C6var and I discussed this idea earlier today
while we discussed git-deploy)

If =C6var's proposal was implemented without a --with-exec switch then

user.name =3D !me

would set your name to the result of executing the "me" command, which
likely would have the same result as not having set your name at all,
but presumably with a warning about a bad command.

> The --with-exec option you talk about seems to me the option about th=
e
> backward compatibility of the _calling script_ of "git config".

By backward compatibility he meant that anything not providing the
--with-exec option to git-config would continue to behave as before,
and anything that did would get the new more powerful behavior, where
! at the front of a value signified that it meant a command to be
executed whose output would be used as the value.

I think it would be convenient to be able to enable this in the config
file itself. Consider a bunch of devs share a box. Their full name and
email address can be located via a LDAP lookup. So if we could enable
=C6var's proposal in the config then we can automagically have their
commits have the correct username and email if we were to put in the
/etc/gitconfig something like this:

config.enable_executable_options=3Dtrue
user.name=3D!ldap_full_name
user.email=3D!ldap_email

So now, user.name and user.email don't have to be configured by the
users. They just get an account on the box and all their commits have
the right details, no fuss.

I am aware that there are other ways of solving /this/ particular
problem, so it specifically is not a big deal, but still I think the
idea makes a lot of sense, I can imagine it being used in a lot of
interesting ways that are not obvious right away.

cheers,
Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
