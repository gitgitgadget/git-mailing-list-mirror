From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [bug-patch] [BUG?] rename patch accepted with --dry-run, rejected without (Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
Date: Sat, 4 Sep 2010 23:57:34 +0200
Organization: SUSE Labs
Message-ID: <201009042357.34237.agruen@suse.de>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <201009040058.18028.agruen@suse.de> <20100903233252.GD30310@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bug-patch@gnu.org,
	"Uwe =?iso-8859-1?q?Kleine-K=F6nig?=" 
	<u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	"Jean-Christophe PLAGNIOL-VILLARD" <plagnioj@jcrosoft.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: linux-sh-owner@vger.kernel.org Sun Sep 05 00:03:26 2010
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-sh-owner@vger.kernel.org>)
	id 1Os0pZ-0007ro-CS
	for glps-linuxsh-dev@lo.gmane.org; Sun, 05 Sep 2010 00:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689Ab0IDWDY (ORCPT <rfc822;glps-linuxsh-dev@m.gmane.org>);
	Sat, 4 Sep 2010 18:03:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:48768 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab0IDWDY (ORCPT <rfc822;linux-sh@vger.kernel.org>);
	Sat, 4 Sep 2010 18:03:24 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id B9F6C94393;
	Sun,  5 Sep 2010 00:03:22 +0200 (CEST)
User-Agent: KMail/1.12.4 (Linux/2.6.31.12-0.2-desktop; KDE/4.3.5; i686; ; )
In-Reply-To: <20100903233252.GD30310@burratino>
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155367>

On Saturday 04 September 2010 01:32:52 Jonathan Nieder wrote:
> Andreas Gruenbacher wrote:
> 
> > something pretty bizarre is going on here.  The wget output modifies the same 
> > file twice, but both patches to this file have the same source sha1 (5645f35):
> 
> From the git v1.6.0-rc0~92 changelog entry:
> 
>     apply: fix copy/rename breakage
>     
>     7ebd52a (Merge branch 'dz/apply-again', 2008-07-01) taught "git-apply" to
>     grok a (non-git) patch that is a concatenation of separate patches that
>     touch the same file number of times, by recording the postimage of patch
>     application of previous round and using it as the preimage for later
>     rounds.
>     
>     This "incremental" mode of patch application fundamentally contradicts
>     with the way git rename/copy patches are designed.  When a git patch talks
>     about a file A getting modified, and a new file B created out of A, like
>     this:
>     
>         diff --git a/A b/A
>         --- a/A
>         +++ b/A
>         ... change text here ...
>         diff --git a/A b/B
>         copy from A
>         copy to B
>         --- a/A
>         +++ b/B
>         ... change text here ...
>     
>     the second change to produce B does not depend on what is done to A with
>     the first change in any way.  This is explicitly done so for reviewability
>     of individual patches.
>     
>     With this commit, we do not look at 'fn_table' that records the postimage
>     of previous round when applying a patch to produce a new file out of an
>     existing file.

Ouch ... this gets really messy when a user concatenates git style patches
and they are not applied to exactly the same source tree.

Thanks for digging out this commit message!

Andreas
