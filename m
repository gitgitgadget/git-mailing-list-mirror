From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] receive-pack: support push-to-checkout hook
Date: Tue, 2 Dec 2014 17:45:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412021744490.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info> <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com> <xmqq389qam25.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info> <xmqqzjbw47vr.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info>
 <xmqqh9y32e36.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info> <xmqq4mu2285w.fsf@gitster.dls.corp.google.com> <xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com> <xmqq1tp643yb.fsf@gitster.dls.corp.google.com>
 <xmqqa936ohs3.fsf@gitster.dls.corp.google.com> <xmqq61duohq7.fsf_-_@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412020929420.13845@s15462909.onlinehome-server.info> <xmqqtx1em2fu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:46:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvqaN-0002rf-HG
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 17:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbaLBQpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 11:45:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:55773 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932236AbaLBQpy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 11:45:54 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LxPuE-1XyMn13QqI-0170bc;
 Tue, 02 Dec 2014 17:45:49 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqtx1em2fu.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:GPNTVFpKh+ovk78LBM/OkG7Wve+JcZzXl2eX4IO+xTOj4IvULSN
 OVljoZiotB9y+dUNVH8oWatIeQMQAxf2tN9VR8WsdqOvhPuVpOUYXt84q2fvs3v86uLzIud
 UD92n/k/LAQa9ONzEe3qQ8DHNIkfZQix5hY49/We77JYPTtHR5R2tqMojVDlmW3U4cGfR8l
 ulz7zAvWVGSxarfo2etOw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260574>

Hi Junio,

On Tue, 2 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > In this particular case, I think that we really, really *just* need to
> > verify that the presence of the hook switches off the default behavior of
> > updateInstead. *Nothing* else is needed to verify that this particular
> > functionality hasn't regressed. I.e. something like:
> >
> > +test_expect_success 'updateInstead with push-to-checkout hook' '
> > +	rm -fr testrepo &&
> > +	git clone . testrepo &&
> > +	(
> > +		cd testrepo &&
> > +		echo unclean > path1 &&
> > +		git config receive.denyCurrentBranch updateInstead &&
> > +		echo 'touch yep' | write_script .git/hooks/push-to-checkout
> > +	) &&
> > +	git push testrepo HEAD^:refs/heads/master &&
> > +	test unclean = $(cat testrepo/path1) &&
> > +	test -f testrepo/yep
> > +'
> >
> > would be more appropriate (although it probably has one or three bugs,
> > given that I wrote this in the mailer).
> 
> Not really.  You need to remember that we write tests not to show
> off the new shiny, but to protect essential invariants from being
> broken by careless others attempting to rewrite the implementation
> in the future.

Fair enough. You are the boss.

I am not, therefore it does not matter what I think,
Johannes
