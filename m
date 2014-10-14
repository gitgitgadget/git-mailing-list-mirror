From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Tue, 14 Oct 2014 21:34:31 +0300
Message-ID: <20141014183431.GA8157@wheezy.local>
References: <1413090791-14428-1-git-send-email-max@max630.net>
 <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
 <543D58D9.5060606@web.de>
 <xmqqoatezhnx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 20:36:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe6ww-0001js-30
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 20:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339AbaJNSfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 14:35:51 -0400
Received: from p3plsmtpa08-07.prod.phx3.secureserver.net ([173.201.193.108]:35830
	"EHLO p3plsmtpa08-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753866AbaJNSfu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2014 14:35:50 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-07.prod.phx3.secureserver.net with 
	id 36bc1p0075B68XE016biKt; Tue, 14 Oct 2014 11:35:46 -0700
Content-Disposition: inline
In-Reply-To: <xmqqoatezhnx.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 14, 2014 at 10:26:42AM -0700, Junio C Hamano wrote:
> And multiple-worktree _is_ about keeping the same repository and
> history data (i.e. object database, refs, rerere database, reflogs for
> refs/*) only once, while allowing multiple working trees attached to
> that single copy.
> 
> So it appears to me that to create a checkout-to copy of a
> superproject with a submodule, a checkout-to copy of the superproject
> would have a submodule, which is a checkout-to copy of the submodule
> in the superproject.

That's right, this linking should be more implicit.

But here are a lot of nuances. For example, it makes sense to have a
superproject checkout without submodules being initialized (so that they
don't waste space and machine time for working tree, which often is more
than repository data). And it may happen so that this checkout is the
master repository for superproject checkouts. But this should not
prevent users from using initialized submodules in other checkouts.

Then, a checkout copy of a submodule can be standalone (for example, git
and git-html-docs are submodules of msysgit). Or, it can even belong to
some other superproject. And in that cases they still should be able to
be linked.

Considering all above, and also the thing that I am quite new to
submodules (but have to use them currently), I did not intend to create
any new UI, only to make backend handle the already existing linked
checkouts, which can be made manually.

-- 
Max
