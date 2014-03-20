From: Stefan Zager <szager@chromium.org>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Thu, 20 Mar 2014 09:08:04 -0700
Message-ID: <CAHOQ7J9drXwcTt4b0Tcyw97KTGcifwsO5rtFNQYf7CVr3WD7zQ@mail.gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
	<532AF304.7040301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Stefan Zager <szager@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 17:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQfVu-0001xX-Av
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 17:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757167AbaCTQII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 12:08:08 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:35369 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbaCTQIF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 12:08:05 -0400
Received: by mail-oa0-f54.google.com with SMTP id n16so1152643oag.41
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=uoGiJh013yxxVcc102mknXkdgWwjwk4zdsYGLLAe/a4=;
        b=EKL0wmDoUgkMIrmQUcsq9sZBWxrI05HEo7u+EG1QF83A+12CvLuoqu0WOrKIwn3dDA
         xjFpifVkeJUwr6XKdfvx4SRXJ2j6elYUQFCM1vUUInOoEl4JzI/Qwqta7Dq0k3NiqF9A
         LsogHUhyeCoGt4ad1GnmEXwzOx1ksrpIQg5zLKnqu3flRizROr8oegQBK4VV3aH3+83+
         Zy797l0jRtNZ13ueRG4JbcnuqePc49CoqFlRgXH0RLfSu2xCqH7VSrW3SFDwIPW6vogx
         yIe+HO8HF6E6r/p4YEYyryV6AlxZx2YlKSwjCYxIC3ajfHFnLLEHy0dOXctTS7IIIf25
         C8fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=uoGiJh013yxxVcc102mknXkdgWwjwk4zdsYGLLAe/a4=;
        b=UmZkdsyZ+EagBNkL9+8fb0JBrqN3tiQm9ZoYV6GtwVClEfg9c6AcESNVWMobH46Bg2
         aFiwM5K722IkZo10zY53jvaBohWhFY+sxXjxccoA/uBI4ERTO4bKIaaBF/krH1hfVhtK
         bENtK+mY7n9pQ9tvULi4BX8meoACPKnu8xwx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uoGiJh013yxxVcc102mknXkdgWwjwk4zdsYGLLAe/a4=;
        b=U1ZGCbrcRc1ACOKEcfZDjjrRoUSNFqArTNLR0TyXMY9+oMlF8cVrtXdsTsK3shmk8W
         3HAWRx1v7lPL1B014GHZ6pJAGZDd9VdDasOw07MYyentpmr7W4miyeauxfrlWml/K8ht
         txCm4Px6HfoLg2xBWtwx2ZH50ISeoLDfzSdRlgTRKSb57DpWnmtgNK4Dz/7ffbhS+wGa
         7lXTf3fxEQUoKNxfALfOG/5VAg9Dr5YqF40zHCOOs/CkvW32ScU8Z3nvTXt3d1uZxoDI
         ad1CDTkfoOC4ikrIjVc6NQVrIrqFT+zl1lEbGcP39X/yKv5kdjNTIsjYrMXGv+zuh9YU
         qMCg==
X-Gm-Message-State: ALoCoQlUUhV+xibwxCsUmf7HhMUWuiJAky48zUpDztxV6SgM3p26cuiW0rwbfQyPB1ebTiAATJLW6TKHP3w2laUQ3tnCw6833CceXLratLrQgbnDS9nnA+Mp32X+iu97jlCEIeLZEHOVzisBf/MWshxDmiCN3WUpRL4LNEaKg1H1Nc5gG91WvmJG7F/5mIzhRZkDWrDeq/Sd
X-Received: by 10.60.145.225 with SMTP id sx1mr38912959oeb.30.1395331684661;
 Thu, 20 Mar 2014 09:08:04 -0700 (PDT)
Received: by 10.182.233.201 with HTTP; Thu, 20 Mar 2014 09:08:04 -0700 (PDT)
In-Reply-To: <532AF304.7040301@gmail.com>
X-Google-Sender-Auth: f82BiZYLl5Y0VoyVEYqrXvnaMe0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244553>

On Thu, Mar 20, 2014 at 6:54 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 19.03.2014 01:46, schrieb szager@chromium.org:
>> This adds a Windows implementation of pread.  Note that it is NOT
>> safe to intersperse calls to read() and pread() on a file
>> descriptor.
>
> This is a bad idea. You're basically fixing the multi-threaded issue twice, while at the same time breaking single-threaded read/pread interop on the mingw and msvc platform. Users of pread already have to take care that its not thread-safe on some platforms, now you're adding another breakage that has to be considered in future development.
>
> The mingw_pread implementation in [1] is both thread-safe and allows mixing read/pread in single-threaded scenarios, why not use this instead?
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/242120


That's not thread-safe.  There is, presumably, a point between the
first and second calls to lseek64 when the implicit position pointer
is incorrect.  If another thread executes its first call to lseek64 at
that time, then the file descriptor may end up with an incorrect
position pointer after all threads have finished.

> Duy's patch alone enables multi-threaded index-pack on all platforms (including cygwin), so IMO this should be a separate patch.

Fair enough, and it's a good first step.  I would love to see it
landed soon.  On the Chrome project, we're currently distributing a
patched version of msysgit; I would very much like for us to stop
doing that, but the performance penalty is too significant right now.

Duy, would you like to re-post your patch without the new pread implementation?

Going forward, there is still a lot of performance that gets left on
the table when you rule out threaded file access.  There are not so
many calls to read, mmap, and pread in the code; it should be possible
to rationalize them and make them thread-safe -- at least, thread-safe
for posix-compliant systems and msysgit, which covers the great
majority of git users, I would hope.
