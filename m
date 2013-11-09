From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] checkout: most of the time we have good leading directories
Date: Sat, 09 Nov 2013 15:24:30 +0100
Message-ID: <87iow1ps9t.fsf@linux-k42r.v.cablecom.net>
References: <xmqqy54zohux.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 15:24:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf9Sx-0005zd-Q0
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 15:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab3KIOYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 09:24:43 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52400 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966Ab3KIOYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 09:24:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 95AB84D659C;
	Sat,  9 Nov 2013 15:24:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yHDaJQYcmG0D; Sat,  9 Nov 2013 15:24:31 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (84-73-190-173.dclient.hispeed.ch [84.73.190.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id DE03C4D6414;
	Sat,  9 Nov 2013 15:24:30 +0100 (CET)
In-Reply-To: <xmqqy54zohux.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Nov 2013 16:30:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237576>

Junio C Hamano <gitster@pobox.com> writes:

> When "git checkout" wants to create a path, e.g. a/b/c/d/e, after
> seeing if the entire thing already exists (in which case we check if
> that is up-to-date and do not bother to check it out, or we unlink
> and recreate it), we validate that the leading directory path is
> without funny symlinks by seeing a/, a/b/, a/b/c/ and then a/b/c/d/
> are all without funny symlinks, by calling has_dirs_only_path() in
> this order.
>
> When we are checking out many files (imagine: initial checkout),
> however, it is likely that an earlier checkout would have already
> made sure that the leading directory a/b/c/d/ is in good order; by
> first checking the whole path a/b/c/d/ first, we can often bypass
> calls to has_dirs_only_path() for leading part.

Naively one would think that this is just as much work -- to correctly
verify that the path consist only of actual directories (not symlinks)
we have to lstat() every component regardless.  It seems the reason this
is an optimization is that has_dirs_only_path() caches its results, so
that we can get 'a/b/c/d/ is okay in every component' from the cache.

Is this analysis correct?  If so, can you spell that out in the commit
message?

-- 
Thomas Rast
tr@thomasrast.ch
