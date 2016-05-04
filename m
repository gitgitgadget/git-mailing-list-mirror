From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: avoid duplicate patches from git log ?
Date: Wed, 4 May 2016 13:44:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605041329040.9313@virtualbox>
References: <712E44CFAD1A41A982AEF1540C1F9F80@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed May 04 13:44:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axvEJ-0004l4-8L
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbcEDLoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:44:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:54828 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524AbcEDLoW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:44:22 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M2L2a-1bpcH72YYG-00s7rr; Wed, 04 May 2016 13:44:17
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <712E44CFAD1A41A982AEF1540C1F9F80@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:j6dTfUO8dyFegT69v4R+eADl8mVcu7GTQMmwwj8zKCEKIWsKtBe
 ezj+PBgp/70R5R5ixgifXi9b+NHhKhutIGyt9S2UKFioWkOGSNhAiOU5H/NjkBrJJELxvB4
 Hvon3Jzn97YHAHGYiqCSV1AKDah7FAW+RWuUE2DFXqMLOlKcThb4M7lxs8+UVU58lYNNgF4
 oUpsfnScjSlQO7VMTmx9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zsg3XvcBx+I=:mpRb7VWFnh4guVrOz6eUm5
 eXw9Cm7Pwe7wF3N17cl6axUxPpHm0DFB1bMFnWrbHeJiN2+7bCBAieCVta+sniNbe3fxiQ23f
 YN7rBwKN+ADnF9V6BaXperciXXSrVp6YP8XnQnPssruCxG51UKeMAjsJAL9EkkRVE+XW/9DSN
 9ws5pMYYq/7du1IsYGaOsdFI7gXLbbeYiv1NwTJ7NMIwI1YvkugrtEP7NNDSnYdofg4Eyu0po
 RWVz35xJw7SRonHvQbj/vVqiPbl0Bt95thheO04755+tAjqI0nnZqArnJgtUL1smNPAKHjm95
 sHaQQYJlO9AYi/JuRAqxkhZSPm9ND+Wq8QOhjMmADMHnpNIVMS32BZMeDfX7EHMYmv6ZILYk8
 rjpB4ulIxcBd1+1aB9A9N4+V6xGLCZDcU0olBUKGN2Mn/rZrLYBxkr77btVlTeV49U61VRX0x
 8gdBvXJeuMZ8iWMwjeL2nJETCnvAKFg3HH9lkWNzo1cDfPrASnjEkqHD1iAfOpuTYRjWmFhIY
 sUOevXJppAPCSi+tDcFdGfT5KQmrGPTwtfaSXj/U6wL3HnMcqOuOiNwZU71UiQatVFnfY9ke4
 axJheYb5KVkiSSuF7pEZnNrHlZCv7n8lvQP7hSd4i0KJuet9PCHIQdAA9/x8sEoyHS35oa/KR
 oSYSsl8Iwb6QC7oP7BlNWbxGP4rQKwxIgUcQ2OibfW1NAjTuWwe/8Hu5/1Z5yH1poofASTxkt
 htJd5GTvMNoRjlFhNtnxdXcrMGPjQEreCYyOpQMX2ucEd2Ci85loRMbmct+qH8PMCWpee6rt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293539>

Hi Philip,

On Tue, 3 May 2016, Philip Oakley wrote:

> I was trying to search the Git for Windows (G4W) history for commits that
> touched MSVC.
> 
> I've used 'git log -SMSVC --pretty='tformat:%h (%s, %ad)' --date=short
> --reverse' to get a nice list of those commits.
> 
> However, as the G4W project (https://github.com/git-for-windows/git/)
> follows the main git repo and its releases, it needs to rebase it's
> fixup patches, while retaining their original series, so has repeated
> copies of those fix patches on the second parent path (a technique Dscho
> called rebasing merges).

Actually, I no longer use rebasing merges, but instead merging rebases.
The difference is a little subtle:

Rebasing merge:

- upstream ----- rebased-A - rebased-B - rebasing-merge (-s ours)
                                       /
- old-A - old-B -----------------------

Merging rebase:

- upstream ----- merging-rebase (-s ours) - rebased-A - rebased-B
               /
- old-A - old-B

Of course both diagrams are drastically simplified, as I do not only
rebase mere patches, but topic branches, including merge structure
(currently 44 IIRC), to make it easier to break out the topic branches for
easy submission later.

It turned out that the rebasing-merge strategy actually made things
harder, as it was not quite as easy to figure out *which* commits needed
rebasing (remember, new commits were added after rebasing-merges).

With merging-rebases, at least, one knows that the tree of the merge
commit starting the whole shebang is identical to upstream's tree.  All of
the patches that come on top of that merge commit need to be rebased the
next time round, including new patches.

Fittingly, the commit message of said merge commit begins with the
following text: "Start the merging-rebase ..."

BTW The reason for this rather unwieldy setup is that we historically had
a hard time getting our patches into upstream Git (there was some degree
of resistance in the past, and also a quite limiting lack of time on my
part).

> for example:
> > bf1a7ff (MinGW: disable CRT command line globbing, 2011-01-07)
> > a05e9a8 (MinGW: disable CRT command line globbing, 2011-01-07)
> > 45cfa35 (MinGW: disable CRT command line globbing, 2011-01-07)
> > 1d35390 (MinGW: disable CRT command line globbing, 2011-01-07)
> > 022e029 (MinGW: disable CRT command line globbing, 2011-01-07)
> 
> 
> How can I filter out all the duplicate patches which are identical other
> than the commit date?

I would go about it in a completely different manner. Remember that the
merging rebase starts with a merge that integrates the previous history,
but also resets the tree to upstream's. Therefore all the commits merged
at the start of the merging-rebase are the ones in which you are *not*
interested.

In other words, this command-line will yield the output you desire:

git log -SMSVC --pretty='tformat:%h (%s, %ad)' --date=short \
	HEAD^{/Start.the.merging-rebase}^2..

Ciao,
Dscho
