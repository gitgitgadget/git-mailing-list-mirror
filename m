From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ! [rejected] master -> master (non-fast forward)
Date: Sun, 18 Nov 2007 13:42:19 -0500
Message-ID: <9e4733910711181042x123e99efjad38486654db17e2@mail.gmail.com>
References: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com>
	 <7v7ikfwhkj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 19:42:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itp6M-0001Uv-Un
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 19:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbXKRSmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 13:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbXKRSmV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 13:42:21 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:41869 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbXKRSmU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 13:42:20 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1721723wah
        for <git@vger.kernel.org>; Sun, 18 Nov 2007 10:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DCEQSydVCJKaWd1/u5su9Up5y39Kf+aF6FrbZX+cvvQ=;
        b=YXj+C+u1/3UXx/sxDmSNnNms0TjRsFHEw1yNEfFzgFC4mgpcXjkTZPo9CE1HCzTSnZ0bTU9aUw6gfGJH3kSgaPjjcqnVCoghRWGnXz5MEhmilriAtqJq89jgT8cExojPAbDede1POVtKEAw81Pjq3lzveflkFwH7nvZqSlOg1XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=seivr+uw+/M2OrDNfYZUenothkQqFrJB/EdnCwV1A/HWhCdaEKvr7B9n6YHVjGebn5wHX+stw9JG6f8aQtASAFQsFrtmYGkWosplBlL/oMfiW6ql+ozx5vkp7GckxcW6rWxPKZfzukXnLHT2fpcwOqu9/h07RRIpVDKShLAouzg=
Received: by 10.115.17.1 with SMTP id u1mr797581wai.1195411339902;
        Sun, 18 Nov 2007 10:42:19 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Sun, 18 Nov 2007 10:42:19 -0800 (PST)
In-Reply-To: <7v7ikfwhkj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65381>

On 11/18/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > What's causing this? I'm using stgit on the master branch.
> > I'm fixing it each time on the remote server by deleting the ref to master.
> >
> > jonsmirl@terra:~/ds$ git push digispeaker
> > To ssh://jonsmirl1@git.digispeaker.com/~/projects/digispeaker-kernel.git
> >  ! [rejected]        master -> master (non-fast forward)
> > error: failed to push to
> > 'ssh://jonsmirl1@git.digispeaker.com/~/projects/digispeaker-kernel.git'
> > jonsmirl@terra:~/ds$
>
> A "non-fast forward" means that you had this history earlier:
>
>          o---o---A
>         /
>     ---o
>
> pushed "A" to the remote's 'master', then built this history:
>
>          o---o---A
>         /
>     ---o---o---o---o---A'
>
> by rewinding and rebuilding, and the tip of the branch now
> points at A', which you tried to push to the remote.

stgit must be doing this when I rebase. It pops all of it's patches,
moves to head of linus/master and then rebases them.

I'm the only person with write access to the repo.

> Which often causes troubles for people who are fetching from the
> branch you are pushing into, and forbidden by default as a
> safety measure.

What is the right way to share repositories using stgit? I have a set
of patches which I am working on for kernel inclusion. I have them
applied as a stgit stack on top of linus/master. I need to share this
patch stack with other developers. These developers may want to change
one of my patches. Right now they are emailing me deltas and I apply
them to the appropriate stgit patch. I have seventeen patches in my
stack currently.

I am starting to see why several people have made comments about
integrating stgit into git. When other developers clone my repo the
stgit setup doesn't come with it. It would be great it we could use
git to push the stgit patches around and work on them.

> As long as the people who fetch from the branch knows that you
> will regularly rewinding the tip of the branch, there is no
> confusion, and you can "force" a non-fast forward update.  There
> are two independent safety mechanisms:
>
>  - the sending end safety can be overriden by "git push --force"
>    and/or by using a refspec prefixed with a '+');
>
>  - the receiving end safety can be overriden by the config
>    variable receive.denynonfastworwards of the repository you
>    are pushing into.
>
> The latter defaults to "unsafe", but if the safety is activated
> in the repository, forcing from the sending side will not
> deactivate it.  IOW, both ends need to agree to allow the unsafe
> behaviour.
>
> > On the server I have:
> > [core]
> >         repositoryformatversion = 0
> >         filemode = true
> >         bare = true
> >         logallrefupdates = true
> >
> > bare was set false, I just flipped it to true. The server repo was
> > originally created via a clone from kernel.org and then renamed to be
> > a bare repo. Why do we need a 'bare' attribute?
>
> There are a few things that change behaviour depending on the
> bareness of the repository.  One example is that "git fetch"
> that updates to the current branch (i.e. what HEAD points at) by
> having it as the RHS of a refspec is accepted only for bare
> repositories (for non-bare repositories such a fetch would make
> the HEAD and the work tree go out-of-sync).
>


-- 
Jon Smirl
jonsmirl@gmail.com
