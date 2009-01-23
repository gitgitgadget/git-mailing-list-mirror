From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Fri, 23 Jan 2009 21:15:16 +0100
Message-ID: <8c5c35580901231215q2be36abbla443975cdbb031f0@mail.gmail.com>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-2-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-3-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-4-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
	 <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>
	 <7vzlhhu8qo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 21:16:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQSSM-0002I5-EG
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 21:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbZAWUPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbZAWUPT
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 15:15:19 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:11336 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbZAWUPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 15:15:17 -0500
Received: by wa-out-1112.google.com with SMTP id v33so36380wah.21
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 12:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bv3hZTzti21WGtSVO6fGBwWnnvQGjrKbAQBX3SiqtRI=;
        b=xZ9QDg7NQWRbdMJs9Fi75oQsvi4wKDmROqdq/i841Xf+pKa/NZRx08g/vp2ag9nxOZ
         AuYyiweSllhnON8HGiqVFVpYinut2oRwkXbthfZMec1qB6oH2U2r2fcHjsiY17f3u3dk
         SKeEAuY1DSm7+uoc0QdQAlSBLyQsktD6dDBiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tRQbQA3dZftp8N3aszHFp/Boyx1RFDXKUv2bBLfTgZNZ+Hd9eIxJtw/Qjoby7LDUf/
         L+uPzVGGp4HVyXleM9sH1A+XCbFkUtoObJzR2bebjp0ppW6EFYfAe+X5pBzuOc/gyHxg
         78kuq5AHtFtZ+qZiic1+2zTfhCMlXBZuKOq/U=
Received: by 10.114.130.15 with SMTP id c15mr4567026wad.59.1232741716696; Fri, 
	23 Jan 2009 12:15:16 -0800 (PST)
In-Reply-To: <7vzlhhu8qo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106911>

On Fri, Jan 23, 2009 at 20:23, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
>>>> The plan is to fix these limitations by extending --submodules to allow
>>>> certain flags/options:
>>>> a|c|r     include any|checked out|registered submodules
>>>> H         resolve submodule HEAD to decide which tree to include
>
> What do you mean by "decide"?  If HEAD exists (iow, the submodule is
> checked out), the tree of the commit recorded in the superproject's
> gitlink entry is included in the result?

No, when H is specified the tree of the currently checked out
submodule commit would be included (this obviously shouldn't be the
default mode of operation, hence a flag to trigger it if that is what
the user wants).

>
> As I already said before, I doubt it makes much sense in the context of
> the current git-archive to base the choise on checkout status.
>
> Unless you are extending git-archive and giving it an ability to write out
> the superproject index or the work tree as an archive, that is.
>
> Just like git-grep lets you grep in the work tree files (limited to paths
> that appear in the index), or grep in the contents registered to the index
> when run with --cached, git-archive could make an archive out of your work
> tree files or your index contents.  Such an extension to git-archive may
> be quite useful with or without submodules.

Absolutely.

>
> In such mode of operation, because you are dealing with the work tree when
> run without --cached, it would make sense to say "Ah, the superproject
> index wants v1.0 of the submodule, but the work tree has v2.0 of it
> checked out, and we are writing out the work tree, so let's include v2.0
> instead", and as a side effect of deciding which commit's tree to include
> from each submodule, it naturally makes sense to exclude submodules that
> are not checked out.
>
> But otherwise I am not so sure what the point of H option would be.

I would find the H flag practical for my own usage of submodules. I
almost never modify the content of the currently checked out submodule
but I often check out a different HEAD than what is registered in the
gitlink in the superproject (typically due to testing the superproject
against different versions of the submodule). And for such a use case,
being able to create a tarball of my currently checked out state seems
useful to me.

Anyways, if we get as far as adding a --submodules option to git
archive, I believe its default mode should be to archive the
superproject HEAD state together with the gitlink'd state of each
submodule registered in .git/config instead of --submodules=c which is
what this patch implements. But I wanted to get some feedback on this
plan before trying to implement it.

--
larsh
