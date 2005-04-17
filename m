From: Paul Jackson <pj@sgi.com>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sat, 16 Apr 2005 18:15:30 -0700
Organization: SGI
Message-ID: <20050416181530.6ccd569b.pj@sgi.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
	<20050416233724.GP19099@pasky.ji.cz>
	<20050416170221.38b3e66c.pj@sgi.com>
	<20050417003325.GA15608@redhat.com>
	<20050416174409.59f94c26.pj@sgi.com>
	<20050417005757.GB15608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 03:12:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMyKe-0002OX-SQ
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 03:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVDQBP4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 21:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVDQBP4
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 21:15:56 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4244 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261232AbVDQBPt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 21:15:49 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H1dALU029286;
	Sat, 16 Apr 2005 18:39:10 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H1FZlU15243101;
	Sat, 16 Apr 2005 18:15:38 -0700 (PDT)
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050417005757.GB15608@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dave wrote:
> http://www.linuxsecurity.com/content/view/115462/151/

Nice - thanks.

Pasky - would you be interested in a patch that used a more robust tmp
file creation, along the lines of replacing

	t=${TMPDIR:-/usr/tmp}/gitdiff.$$
	trap 'set +f; rm -fr $t.?; trap 0; exit 0' 0 1 2 3 15

with:

	tmp=${TMPDIR-/tmp}
	tmp=$tmp/gitdiff-do.$RANDOM.$RANDOM.$RANDOM.$$
	(umask 077 && mkdir $tmp) || {
		echo "Could not create temporary directory! Exiting." 1>&2 
		exit 1
	}
	t=$tmp/tmp
	trap 'rm -fr $tmp; trap 0; exit 0' 0 1 2 3 15

If interested, would you want it instead of my previous mktemp removal
patch, or on top of it?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
