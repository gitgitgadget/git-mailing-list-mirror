From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Mon, 23 Jan 2012 08:53:23 -0500
Message-ID: <CADo4Y9iH+J-X-TdqTN2Y9KhQnprnCVvC4Xy6qhVHwsBRmsZUrg@mail.gmail.com>
References: <20110607200659.GA6177@sigill.intra.peff.net>
	<CACsJy8BCGi3s8gXr4kk-u8tDWztV6ozg1Tap23Q=TxA5d9iL+g@mail.gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 14:53:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpKKv-0007AC-C6
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 14:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab2AWNxZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 08:53:25 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51171 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab2AWNxY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2012 08:53:24 -0500
Received: by vbbfc26 with SMTP id fc26so271442vbb.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 05:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=QjWWnif5fJRCaQGLsKLFJlrIsoJhP0jzbGiyOfonglM=;
        b=ASfXZaRipVSrbBWDHD4fuNdASoGdUQbmj3f0ll8vjfRl79TjCeoAtN7hmYZUh/UUhs
         2mbOBYw6WVVTQP5+EkKNns9Tr+qrbi6uLQA9rgBoPA8TUeq0yoUHvUyguUmExRLaxMr6
         8sm8+Z7pu9XI7cyqXRjb/5nxMw7tzv1sTaIv4=
Received: by 10.52.90.171 with SMTP id bx11mr3905755vdb.26.1327326803354; Mon,
 23 Jan 2012 05:53:23 -0800 (PST)
Received: by 10.52.64.231 with HTTP; Mon, 23 Jan 2012 05:53:23 -0800 (PST)
In-Reply-To: <CACsJy8BCGi3s8gXr4kk-u8tDWztV6ozg1Tap23Q=TxA5d9iL+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188990>

On Mon, Jan 23, 2012 at 5:32 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
>
> (Bringing up an old thread)

"...thank you so much for bringing up such a painful subject. While
you're at it, why don't you give me a nice paper cut and pour lemon
juice on it."


"git put" is "git cp".=A0 It copies from one filesystem (or a snapshot
of a filesystem) to another filesystem.

Without multiple working directories, a modifiable "stash", or a
(useful) name for the filesystem referred to as
"index"/"cache"/"staging area", there is only one filesystem that the
command can write to: the (singular) working directory.

So, "git put <src filesystem> -- <path>" is fine.=A0 It will copy from
the path in the src filesystem to the path in the current working
directory.=A0 I don't think the command "put" is a great name for that.
Since we already have some strange double-usage commands like "git
checkout --" and "git reset --", perhaps this should be "git
cherry-pick --".

<rant>
But for my money, "git cp" is clearer and I'd love to get rid of the
user-confusing double-usage commands.=A0 I'd replace "git checkout --"
with "git cp NEXT WTREE -- <path>" and replace "git reset --" with
"git cp HEAD NEXT --" where NEXT is the filesystem represented by the
"index"/"cache"/"staging area" and WTREE is an alias for the working
directory.
</rant>

Still, good luck.  It's a useful addition even if it is "git cherry-pic=
k --".

Mike

>
>
> On Wed, Jun 8, 2011 at 3:06 AM, Jeff King <peff@peff.net> wrote:
> > ...
> > But another way to think about it is that commits, the index, and t=
he
> > working tree are all "locations" with content. And one common opera=
tion
> > you may want to do is to move content from one spot to another, eit=
her
> > whole, by file, or by diff hunks. To a new user, knowing that "add"=
 is
> > the command for moving content from thet working tree to the index =
does
> > not help them know which command to use to do the opposite content
> > movement.
> > ...
> > My idea is therefore to have a single command for moving content fr=
om
> > one location to another. You specify a source and a destination and=
 get
> > a uniform interface for moving content.
> >
> > A proof-of-concept patch is below. Be aware that is meant to be
> > illustrative and is not well tested. Also, it is a minimal presenta=
tion
> > of the concept. Other "locations" may also be meaningful. I'll incl=
ude
> > some ideas below the patch.
> >
> > ---
> > =A0Makefile =A0 | =A0 =A01 +
> > =A0git-put.sh | =A0 70 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> > =A02 files changed, 71 insertions(+), 0 deletions(-)
> > =A0create mode 100644 git-put.sh
> >
> > diff --git a/Makefile b/Makefile
> > index e40ac0c..4564506 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -368,6 +368,7 @@ SCRIPT_SH +=3D git-merge-one-file.sh
> > =A0SCRIPT_SH +=3D git-merge-resolve.sh
> > =A0SCRIPT_SH +=3D git-mergetool.sh
> > =A0SCRIPT_SH +=3D git-pull.sh
> > +SCRIPT_SH +=3D git-put.sh
> > =A0SCRIPT_SH +=3D git-quiltimport.sh
> > =A0SCRIPT_SH +=3D git-rebase.sh
> > =A0SCRIPT_SH +=3D git-repack.sh
> > diff --git a/git-put.sh b/git-put.sh
> > new file mode 100644
> > index 0000000..f673e14
> > --- /dev/null
> > +++ b/git-put.sh
> > @@ -0,0 +1,70 @@
> > +#!/bin/sh
> > +
> > +SUBDIRECTORY_OK=3DYes
> > +OPTIONS_KEEPDASHASH=3DYes
> > +OPTIONS_SPEC=3D"\
> > +git put [options] <from> <to> [--] <file...>
> > +
> > +Move contents from one place to another, where <from> and <to> are=
 one of:
