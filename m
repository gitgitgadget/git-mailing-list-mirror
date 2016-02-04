From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 14/15] git-am.sh: replace using expr for arithmetic
 operations with the equivalent shell builtin
Date: Thu, 4 Feb 2016 12:53:27 +0100
Message-ID: <CA+EOSB=ky8E7J0Fa26DjgT=5-X9N09=4kRbGvWZo5K7PhwS7hg@mail.gmail.com>
References: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com>
	<alpine.DEB.2.20.1602041204430.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 12:53:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRITd-0006sd-L7
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 12:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbcBDLxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 06:53:30 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35461 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbcBDLx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 06:53:29 -0500
Received: by mail-vk0-f65.google.com with SMTP id e185so1538188vkb.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 03:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=B85LfHrYbGej2C8cKNpBknmw+DXmZo11xNxIITtflGc=;
        b=MbbFfpSq60vkOb7vQ+OTcIP0cMHE4Fl9du1EbSD8T9VmoNdL/Rd/CIKst4i1mOE7OT
         ha/YhIA1oBnmrmuAHj8ygJEvgjkSZDm9YS0vN7FAziGaHV4ZcWGFIiMMREjiH60Gs8v5
         Yf0uwQlBGlBY0jY4SNc3TWKpfV3hbASBtByQnMZ/adtiGbqh3RcAiP+nCkf/FhkjaYW5
         BBIiT+f1LiJIbj2vp/rA+9bH2JEGUV9Yv8i+IH6NuXDDNveBL9w3vN73gMV/X9mtemZ+
         G92Sd2bjUV/V7lgWVqBBY6+1wkcYlV75/d7Uz60Zoa88FNwIEyLwq/FMCDfWviNIYvEF
         qpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=B85LfHrYbGej2C8cKNpBknmw+DXmZo11xNxIITtflGc=;
        b=OZfAyNH6c5QV0YsQk4Ra+JRKBMSKIKXLRwn3lXTvNn8g6ItqgtuDNeDybC44Ue0qie
         dUhSYGsOvK+zpiU0oceGij+T718EushVV8hHbqJso4hjSp+lD2NTQIAZl1rgDWGKu0+V
         IGdbmvYMLcqJJ1Df90n3gpHgkwANf492A4vOLSXwuz5L6PaaD1gHAgQJ2W3a+vn+Fd/+
         FmSwRPZXQ73gsrzZ1PrsBJLNtOK1BYOWitE4vzXGiiFxyPgBYXUviGsg8qcTdCuoD96Y
         xvAA78v4Kosh2wrRt6EEsNDJGSUN1mSC1zOirkGkYw6cC5aEHYC8ZtXZYkgns2p6dyAE
         kC5Q==
X-Gm-Message-State: AG10YORl0yKYa4TMEpdJCabrRMtClwkmy2mRW+50wklug2DmHCHYUAs00I1ZfKH6xCTIxlhMzelvL4zYBZW4XQ==
X-Received: by 10.31.47.207 with SMTP id v198mr5051921vkv.6.1454586807945;
 Thu, 04 Feb 2016 03:53:27 -0800 (PST)
Received: by 10.31.56.10 with HTTP; Thu, 4 Feb 2016 03:53:27 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1602041204430.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285454>

2016-02-04 12:14 GMT+01:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi Elia,
>
> On Thu, 4 Feb 2016, Elia Pinto wrote:
>
>> -                     this=$(expr "$this" + 1)
>> +                     this=$(( "$this" + 1 ))
>
> Why the funny spaces? We do not do that anywhere in the existing code
> except in three places (2x filter-branch, 1x rebase--interactive, all
> three *not* my fault) and in some tests.
>
> Also, I am *pretty* certain that the quotes break this code:
>
>         me@work MINGW64 /usr/src/git (master)
>         $ this=1
>
>         me@work MINGW64 /usr/src/git (master)
>         $ this=$(( "$this" + 1 ))
>         bash: "1" + 1 : syntax error: operand expected (error token is ""1" + 1 ")
>
> Whereas if you do *not* add the superfluous spaces and quotes, it works:
>
>         me@work MINGW64 /usr/src/git (master)
>         $ this=1
>
>         me@work MINGW64 /usr/src/git (master)
Thanks for noticing.

You are right. I ran the test but did not notice mistakes, my fault.

I will resend. Thanks again.

Best

>         $ this=$(($this+1))
>
>         me@work MINGW64 /usr/src/git (master)
>         $ echo $this
>         2
>
> Maybe this is only a problem with Bash 4.3.42 in MSYS2, but I do not think
> so.
>
> *Clicketyclick*
>
> Nope. It also happens in Ubuntu's Bash 4.3.42:
>
>         me@ubuntu-vm  ~/git (master)
>         $ this=1
>
>         me@ubuntu-vm  ~/git (master)
>         $ this=$(( "$this" + 1 ))
>         bash: "1" + 1 : syntax error: operand expected (error token is ""1" + 1 ")
>
>         me@ubuntu-vm  ~/git (master)
>         $ bash --version
>         GNU bash, version 4.3.42(1)-release (x86_64-pc-linux-gnu)
>         Copyright (C) 2013 Free Software Foundation, Inc.
>         License GPLv3+: GNU GPL version 3 or later
>         <http://gnu.org/licenses/gpl.html>
>
>         This is free software; you are free to change and redistribute it.
>         There is NO WARRANTY, to the extent permitted by law.
>
> ... which makes me wonder in which environment you tested this?
>
> Ciao,
> Dscho
