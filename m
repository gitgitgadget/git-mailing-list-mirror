From: Chris Webb <chris@arachsys.com>
Subject: git-commit bug (was Re: Editing the root commit)
Date: Tue, 26 Jun 2012 16:04:37 +0100
Message-ID: <20120626150436.GU9682@arachsys.com>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com>
 <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
 <20120620192938.GC31520@sigill.intra.peff.net>
 <20120620193922.GB3192@arachsys.com>
 <20120620194824.GA32228@sigill.intra.peff.net>
 <20120622205026.GI32205@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 17:04:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjXK1-0004ru-0J
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 17:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917Ab2FZPEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 11:04:49 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:47384 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508Ab2FZPEs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 11:04:48 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjXJp-0006if-9F; Tue, 26 Jun 2012 16:04:41 +0100
Content-Disposition: inline
In-Reply-To: <20120622205026.GI32205@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200650>

Chris Webb <chris@arachsys.com> writes:

> PS Whilst experimenting, I also noticed a (presumably unintentional)
> behaviour:
> 
>   $ git init .
>   Initialized empty Git repository in /tmp/foo/.git/
>   $ git checkout --detach
>   $ touch bar
>   $ git add bar
>   $ git commit -m test
>   [(null) (root-commit) 17b5bf9] test
>    0 files changed
>    create mode 100644 bar
>   $ ls .git/refs/heads/
>   (null)
>   $
> 
> Here we've created a branch with the strange name '(null)' instead of
> actually detaching, or refusing to detach because we're on an unborn
> branch.

This was introduced by abe199808c, which is intended to allow

  git init . && git checkout --orphan newbranch

but presumably wasn't also meant to enable

  git checkout --orphan foo
  git checkout --detach

This leads to a printf("%s", NULL) and thus

  $ git symbolic-ref HEAD
  refs/heads/(null)

I've followed up to this message with a patch including a test to catch this
in future.

Best wishes,

Chris.
