From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Sharing a file between projects
Date: Mon, 24 May 2010 03:55:33 -0500
Message-ID: <20100524085533.GA25227@progeny.tock>
References: <D3671E72-7B04-446B-86A8-48761FD476E4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Patrick Rutkowski <rutski89@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 10:55:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGTRV-0005k9-0m
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 10:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136Ab0EXIzT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 May 2010 04:55:19 -0400
Received: from mail-yw0-f180.google.com ([209.85.211.180]:54415 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab0EXIzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 04:55:18 -0400
Received: by ywh10 with SMTP id 10so1757767ywh.1
        for <git@vger.kernel.org>; Mon, 24 May 2010 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wvUlUR2pMGTxgaA4WRIKXBG1Y7drG9deCFSGDUTH6bY=;
        b=KD3paior8GJX8WLnpHn5VweQRsksjiL2qnjZhKlHINwztG5ShmN8jFp7hKSDxh3LjW
         D9yYxQlblMPpU+6D1MvGEbiA54TDMX25Sp5ambGDcAYTSa06wh3KSQ/7cloqvSKDnnEU
         oNXNDR6BsqfW0q4p+o0kGFibf+MXBcejZPbfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wAXK1g8PIBotaSsNGq8eFyh+W9lwzHWwcoaxaJK9CnSw+hP+KlxyOXtpM/9kvPiwxR
         ZoitYwU0oC9YWNa9ByEwfFnarDqcNQg/AXrQyDPuiEJpp6nCVWEkR9iHr930odmTLBwR
         z66MWv4Ki6TiiYCKCtWgcYqPFuF3F9z/trC0U=
Received: by 10.150.128.24 with SMTP id a24mr6375247ybd.268.1274691316347;
        Mon, 24 May 2010 01:55:16 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2928920ywh.1.2010.05.24.01.55.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 01:55:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <D3671E72-7B04-446B-86A8-48761FD476E4@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147614>

Patrick Rutkowski wrote:

> I also don't want to have to manually make sure that foo.cfg is
> synced among all three projects.

Give foo.cfg its own repo, since it seems it is independently useful.
Then you could use it from your other projects P1, P2, P3 in one of
the following ways:

a. Installation script (=E2=80=98make install=E2=80=99) copies foo.cfg =
to some
   standard filename, such as /usr/share/foo/foo.cfg or /etc/foo.cfg.

   Then use it from there, e.g. by tracking an ordinary symlink
   /etc/foo.cfg -> foo.cfg in the P1, P2, P3 trees.

b. Occasionally pull from the foo.cfg project into P1, P2, and P3.

c. Teach P1, P2, P3 build scripts to clone the foo.cfg repo and grab
   foo.cfg

d. Add the foo.cfg repo as a submodule of the P1, P2, and P3 repos.

Examples:

 a. most libraries.  I guess /usr/lib/tclConfig.sh and
    /usr/lib/pkgconfig/* are good examples.
 b. Debian X build system: http://git.debian.org/?p=3Dpkg-xorg/xsfbs.gi=
t
 d. gnulib: http://git.savannah.gnu.org/cgit/gnulib.git/tree/users.txt

Relevant git features:

 a. If there is a symlink in the worktree, the only information that
    git will notice is =E2=80=9Csymlink to <target>=E2=80=9D.  The cont=
ent of the
    target does not enter the tracked tree.

 b. Merging from an independent project is a perfectly okay way to add
    files.  Merging again is a good way to update them.

    Merging changes back to a smaller project is not so well
    supported[1].

 d. Using submodules works like this:

    . =E2=80=98git clone --recursive=E2=80=99 to grab all the relevant =
files at once

    . Do work within submodules and =E2=80=98git push=E2=80=99 to publi=
sh your work

    . Git will remember the =E2=80=98last tested commit=E2=80=99 so new=
 changes to
      foo.cfg do not break new clones of P1, P2, and so on until
      someone in each project explicitly acks them.

    . See git-submodule(1) for details (and please let us know about
      confusing or missing details in that manual).

Thoughts?
Jonathan

[1] Suppose I have been working for a while as in case (b) above [time
flows from left to right]:

 foo.git:    F --- G --- H --- I
                    \           \
 P1: A --- B --- C - M --- D --- N --- O

Now I make a change to foo.cfg (Q) and commit and push it in P1.git,
even though it ought to have been done in foo.git so it could be used
by P2 and P3, too.  Oops.

 foo.git:    F --- G --- H --- I
                    \           \
 P1: A --- B --- C - M --- D --- N --- O --- Q

Now I could try to merge P1 into foo.git, but unfortunately the result
would be a commit incorporating all development from both branches,
including the files from P1 that are _not_ foo.cfg.

I use git-filter-branch(1) to recover, producing an alternate history
tracking only changes to foo.cfg:

      F --- G --- H --- I
             \           \
        A' ---M'----------N' --- Q'

Uh, the desired history looks more like the following:

     F --- G --- H --- I --- Q'

but git filter-branch --prune-empty is not sophisticated enough to do
that.  Maybe someone can chime in with a script for this situation.

Now I merge the rewritten history into foo.git:

 foo.git:    F --- G --- H --- I --- Q'
                    \           \
 P1: A --- B --- C - M --- D --- N --- O --- Q

and use =E2=80=98merge -s ours=E2=80=99 to indicate that the new change=
s have already
been incorporated into P1.

 foo.git:    F --- G --- H --- I ------ Q' ---.
                    \           \              \
 P1: A --- B --- C - M --- D --- N --- O --- Q - R
