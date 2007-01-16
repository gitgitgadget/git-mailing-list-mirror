From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Tue, 16 Jan 2007 22:42:17 +0000
Message-ID: <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com>
	 <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com>
	 <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net>
	 <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com>
	 <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com>
	 <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 16 23:42:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6x0Y-0002Hn-Dz
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 23:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbXAPWmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 17:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbXAPWmU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 17:42:20 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:31904 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXAPWmT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 17:42:19 -0500
Received: by nz-out-0506.google.com with SMTP id s1so277346nze
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 14:42:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EAB7HoI+pQ1FxIGWddANNdYBSWfWa+UBwAReho+ZOlXBtzmKGr2Z/ON9NaOQaLpnIOxtvd39fPz/5YkwQUuqbc0A4bPelE1urt5+MPUt9rb6BUg5ZLYU8ALs8Mjex8CTS6JA4UFUP0GskRdqXlYQcEgdFcGmjNyQCA7XLJ9Bg1A=
Received: by 10.65.154.10 with SMTP id g10mr8764743qbo.1168987338005;
        Tue, 16 Jan 2007 14:42:18 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Tue, 16 Jan 2007 14:42:17 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36975>

On 15/01/07, Yann Dirson <ydirson@altern.org> wrote:
> On Mon, Jan 15, 2007 at 10:46:37PM +0000, Catalin Marinas wrote:
> > >I have started work on implementing "stg pull --to <newbase>", but I'm
> > >facing some issues.
> >
> > I think the combination of 'pull' and '--to' is confusing (at least to
> > me) if you think of there English meaning.
>
> That's possible, I'm not a native english speater :)

I'm not either :-)

> The idea is that we pull our stack from one place (current base) to
> another.  Another possiblity would have been "stg rebase", but I'm not
> very keen on adding another command to do a very similar job.

Can you give a typical example of what <newbase> argument for --to is
and what you repository looks like? I just want make sure I correctly
understand the problem.

I see the 'pull' command as a way to fetch the latest remote changes
and merge them into the current branch (which would usually be a
fast-forward). This command was meant as a stgit-aware 'git pull'.

> > As Petr suggested at the OLS last year, I added the possibility to
> > configure the 'git pull' command so that people use whatever script
> > they like.
>
> Right.  Maybe different workflows should have this option set to
> different values in different repos ?  I'm merely trying to get the
> best default :)

But you want to replace the call to 'git pull' with 'git fetch'. I
think this is fine with my workflow but some people might actually
rely on calling 'git pull' (or cg-pull).

> > I was working on a set of patches (mainly picking from other
> > branches and minor modifications) and just committing them when
> > finishing. Further updates from kernel.org triggered full merges
> > with the base.
>
> But doing this means that you can end with a base that is not any more
> on the parent branch, but on a local merge, right ?  I'm not sure it
> is an easy thing to work with.

Yes, indeed, but this is probably the only way you can publish a
branch and still partially manage it with StGIT.

> On the StGIT front, we could have "stg clone" look at
> patches/<branch>/current or so, and then modify the
> remote.<name>.fetch entry accordingly.  Or do you think of any
> workflow that would break under this change ?

Currently, 'stg clone' just calls 'git clone' and initializes the
master branch. There is no patches/<branch>/current file as there is
no current patch.

> Even if we would not need it here, it would be good to have those 2
> parameters set when we can infer them.  That reminds me that "stg
> clone" does not appear to allow selecting a specific branch in the
> parent repo (which explains why the .merge parameter is not so
> crucially needed yet: we always clone the main branch).

I haven't looked at 'git clone' recently, can you select a specific branch?

-- 
Catalin
