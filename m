From: Olaf Dabrunz <Olaf@Dabrunz.com>
Subject: Re: [TopGit PATCH] t/depend-add-using-export
Date: Sat, 9 Oct 2010 14:21:11 +0200
Message-ID: <20101009122111.GA29010@santana.dyndns.org>
References: <1286588598-4005-1-git-send-email-odabrunz@gmx.net>
 <AANLkTik6R89vPhwKyWOheHPkxQ9JPpmrQVmXon8Vn4+A@mail.gmail.com>
 <20101009105456.GA7328@santana.dyndns.org>
 <AANLkTi=Xhd8DY+f1ZYR6dEhHvC-=50iHLnhdv8GTacNX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olaf Dabrunz <odabrunz@gmx.net>, git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, Petr Baudis <pasky@suse.cz>,
	martin f krafft <madduck@madduck.net>,
	Per Cederqvist <ceder@lysator.liu.se>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 14:21:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4YQQ-0003q4-NR
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 14:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577Ab0JIMVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 08:21:16 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:60938 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755483Ab0JIMVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 08:21:15 -0400
Received: (qmail invoked by alias); 09 Oct 2010 12:21:11 -0000
Received: from unknown (EHLO santana.dyndns.org) [109.250.241.189]
  by mail.gmx.net (mp068) with SMTP; 09 Oct 2010 14:21:11 +0200
X-Authenticated: #20497841
X-Provags-ID: V01U2FsdGVkX1/CtXYVwijC5WqmEaqjDB9/gnOdyRXk1V5kwR9otd
	PLvowcesvaU2ej
Received: by santana.dyndns.org (Postfix, from userid 1000)
	id A4FB027D83; Sat,  9 Oct 2010 14:21:11 +0200 (CEST)
Mail-Followup-To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Olaf Dabrunz <odabrunz@gmx.net>, git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Petr Baudis <pasky@suse.cz>, martin f krafft <madduck@madduck.net>,
	Per Cederqvist <ceder@lysator.liu.se>
Content-Disposition: inline
In-Reply-To: <AANLkTi=Xhd8DY+f1ZYR6dEhHvC-=50iHLnhdv8GTacNX@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158585>

On 09-Oct-10, Bert Wesarg wrote:
> On Sat, Oct 9, 2010 at 12:54, Olaf Dabrunz <Olaf.Dabrunz@gmx.net> wrote:
> > [...]
> 
> When I understand this correctly, this hand made merge commit on base,
> has also the just removed dep as parent. But the tree does not include

The hand made merge commit on base only has a removed dep as a parent if
that removed dep is brought in again directly, as the new dep that is
added here. The only parents of the hand made merge commit are: the tip
of the current topgit branch's base and the new dependency.

    hand made merge commit on base =                        \
        git-commit-tree $tree_from_merge_on_export          \
                        -p $topgit_base_branch -p $new_dep

In general, the new dep may already have merged in a dep that we
previously removed from our topgit branch. So the previously removed dep
is brought in indirectly by merging a branch that contains it.

This patch tries to cover both cases. The latter case and requirements
for tg depend add to cover it were discussed by you and Uwe in this
thread:

http://lists-archives.org/git/688698-add-list-and-rm-sub-commands-to-tg-depend.html

> any code from that dep. So git merge-base would select this commit as

If the new dep _is_ a previously removed dep, the code of the new dep is
contained in the hand made merge as well.

If the new dep _brings in_ a previously removed dep, it depends on how
the previously removed dep was merged into the new dep we are trying to
merge now. If our new dep merged in the previously removed dep but used
the "ours" merge strategy to supersede that dep's contents, it does not
bring in any code from that dep but only brings in that dep as part of
it's history.

> the merge base.

Yes, as the previously removed dep is now -- directly or indirectly --
part of the history of the hand made merge on base.

I should really draw graphs. But here is the mail anyway (release
early...).

Olaf

-- 
Olaf Dabrunz (Olaf <at> dabrunz.com)
