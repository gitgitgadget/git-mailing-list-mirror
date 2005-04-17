From: Paul Jackson <pj@sgi.com>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sat, 16 Apr 2005 17:02:21 -0700
Organization: SGI
Message-ID: <20050416170221.38b3e66c.pj@sgi.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
	<20050416233724.GP19099@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 01:59:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMxCO-0006XZ-TQ
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVDQADR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 20:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVDQADR
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 20:03:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2520 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261209AbVDQADN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 20:03:13 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H1gXrq010521;
	Sat, 16 Apr 2005 18:42:43 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H02PlU15250906;
	Sat, 16 Apr 2005 17:02:26 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050416233724.GP19099@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> And racy. And not guaranteed to come up with fresh new files.

In theory perhaps.  In practice no.

Even mktemp(1) can collide, in theory, since there is no practical way
in shell scripts to hold open and locked the file from the instant of it
is determined to be a unique name.

The window of vulnerability for shell script tmp files is the lifetime
of the script - while the file sits there unlocked.  Anyone else with
permissions can mess with it.

More people will fail, and are already failing, using mktemp than I have
ever seen using $$ (I've never seen a documented case, and since such
files are not writable to other user accounts, such a collision would
typically not go hidden.)

Fast, simple portable solutions that work win over solutions with some
theoretical advantage that don't matter in practice, but also that are
less portable or less efficient.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
