From: Dave Jones <davej@redhat.com>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sat, 16 Apr 2005 20:33:25 -0400
Message-ID: <20050417003325.GA15608@redhat.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com> <20050416233724.GP19099@pasky.ji.cz> <20050416170221.38b3e66c.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 02:30:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMxfZ-0008KV-PA
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVDQAdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 20:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVDQAdc
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 20:33:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39337 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261218AbVDQAd2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 20:33:28 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j3H0XPvY016184;
	Sat, 16 Apr 2005 20:33:25 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j3H0XPO06901;
	Sat, 16 Apr 2005 20:33:25 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j3H0XPSo020020;
	Sat, 16 Apr 2005 20:33:25 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j3H0XPHv020018;
	Sat, 16 Apr 2005 20:33:25 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050416170221.38b3e66c.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 16, 2005 at 05:02:21PM -0700, Paul Jackson wrote:
 > > And racy. And not guaranteed to come up with fresh new files.
 > 
 > In theory perhaps.  In practice no.
 > 
 > Even mktemp(1) can collide, in theory, since there is no practical way
 > in shell scripts to hold open and locked the file from the instant of it
 > is determined to be a unique name.

Using the pid as a 'random' number is a bad idea. all an attacker
has to do is create 65535 symlinks in /usr/tmp, and he can now
overwrite any file you own.

mktemp is being used here to provide randomness in the filename,
not just a uniqueness.

 > The window of vulnerability for shell script tmp files is the lifetime
 > of the script - while the file sits there unlocked.  Anyone else with
 > permissions can mess with it.

Attacker doesnt need to touch the script. Just take advantage of
flaws in it, and wait for someone to run it.

 > More people will fail, and are already failing, using mktemp than I have
 > ever seen using $$ (I've never seen a documented case, and since such
 > files are not writable to other user accounts, such a collision would
 > typically not go hidden.)
 > 
 > Fast, simple portable solutions that work win over solutions with some
 > theoretical advantage that don't matter in practice, but also that are
 > less portable or less efficient.

I'd suggest fixing your distributions mktemp over going with an
inferior solution.

		Dave

