From: Dave Jones <davej@redhat.com>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sat, 16 Apr 2005 20:57:57 -0400
Message-ID: <20050417005757.GB15608@redhat.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com> <20050416233724.GP19099@pasky.ji.cz> <20050416170221.38b3e66c.pj@sgi.com> <20050417003325.GA15608@redhat.com> <20050416174409.59f94c26.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@ucw.cz, git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 02:55:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMy3Y-00015g-Jb
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVDQA6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 20:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVDQA6J
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 20:58:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28591 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261226AbVDQA6F (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 20:58:05 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j3H0vvMO019491;
	Sat, 16 Apr 2005 20:57:57 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j3H0vvO08986;
	Sat, 16 Apr 2005 20:57:57 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j3H0vvDI023469;
	Sat, 16 Apr 2005 20:57:57 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j3H0vvIU023467;
	Sat, 16 Apr 2005 20:57:57 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050416174409.59f94c26.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 16, 2005 at 05:44:09PM -0700, Paul Jackson wrote:
 > Dave wrote:
 > > mktemp is being used here to provide randomness in the filename,
 > > not just a uniqueness.
 > 
 > Ok - useful point.
 > 
 > How about:
 > 
 > 	t=${TMPDIR:-/usr/tmp}/gitdiff.$$.$RANDOM

pid is still predictable by watching ps output, $RANDOM is one of 32768
numbers, so it's still feasable to predict the result.
$RANDOM$RANDOM is better, and gets a little closer to mktemp strength randomness.

 > > all an attacker has to do is create 65535 symlinks in /usr/tmp
 > And how about if I removed the tmp files at the top:
 > 
 > 	t=${TMPDIR:-/usr/tmp}/gitdiff.$$.$RANDOM
 > 	trap 'rm -fr $t.?; trap 0; exit 0' 0 1 2 3 15
 > 	rm -fr $t.?
 > 
 > 	... rest of script ...

Racy, though the chance of creating x thousand symlinks in such a small
window probably makes it a non-issue.

Actually.. http://www.linuxsecurity.com/content/view/115462/151/
has some interesting bits on temp dir creation without mktemp.
See section 3.4 onwards.

		Dave

