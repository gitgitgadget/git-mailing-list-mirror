From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Advice on choosing git
Date: Wed, 12 May 2010 04:24:46 -0500
Message-ID: <20100512092446.GA17520@progeny.tock>
References: <4BEA4B46.6010009@smartmediacorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
To: Noah Silverman <noah@smartmediacorp.com>
X-From: git-owner@vger.kernel.org Wed May 12 11:24:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC8BI-0003d3-4R
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 11:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab0ELJYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 May 2010 05:24:36 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:47723 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab0ELJYe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 05:24:34 -0400
Received: by gxk8 with SMTP id 8so1361390gxk.9
        for <git@vger.kernel.org>; Wed, 12 May 2010 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wMPwHhtnSARiKS9xNv2q5XpivIvD2OoopbjSpC/pD0Q=;
        b=IZ2iLwQRGDxBg+7E8gANBOHiJ+wtZxSSvDUhkN1v4m5UzlzbnzSC56MctZDmd5kiBf
         p0/pTZCFmuydT3IDm50/rTTlo29+2hNmK+ryu07ACxi9JHqzUEvSUdgGz15p9rpdIe+Y
         w4i3aZ4IXwpT3DPa9DmQlO8yMQqUiPJ+b3mLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CLNWZ+oLASAy4bqy45L9mzepO/a7D3/GFrqrfmwwH3O1CUkFPUJqI9bb2bV5zGqKQU
         2z8aNswIsIyTTWM2sXrijakVqoR27gfkd+4vOAeD/Kz0sV8Cb8cc4OszW2whALiDaUGT
         quFjr1hTugGmlDhO9HfaRnXu+PwgWnrxkFO0o=
Received: by 10.101.203.27 with SMTP id f27mr3822533anq.239.1273656271723;
        Wed, 12 May 2010 02:24:31 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm5076577ywh.3.2010.05.12.02.24.28
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 02:24:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BEA4B46.6010009@smartmediacorp.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146935>

Hi,

Noah Silverman wrote:

> I'm looking for both a version control system and backup system.

I am fond of this question. :)

> I guess, that I need just keep some files backed up (and/or synced) a=
s
> they're not "working projects".  I will add new documents and
> occasionally edit others, but no real need for versioning.

I suggest rsync or unison[1], and to use btrfs locally if you want
snapshots.  I don=E2=80=99t know a good tool for shared snapshots, but =
that is
probably my ignorance.

In my humble opinion, tools designed for tracking source code, like
git and bzr, are not appropriate for this task.  To illustrate this, I
have put some thoughts about how to cheat git into doing an okay job
in a footnote[4].

> Other files
> are working projects (possible with collaboration) and need active VC=
S.=20

In very small projects, I believe any free DVCS will do.

What tools are you and your collaborators already comfortable with?
I hear it can be hard to unlearn habits from using Subversion when
getting started with Git.  Some other version control systems cater to
that transition better.

As projects scale in size, the speed differences between version
control systems start to matter.  I find myself making larger commits,
looking through history less, and checking email more often when using
certain systems.

> From what I have read, I will
> effectively have multiple copies of each item on my hard drive, thus
> eating up a lot of space (One of the "working file"and several in the
> .git directory.) If I have multiple changes to a file, then I have
> several full versions of it on my machine.

If your files are relatively compressible (or at least rsyncable) and
you pack your the repository occasionally, this should not be a
problem.  The relevant page[2] of the Pro Git book tells probably more
than you wanted to know about this.

Short summary: each file is initially stored in the .git directory as
a compressed file named after its content.  When asked to pack with
the "git gc"[3] command (or automatically if there are too many
unpacked objects around), git puts the data into a larger "pack file",
this time as a delta against some suitable similar blob.

=46or source code (which is already rather compressible), this tends to
work well.  My local git/.git object repository is about 2=C2=BD times =
the
size of the working copy.

> This could be a problem for
> a directory with 100GB or more, especially on a laptop with limited h=
ard
> drive space.

Yes.  Actually, this point is why I replied.  Using a source code
management system as a backup system generally implies this weird
assumption that even the oldest revisions are always worth keeping.

With big, machine-generated files, that doesn=E2=80=99t make sense to m=
e ---
it is better to be able to throw away some snapshots when you are
running low on space.

> 2) Sub-directory selection.  On my laptop, I only want a few
> sub-directories to be synced up.  I don't need my whole document tree=
,
> but just a few directories of things I work on.

It requires foresight, but you could use a separate filesystem for
this (possibly loop-mounted) if you want to keep snapshots.  With
some symlinks, this would not require changing the directory
structure.

> Any and all suggestions are welcome and appreciated.

Thanks for the food for thought.
Jonathan

[1] http://www.cis.upenn.edu/~bcpierce/unison/
[2] http://progit.org/book/ch9-4.html
[3] http://www.kernel.org/pub/software/scm/git/docs/git-gc.html
[4]
So, you want to use git as a general backup tool?

 . Files should be compressible.  Set appropriate attributes.  Use
   clean and smudge filters[5] to replace the weird working-copy
   representation with a simpler tracked form.  Use !delta[6] where
   appropriate so git knows not to waste its time.

 . Files should be conducive to de-duplication.  Cut large files
   into slices using rsync=E2=80=99s rolling checksum algorithm[7].

 . Backups should be fault-tolerant.  Use par2[8] or zfec[9] to
   protect pack files, maybe.

 . Sometimes metadata (file owners and modes) is important.  Track a
   "restore" script that sets the appropriate metadata, and update it
   before each commit[10].

 . Files should not change as git reads them (or it will error
   out).  Wait for a quiescent state to backup, or make a
   snapshot some other way and ask git to back up that.

 . Old revisions are not precious.  It would be nice to be able to
   decide when each backed-up tree can expire.  My best suggestion is
   to rely on reflogs[11] instead of the revision graph to represent
   your history so old versions can expire, but getting this to work
   nicely would take some work: there is no built-in mechanism to
   transfer reflogs and associated objects to another repository, for
   example.

[5] http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html#=
_tt_filter_tt
[6] http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html#=
_tt_delta_tt
[7] http://github.com/apenwarr/bup
[8] http://parchive.sourceforge.net/
[9] http://allmydata.org/trac/zfec
[10] http://kitenet.net/~joey/code/etckeeper/
[11] http://www.kernel.org/pub/software/scm/git/docs/git-reflog.html
