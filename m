From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Thu, 2 Jan 2014 21:42:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1401022135030.1191@s15462909.onlinehome-server.info>
References: <52C5A039.6030408@gmail.com> <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info> <xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 21:42:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyp6B-0003Rh-32
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 21:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbaABUmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 15:42:31 -0500
Received: from mout.gmx.net ([212.227.17.20]:50751 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbaABUmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 15:42:31 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0Mecqq-1VnlQT3k2y-00ODyR
 for <git@vger.kernel.org>; Thu, 02 Jan 2014 21:42:29 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:KWR+x5A7iDGP78ldl1smeS3l91BAxRIMQsqLorI6lmbWpRKmsmB
 YbH96pKKAISYrPmtD/q23fViftT1eZkqkd1Roz82jFIkTMkq+XjUjkmOMG5kqcgJ9xrryFX
 beQv4Ic9S8Jxi9EYupskrP3Fk7l9ARIdwwUyBLX5YBIhvof3vezbcdYcNs/F6I4z6NpBrDn
 Pk20kpMo17H1KvI7R49lw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239874>

Hi Junio,

On Thu, 2 Jan 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 2 Jan 2014, Sebastian Schuberth wrote:
> >
> >> See https://github.com/msysgit/git/pull/80.
> >
> > Thanks Sebastian!
> >
> > However, since the git.git project is not comfortable with the concept
> > of pull requests (which is why you submitted this patch via mail), I
> > believe that we have to explain the rationale in the commit message.
> > So here goes my attempt:
> 
> Thanks; the conclusion is correct --- you need a good commit message in
> the recorded history.  That does not have anything to do with
> integrating with pulling from subsystem maintainers, which we regularly
> do.

I should have pointed out that I was talking about the concept of pull
requests, not the concept of accepting pull requests from dedicated
subsystem maintainers.

> > On Linux, we can get away with assuming that the directory separator
> > is a forward slash, but that is wrong in general. For that purpose,
> > the is_dir_sep() function was introduced a long time ago. By using it
> > in safe_create_leading_directories(), we proof said function for use
> > on platforms where the directory separator is different from Linux'.
> 
> Perhaps with s|Linux|POSIX|,

No, for two reasons:

* OpenVMS supports POSIX, yes? And OpenVMS does not have the forward slash
  as directory separator but instead the dot, yes?

* it would be dishonest. The reason is not that we looked at the POSIX
  standard when we determined how to implement
  safe_create_leading_directories(), but at Linux.

> but more importantly, was there a specific error scenario that triggered
> this change?

Yes, the concrete use case that triggered the pull request whose change we
did not accept but instead would prefer Sebastian's patch is where a user
called

	git clone <URL> C:\directory

in cmd.exe.

Ciao,
Johannes
