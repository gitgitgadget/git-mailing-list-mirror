From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git performance
Date: Thu, 23 Oct 2008 14:16:32 +0200
Message-ID: <vpq4p33pkv3.fsf@bauges.imag.fr>
References: <000801c93483$2fdad340$8f9079c0$@com>
	<20081022203624.GA4585@coredump.intra.peff.net>
	<000901c93490$e0c40ed0$a24c2c70$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Edward Ned Harvey" <git@nedharvey.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 14:43:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KszXY-0003nH-CP
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 14:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbYJWMmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 08:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYJWMmf
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 08:42:35 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:36857 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbYJWMme (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 08:42:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m9NCcneg019237;
	Thu, 23 Oct 2008 14:39:00 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ksz7A-0004ql-7X; Thu, 23 Oct 2008 14:16:32 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Ksz7A-0006of-5I; Thu, 23 Oct 2008 14:16:32 +0200
In-Reply-To: <000901c93490$e0c40ed0$a24c2c70$@com> (Edward Ned Harvey's message of "Wed\, 22 Oct 2008 17\:55\:14 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Thu, 23 Oct 2008 14:39:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98956>

"Edward Ned Harvey" <git@nedharvey.com> writes:

>> Yes, it does stat all the files. How many files are you talking about,
>> and what platform?  From a warm cache on Linux, the 23,000 files kernel
>> repo takes about a tenth of a second to stat all files for me (and this
>> on a several year-old machine). And of course many operations don't
>> require stat'ing at all (like looking at logs, or diffs that don't
>> involve the working tree).
>
> No worries.  No solution can meet everyone's needs.
>
> I'm talking about 40-50,000 files, on multi-user production linux,
> which means the cache is never warm, except when I'm benchmarking.
> Specifically RHEL 4 with the files on NFS mount. Cold cache "svn st"
> takes ~10 mins. Warm cache 20-30 sec.

SVN does not only has to stat the files. It also has to read the
stat-cache information wich is split in one .svn/ per directory in the
working tree. Not sure which operation dominates the performance,
though. Best is just to try.

> Out of curiosity, what are they talking about, when they say "git is
> fast?" Just the fact that it's all local disk, or is there more to
> it than that?

Not just local disk: bzr also works locally, and git is much faster on
most operations (bzr status can now compete with git, but "git log"
and "git commit" can be instantaneous where bzr take 1 minute for
example).

For sure, doing most operations locally is the key to being fast, but
Git has also been written so that the complexity of algorithms be as
low as possible.

> I could see - git would probably outperform perforce for versioning
> of large files (let's say iso files) to benefit from sustained local
> disk IO, while perforce would probably outperform anything I can
> think of, operating on thousands of tiny files, because it will
> never walk the tree.

Mercurial has an extension called "inotify" that avoids walking the
disk too. AFAIK doesn't have an equivalent in Git (mostly because most
people interested find git fast enough).

-- 
Matthieu
