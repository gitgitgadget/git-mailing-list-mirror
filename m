From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.mak.uname: Cygwin: Use renames for creation
Date: Mon, 10 Aug 2015 12:08:29 -0700
Message-ID: <xmqqwpx3t102.fsf@gitster.dls.corp.google.com>
References: <1438979428-5888-1-git-send-email-adam@dinwoodie.org>
	<55C66AF2.3060706@gmail.com>
	<20150808210627.GB155450@vauxhall.crustytoothpaste.net>
	<CA+kUOa=KRBSKDqWUj2RiO45PqVYGmN+yqG426jtUoXayxGkduw@mail.gmail.com>
	<058a7756ada2fa5043ca9b910d6e1543@www.dscho.org>
	<55C7883C.7040504@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Adam Dinwoodie <adam@dinwoodie.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 21:08:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOsR2-0008NM-KA
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 21:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbbHJTIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 15:08:32 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35372 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932456AbbHJTIb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 15:08:31 -0400
Received: by pacgr6 with SMTP id gr6so32806101pac.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qYHvc0lRYEZzCzKaK4i0RLFLeXDgJ60hwlGcAFO7MoI=;
        b=mSSVgTl3k3OGpm4+UpL6LC61ytG6Y/5dR8dZjOTsMDwR6BLqfH+mLWOq42RjOqHpT7
         gSGTI4O3tk+KlKbNkGgtxpVxgi+eJHTzPkFMYvXRj2GOjCFgEojZXkgo7A01zXmBF5dq
         uEFt7hmC/U2q08GYigWXQKZSUJhHJL3zOYXhiSf4lv7IRZ0uPOIZjWmxr5uWp0/eIAGv
         13qIx5NBlF2LuFGDv9RrV2460SlMpEDCv1S9WXJlB3z/lbZoMjOTbKfyXu8Q5LobRgsf
         NLyJoyaD7g495zXAYdD8iXgiGCowYk9Ff7EGLNAuXrcy8ahvuQCXZDE+s+04jDazAQMJ
         0bDQ==
X-Received: by 10.68.57.170 with SMTP id j10mr47890724pbq.56.1439233710517;
        Mon, 10 Aug 2015 12:08:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id oc2sm20859544pdb.45.2015.08.10.12.08.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 12:08:29 -0700 (PDT)
In-Reply-To: <55C7883C.7040504@dinwoodie.org> (Adam Dinwoodie's message of
	"Sun, 09 Aug 2015 18:05:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275649>

Adam Dinwoodie <adam@dinwoodie.org> writes:

> If the desired goal is that Cygwin's link(2) acts like POSIX link(2)
> on network drives, I'm not convinced that's possible, at least not by
> emulating `core.createObject = rename` in the Cygwin library
> layer.

The way core.createObject=rename makes things work is by avoiding
link(2) in the first place and using rename(2) instead.  You might
be able to emulate rename(2) of A to B by doing a link(2) of A to B
and then unlink(2) of A, but I do not think it is reasonable for the
system call emulation layer to detect a sequence of link followed by
unlink and use rename, i.e. emulationg the other way around.

So I suspect "fix in Cygwin" is a non-starter.

But in the end, I'd prefer the choice of the compiled-in default up
to the port maintainers.  You earlier said:

    This problem was reported on the Cygwin mailing list at
    https://cygwin.com/ml/cygwin/2015-08/msg00102.html (amongst others) and
    is being applied as a manual patch to the Cygwin builds until the patch
    is taken here.

so my preference is to see Cygwin continue to do so for a couple
release cycles of ours to make sure all Cygwin end-users are happy
and consider the flip of the default a good change for them, and
then the official Cygwin packager of Git sends a patch our way.

https://cygwin.com/ml/cygwin/2015-08/msg00102.html seems to indicate
that somebody called Adam Dinwoodie is wearing Git maintainer hat,
so perhaps you may be that "official Cygwin packager of Git" ;-)

I agree with everything you said in that message to Peter---the
patch should be included when you hear reports of `git config
core.createObject rename` helping more people.  After versions of
Cygwin Git package with such a change proves good, let's reduce the
workload of Cygwin Git maintainer by upstreaming that change to my
tree.  But not before.

Thanks.