> > + =A01. A commit (e.g., master, HEAD~10, v1.7.5)
> > + =A02. The special token INDEX to indicate git's index.
> > + =A03. The special token WORKTREE to indicate the working director=
y.
> > +
> > +Options:
> > +--
> > +p =A0 =A0 =A0 =A0 =A0 =A0don't move whole files; use the patch int=
erface
> > +"
> > +. git-sh-setup
> > +
> > +patch=3D
> > +while test $# !=3D 0; do
> > + =A0 =A0 =A0 case "$1" in
> > + =A0 =A0 =A0 -p) patch=3D--patch ;;
> > + =A0 =A0 =A0 --) shift; break ;;
> > + =A0 =A0 =A0 *) usage ;;
> > + =A0 =A0 =A0 esac
> > + =A0 =A0 =A0 shift
> > +done
> > +test $# -lt 2 && usage
> > +
> > +from=3D$1; shift
> > +to=3D$1; shift
> > +test "$1" =3D "--" && shift
> > +
> > +type_of() {
> > + =A0 =A0 =A0 case "$1" in
> > + =A0 =A0 =A0 INDEX) echo index ;;
> > + =A0 =A0 =A0 WORKTREE) echo worktree ;;
> > + =A0 =A0 =A0 *) echo commit ;;
> > + =A0 =A0 =A0 esac
> > +}
> > +
> > +# Checkout contents to worktree without munging the index in
> > +# between.
> > +worktree_checkout() {
> > + =A0 =A0 =A0 old=3D$GIT_INDEX_FILE
> > + =A0 =A0 =A0 test -z "$old" && old=3D$(git rev-parse --git-dir)/in=
dex
> > + =A0 =A0 =A0 new=3D$(git rev-parse --git-dir)/put-index.tmp
> > + =A0 =A0 =A0 cp "$old" "$new" &&
> > + =A0 =A0 =A0 GIT_INDEX_FILE=3D$new git checkout "$@"
> > + =A0 =A0 =A0 status=3D$?
> > + =A0 =A0 =A0 rm -f "$new"
> > + =A0 =A0 =A0 exit $status
> > +}
> > +
> > +case "$(type_of "$from"),$(type_of "$to")" in
> > +*,commit)
> > + =A0 =A0 =A0 die "You can't modify an existing commit." ;;
> > +index,index)
> > + =A0 =A0 =A0 die "You can't move content from the index on top of =
itself." ;;
> > +worktree,index)
> > + =A0 =A0 =A0 exec git add $patch -- "$@" ;;
> > +commit,index)
> > + =A0 =A0 =A0 exec git reset $patch "$from" -- "$@" ;;
> > +index,worktree)
> > + =A0 =A0 =A0 exec git checkout $patch -- "$@" ;;
> > +worktree,worktree)
> > + =A0 =A0 =A0 die "You can't move content in the worktree on top of=
 itself." ;;
> > +commit,worktree)
> > + =A0 =A0 =A0 worktree_checkout $patch "$from" -- "$@" ;;
> > +esac
> >
> >
> > As you can see, this handles only three typoes of locations: the
> > worktree, the index, and an arbitrary commit (really a tree-ish).
>
> Last time we were stuck at the magic keywords INDEX and WORKTREE. Wha=
t
> if we sort of follow scp naming convention:
>
> =A0- Normal paths are working tree's paths
> =A0- Paths with a colon in it are in "remote" locations (index or a
> tree). The part before colon specifies the location.
>
> We could have:
>
> git put <src> [<src>...] <dst>
> git put <src> [<src>...] <dst> -- <pathspec>
>
> Where <src> and <dst> could be
>
> =A0- <tree-ish> <colon> [<pathspec>]
> =A0- [0-3] <colon> [<pathspec>]
> =A0- <pathspec> (or plain path)
>
> In the first form, pathspec could be specified in <src>. If <dst> is
> worktree, then "." would be enough (or path to repo's root to be more
> strict). In the second form, no pathspec can be part of <src> nor
> <dst> because they're at the end already.
>
> With this syntax we could have:
>
> git put 0:path/to/file.c . (or git put 0: path/to/file.c)
> =A0-> copy file.c from index to worktree (at the same path "path/to/f=
ile.c")
> git put path/to/file 0:
> =A0-> copy file to index
> git put HEAD: . -- path/
> =A0-> checkout everything in path/ from HEAD
>
> I'm not sure how mutiple <src> should work, but there may be a use ca=
se for it.
>
> > Some other types I've thought of are:
> > ...
> > =A0- branches as destinations; obviously we can't change an existin=
g
> > =A0 =A0commit, but what about something like:
> >
> > =A0 =A0 =A0git put WORKTREE BRANCH:foo
> >
> > =A0 =A0to optionally create a new branch "refs/heads/foo" based on =
the
> > =A0 =A0current HEAD, push changes into a temporary index that match=
es its
> > =A0 =A0tip, and then making a new commit based on top.
> >
> > =A0 =A0This would serve a similar purpose to stashes, except that t=
hey
> > =A0 =A0would be named and could operate as full branches. I would f=
ind it
> > =A0 =A0useful for picking apart a mass of worktree changes into dis=
crete
> > =A0 =A0commits.
> >
> > =A0- allow multiple destinations, like
> >
> > =A0 =A0 # equivalent to "git checkout --"
> > =A0 =A0 git put HEAD INDEX,WORKTREE
>
> These obviously do not work with the syntax I propose.
> --
> Duy
