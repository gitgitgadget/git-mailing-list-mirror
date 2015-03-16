From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Mon, 16 Mar 2015 19:40:40 +0100
Message-ID: <20150316184040.GA8902@inner.h.apk.li>
References: <20150316142026.GJ7847@inner.h.apk.li> <xmqq1tkosvpi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 19:41:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXZwi-0004FM-5k
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 19:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934195AbbCPSks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 14:40:48 -0400
Received: from continuum.iocl.org ([217.140.74.2]:57282 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091AbbCPSkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 14:40:46 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t2GIefB16767;
	Mon, 16 Mar 2015 19:40:41 +0100
Content-Disposition: inline
In-Reply-To: <xmqq1tkosvpi.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265585>

On Mon, 16 Mar 2015 10:23:05 +0000, Junio C Hamano wrote:
> Andreas Krey <a.krey@gmx.de> writes:
> 
...
> say "a lot of ignored directories", but do you mean directories in
> the working tree (which I suppose do not have much to do with the
> submodule_ref_caches[])?

Apparently, they do.

>I am guessing that the repository has tons
> of submodules?

Not a single one. Thats's thie interesting thing that
makes me think I'm not actually solving the right problem.

This repo has about 100k subdirectories that are ignored
(I don't know whether directly or within ignored dirs),
and strace said that git looks for '.git/HEAD' and one
other file in each of these. Apparently it trieds to
find out if any of these dirs happen to be a git repo
which git clean treats specially, but it seems it also
calls get_ref_cache for each of these dires even though
the turn out not to be a sub-repo.

In other words: I suspect that get_ref_cache shouldn't
be called that often, or that the cache entries should
be removed once a directory is found not to be a sub repo.
Then the linear list wouldn't really hurt.

I'll look into that tomorrow, and also into the hashmap API.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
