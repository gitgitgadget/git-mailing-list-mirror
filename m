From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git-svn clone -- runs out of memory
Date: Wed, 19 May 2010 16:33:41 +0000
Message-ID: <AANLkTimm_9Ks3adWqXpVBbY6osLl_3c029x8eMI5tb1M@mail.gmail.com>
References: <F47FB1C2-3EEB-475C-8874-CBEC45582386@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jack Moore <jhmoore719@verizon.net>
X-From: git-owner@vger.kernel.org Wed May 19 18:34:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEmDa-0006Rq-LS
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 18:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab0ESQd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 May 2010 12:33:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45607 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab0ESQd5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 May 2010 12:33:57 -0400
Received: by iwn6 with SMTP id 6so3154503iwn.19
        for <git@vger.kernel.org>; Wed, 19 May 2010 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Mnh7fOQPJu6KLaK54HhjwcJYNXyAmwVLYj3vq2+wl1A=;
        b=oCXGLwUCohWkB2rUGdLmPiN3m3DEs7jrz8RNvL8qUhSelQfNLsyEuH0JvlMxhNMKdY
         uihc+XnT03xPZvh7hXMVaWLOUdocdJdu4LIWydiH/vJNinGFBdO6W7A4+19klN0PRlwE
         Iy9lH3f1f5Io09rQxfCk0qpHt1cF8dvbkYIeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vCjvi5djoZMQh2wpzHAehiMTh8d7xAT/ucoW+YyIDxf6Lw/c17JFor3a3d5rsteYP8
         hcnyY6gygs0W/ePInoXBnf0nn/pgHAtK/bu8LRn/nfnrMCLA+Uz6QnXwUAvaUlhlzSh9
         k6sESD0JM2MMlwjf/4VAWqkKVXZ1f1XcWEbm4=
Received: by 10.231.168.129 with SMTP id u1mr3829153iby.49.1274286821549; Wed, 
	19 May 2010 09:33:41 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 19 May 2010 09:33:41 -0700 (PDT)
In-Reply-To: <F47FB1C2-3EEB-475C-8874-CBEC45582386@verizon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147333>

On Wed, May 19, 2010 at 05:51, Jack Moore <jhmoore719@verizon.net> wrot=
e:

> When I "git-svn clone" the repository it takes about 30 hour (yes
> hours) =C2=A0to (appears to) retrieve the files.

That's relatively short actually with git-svn. I've taken 3 weeks to
clone one large (~70k revisions + lots of branches) repository, and
that was via local file:// access.

> Then git goes into either a packing or garbage collecting phase and
> eventually runs out of memory. =C2=A0I get an error relating to "mmap
> ... out of memory". =C2=A0When it runs out of memory the "cloned"
> repository is ~2.4 GBi.

This could be one of a few things:

  * git-svn leaks *lots* of memory.

    The solution is to just kill it and restart it every few
    hours. After it's killed run `git svn fetch`. You should be doing
    this anyway on any clone that takes >1 hour, aside from leaking
    memory it gets a lot slower.

  * The known problem with some git utilities doing things in-memory.

    If that's the case the solution is to just add lots of swap (or
    patch the core).

  * Something I'm forgetting

In any case, run it with GIT_TRACE=3D1 so you can see what command is
the one that failed.
