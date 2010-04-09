From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull suggestion
Date: Fri, 9 Apr 2010 15:33:35 -0400
Message-ID: <i2y3abd05a91004091233nc11ee5f8m4f40e7451e02518a@mail.gmail.com>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com> 
	<201004081754.24954.trast@student.ethz.ch> <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com> 
	<20100408231154.GB13704@vidovic> <v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com> 
	<20100409034911.GA4020@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 09 21:34:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Jxq-0004eA-FK
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 21:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576Ab0DITd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 15:33:57 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:33794 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab0DITd4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 15:33:56 -0400
Received: by wwi17 with SMTP id 17so1086815wwi.19
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dx2JfWFwrvc1R2fsEdYZA5oDz+HPs8dbUHWJmLsvLR0=;
        b=hjXJn7qOnEQLqz+FNBoG1Q26U+LvhfirNZVreeYwNl/jnytRfJ0Sas/mK5OHGH+JC/
         vw+5ZOzJpQcHqKiYXRybSXB7CP+i5LNXnBxNkK4I0XYzvXAyqFAnBComrdYDgOqp/kFf
         elZQ9FBuCRUc0glxB5LYuOFHj+EJeJanG7mZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JdNx53lEo7aqjebriBHlRG4/RAvk6v+EiGZh9CXI2CjC71Au8Z2bzCYQdS6OpsPb4e
         /JqyaEM3145FpmE8cZwO/AJX9G2NI53syPWvajjOir3NnzlgwSzXrBIOBoCEWGO6A3Kc
         5gCdw9UMtOdeSGNyTLgopbtgCPOWALe/Fr69Q=
Received: by 10.216.170.8 with HTTP; Fri, 9 Apr 2010 12:33:35 -0700 (PDT)
In-Reply-To: <20100409034911.GA4020@coredump.intra.peff.net>
Received: by 10.216.88.7 with SMTP id z7mr290617wee.19.1270841635140; Fri, 09 
	Apr 2010 12:33:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144463>

Jeff King <peff@peff.net> wrote:
>
> ...
>
> I get:
>
> =A0$ git merge other
> =A0error: Your local changes to 'file1' would be overwritten by merge=
=2E Aborting.
> =A0Please, commit your changes or stash them before you can merge.
>
> But that's not the whole story. Once you fix that, you will see that
> your local changes to 'file2' would be overwritten by the merge:
>
> =A0$ git commit -m "commit file1" file1
> =A0$ git merge other
> =A0error: Your local changes to 'file2' would be overwritten by merge=
=2E Aborting.
> =A0Please, commit your changes or stash them before you can merge.
>
> And so on.
>
> Notice that I didn't use "pull", but pull should invoke git-merge aft=
er
> fetching from the remote. I assume this is the same message you are
> talking about?

Exactly.

> It is possible to manually get the answer you want, or close to it. Y=
ou
> are looking for the intersection of files modified by you and files
> modified by the upstream. So:
>
> =A0# unique list of modified working tree files and index entries
> =A0$ (git diff-files --name-only;
> =A0 =A0 git diff-index --name-only HEAD
> =A0 =A0) | sort -u >us
> =A0# files that will be changing as part of merge
> =A0$ git diff-tree --name-only $HEAD_TO_MERGE_FROM | sort >them
> =A0$ comm -12 us them
>
> where $HEAD_TO_MERGE_FROM in my example would be "other", but in the
> case of a pull, would probably be FETCH_HEAD.

Thanks a lot for this, I will try it.

> In practice, I have never actually wanted to this. The workflow goes
> something like:
>
> =A0(1) Run git merge foo (or git pull)
>
> =A0(2) Oops, I have cruft in my working tree. What was it? Run git
> =A0 =A0 =A0status.
>
> =A0(3a) Oh, that cruft should have been committed. Make a commit (or
> =A0 =A0 =A0 commits). Go to (1), possibly still with some changes in
> =A0 =A0 =A0 the working tree.
>
> =A0 =A0 =A0 or
>
> =A0(3b) Oh, that cruft is some change I want to carry forward in the
> =A0 =A0 =A0 working directory. Run git stash, repeat the pull, fix an=
y
> =A0 =A0 =A0 merge conflicts, and then git stash apply.
>
> So it doesn't really matter to me if there is 1 conflicting file or 1=
00.
> In most cases, the commits in (3a) will clean up all of it in one go.
> Otherwise, I'll just stash it all and come back to it.
>

That is exactly my workflow and I am perfectly happy with that. The
problem is that I am putting git in the hands of svnites and
sometimes I have to address some usability issues like these.

It is another issue, but I feel that the 'dirty working directory' is
one of the major usability hurdles for people migrating from svn
and CVS (a git pull --merge-using-stash could address it, maybe).

  -- aghiles
