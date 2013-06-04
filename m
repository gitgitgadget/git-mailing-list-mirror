From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Tue, 4 Jun 2013 21:17:17 +1000
Message-ID: <20130604111717.GA306@book.hvoigt.net>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org> <51A7A73C.6070103@web.de> <20130531194051.GC1072@serenity.lan> <51AD0EEB.4020106@web.de> <20130603222341.GL1072@serenity.lan> <20130604052950.GA2943@book.hvoigt.net> <20130604081045.GM1072@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jun 04 13:17:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjpFD-00048N-PB
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 13:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab3FDLRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 07:17:36 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.100]:53539 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3FDLRe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 07:17:34 -0400
Received: from [211.30.231.44] (helo=book.hvoigt.net)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UjpF1-0007nQ-Pw; Tue, 04 Jun 2013 13:17:29 +0200
Content-Disposition: inline
In-Reply-To: <20130604081045.GM1072@serenity.lan>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226341>

On Tue, Jun 04, 2013 at 09:10:45AM +0100, John Keeping wrote:
> On Tue, Jun 04, 2013 at 03:29:51PM +1000, Heiko Voigt wrote:
> > On Mon, Jun 03, 2013 at 11:23:41PM +0100, John Keeping wrote:
> > > > Sorry, I should have been more specific here. I saw that you did some
> > > > changes to make "submodule add" do the right thing with relative paths,
> > > > but the following change to t7406 does not work like I believe it
> > > > should but instead makes the test fail:
> > > > -------------------8<---------------------
> > > > diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> > > > index a4ffea0..9766b9e 100755
> > > > --- a/t/t7406-submodule-update.sh
> > > > +++ b/t/t7406-submodule-update.sh
> > > > @@ -559,7 +559,9 @@ test_expect_success 'add different submodules to the same pa
> > > >  test_expect_success 'submodule add places git-dir in superprojects git-dir' '
> > > >         (cd super &&
> > > >          mkdir deeper &&
> > > > -        git submodule add ../submodule deeper/submodule &&
> > > > +        (cd deeper &&
> > > > +         git submodule add ../../submodule submodule
> > > > +        ) &&
> > > >          (cd deeper/submodule &&
> > > >           git log > ../../expected
> > > >          ) &&
> > > > -------------------8<---------------------
> > > 
> > > Ah, ok.  I think this case is problematic because the repository
> > > argument is either relative to "remote.origin.url" or to the top of the
> > > working tree if there is no "origin" remote.  I wonder if we should just
> > > die when a relative path is given for the repository and we're not at
> > > the top of the working tree.
> > 
> > Why not behave as if we are at the top of the working tree for relative
> > paths? If there is an origin remote thats fine. If there is no origin
> > remote you could warn that the path used is taken relative from the root
> > of the superproject during add. What do you think?
> 
> That's what the patch currently queued on "pu" does, which Jens wants to
> change, isn't it?

True I did not realize this when reading it the first time. But I think
we should still not die when in a subdirectory. After all this series is
trying to archive that the submodule command works in subdirectories
seamlessly right? So you probably want to translate a relative path
without "origin" remote given from a subdirectory to the superproject
level and use that. Then you do not have to die.

Cheers Heiko
