From: John Keeping <john@keeping.me.uk>
Subject: Re: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Tue, 4 Jun 2013 09:10:45 +0100
Message-ID: <20130604081045.GM1072@serenity.lan>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
 <51A7A73C.6070103@web.de>
 <20130531194051.GC1072@serenity.lan>
 <51AD0EEB.4020106@web.de>
 <20130603222341.GL1072@serenity.lan>
 <20130604052950.GA2943@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jun 04 10:11:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjmKe-0001b8-9Y
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 10:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461Ab3FDILA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 04:11:00 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:53174 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab3FDIK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 04:10:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 8539CCDA59C;
	Tue,  4 Jun 2013 09:10:55 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oV+qsKPvqURt; Tue,  4 Jun 2013 09:10:53 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id A1C03CDA5DB;
	Tue,  4 Jun 2013 09:10:47 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130604052950.GA2943@book.hvoigt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226331>

On Tue, Jun 04, 2013 at 03:29:51PM +1000, Heiko Voigt wrote:
> On Mon, Jun 03, 2013 at 11:23:41PM +0100, John Keeping wrote:
> > > Sorry, I should have been more specific here. I saw that you did some
> > > changes to make "submodule add" do the right thing with relative paths,
> > > but the following change to t7406 does not work like I believe it
> > > should but instead makes the test fail:
> > > -------------------8<---------------------
> > > diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> > > index a4ffea0..9766b9e 100755
> > > --- a/t/t7406-submodule-update.sh
> > > +++ b/t/t7406-submodule-update.sh
> > > @@ -559,7 +559,9 @@ test_expect_success 'add different submodules to the same pa
> > >  test_expect_success 'submodule add places git-dir in superprojects git-dir' '
> > >         (cd super &&
> > >          mkdir deeper &&
> > > -        git submodule add ../submodule deeper/submodule &&
> > > +        (cd deeper &&
> > > +         git submodule add ../../submodule submodule
> > > +        ) &&
> > >          (cd deeper/submodule &&
> > >           git log > ../../expected
> > >          ) &&
> > > -------------------8<---------------------
> > 
> > Ah, ok.  I think this case is problematic because the repository
> > argument is either relative to "remote.origin.url" or to the top of the
> > working tree if there is no "origin" remote.  I wonder if we should just
> > die when a relative path is given for the repository and we're not at
> > the top of the working tree.
> 
> Why not behave as if we are at the top of the working tree for relative
> paths? If there is an origin remote thats fine. If there is no origin
> remote you could warn that the path used is taken relative from the root
> of the superproject during add. What do you think?

That's what the patch currently queued on "pu" does, which Jens wants to
change, isn't it?
