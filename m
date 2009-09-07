From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Mon, 07 Sep 2009 09:07:13 +0900
Message-ID: <20090907090713.6117@nanako3.lavabit.com>
References: <20090902080305.GA11549@neumann>
	<20090902081917.GA5447@coredump.intra.peff.net>
	<20090904070216.GA3996@darc.dnsalias.org>
	<20090905061804.GB29863@coredump.intra.peff.net>
	<7v8wgt98ms.fsf@alter.siamese.dyndns.org>
	<20090905084641.GA24865@darc.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER Gbor <szeder@ira.uka.de>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 07 02:09:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkRnh-0002e0-GS
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 02:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758295AbZIGAHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 20:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758275AbZIGAHs
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 20:07:48 -0400
Received: from karen.lavabit.com ([72.249.41.33]:53714 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758270AbZIGAHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 20:07:47 -0400
Received: from h.earth.lavabit.com (h.earth.lavabit.com [192.168.111.17])
	by karen.lavabit.com (Postfix) with ESMTP id 4085111BCA8;
	Sun,  6 Sep 2009 19:07:50 -0500 (CDT)
Received: from 7299.lavabit.com (212.116.219.172)
	by lavabit.com with ESMTP id W0WQRBMMVZQH; Sun, 06 Sep 2009 19:07:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=X3kWe7mBCAVZX1iYqIjVMu2VK5Nbz392MYwZ6hhklHo9dngB0C0HX9UEHtx30SJU0DMT5Xf8+neaPT5RWk+4QX5dfZb1tNlhpq+tXl/4bQHYn2/y+knR4IH69KBIG603uRb4hOCmY2iYPu1wUtfKdiu9bOtNlT3pKbJ3x9tDWs4=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090905084641.GA24865@darc.dnsalias.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127876>

Quoting Clemens Buchacher <drizzd@aon.at>

> Sorry for stating the obvious here, but the following commands affect the
> entire repository, even though they limit themselves to the current
> directory, if passed a '.'.
>
> 	git commit
> 	git log
> 	git diff
> 	git checkout
> 	git reset
>
> Due to the frequent use of these commands, I believe many users (myself
> included) expect "git add" and "git grep" to do the same. AFAICT the
> following commands are the only non-plumbing ones that behave differently:
>
> 	git add -u
> 	git add -A
> 	git grep
>
> So I argue that _that_ is the real inconsistency.

The default behavior for 'git-grep' has already been discussed in length, and I don't think it is likely to change. See 

  http://thread.gmane.org/gmane.comp.version-control.git/111519/focus=111717

The original design for the other two in your list was to be a whole tree operation. This commit broke it. 

  2ed2c22 "git-add -u paths... now works from subdirectory".

'git-add -u' in a subdirectory without any other argument used to work on the entire working tree before that commit, but it didn't prefix the current directory in front of the paths... arguments. 

That commit 2ed2c22 fixed 'git-add -u paths...' by prepending the prefix to the arguments, but it broke 'git-add -u' to always limit the updates to the current directory. 

I think it is a good idea to fix this as an old regression in the maint branch. You don't have to introduce "git add -a". In fact the -a option was explicitly rejected when "git add -A" option was added with this commit. 

  3ba1f11 "git-add --all: add all files"

because "git commit -a" will never include new files and it will be inconsistent if "git add -a" did so.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
