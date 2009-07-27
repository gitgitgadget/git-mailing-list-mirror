From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH v3 0/5] {checkout,reset,stash} --patch
Date: Mon, 27 Jul 2009 12:10:36 +0200
Message-ID: <200907271210.40001.trast@student.ethz.ch>
References: <7vzlat64u1.fsf@alter.siamese.dyndns.org> <cover.1248557241.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 12:11:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVNAZ-0007jG-6a
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 12:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979AbZG0KKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 06:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755977AbZG0KKv
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 06:10:51 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:8020 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755976AbZG0KKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 06:10:50 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Jul 2009 12:10:49 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Jul 2009 12:10:49 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <cover.1248557241.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 27 Jul 2009 10:10:49.0796 (UTC) FILETIME=[84249040:01CA0EA2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124160>

I wrote:
> 
> Similarly, "stash" has some problems: we want to encode the changes
> HEAD..index into one commit, and index..worktree into another.
> However, these patches may not apply on top of each other depending on
> what hunks were selected.  I see three options:
> 
> * Make more a priori restrictions, such as, --patch is strictly about
>   the worktree and simply refuses to stash anything if you have staged
>   changes; or, we only deal with the worktree and always stash the
>   index whole.  I think at least the first option would make it
>   significantly less useful though.

I'm still not happy with this interface.  How about the following to
make it less confusing:

1b) 'stash save -p' defaults to --keep-index (which can be disabled
    with a new option --no-keep-index).  In --keep-index mode, it only
    offers hunks from the worktree.

That way, it's almost analogous to 'git add -p', but for "adding to
the stash".

> * Hope that it works out, and catch failure later.  This is what it
>   currently does.
> 
> * Expand the stash format to four commits so that, e.g.,
>   stash^1..stash^2 is HEAD..index and stash^3..stash is
>   index..worktree.  (Currently stash^1 is HEAD, stash^2 is index and
>   stash is worktree.)  This would require more changes, and make these
>   stashes backward incompatible w.r.t. application, so I'm not sure it
>   is worth the trouble.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
