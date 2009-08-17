From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] quick question about __stdcall at run-command.c mingw.c
Date: Mon, 17 Aug 2009 01:03:13 +0100
Message-ID: <a5b261830908161703l2296448l698d07d01ae8a6d3@mail.gmail.com>
References: <1976ea660908161619x5182762sade051f24fef13db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 02:03:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcph3-0007p5-3s
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 02:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbZHQADN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 20:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbZHQADN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 20:03:13 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:56681 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbZHQADN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 20:03:13 -0400
Received: by fxm11 with SMTP id 11so2024036fxm.39
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 17:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C3nnPbBRA0XuGZgrvb5qWNkUlRtrx3tEDXbGrqk0wNk=;
        b=Q7S8V8ma0FRKzX8sLpvTYYZcbDoB488Uy51hyaRZ6HM6yhtaOGNYvG5NcVI/dnQKTy
         f+zIPN2HFN+WlZ4RD1eadZGfkLoHOagrlrT/RZa0FlyXMrSVapqcWN85Y8USrZdE3JQr
         sTDJkOwh7MOUjR8sNua00hzufEKlFiRkGLiLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ToaFSzDe1VizsTGbDyx6WokLkIql0cflVyVKb/sR7oVlG4bzyrSP8zrTRcHnZOXD+9
         QTYGHne8YVKjKa3wYebZYplddae14g0Pc2BiR7xaeH6y3Azo1BIFMXQPMKfRWhjQkaYe
         erE+Y5l/8H0I+RD1A6IAAqkMzzrWf0QDGvp7Q=
Received: by 10.239.130.28 with SMTP id 28mr234630hbh.22.1250467393444; Sun, 
	16 Aug 2009 17:03:13 -0700 (PDT)
In-Reply-To: <1976ea660908161619x5182762sade051f24fef13db@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126100>

2009/8/17 Frank Li <lznuaa@gmail.com>:
>
> I am tring to clear VC build patch.
>
> I found __stdcall position break MSVC build.
>
> static __stdcall unsigned run_thread(void *data)
>
> MSVC require __stdcall should be between return type and function name.
> like
> static unsigned __stdcall run_thread(void *data)
>
> I think msys gcc should support MSVC format.
>
> Should I directly change to MSVC format or add _MSC_VER marcro like
>
> #if defined(__MINGW32__)
> static __stdcall unsigned run_thread(void *data)
> #elif defined(_MSC_VER) /*MSVC must put __stdcall between return value
> and function*/
> static unsigned __stdcall run_thread(void *data)
> #endif

The win32 api prototype used for thread entry functions is declared as
a DWORD (WINAPI *LPTHREAD_START_ROUTINE)(LPVOID) type in the mingw
headers and WINAPI as #define WINAPI __stdcall. This is true for the
MSVC headers as well. So gcc and msvc are happy using the same
definition for such a function and just "static unsigned long WINAPI
run_thread(void *)" might well be sensible.
