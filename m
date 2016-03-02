From: Stefan Beller <sbeller@google.com>
Subject: Re: bug: git submodule add in of nested submodule handles relative
 path wrong
Date: Wed, 2 Mar 2016 13:47:16 -0800
Message-ID: <CAGZ79kYJKyriLy8KMeAiG9E9u=LrQgXdO4wH1ERX3HsqZ2uVYQ@mail.gmail.com>
References: <20160302165240.GA17654@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joey Hess <id@joeyh.name>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:47:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abEcG-0006nl-C4
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 22:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbcCBVrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 16:47:21 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:35620 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbcCBVrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 16:47:18 -0500
Received: by mail-io0-f171.google.com with SMTP id g203so6947385iof.2
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 13:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=MDy/4rF171zSced5QfHfEIhr+fKVqGYE4njNlC0TDIY=;
        b=Yq8gqGiwoWrKM4Tz6Y+wkh+uyTUGbb0YVGFgbhHoeuoJHXjLHSmshisuABfQjxFV46
         ShO/8P/G2lkUD8sfz6ksb14swaOCn9vXsFb0DBefZZT/jnq6tbro0wY1kuuj8m2G3QFe
         MH92dwJLeSWqbBcFqowwcIJO0HJxm7AoMIiZ2RMH+HipmQ6PSlx5iWStWMKYNmEJUznE
         8UqEkmw7E+nEon+/uUnMzLHdY37EW2TmpRNf3zmPQdQ5tm2i6M2drgh8EExcpegIRx25
         80NYT/89HWjzplFzk6+9BSmvwvTIQDElVgSfUbm4y5RqlqkHxoZWmBY5LYqhQPwVsott
         5PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=MDy/4rF171zSced5QfHfEIhr+fKVqGYE4njNlC0TDIY=;
        b=HeiBICWUbtKjSqnUNyccGibiYulKUv8f4ytEUwx5LFgnmPK38P82vHXcNlEjQxG2KI
         yjQP3hF0u/TBgqypIGCeMPa/P1qMfJdeGOZU2MRvLihN3+t3HhQVNWY81kMv4kllc2CV
         YiVUa18VfjQw7DzOwaW8j2gie99I2hgp+7ZbU8J5Bp4FXZhbvelCDAuIMXvp4R7NslH/
         mXQvlTPNU+y+SQAmjKemRp4KmZdlWgEC8V7g912J6Oph9/xc1reFaA4sQ1ahUzMD8UdT
         yvWsoY6E129tmZu115iimrIUHdeQLljULpI4x25YMm28L1iLlB38Z8im8aVi+29nLsMN
         wRXg==
X-Gm-Message-State: AG10YOTOOAUW7d1xcg7pIFClp7H5JkESy27ZlQBA3vajmEC/uRiAhHZaV8l9OnqQX/EeRCHpyy8qpHFe18jCAMaM
X-Received: by 10.107.158.138 with SMTP id h132mr31238685ioe.174.1456955237064;
 Wed, 02 Mar 2016 13:47:17 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Wed, 2 Mar 2016 13:47:16 -0800 (PST)
In-Reply-To: <20160302165240.GA17654@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288157>

I'll add Jens, who has deep knowledge of submodules.

On Wed, Mar 2, 2016 at 8:52 AM, Joey Hess <id@joeyh.name> wrote:
> joey@darkstar:/tmp/empty>git init sub1
> Initialized empty Git repository in /tmp/empty/sub1/.git/
> joey@darkstar:/tmp/empty>git init sub2
> Initialized empty Git repository in /tmp/empty/sub2/.git/
> joey@darkstar:/tmp/empty>cd sub1
> joey@darkstar:/tmp/empty/sub1>date > f1 ; git add f1; git commit -m add -q
> joey@darkstar:/tmp/empty/sub1>cd ..
> joey@darkstar:/tmp/empty>cd sub2
> joey@darkstar:/tmp/empty/sub2>date > f2 ; git add f2; git commit -m add -q
> joey@darkstar:/tmp/empty/sub2>cd ..
> joey@darkstar:/tmp/empty>git init repo
> Initialized empty Git repository in /tmp/empty/repo/.git/
> joey@darkstar:/tmp/empty>cd repo
> joey@darkstar:/tmp/empty/repo>git submodule add ../sub1 1
> Cloning into '1'...
> done.
> joey@darkstar:/tmp/empty/repo>cd 1
> joey@darkstar:/tmp/empty/repo/1>ls
> f1
> joey@darkstar:/tmp/empty/repo/1>git submodule add ../../sub2 2
> fatal: repository '/tmp/sub2' does not exist
> fatal: clone of '/tmp/sub2' into submodule path '2' failed

This happens because inside "git submodule add" as in
any git submodule command you cd to the top level of the superproject
and then there is no proper way to describe where you came from.

Compare to [1], where I poke around with submodules as well.

[1] http://thread.gmane.org/gmane.comp.version-control.git/287620

>
> Like the bug I filed yesterday, this is caused by git submodule add's
> chdir into .git/modules.

I wonder if we want to take note of "these small annoyances"
in the submodule wiki[2].

[2] https://github.com/jlehmann/git-submod-enhancements/wiki#submodule-related-bugs-to-fix
  I consider Jens wiki one of the best sources for a high level overview
  of what needs to be done, and what is already solved for submodules.
  I linked to this thread from there. (I did not know I had write permission)

Thanks,
Stefan

>
> Workaround is to pass absolute paths to git submodule add.
>
> Note that this could be an exploitable security hole under some unusual
> circumstances. In the example above, any other local user could create a
> /tmp/sub2 containing something nasty, and git would check it out
> accidentially.
>
> git version 2.7.0
>
> --
> see shy jo
