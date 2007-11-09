From: "Yossi Leybovich" <sleybo@gmail.com>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 12:53:51 -0500
Message-ID: <4fe79b4b0711090953h5b06f7d4l2d17972630a4d355@mail.gmail.com>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
	 <alpine.LFD.0.999.0711090758560.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ae@op5.se,
	"Yossi Leybovich" <sleybo@mellanox.co.il>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 18:54:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqY3W-0000uV-9p
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbXKIRxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 12:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbXKIRxx
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:53:53 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:14285 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbXKIRxw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 12:53:52 -0500
Received: by wa-out-1112.google.com with SMTP id v27so688728wah
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6ajyAQiJY/TfzxPiBmj/MVT4Oh65Bu8x4aA5r8pEGXo=;
        b=Q3KAZqzhhD44IPPKEHO5yzp/01SMZ/qF1JzDwg+nfo6wZCP8T3NJTXQOQGltmBSVqYAmNeh+ODejPbhs5jTFcNkVs0TpC+VaiDddL87S0moZnOZ/x2xp5hb7d7EY7KQS3sXc89c37n61/sqH0GTLXMJgn2URfZXUhWH/TDNh3LY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D4VSsr7gVEYJdUg8sKdDbdP2NjzNrHlFCihM4EOZrCRCbag1ch2b/mWxig/5NbPmbI6A8x6pb4uQhKZuo0SwR5Gz7are50B0vByxsbGCQ/fOBQJlYXap93M9rsFq3Blab2L9bf+7re0hzqFgRVgxIECckqk+X+1NWFVJs5QDQfw=
Received: by 10.115.90.1 with SMTP id s1mr24898wal.1194630831218;
        Fri, 09 Nov 2007 09:53:51 -0800 (PST)
Received: by 10.114.174.5 with HTTP; Fri, 9 Nov 2007 09:53:51 -0800 (PST)
In-Reply-To: <alpine.LFD.0.999.0711090758560.15101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64234>

On Nov 9, 2007 11:28 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> and you should now have a line that looks like
>
>        10064 blob 4b9458b3786228369c63936db65827de3cc06200     my-magic-file

That works and now I know the file
>
> The easiest way to do it is to do
>
>        git log --raw --all --full-history -- subdirectory/my-magic-file
>
> and that will show you the whole log for that file (please realize that
> the tree you had may not be the top-level tree, so you need to figure out
> which subdirectory it was in on your own), and because you're asking for
> raw output, you'll now get something like
>
>        commit abc
>        Author:
>        Date:
>          ..
>        :100644 100644 4b9458b... newsha... M  somedirectory/my-magic-file
>
>
>        commit xyz
>        Author:
>        Date:
>
>          ..
>        :100644 100644 oldsha... 4b9458b... M   somedirectory/my-magic-file
>
> and this actually tells you what the *previous* and *subsequent* versions
> of that file were! So now you can look at those ("oldsha" and "newsha"
> respectively), and hopefully you have done commits often, and can
> re-create the missing my-magic-file version by looking at those older and
> newer versions!
>
> If you can do that, you can now recreate the missing object with

Ok, tried that and unfortuantly the SHA1 number is apear only one

[mellanox@mellanox-compile ib]$ git log --raw --all --full-history --
SymmK/St.c  | grep 4b9
:100755 100755 308806c... 4b9458b3786228369c63936db65827de3cc06200 M
 SymmK/St.c

git log --raw --all --full-history -- SymmK/St.c

...
...
commit 597e70e7dc8e06a7cdbe4d9e9727411c964bd023
Author: sleybo <sleybo@mellanox.co.il>
Date:   Fri Oct 5 10:41:43 2007 -0400

    1. increase QPs parameters - QP is bigger than 4k
    2. lock buffers use the dma key
    3. add prints

:100755 100755 308806c... 4b9458b3786228369c63936db65827de3cc06200 M
 SymmK/St.c


What intersting is that the SHA1 that I looked for apear only once
(only as new SHA1)

So I checkout version of the file which produce the old SHA1 308806c....

[mellanox@mellanox-compile ib-tmp]$ git checkout mlx4-start -- SymmK/St.c
[mellanox@mellanox-compile ib-tmp]$  git hash-object -w SymmK/St.c
308806cf3a864656a49d00edc35b9505abd627a2

than I did
[mellanox@mellanox-compile ib-tmp]$ git diff-tree --stdin -p --pretty
597e70e7dc8e06a7cdbe4d9e9727411c964bd023  > commit-597e70e

( which is the commit SHA1)

[mellanox@mellanox-compile ib-tmp]$ git apply commit-597e70e
Adds trailing whitespace.
../ib/commit-597e70e:1622:
Adds trailing whitespace.
../ib/commit-597e70e:1646:                      (int)devif->lock_dma +
lockid*sizeof(u64),
warning: 2 lines add whitespace errors.
[mellanox@mellanox-compile ib-tmp]$  git hash-object -w SymmK/St.c
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391


So the same commit actual lead to the wrong SHA1
(I tried this flow on different file and it works)

I think I am close but still not there , any suggestions ?

Thanks
Yossi
