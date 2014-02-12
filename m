From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 15:05:43 -0800
Message-ID: <CAPc5daVcAq2jb2-R32HVEG_GY4=JZLG-AmgZKNdQMzZZX2LOCg@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
 <CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
 <xmqqr478m6xx.fsf@gitster.dls.corp.google.com> <CAHOQ7J8Q1905pVwx9QVib1BM-Xxg8vTL=hDUjT7garX++VXm3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Thu Feb 13 00:06:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDisc-0007c8-TC
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 00:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbaBLXGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 18:06:06 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:36655 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbaBLXGF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 18:06:05 -0500
Received: by mail-la0-f48.google.com with SMTP id mc6so7628682lab.35
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 15:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=BtYl+Ds28vpCoJy6Ro2Cxf2YaoY5NPtAjWRe8c92wrI=;
        b=xnCSMmJvou5cPpunIm8ZAJ1mof/BjZYJm1iaExDeulSFWwvz9URD83iRKSU/PPhogB
         jX8I9ezCIZpuoyvZtqRU9v/cwQy/CFOkWa8noYSJlpKXK/HGHOZJwt3hs1P6KzqAkv9f
         9vM74sScXjfhJLMGMeaOT7BtMYJB12mnpjflAOfbUctXnddWjlfEwUWlaKlLxPNTe4xm
         X3rZEj/QdoEWzb646Te+0fSDSFaxOJsq7/KWt35hUUQWMQtkt9QOP2oHZiQL3CifOolA
         BfdOplFkQZ3QiK6WPD5nW1Rm2C1Zx1B0nqaXZmULyhFbE1EUoJyL7TuILjRtDX55Wo8M
         1aPA==
X-Received: by 10.152.28.200 with SMTP id d8mr18181lah.59.1392246363100; Wed,
 12 Feb 2014 15:06:03 -0800 (PST)
Received: by 10.112.180.130 with HTTP; Wed, 12 Feb 2014 15:05:43 -0800 (PST)
In-Reply-To: <CAHOQ7J8Q1905pVwx9QVib1BM-Xxg8vTL=hDUjT7garX++VXm3g@mail.gmail.com>
X-Google-Sender-Auth: eYHFD-A1yE134zg74jpy-OLwK5I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242031>

On Wed, Feb 12, 2014 at 12:27 PM, Stefan Zager <szager@chromium.org> wrote:
> On Wed, Feb 12, 2014 at 12:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Zager <szager@chromium.org> writes:
>>
>> Calls to write (and preparation of data to be written) will then
>> remain single-threaded, but it sounds like that codepath is not the
>> bottleneck in your measurement, so....
>
> Yes, I considered that as well.  At a minimum, that would still
> require attr.c to implement thread locking, since attribute files must
> be parsed to look for stream filters.  I have already done that work.

I would have imagined that use of the attribute system belongs to "write and
preparation of data to be written" category, i.e. the single threaded
part of the
kludge I outlined.

> But I'm not sure it's the best long-term approach to add convoluted
> custom threading solutions to each git operation as it appears on the
> performance radar.

Yeah, it depends on how clean and non-intrusive an abstraction we can make.
The kludge I outlined is certainly not very pretty.
