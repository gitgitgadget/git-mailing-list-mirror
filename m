From: Ravi Shekhar Jethani <rsjethani@gmail.com>
Subject: Re: Rationale behind 'extern' on protypes in .h files
Date: Mon, 23 Dec 2013 20:54:09 +0530
Message-ID: <CAKTJ_1z-pMePmh4phM2TXSMx0kOjGJ0afQ_JRESggi=k6+y-jA@mail.gmail.com>
References: <CAKTJ_1zecXP03k_2YRnm_26n=anxkG6=k+isZxnnjWgfec70LA@mail.gmail.com>
	<52B71D24.4000207@googlemail.com>
	<87eh54spw3.fsf@jedbrown.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org
To: Jed Brown <jed@59a2.org>
X-From: git-owner@vger.kernel.org Mon Dec 23 16:24:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vv7Mf-00089q-DF
	for gcvg-git-2@plane.gmane.org; Mon, 23 Dec 2013 16:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab3LWPYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Dec 2013 10:24:12 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:43416 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab3LWPYL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Dec 2013 10:24:11 -0500
Received: by mail-lb0-f170.google.com with SMTP id c11so2381950lbj.1
        for <git@vger.kernel.org>; Mon, 23 Dec 2013 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eMSSPuUriq6ukQ2whFD8fLL2FbVWkwQbDVCxkEqoJds=;
        b=lM/f5cjKIUFgxn82lYwQTD16WTJFhCoxfjCnwbbYgzfRYU4GzY1iRx06iJXJjSCzfb
         SlXM7gaFV8LcDgAPescxMcxsp/tap2snWXJZye4UrvjbjPsNzal8AzBOOy3HeBQZI2GQ
         hT4i9dcstmUT2t7KnFPWrFSJ/vUBlHHoypnyOQ33jEpcoYL9zTZHhQoONpcvvmlWlJK/
         QA0jLjedeQ9Oas4CzJg+2JyH/+vC8MAZbz0DgbQGK9ivQb5ayAQcBQqqzQSgQ44aGd82
         0Yo06pSUbd99ncUcvwi40myBaSbHVIZ6fUD1Mp3iPFEq1G9kRJnHE6B8RzBDzGaTT8LD
         bjEg==
X-Received: by 10.152.5.163 with SMTP id t3mr1272550lat.39.1387812249938; Mon,
 23 Dec 2013 07:24:09 -0800 (PST)
Received: by 10.114.18.43 with HTTP; Mon, 23 Dec 2013 07:24:09 -0800 (PST)
In-Reply-To: <87eh54spw3.fsf@jedbrown.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239652>

2013/12/22 Jed Brown <jed@59a2.org>:
> There is a difference for shared libraries if you would like to control
> which symbols are exported.  With gcc, for example, you might compile
> using -fvisibility=hidden.  Any functions explicitly declared with
> extern, bearing __attribute__((visibility("default")), or using
> visibility pragmas will be exported (similar to __declspec(dllexport) on
> Windows).  Other functions will be internal to the shared library so you
> don't have to worry about callers depending on those symbols and
> performance can be a bit better by skipping the PLT and avoiding symbol
> relocations at load time.  See Drepper's guide for more.
>
> http://www.akkadia.org/drepper/dsohowto.pdf

To check this I installed the libgit2-dev package which installed:
/usr/include/git2/*.h , /usr/lib/libgit2.so
Now, I exported all symbols using:
$ readelf -s /usr/lib/libgit2.so
and tried to match these with 'externed' prototypes in the Git source
directory..no matches.
I am confused!!!.

Also I checked this:
$ ldd git
There is no 'gitish' .so in the output; it seems everything is packed
inside one executable.
So your second point 'skipping the PLT...' also doesn't seem to apply here.


Regards,
Ravi Shekhar Jethani
