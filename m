From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 22:03:23 +0200
Message-ID: <CAHGBnuNQFRHunX9wkBpS1GHXVRP+LL2YOr38fyX_J=5TWP5jgw@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	<xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
	<CA+55aFws7iNGRpu6wKBkKj_5bw3vu_E+q+1__Aw4kmhkaUMRGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 13 22:03:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKZaT-0008VB-VW
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 22:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab3IMUD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 16:03:26 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36602 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab3IMUDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 16:03:25 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so2459129lbh.34
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7iawoWX62mKMI7EVFbzkWTkUUaYIfZioV/mK7vk4ggw=;
        b=LmxQrRfeyQdnsb/7v2uHSKVmiIVIllQ1fwo+0a80LXNBU6SN3RRZhe5uWPBHaZZ5fJ
         sNzrQLI0lKdTDLv8vy0+caNzLvyVq/cf9tHK09CLA7CByFPNwnU0O/XJQoMs1hTcG/6J
         /d+iotHMS/bG+i11bOuVlALKtS+Sgpk2Nlp60PqQ3AsThVTtfpk4DhTRVUa7Z0BoLRNH
         bfsjxXXEaeyS7n6Aj7P0pOwVPmdOqq7AnyjsjATdg6FL+9BDZmGgAIL1FJM9mpJMO/9S
         JswIoU2yCBivbvfElqz4f4xKm289iyxiPpYC4pjrzDZDt5iyjXECCZ7t42/ne9lg0Pws
         Ikmw==
X-Received: by 10.112.181.100 with SMTP id dv4mr2872647lbc.34.1379102603830;
 Fri, 13 Sep 2013 13:03:23 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Fri, 13 Sep 2013 13:03:23 -0700 (PDT)
In-Reply-To: <CA+55aFws7iNGRpu6wKBkKj_5bw3vu_E+q+1__Aw4kmhkaUMRGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234768>

On Fri, Sep 13, 2013 at 9:56 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

>> +#ifdef __MINGW32__
>> +#ifdef __NO_INLINE__
>
> Why do you want to push this insane workaround for a clear Mingw bug?

To be frank, because Git is picking up patches much quicker than MinGW
does, and I want a solution ASAP. Although I of course agree that
fixing the real issue upstream in MinGW is the better solution.

> Please have mingw just fix the nasty bug, and the git patch with the

I'll try to come up with a MinGW patch in parallel.

> trivial wrapper looks much simpler than just saying "don't inline
> anything" and that crazy block of nasty mingw magic #defines/.

It may look simpler, but as outlines in this thread it's less
maintainable because you need to remember to use the wrapper. And
people tend to forget that no matter how loudly you document that. If
we can make the code more fool proof we IMHO should do so.

-- 
Sebastian Schuberth
