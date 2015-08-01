From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the
 presentation layer
Date: Sat, 1 Aug 2015 05:03:56 -0400
Message-ID: <CAPig+cTyK=xDbtsK+q0eL=wmZ87xWue8SMJm=DQOzX22R1AOtQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
	<vpqbnewxwcx.fsf@anie.imag.fr>
	<CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
	<vpqk2tjmgeg.fsf@anie.imag.fr>
	<CAOLa=ZRUnF12gO=AKg3E373XETqoykqOXSkPvr7DHCVrOeggAA@mail.gmail.com>
	<vpq4mkmejsh.fsf@anie.imag.fr>
	<CAOLa=ZRq7zowwse7OGeU_AwJe_Z0WDn1qoYaH_A6AD5g92e_GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 11:04:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLSiG-0004v9-6V
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 11:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbbHAJD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 05:03:59 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34296 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbHAJD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 05:03:57 -0400
Received: by ykax123 with SMTP id x123so76991114yka.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2015 02:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XO3XzQzoFHW93vpO4u0qiGKPMQg1PHgZEH3vdRVlfG8=;
        b=cDBbc7P8ziyPH2N73QalCS46cNmCSox/9Xetk+oHUP2kzlNipVMak8oU/LRkij3hHx
         keAK0r8o5IUb/eV+ThbBD2RM56YFi8MugThYt1Zbzjb9OAMtKBvqcUDUxkS2I/1YCqWR
         Q/qD4j9UuKwUGDpYgK6C5nuSPPkL52kodR0lOmcylh4Rch4prv0VppE9R8Udh7eQeKRH
         kIjBb9xxm+cm0os4h5Tyba7oNnHZRJwgnLCzu4iTVXZKVU7k9a9KomVaNhpEjWMdt1za
         x0Nc3aiSL4awQNtv8EgVKfXcxKgi8bkK9JNYfk2A8EeR7aRh4uv70UNddiP2xowZz/lE
         dyWg==
X-Received: by 10.13.221.213 with SMTP id g204mr6392123ywe.48.1438419836444;
 Sat, 01 Aug 2015 02:03:56 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 1 Aug 2015 02:03:56 -0700 (PDT)
In-Reply-To: <CAOLa=ZRq7zowwse7OGeU_AwJe_Z0WDn1qoYaH_A6AD5g92e_GQ@mail.gmail.com>
X-Google-Sender-Auth: UXHyjhHYCMvMmuH8yWvVjkNBYDE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275115>

On Sat, Aug 1, 2015 at 2:48 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Thu, Jul 30, 2015 at 2:57 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> Good point! I just was wondering if we need another atom just to print a star.
> But your points certainly are valid. I'll implement this. Thanks :)
>
>>> This would remove the need of making the printing of the "*" to be
>>> needed by ref-filter. As this is only needed in branch.c
>>>
>>> If going on what you're saying we could have a "%(starifcurrent)" atom or
>>> something, but I don't see a general use for this.
>>
>> To have a really customizeable format, you would want to allow e.g.
>>
>>   git branch --format '%(starifcurrent) %(objectname) %(refname)'
>>
>> if the user wants to get the sha1 before the refname, and still have the
>> star in front. It's a bit frustrating to have a hardcoded format that
>> the user can't reproduce with the --format option, since it means you
>> can't easily make a small variation on it.
>
> Agreed. will have a "starifcurrent" atom :)

Please don't. It's better to avoid these highly specialized solutions
and instead seek general purpose ones. For instance, utilizing the
%(if:) atom suggested elsewhere, you might add an %(iscurrentbranch)
which would allow a format like this:

    %(if:iscurrentbranch)*%(endif)

Even more generic would be an %(ifeq:x:y) conditional and a
%(currentbranch) atom:

    %(ifeq:refname:currentbranch)*%(endif)

Those are just a couple ideas. Other variations are possible and
likely preferable to the specialized %(starifcurrent).
