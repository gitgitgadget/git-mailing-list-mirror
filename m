From: Paul Jackson <pj@sgi.com>
Subject: Re: optimize gitdiff-do script
Date: Mon, 18 Apr 2005 08:23:34 -0700
Organization: SGI
Message-ID: <20050418082334.25359013.pj@sgi.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
	<20050416232810.23430.78712.sendpatchset@sam.engr.sgi.com>
	<20050416234344.GQ19099@pasky.ji.cz>
	<20050416171009.0bedbab4.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 17:24:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNY6S-0002Ls-6Z
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 17:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVDRP1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 11:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVDRPZI
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 11:25:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38038 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262112AbVDRPY3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 11:24:29 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3IH43f3030708;
	Mon, 18 Apr 2005 10:04:13 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3IFNdlU15729634;
	Mon, 18 Apr 2005 08:23:39 -0700 (PDT)
To: pasky@ucw.cz
In-Reply-To: <20050416171009.0bedbab4.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pasky,

Looks like a couple of questions I asked over the weekend
got lost along the way.

 1) How do you want me to fix the indentation on my patch
    to optimize gitdiff-do script:
	- forget my first patch and resend from scratch, or
	- a second patch restoring indentation, on top of my first one.

 2) Would you be interested in a patch that used a more robust tmp
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
	    trap 'rm -fr $tmp; trap 0; exit 0' 0 1 2 3 15
	    t=$tmp/tmp

    From the www.linuxsecurity.com link that Dave Jones provided, the
    above $tmp directory is about as good as using mktemp, while
    avoiding both dependency on mktemp options not everyone has.

 3) If interested in (2), would you want it instead of my previous mktemp
    removal patch, or on top of it?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
