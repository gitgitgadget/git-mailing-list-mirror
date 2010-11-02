From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: rebase not honoring core.worktree pointing elsewhere
Date: Tue, 2 Nov 2010 07:11:16 +0700
Message-ID: <AANLkTi=ejRcnz+83zc2Z-6etUGMsBSw1FFUY0JNFRFGB@mail.gmail.com>
References: <loom.20101101T182113-378@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Drews <paul.drews@intel.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 01:12:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PD4U6-00064g-9C
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 01:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab0KBALk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 20:11:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46020 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab0KBALj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Nov 2010 20:11:39 -0400
Received: by wwe15 with SMTP id 15so6750609wwe.1
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 17:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bU+5xXY6HaiJaW7zh4GykcXLnR0ijAxW72kxWr6pEDQ=;
        b=Vkf7DS/LL5ydNbHH/GtNIfDB3DOQOoSxA0GexsJst+QZ696nqhEERZyQMcqtJ6w/UX
         mjKXrIugNrp97t/HelxP9g5G4zixzVKSWFh5zL6RR0hpkl4SVpPG/k1f20pWMwztIQtK
         atEC3JF6ICJzkJRVjB9QhpuNd4RF8W2kxWNyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Di02uDwl3XyGJ4STGp/Cy0C8ZGjTVyjPuGXwaXDCdxmfFvn75Q/gfhuPMU94vWB9BL
         BqXgcbst7SvZqwsr0K1v6BFNl8xqDiIWKplefIOQzXoDGrTD01OCKfOx1tMA8HzIltoD
         pDU6eENewIzx6UR3qI5BgRa14aGp5FvrPGCjs=
Received: by 10.216.47.19 with SMTP id s19mr345577web.56.1288656697753; Mon,
 01 Nov 2010 17:11:37 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Mon, 1 Nov 2010 17:11:16 -0700 (PDT)
In-Reply-To: <loom.20101101T182113-378@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160502>

On Tue, Nov 2, 2010 at 12:22 AM, Paul Drews <paul.drews@intel.com> wrot=
e:
> Hello,
>
> I'm observing an unexpected error from "git rebase" run from the dire=
ctory
> containing the ".git" directory:
>
> $ git --version
>
> git version 1.7.3.GIT
> (includes up to commit ca2090 from git repository at
> http://www.kernel.org/pub/scm/git/git.git)
>
> $ mkdir wherefilesare
> $ mkdir wheregitis
> $ cd wherefilesare
> $ echo "Here is a line from the original" > myfile.txt
> $ cd ../wheregitis
> $ git init
> $ git config core.worktree /absolute/path/to/wherefilesare/
> $ git add .
> $ git commit
> $ git branch mybranch
> $ git checkout mybranch
> $ vim ../wherefilesare/myfile.txt
> $ git add .
> $ git commit
> $ git checkout master
> $ vim ../wherefilesare/myfile.txt
> $ git add .
> $ git commit
> $ git checkout mybranch
> $ git rebase master
>
> fatal: /usr/libexec/git-core/git-rebase cannot be used without a work=
ing tree.
>
> Since I'm in the directory containing ".git" at this point, the ".git=
" directory
> and the worktree can be unambiguously found. =C2=A0Other commands bes=
ides "git
> rebase" work. =C2=A0I would expect "git rebase" to work as well. =C2=A0=
Is this a bug or an
> unreasonable expectation on my part?

=46irst of all, core.worktree should not matter because GIT_DIR has not
been set (No don't trust core.worktree documentation, it's equivalent
to --work-tree in "man git"). You need to set GIT_DIR (or --git-dir).
That's a bug I'm working on.

Then, yes, rebase should be updated to use worktree even if it's
outside cwd. I'm not sure how to do it properly in git-rebase.sh
though.  The requirement "require_work_tree" can be loosen a bit.
--=20
Duy
