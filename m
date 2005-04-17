From: Paul Jackson <pj@sgi.com>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sat, 16 Apr 2005 17:44:09 -0700
Organization: SGI
Message-ID: <20050416174409.59f94c26.pj@sgi.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
	<20050416233724.GP19099@pasky.ji.cz>
	<20050416170221.38b3e66c.pj@sgi.com>
	<20050417003325.GA15608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 02:42:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMxrJ-0000Va-24
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVDQApg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 20:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVDQApf
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 20:45:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49122 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261224AbVDQAp2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 20:45:28 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H2ONxf018343;
	Sat, 16 Apr 2005 19:24:33 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H0iDlU15254075;
	Sat, 16 Apr 2005 17:44:16 -0700 (PDT)
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050417003325.GA15608@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dave wrote:
> mktemp is being used here to provide randomness in the filename,
> not just a uniqueness.

Ok - useful point.

How about:

	t=${TMPDIR:-/usr/tmp}/gitdiff.$$.$RANDOM

> all an attacker has to do is create 65535 symlinks in /usr/tmp

And how about if I removed the tmp files at the top:

	t=${TMPDIR:-/usr/tmp}/gitdiff.$$.$RANDOM
	trap 'rm -fr $t.?; trap 0; exit 0' 0 1 2 3 15
	rm -fr $t.?

	... rest of script ...

How close does that come to providing the same level of safety, while
remaining portable over a wider range of systems, and not requiring that
a separate command be forked?

> I'd suggest fixing your distributions ...

It's not just my distro; it's the distros of all git users.

If apps can avoid depending on inessential details of their
environment, that's friendlier to all concerned.

And actually my distro is fine - it's just that I am running an old
version of it on one of my systems.  Newer versions of the mktemp -t
option.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
