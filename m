From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Wed, 29 Jul 2015 23:18:16 +0530
Message-ID: <CAOLa=ZTUJHnXWJyr0wp0CZgR9S1pBxCEsGRiDPsJdUyzTZaZUw@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
 <xmqq8ua0f9lk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 19:48:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKVTG-0003IX-Le
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 19:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbbG2Rsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 13:48:46 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33187 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbbG2Rsq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 13:48:46 -0400
Received: by obdeg2 with SMTP id eg2so12919847obd.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bd/DhT7+v0wF0pwFlvobA7ctYzVG9SQRrv3jJmiP0qI=;
        b=JH52cS1xl27RooMaO5vH6AgSVOkAraKAL8cayRPQJudQbU65JgWe2DF/Yahfmebcj9
         O+HNLPzmL/BeRz0Ac9wVzhwKx7tdu5P0cDl4POyybxiOzmUc7QMNM3pdOwd3iJUAN0xv
         lEz+20tbwiua3EcLVdppCqUrwRZLR5AJQBCxb3x7eF8FHfbGRdLfnubfQrsqzgM5mEha
         BQ11EjulUvG0rgPcFP6zaO9j0Hn+kKLNgJGcMwy97KpwytSW1V0ayjFS1bDQB6mDZmwt
         oqQ4ubPVR5/+VsKuuRA3EsLeau5liV+vzzEJLQTOtrIHJeO+N7ZTlmsYo1ArnN1vTpoE
         Nc2w==
X-Received: by 10.60.42.230 with SMTP id r6mr43740432oel.9.1438192125666; Wed,
 29 Jul 2015 10:48:45 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 10:48:16 -0700 (PDT)
In-Reply-To: <xmqq8ua0f9lk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274924>

On Tue, Jul 28, 2015 at 11:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'ifexists' atom allows us to print a required format if the
>> preceeding atom has a value. If the preceeding atom has no value then
>> the format given is not printed. e.g. to print "[<refname>]" we can
>> now use the format "%(ifexists:[%s])%(refname)".
>
> A handful of "huh?" on the design.
>
>  - The atom says "if *exists*" and explanation says "has a value".
>    How are they related?  Does an atom whose value is an empty
>    string has a value?  Or is "ifexists" meant to be used only to
>    ignore meaningless atom, e.g. %(*objectname) applied to a ref that
>    refers to an object that is not an annotated tag?

It's meant to ignore meaningless atom. atom's whose values are empty
strings are ignored.

>
>  - That %s looks ugly.  Are there cases where a user may want to say
>    %(ifexists:[%i]) or something other than 's' after that per-cent?
>

Couldn't think of a better replacer, any suggestions would be welcome :)

>    . Is it allowed to have more than one %s there?
>    . Is it allowed to have no %s there?
>

1. yes its allowed to have multiple %s
2. yes no %s is also allowed.

>  - The syntax makes the reader wonder if [] is part of the
>    construct, or just an example of any arbitrary string, i.e. is
>    "%(ifexists:the %s can be part of arbitrary string)" valid?
>

Its given as example, is that misleading?

>  - If an arbitrary string is allowed, is there any quoting mechanism
>    to allow ")" to be part of that arbitrary string?

Nope. Haven't done anything for that. I'll look into that :)

>
>  - What, if anything, is allowed to come between %(ifexists...) and
>    the next atom like %(refname)?  For example, are these valid
>    constructs?
>
>     . %(ifexists...)%(padright:20)%(refname)

Doesn't work with padright, maybe we could eventually support that.

>     . %(ifexists...) %(refname) [%(subject)]
>

Not sure what this is.

>  - This syntax does not seem to allow switching on an attribute to
>    show or not to show another, e.g. "if %(*objectname) makes sense,
>    then show '%(padright:20)%(refname:short) %(*subject)' for it".

Yes this doesn't do that, I can say this is a pretty basic version, we could
probably work on and implement more things?
This is currently to support 'git branch -vv' where we have the upstream
in square brackets.

-- 
Regards,
Karthik Nayak
