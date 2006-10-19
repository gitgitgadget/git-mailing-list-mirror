From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 18:38:15 +0200
Message-ID: <vpq1wp42rd4.fsf@ecrins.imag.fr>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org>
	<45359B2A.1070102@utoronto.ca> <87y7rdd47j.wl%cworth@cworth.org>
	<20061019091045.GV75501@over-yonder.net> <45375E56.4090106@op5.se>
	<vpqirigqzpd.fsf@ecrins.imag.fr> <20061019123349.GE20017@pasky.or.cz>
	<vpqr6x4pghp.fsf@ecrins.imag.fr> <87ac3s2syi.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 18:39:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaavL-00018c-4N
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 18:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946199AbWJSQjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 12:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946210AbWJSQjK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 12:39:10 -0400
Received: from imag.imag.fr ([129.88.30.1]:57010 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1946199AbWJSQjG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 12:39:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9JGcGIJ012562
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Oct 2006 18:38:17 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GaauO-0001yU-1c; Thu, 19 Oct 2006 18:38:16 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GaauN-000209-Um; Thu, 19 Oct 2006 18:38:15 +0200
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87ac3s2syi.wl%cworth@cworth.org> (Carl Worth's message of "Thu\, 19 Oct 2006 09\:03\:49 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 19 Oct 2006 18:38:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29369>

Carl Worth <cworth@cworth.org> writes:

> Yes. We're identifying the core underlying technical difference behind
> the recent discussion. Namely bzr treats one parent as special, (the
> parent that was the branch tip previously). And this special treatment
> eliminates the ability to fast-forward, 

No.

bzr could trivially do fast-forward too. It's an explicit design
decision to have two separate commands.

> adds merge commits that wouldn't exist with fast forwarding,

They don't exist either with "pull".

The difference between bzr and git is smaller than you think on this
point I believe.

> There's a bit more to it than that though. The git command named
> "pull" will perform a fast-forward if possible, but will create a
> merge commit if necessary. For example:

The bzr command "pull" will do a fast-forward if possible, but will
refuse to continue and ask you to create the merge commit with other
commands if necessary.

> 	a       a                      a
> 	| pulls | and fast-forwards to |
> 	b       b                      b
> 	        |                      |
> 	        c                      c

Same as bzr.

> whereas:
>
>         a       a                       a
>         | pulls | and creates a merge  / \
>         b       c                     b   c
>                                        \ /
>                                         m

Here, bzr will refuse to pull. It will say "branches have diverged"
and tell you to use merge.

Then, you'll do

$ bzr merge

# optionally "bzr status"

$ bzr commit -m "merged such or such thing"


So, "git pull" seems roughly equivalent to something like

$ bzr pull || (bzr merge; bzr commit -m merge)

> So I'm curious. What does bzr pull do in the case of divergence like
> this? (And this is the "numbers will be changed" case, by the way).

Not yet. The "numbers will be changed" is if b pulls, right after.


Then, one other difference is in the UI. bzr shows you commits in a
kind of hierarchical maner, like (fictive example, that's not the real
exact format).

$ bzr log
commiter: upstream@maintainer.com
message:
  merged the work on a feature
  ------
  commiter: contributor@site.com
  message:
    prepared for feature X
  ------
  commiter: contributor@site.com
  message:
    implemented feature X
  ------
  commiter: contributor@site.com
  message:
    added testcase for feature X
------
commiter: upstream@maintainer.com
message:
  something else

No big difference in the model either, but it probably reveals a
different vision of what "history" means.

-- 
Matthieu
