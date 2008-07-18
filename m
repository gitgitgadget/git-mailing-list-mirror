From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed repositories
Date: Fri, 18 Jul 2008 10:36:51 +0100
Message-ID: <320075ff0807180236u4e7f5f9bm81b702d14c052de8@mail.gmail.com>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
	 <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com>
	 <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com>
	 <alpine.DEB.1.00.0807171351380.8986@racer>
	 <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com>
	 <alpine.DEB.1.00.0807171513560.8986@racer>
	 <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com>
	 <20080717182253.GZ32184@machine.or.cz>
	 <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com>
	 <20080718091608.GL10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:37:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJmPU-0006KC-48
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbYGRJgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbYGRJgy
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:36:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:61360 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbYGRJgy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:36:54 -0400
Received: by yw-out-2324.google.com with SMTP id 9so85338ywe.1
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mogiBly71ktqFci7uT6PXvXcd08NTfipUE11cggrdow=;
        b=U8ekYY+owwc8G97ycWX7pFo9pkgVyXGAjzqpr4hO3XcSSzIPF0ANpF4uxg96dGMOzu
         lEQR+dcvoMOtbBDdKfN0A8JnXrX7cIG0JweoJFqTN2kbs4VtvkhUCG3PgqvQWK5ZUGm7
         Z+PC7LvJxsOYzaCCoiTvpCojHiHefvULBss/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EaQbjO9izWDFAJ4sHtaGNcKNG3Z/t40SPsHnCJt/Xj0JRQ0ES8Z/VgRbyuGsbR1ub1
         Ef/S8GjxqA7RpWvSYQvdG2RZr5p0I81dIv4J3IRmCrZQTal5LG5T/40sycWLyrVKvh5L
         4tfl4P15m4CAgQTII66ioukx0qgHbSbmcCW60=
Received: by 10.102.228.10 with SMTP id a10mr2789173muh.109.1216373811888;
        Fri, 18 Jul 2008 02:36:51 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Fri, 18 Jul 2008 02:36:51 -0700 (PDT)
In-Reply-To: <20080718091608.GL10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89020>

On Fri, Jul 18, 2008 at 10:16 AM, Petr Baudis <pasky@suse.cz> wrote:
> snip
>
>        "How do we mass-supply custom submodule URLs when publishing the
>        customized main repository at a custom location too?"
>
Yes - that is an additional problem.

If I may expand the usecase just so it's clear (and to check we're
talkiing the same language)

I do something like
$ git remote add fred git://fredcomputer/superproject/.git
$ git fetch --submodules fred

And when the recursive fetching enters a submodule, it is trying
itself to do something like
$ git fetch fred

At which point
1) the submodule also has a remote specified for fred. In which case
it can continue
2) the submodule doesn't have remote specified for fred. How to solve
this case? (I.E how does 'my' git 'discover' where fred's git
repositories are for the submodules?)
 a) By getting some information from fred, either in *Fred's*
superproject .git/config (or some other readable file)
 b) By reading some information out of the superproject .gitmodules
that has been fetched from fred
 c) By calculating a relative URL based on the supposition that fred
has working copies laid out in the filesystem.

I was tentatively suggesing (c), with a backup of (a) for the minority
cases where you weren't pulling from a person but from a mirror or
something. Having the client edit config files just feels like a hack
to me, regardless of whether scripts are enabled to do it.
