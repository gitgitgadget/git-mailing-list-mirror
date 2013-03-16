From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: regression in multi-threaded git-pack-index
Date: Sat, 16 Mar 2013 19:38:40 +0700
Message-ID: <CACsJy8D9zwwij9DDrug_tvp2_zrXG7RGcZBbKzpHu1T5iQdxZg@mail.gmail.com>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com> <20130316114118.GA1940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 16 13:39:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGqOh-0006Uk-Ug
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 13:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710Ab3CPMjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 08:39:13 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:36272 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665Ab3CPMjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 08:39:12 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so4368174oag.29
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6Exy297fYFuFTiYhnzZQDcklr/nBK6kax9fI/J4iGPQ=;
        b=cvKsfIh6IsOAh5tXss1miTTFTVY8qnrNkcsqra4oP/OEM4w/obpsNXNiGNZyVm8fji
         Hr8aMktjVsHn2KEiIlOkr2oXzmwxfkEzH0LDzii6mgEqKkHnGVSoLTc/jmn9Q9NkonKL
         aaCer7zjFGbplK38u/4cwiAWD0sWNuI0Q75FUYl9B8QWcsIWKyUDOxSWrQuE78TGuhwD
         fmwrV8wYnND6smat2UrC9oMmgkAZNn4LY2MEEqJn8F1XFK3UdfeqMVFjBN2UjKuMCxQm
         2GE9EEbGnut2AFVAaWVz4gN2e33v5x/tzAZGE+C0dn9MsxMGXZe/7lEKQijs7ZK2KPJo
         4SkQ==
X-Received: by 10.182.43.103 with SMTP id v7mr4402571obl.17.1363437551051;
 Sat, 16 Mar 2013 05:39:11 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sat, 16 Mar 2013 05:38:40 -0700 (PDT)
In-Reply-To: <20130316114118.GA1940@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218301>

On Sat, Mar 16, 2013 at 6:41 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 15, 2013 at 03:42:40PM -0700, Stefan Zager wrote:
>
>> We have uncovered a regression in this commit:
>>
>> b8a2486f1524947f232f657e9f2ebf44e3e7a243

What version did you test? We used to have problems with multithreaded
index-pack on cywgin because its pread implementation is not
thread-safe, see c0f8654 (index-pack: Disable threading on cygwin -
2012-06-26). Not sure if we fall into the same path on Mac, or this is
something else..

>>
>> The symptom is that 'git fetch' dies with:
>>
>> error: index-pack died of signal 10
>> fatal: index-pack failed

I guess it won't help much, but what if you enable coredump and get a
stack trace from it?

>>
>> I have only been able to reproduce it on a Mac thus far; will try
>> ubuntu next.  We can make it go away by running:
>>
>> git config pack.threads 1
-- 
Duy
