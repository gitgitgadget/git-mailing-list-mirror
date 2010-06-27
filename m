From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Sun, 27 Jun 2010 16:45:01 -0400
Message-ID: <AANLkTilvV9Lty6jciIvASrRrzZ5rf9s2zmgulxuyM1hE@mail.gmail.com>
References: <4C226520.5080009@ramsay1.demon.co.uk>
	<AANLkTinmGOSwNzLBngXHOU-pxNTbHFJQyCLIHQWFW6Eo@mail.gmail.com>
	<4C251062.8040507@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jun 27 22:45:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSyjO-0002yG-BZ
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 22:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831Ab0F0UpE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jun 2010 16:45:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37268 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab0F0UpD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jun 2010 16:45:03 -0400
Received: by wyb38 with SMTP id 38so1329667wyb.19
        for <git@vger.kernel.org>; Sun, 27 Jun 2010 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=mX8hVJnzfhZd4vFZSQ5dXZrkdiTsBGfL/wc1evBVxuQ=;
        b=mkZj+gT5cKuKyGF9Xxf0p3/hz9WmoI4PCkrkBi9mV6Ur9OX9XdTVupWKw0AVKJICbS
         jUlulFWG+qSU4bddeKwnz0GQCD3OmIo7zAtNjc8gsEucMoT/eXSKlyU8QoHXoD63zqff
         04KpIhIXAhz/8fJ9cR2J3bcbqTUEQ7SYKFNJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=MxCysPTYj2yLjzybJifzQOO7r9d1fvQ/PEYPLQo51JcBI5k4WzTY4cR0+y9Ck5psaX
         jbjloyTcYR1r04D2npUgAP4FUs1GuQmHsUZt1l2jfK1tbfzLEbnsTzCRKrwF6H+JQtNN
         W1xsz/6GXey049t9CWzVh1dXnp3vyqqdQKY3g=
Received: by 10.227.143.213 with SMTP id w21mr3045055wbu.63.1277671501968; 
	Sun, 27 Jun 2010 13:45:01 -0700 (PDT)
Received: by 10.216.165.78 with HTTP; Sun, 27 Jun 2010 13:45:01 -0700 (PDT)
In-Reply-To: <4C251062.8040507@ramsay1.demon.co.uk>
X-Google-Sender-Auth: nkKiQVQk4_wqJ2bNQG_qvoprTaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149809>

On Fri, Jun 25, 2010 at 4:24 PM, Ramsay Jones wrote:
> Peter Harris wrote:
>> On Wed, Jun 23, 2010 at 3:48 PM, Ramsay Jones wrote:
>>> The msvc debug build (make MSVC=3D1 DEBUG=3D1) issues a warning
>>> on every invocation of the linker:
>>>
>>> =A0 =A0LINK : warning LNK4044: unrecognized option '/Zi'; ignored
>>>
>>> In order to suppress the warning, we refrain from passing the
>>> $(ALL_CFLAGS) macro to the linker.
>>
>> Alternatively, we could leave the makefile alone and fix it up in
>> compat/vcbuild/scripts/clink.pl
>
> Hmm, OK ... but it would be much easier if we didn't pass inappropria=
te
> options in the first place. :-P

Well, yes and no.

The vast majority of git devs work in an environment where compiler
flags and linker flags aren't completely disjoint, and it's not very
polite of us to rework their makefile to fit our view of the world.
Especially when we already have a wrapper that fits their world to
ours.

So I suggest that improving clink.pl is a whole lot easier for a whole
lot more people (compared to reworking the entire makefile being
easier for far fewer people).

> Also, are you correctly filtering *all* possible inappropriate option=
s?
> For example, the very next patch on my branch (not sent to list) adds
> a -W3 option ... ;-)

Heck no. This only filters the options that are used by the git makefil=
e.

But adding a filter for -W* is a trivial one liner (one character-er, e=
ven).

Peter Harris
