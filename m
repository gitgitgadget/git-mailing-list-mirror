From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Fri, 23 Nov 2012 16:55:21 +0100
Message-ID: <20121123155521.GB14509@book.hvoigt.net>
References: <20121117153007.GB7695@book.hvoigt.net> <20121117192026.GI22234@odin.tremily.us> <7vd2z9t7y2.fsf@alter.siamese.dyndns.org> <20121120011628.GD321@odin.tremily.us> <7v1ufou92h.fsf@alter.siamese.dyndns.org> <20121120121912.GC7096@odin.tremily.us> <7vhaokrr01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 16:55:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbvbV-00079P-6p
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 16:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab2KWPza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 10:55:30 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:38433 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab2KWPz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 10:55:29 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Tbvb7-0002kb-TS; Fri, 23 Nov 2012 16:55:22 +0100
Content-Disposition: inline
In-Reply-To: <7vhaokrr01.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210262>

On Tue, Nov 20, 2012 at 11:52:46AM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> 
> > The superproject gitlink should only be updated after
> >
> >   $ git submodule update --pull
> >
> > A plain
> >
> >   $ git submodule update
> >
> > would still checkout the previously-recorded SHA, not the new upstream
> > tip.
> 
> Hrm, doesn't it make the "float at the tip of a branch" mode
> useless, though?

How about having a branch config option and reusing our
submodule.$name.update option for specifying whether the user wants to
always float to the tip of the branch?

1. If submodule.$name.update is pull it would checkout the specified tip.

2. If submodule.$name.update is checkout or none it would do the usual
   thing and you need to specify --pull to get the tip.

I am still a little bit undecided about an automatically crafted commit.

At $dayjob we sometimes update submodules to their tip without any
superproject changes just to make sure we use the newest version. Most
of the time the commit messages are along the lines of "updated
submodule x to master".

On one hand Junio is right that the person updating to the newest
submodule stuff has no clue what to write in this message. On the other
hand someone might as well just use this functionality to get all the
tips of all the submodules checked out. He then individually decides
which changes to take by using add but will then still use a commit
message like the one above.

So currently I am more on the "have an automatically generated
commit message" side. Its in a similar corner like merge commits, that
are also generated, for me. We could have it as the default and a
--no-commit option (like merge) for people that want to stage submodules
individually.

Cheers Heiko
