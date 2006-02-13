From: Andrew Morton <akpm@osdl.org>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 02:19:17 -0800
Message-ID: <20060213021917.742b2b10.akpm@osdl.org>
References: <20060213002502.5c23122c.akpm@osdl.org>
	<7virrj1v44.fsf@assigned-by-dhcp.cox.net>
	<20060213013205.4ba47836.akpm@osdl.org>
	<7vbqxb1sho.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 11:20:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8aoZ-0007nG-T6
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 11:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWBMKUM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 05:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbWBMKUM
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 05:20:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751715AbWBMKUK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 05:20:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1DAK6DZ023132
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 02:20:07 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1DAK6AW012735;
	Mon, 13 Feb 2006 02:20:06 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqxb1sho.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16064>

Junio C Hamano <junkio@cox.net> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> >> As humans, we can tell that it is not very plausible that the
> >>  EXTRAVERSION change caused whatever breakage you are chasing,
> >>  but sorry, from your log, I think bisect is doing the right
> >>  thing.
> >
> > I don't think humans are well-suited to using git.
> 
> I did not mean that ;-).  Git is not as smart as humans.
> 
> > My current theory is that I was bisecting Linus's tree all along.
> 
> Sorry, I did not realize that was _not_ what you were doing.
> Your log started by saying 2.6.16-rc1 is good but 2.6.16-rc2 was
> not, so I just assumed your bug was between those two.
> 
> If your suspect was merged between these two versions, then it
> does not matter which branch you were _on_ when you started to
> bisect.  
> 
> You mark points that are good and bad, and wander around in the
> commit DAG, trying to narrow down the distance between known
> good points and bad points while bisecting, and during that, you
> are not really on _any_ branch.

So how am I supposed to find this bug in Jeff's tree?

I do git-checkout -f git-netdev-all, then do the bisection and I come up
with junk.

<does it all again>

It points at this:

commit a03b1950521466e007288a25c9fc7ac7f05a97e5
Merge: 0b310f36d7d96e27f6941ec0f9b95e15142f1e78 c6f0d75a2defe8c7d8bf9f78de891cedc46b4b3e
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Tue Jan 31 11:52:21 2006 -0500

    Merge branch 'upstream-fixes'



git-bisect start
# good: [d834a41c966c6a20368fadb59248740935e6fbae] ipw2200: do not sleep in ipw_request_direct_scan
git-bisect good d834a41c966c6a20368fadb59248740935e6fbae
# bad: [b0afb58735e5dae05cb06ce6d0ca3073f390e9dc] Merge branch 'upstream'
git-bisect bad b0afb58735e5dae05cb06ce6d0ca3073f390e9dc
# good: [0c19585b0d2f6817dd9af607650d3f6cae2fd8bc] uml: typo fixup
git-bisect good 0c19585b0d2f6817dd9af607650d3f6cae2fd8bc
# good: [71baa1a599c04ab56ebf5fdb8d03abd0d601462f] [MIPS] Get rid of unnecessary prototypes. Fixes and optimizations for HZ > 100.
git-bisect good 71baa1a599c04ab56ebf5fdb8d03abd0d601462f
# good: [d04e4e115bd9df2b748cb30abd610f3c0eb1e303] eeh_driver NULL noise removal
git-bisect good d04e4e115bd9df2b748cb30abd610f3c0eb1e303
# good: [9908104935325bd6beba67d637b6f5396d47075c] [IPV6]: Address autoconfiguration does not work after device down/up cycle
git-bisect good 9908104935325bd6beba67d637b6f5396d47075c
# good: [0b310f36d7d96e27f6941ec0f9b95e15142f1e78] Merge branch 'upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6
git-bisect good 0b310f36d7d96e27f6941ec0f9b95e15142f1e78
# bad: [70c07e02625ec46d0ffbfce1acef42d660803528] Merge branch 'viro'
git-bisect bad 70c07e02625ec46d0ffbfce1acef42d660803528
# good: [2746b8623abce815aaae7afc946b1b39f8436f5a] Merge branch 'net.b0' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/bird
git-bisect good 2746b8623abce815aaae7afc946b1b39f8436f5a
# bad: [6bd0e10e53cc4824cd8cdaab8c370e53ab2e23c2] Merge branch 'sundance'
git-bisect bad 6bd0e10e53cc4824cd8cdaab8c370e53ab2e23c2
# bad: [3c9b3a8575b4f2551e3b5b74ffa1c3559c6338eb] Merge branch 'master'
git-bisect bad 3c9b3a8575b4f2551e3b5b74ffa1c3559c6338eb
# bad: [c0d3c0c0ce94d3db893577ae98e64414d92e49d8] [netdrvr] schedule eepro100 for removal
git-bisect bad c0d3c0c0ce94d3db893577ae98e64414d92e49d8
# bad: [a03b1950521466e007288a25c9fc7ac7f05a97e5] Merge branch 'upstream-fixes'
git-bisect bad a03b1950521466e007288a25c9fc7ac7f05a97e5
