From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Read several objects at once with git cat-file --batch
Date: Mon, 11 Aug 2008 01:58:45 +0200
Message-ID: <20080810235845.GA5106@diana.vm.bytemark.co.uk>
References: <20080808082728.GA24017@diana.vm.bytemark.co.uk> <20080808080614.23424.28169.stgit@yoghurt> <b0943d9e0808101525w1e6f1e60h162a4b137d6dca6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 01:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSKTl-0000Fy-KV
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 01:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYHJXgk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2008 19:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbYHJXgj
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 19:36:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1510 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbYHJXgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 19:36:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KSKo9-0001Nm-00; Mon, 11 Aug 2008 00:58:45 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0808101525w1e6f1e60h162a4b137d6dca6c@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91905>

On 2008-08-10 23:25:08 +0100, Catalin Marinas wrote:

> 2008/8/8 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Instead of spawning a separate cat-file process for every blob and
> > commit we want to read. This speeds things up slightly: about 6-8%
> > when uncommitting and rebasing 1470 linux-kernel patches
> > (perftest.py rebase-newrebase-add-file-linux).
>
> Which version of Git got the --batch option to git-cat-file? It
> might be possible that default Git in Debian (testing) or Ubuntu
> doesn't have this option. Maybe we could still have the original
> behaviour as a fallback.

Hmm, I never realized it was so new. It's not in any 1.5.5 release,
but it is in 1.5.6-rc0. So realistically, we'll have to require
version 1.5.6 for this. (The patch should add a paragraph about the
required git version to some doc file.)

A fallback is certainly conceivable. The only nontrivial thing about
it would be to detect when it's necessary. And to make sure both code
paths are tested ...

(I have a similar patch that uses diff-tree --stdin, but that needs a
git with the patches I posted some hours ago.)

> Otherwise, the patch looks allright. It took me a bit of time to see
> why we need the new run_background() function (but in my current
> Git, 1.5.3.4.206.g58ba4, there wasn't such an option; I had to
> upgrade).

Thanks. I'm not 100% pleased with the background running stuff yet. It
works, but could use some refactoring so that callers don't have to
know too much.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
