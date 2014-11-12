From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore
 submodules
Date: Wed, 12 Nov 2014 12:09:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de> <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
 <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com> <xmqq389qam25.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 12:09:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoVng-0007rj-HZ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 12:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbaKLLJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 06:09:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:60525 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598AbaKLLJU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 06:09:20 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0Mdr7l-1XeNIU0953-00Pgsd;
 Wed, 12 Nov 2014 12:09:15 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq389qam25.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:gevmcZfn/H2zmbL+zYGY2iu/1jGiepS4ygZnhHkqHKu8fGOjYJE
 Oru+GChFmRm7lJBBHKPaU0SFh75ypN01zO908rSz8HEHmD9MKkFaoTVtsyRGm2iUixfx40Z
 sqqXYVx9bbVvBXPBl5Oe13QBYM/LRsov8SNrO65feftx7HYLh+aQ0dM1dO8C5qyE3iD5ZiW
 PLq/sR7wQjC/QH3KSBNuw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 10 Nov 2014, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Dying when "update-index --refresh" signals a difference is an
> > attempt to mimic #1, but it is in line with the spirit of the reason
> > why a user would want to use updateInstead, I think.  The situation
> > is more like the person who pushed into your repository from
> > sideline did a "checkout -B $current_branch $new_commit" to update
> > the HEAD, the index and the working tree, to let you pretend as if
> > you based your work on the commit he pushed to you.
> >
> > While you still need to error out when your local work does not
> > satisfy the cleanliness criteria #3 above, I do not think you would
> > want to stop the operation when "checkout" would not fail, e.g. you
> > have a local change that does not interfere with the update between
> > the two commits, with this one:
> >
> > +	if (run_command(&child))
> > +		die ("Could not refresh the index");
> >
> > When refreshed the index successfully, we signal that there were
> > differences between the index and the working tree with a non-zero
> > return value, so "Could not refresh" is not quite right, either.
> 
> Just to make sure.  I am *not* saying that you do not need to run
> "update-index --refresh".  It is necessary before running read-tree
> to avoid false dirtyness, so you do need to run it.
> 
> I am only saying that it is too strict to fail the operation when
> the command reports that you have a local modification in the
> working tree.

Okay, now I am even more puzzled. I guess you actually meant to say that I
need to convert the die() into a return? If so, I agree fully.

Ciao,
Johannes
