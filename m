From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up hard
 right after logging in)
Date: Thu, 12 May 2011 10:37:53 -0700
Message-ID: <BANLkTi=YDZa+BRaG90vJsjrT9VxgySrDRQ@mail.gmail.com>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	git@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
X-From: git-owner@vger.kernel.org Thu May 12 19:39:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKZqx-0002aq-57
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 19:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758294Ab1ELRit convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2011 13:38:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35403 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758281Ab1ELRiq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 13:38:46 -0400
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p4CHcFpJ032410
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL);
	Thu, 12 May 2011 10:38:16 -0700
Received: by ewy4 with SMTP id 4so494563ewy.19
        for <multiple recipients>; Thu, 12 May 2011 10:38:13 -0700 (PDT)
Received: by 10.14.13.66 with SMTP id a42mr289003eea.193.1305221893098; Thu,
 12 May 2011 10:38:13 -0700 (PDT)
Received: by 10.14.127.144 with HTTP; Thu, 12 May 2011 10:37:53 -0700 (PDT)
In-Reply-To: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com>
X-Spam-Status: No, hits=-102.977 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173488>

On Thu, May 12, 2011 at 10:15 AM, Andrew Lutomirski <luto@mit.edu> wrot=
e:
>
> OK, this sucks. =A0In the course of bisecting this, I've hit two othe=
r
> apparently unrelated bugs that prevent my from testing large numbers
> of kernels. =A0Do I have two questions:
>
> 1. Anyone have any ideas from looking at the log?

Nope, that doesn't look very helpful.

> 2. =A0The !&$#@ bisection is skipping all over the place. =A0I've see=
n
> 2.6.37 versions and all manner of -rc's out of order.

That's the _point_ of bisection. It jumps around. You can start off
trying to pick points on my development tree, but I only have a
hundred merges or so. You're going to start delving into the actual
development versions very quickly. And if you don't do it early,
bisection is going to be much much slower, because it's not going to
pick half-way points.

So bisection works so well exactly because it picks points that are
far away from each other, and you should just totally ignore the
version number. It's meaningless. Looking at it just confuses you.
Don't do it.

Now, "pick stable points" would obviously be nice, but that is going
to have to be manual. You can certainly make some helper scripts, and
that's where that "--first-parent" thing comes in. So if you want to,
just use "git bisect reset" to the commit you want to test.

If you think it's networking, for example, and you've bisected into
there but aren't sure, do "gitk --bisect", find the point where I
merge, and pick that (and my parent), and "git bisect reset" those
points. That way you can verify that it's the networking merge (or
verify that it isn't).

                         Linus
