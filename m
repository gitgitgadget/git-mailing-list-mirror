From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: switching upstream tips
Date: Wed, 13 May 2009 09:19:57 +0200
Message-ID: <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>
References: <4A0A6BD1.7050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 09:22:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M48lZ-0003zP-Hw
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 09:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbZEMHT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 03:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbZEMHT6
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 03:19:58 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:61033 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbZEMHT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 03:19:57 -0400
Received: by bwz22 with SMTP id 22so450439bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 00:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XP3CjKClGMua1gkV152jabiTvEezzK9RDDxcqHTX3Bs=;
        b=v3lCo7uSygNWpKkQeAF4z1SdZCi/ajK2Vc+F8IUpi2CVq6NwpzQtyA9ENFeB+FbwSf
         Z/bGIpXp+LCm03OAuqIm03Ex2AnGMFiYncguC2cRyaRevNg7/vWhp8vNyq73VIlQvhFU
         AzLrUe8J67OfWKCLV2YvyIDH/fj5pDle/WkRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iBQq3pcHYsaT5W3yLRYpv8GKIxdAsMwngO/IQqV5xFA9rkxnnTP1fdTzdM+BuUp5A4
         NgzJqOsPxCVPKHlviTvLG97skLI8KhigUMyz97KqwOz/O+KehkFZajk8z3qNGWbzEyBn
         EJizYq8tAc3VduPhCYB8wM7jJ2G6Vh+pJeezU=
Received: by 10.204.59.18 with SMTP id j18mr582574bkh.206.1242199197524; Wed, 
	13 May 2009 00:19:57 -0700 (PDT)
In-Reply-To: <4A0A6BD1.7050907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118992>

2009/5/13 Ittay Dror <ittay.dror@gmail.com>:
> I'm working on a repository in github that is forked from another
> repository. I've committed several times and pulled (merged) from the
> upstream a few times (so the committs are interleaved). The upstream
> repository is a clone of an SVN repository (in apache). The project has
> switched svn repositories (moved from incubation to top level project) and
> so created a new repository in github.

That's evil.

> * Reorder my history so that my commits are on top of the tip of the old
> upstream repository.

Look at "git rebase -i" (interactive rebase)

> * Change the upstream repository reference so it points to the new
> repository

Just edit your .git/config and re-fetch.

> * Apply my commits on top of the new upstream repository

You can try to cherry-pick your commits (git cherry-pick).
Maybe rename detection will be enough to apply your changes
as is. But as far as I understand, the path names in the new
upstream are now all different (moved a level up?).
You can save your commits in a mbox:

   git format-patch -o mbox old-upstream..your-last-commit

Edit the paths in the mbox and try to apply the result:

   git am -3 result.mbox

Or, you can use git filter-branch to modify the old history as if it
was always operating on the directory structure of the new
upsteam (assuming it is possible, of course). See manpage
of git filter-branch, there is an example (look for "move the whole
tree into a subdirectory").
