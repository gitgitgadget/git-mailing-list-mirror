From: David Kastrup <dak@gnu.org>
Subject: Re: Empty directories...
Date: Fri, 27 Jul 2007 07:22:08 +0200
Message-ID: <854pjq775r.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<200707270133.25221.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEIHQ-00084Y-OS
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbXG0FWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbXG0FWW
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:22:22 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:53371 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753548AbXG0FWV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 01:22:21 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 17C88336950;
	Fri, 27 Jul 2007 07:22:20 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 01371345BE8;
	Fri, 27 Jul 2007 07:22:20 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-061-025.pools.arcor-ip.net [84.61.61.25])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id B285B1323B;
	Fri, 27 Jul 2007 07:22:19 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3E17E1C39595; Fri, 27 Jul 2007 07:22:08 +0200 (CEST)
In-Reply-To: <200707270133.25221.robin.rosenberg.lists@dewire.com> (Robin Rosenberg's message of "Fri\, 27 Jul 2007 01\:33\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3779/Thu Jul 26 21:33:22 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53889>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> (
> 	I don't know which mail is the best to reply to and I probably missed 
> 	something in the thread, so bear with me if I'm repeating anything.
> )
>
> David. Reconsider "tracking" all directories and what that would
> give, compared to explicitly tracking specific ones and the requires
> magic entries.

It would be quite a nuisance for a patch-based workflow, since patches
don't talk about the creation and deletion of directories.

The "track only when entered approach" has the advantage that
directories that were only created to accommodate patches will be
removed again when becoming empty.

Of course, once doing "git-add top-level" will level the difference.

> Say we have a config setting that tells git never to remove empty
> trees.

Why wouldn't I have tree/zap removed when doing git-rm tree?

> Linus patches could be a start for representing trees in the
> index. As an optimization the index could prune trees from the index
> if they contain things as long as the index *effectively* remembers
> all trees.

But it doesn't.  If you do git-add tree, optimizing the dir entry away
since tree/zap exists, then subsequently do git-rm tree/zap, of course
there is nothing to do except remove tree/zap, and the tree is gone.

One can't start tracking trees explicitly only when they become empty,
because one can't know whether to track them then.

> Using the patches again we could add empty directories to the index
> and remove them. No directory would be removed automatically, except
> maybe by a merge.

I currently have the problem that

rm -rf *
unzip some-archive
git-add some-archive
git-commit -a -m whatever
git-checkout something else

leaves empty directory skeletons lying around.

> We would probably have only a few empty directories and new
> unexpected ones would only pop up when we remove all blobs from
> one. Git status could tell us about them so we will not forget
> them.

I don't want a source management system to tell me whenever it is
going to annoy me.

> It could even tell us about "new" empty directories, which is
> probably the most important thing you'd want to know.
>
> Forgetting to untrack an empty directory would not be a big deal.
>
> Whether to retain empty trees or not should be a repository policy,
> but an all or nothing setting.

With that approach idea the workflow

"Apply a patch creating something/hello"
"Undo the patch creating something/hello"

will leave something lying around.  For somebody managing hundreds of
directories, that would be a nuisance.

I don't say that a "track all parents automatically" approach would
not have its merits: it would likely prevent some mistakes and be
easily understandable to most users.  But for managing a patch
workflow, it would appear to get in the way.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
