From: Ingo Molnar <mingo@elte.hu>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 18:59:54 +0200
Message-ID: <20081012165954.GA2317@elte.hu>
References: <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com> <20081012152427.GA4607@elte.hu> <20081012153952.GV10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Wang Chen <wangchen@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Oct 12 19:01:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp4K1-0006Oh-47
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 19:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbYJLRAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 13:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754246AbYJLRAZ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 13:00:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49974 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108AbYJLRAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 13:00:24 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1Kp4IQ-000677-2c
	from <mingo@elte.hu>; Sun, 12 Oct 2008 19:00:02 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 205473E21A3; Sun, 12 Oct 2008 18:59:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081012153952.GV10544@machine.or.cz>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00,DNS_FROM_SECURITYSAGE autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 DNS_FROM_SECURITYSAGE  RBL: Envelope sender in
	blackholes.securitysage.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98037>


* Petr Baudis <pasky@suse.cz> wrote:

> On Sun, Oct 12, 2008 at 05:24:27PM +0200, Ingo Molnar wrote:
> > hm, -tip's .git/hooks/post-update already contained this, for the last 2 
> > months:
> > 
> >   exec git update-server-info
> > 
> > so ... _despite_ us having this in the git repo, the HTTP protocol still 
> > does not work. Why?
> 
> I think your problem is that HTTP does not know where to look for
> objects coming from alternates; IIRC this would work if you used
> relative paths in objects/info/alternates, or you can create
> objects/info/http-alternates like
> 
> 	/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
> 	/pub/scm/linux/kernel/git/sfr/linux-next.git/objects

ok, i've now set it up like this:

 $ pwd
 /pub/scm/linux/kernel/git/x86/linux-2.6-tip.git

 $ cat objects/info/alternates
 /home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
 /home/ftp/pub/scm/linux/kernel/git/sfr/linux-next.git/objects

 $ cat objects/info/http-alternates
 /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
 /pub/scm/linux/kernel/git/sfr/linux-next.git/objects

and i've added "git update-server-info" to hooks/post-receive and made 
it chmod +x.

that should be golden, right? I'm wondering why this isnt in the default 
setup - i've been behind a limited corporate firewall in a former life 
and having HTTP access is indeed very handy and pragmatic. Often hotel 
WLANs are HTTP only as well.

Soapbox: in fact it would be outright stupid to limit the kernel 
source's availability artificially by not making HTTP a tier-one access 
method.

Fighting against HTTP-only firewalls is like constantly pointing it out 
to the popular press that they should say 'cracker' instead of 'hacker'. 
It is pointless and only hurts the availability our own project.
	
	Ingo
