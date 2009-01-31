From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Sun, 01 Feb 2009 06:45:43 +0900
Message-ID: <20090201064543.6117@nanako3.lavabit.com>
References: <871vulda2r.fsf@gigli.quasi.internal>
	<slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>
	<87vdrwbofv.fsf@gigli.quasi.internal>
	<slrngo771p.b1i.sitaramc@sitaramc.homelinux.net>
	<87myd7bo8f.fsf@gigli.quasi.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Raimund Berger" <raimund.berger@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 22:47:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTNgx-0008T7-NB
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 22:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbZAaVqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 16:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbZAaVqQ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 16:46:16 -0500
Received: from karen.lavabit.com ([72.249.41.33]:44938 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbZAaVqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 16:46:13 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 89967C8448;
	Sat, 31 Jan 2009 15:46:12 -0600 (CST)
Received: from 9691.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id AQFT85OP2VXN; Sat, 31 Jan 2009 15:46:12 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=fUGBk2y7I5T+TdBr61ZFGXUNOLzTcEDmIHot3uXYpe/DkubGTsvTSPyuAVrnuTliRlL3f0zwCjnd7aOCpMPNyTf4oWuAEzKDE1rsQpUoae5qizX6wsw1s2AjZcvXpCNrEfHnD1HCVA5A7CSejfwmhFEiPvcTFK0SzALZGNYmoyA=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <87myd7bo8f.fsf@gigli.quasi.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107944>

Quoting "Raimund Berger" <raimund.berger@gmail.com> writes:

> I'm myself, especially since a conflicting rebase leaves the index in an
> "unmerged" state. Much like a regular merge does. It's still all
> assumptions though, or maybe I'm missing documentation .... (?)

The rebase command you run with neither -m nor -i option replays
your work on top of the upstream by running git-am with the --3way
option.

This commit introduced the feature.

commit 7f59dbbb8f8d479c1d31453eac06ec765436a780
Author: Junio C Hamano <junkio@cox.net>
Date:   Mon Nov 14 00:41:53 2005 -0800

    Rewrite rebase to use git-format-patch piped to git-am.
    
    The current rebase implementation finds commits in our tree but
    not in the upstream tree using git-cherry, and tries to apply
    them using git-cherry-pick (i.e. always use 3-way) one by one.
    
    Which is fine, but when some of the changes do not apply
    cleanly, it punts, and punts badly.

    [omitting the rest]

The message talks about what was wrong with the original, what
benefit it gives the users, and how to use it, but it doesn't
discuss how the magic works in detail.

Junio much later describes how it works, taking a real-world example
in this message:

http://thread.gmane.org/gmane.comp.version-control.git/46569/focus=46609

In short, it works by applying your changes as patches but when a
patch doesn't apply it falls back to a simplified three-way merge.

http://thread.gmane.org/gmane.comp.version-control.git/100579/focus=100602

I think Junio misremembered the history in his last message in the thread.
He says that rebase was originally a format-patch piped to am, but
before the commit 7f59dbbb8f8d479c1d31453eac06ec765436a780 it was
done by a series of cherry-pick.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
