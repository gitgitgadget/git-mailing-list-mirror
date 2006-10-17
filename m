From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] nice ftplugin for vim, that shows the commited diff in a split'ed buffer.
Date: Tue, 17 Oct 2006 12:38:02 +0200
Organization: Polytechnique.org
Message-ID: <200610171238.04372.madcoder@debian.org>
References: <11610450702261-git-send-email-madcoder@debian.org> <11610450701082-git-send-email-madcoder@debian.org> <802d21790610170122j6191ba51l2c39d3bc6a3475b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6687004.dqHsB5XBZL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 17 12:38:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZmKq-0000vG-Ep
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 12:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWJQKiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 06:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161206AbWJQKiI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 06:38:08 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:16537 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S1161189AbWJQKiH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 06:38:07 -0400
Received: from mad.intersec.eu (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id 10E093318A;
	Tue, 17 Oct 2006 12:38:06 +0200 (CEST)
To: "Peter Baumann" <peter.baumann@gmail.com>
User-Agent: KMail/1.9.5
In-Reply-To: <802d21790610170122j6191ba51l2c39d3bc6a3475b@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Tue Oct 17 12:38:06 2006 +0200 (CEST))
X-DCC-xorg-Metrics: djali 32702; Body=3 Fuz1=3 Fuz2=3
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000002, queueID=3F90933228
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29053>

--nextPart6687004.dqHsB5XBZL
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le mar 17 octobre 2006 10:22, Peter Baumann a =C3=A9crit :
> 2006/10/17, Pierre Habouzit <madcoder@debian.org>:
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  contrib/vim/README                 |    6 ++++
> >  contrib/vim/ftplugin/gitcommit.vim |   61
> > ++++++++++++++++++++++++++++++++++++ 2 files changed, 67
> > insertions(+), 0 deletions(-)
> >
> > diff --git a/contrib/vim/README b/contrib/vim/README
> > index 9e7881f..26c1682 100644
> > --- a/contrib/vim/README
> > +++ b/contrib/vim/README
> > @@ -6,3 +6,9 @@ To syntax highlight git's commit message
> >       $ cat >>$HOME/.vimrc <<'EOF'
> >       autocmd BufNewFile,BufRead COMMIT_EDITMSG set
> > filetype=3Dgitcommit EOF
> > +
> > +To use the fancy split-view with the currently commited diff, you
> > need to: +  1. Copy ftplugin/gitcommit.vim to vim's ftplugin
> > directory: +     $ mkdir -p $HOME/.vim/ftplugin
> > +     $ cp ftplugin/gitcommit.vim $HOME/.vim/ftplugin
> > +  2. Auto-detect the editing of git commit files (see above).
> > diff --git a/contrib/vim/ftplugin/gitcommit.vim
> > b/contrib/vim/ftplugin/gitcommit.vim new file mode 100644
> > index 0000000..f9efd59
> > --- /dev/null
> > +++ b/contrib/vim/ftplugin/gitcommit.vim
> > @@ -0,0 +1,61 @@
> > +if exists("b:did_ftplugin")
> > +  finish
> > +endif
> > +
> > +let b:did_ftplugin =3D 1
> > +
> > +setlocal tw=3D74
> > +setlocal nowarn nowb
> > +
> > +"{{{ function Git_diff_windows
> > +
> > +function! Git_diff_windows()
> > +    let i =3D 0
> > +    let list_of_files =3D ''
> > +
> > +    " drop everything until '#  (will commit)' and the next empty
> > line +    while i <=3D line('$')
> > +        let line =3D getline(i)
> > +        if line =3D~ '^#\s*(will commit)$'
> > +            let i =3D i + 2
> > +            break
> > +        endif
> > +
> > +        let i =3D i + 1
> > +    endwhile
> > +
> > +    " read file names until we have EOF or an empty line
> > +    while i <=3D line('$')
> > +        let line =3D getline(i)
> > +        if line =3D~ '^#\s*[a-z ]*:.*->.*$'
> > +            let file =3D substitute(line,
> > '\v^#[^:]*:.*->\s*(.*)\s*$', '\1', '') +            let
> > list_of_files =3D list_of_files . ' '.file
> > +            let file =3D substitute(line,
> > '\v^#[^:]*:\s*(.*)\s*->.*$', '\1', '') +            let
> > list_of_files =3D list_of_files . ' '.file
> > +        elseif line =3D~ '^#\s*[a-z ]*:'
> > +            let file =3D substitute(line, '\v^#[^:]*:\s*(.*)\s*$',
> > '\1', '') +            let list_of_files =3D list_of_files . ' '.file
> > +        elseif line =3D~ '^#\s*$'
> > +            break
> > +        endif
> > +
> > +        let i =3D i + 1
> > +    endwhile
> > +
> > +    if list_of_files =3D=3D ""
> > +        return
> > +    endif
> > +
> > +    rightbelow vnew
>
> I find it confusing that you split vertically, especially if I work
> in small terminals.
> I would prefere a horizontal split, thats why I changed it to the way
> to the way it is
> handled in the svn.vim commit case:
>
> below new
>
> > +    silent! setlocal ft=3Ddiff previewwindow bufhidden=3Ddelete
> > nobackup noswf nobuflisted nowrap buftype=3Dnofile +    exe 'normal
> > :r!LANG=3DC cd ..; git diff HEAD -- ' . list_of_files . "\n1Gdd" +  =20
> > exe 'normal :r!LANG=3DC cd ..; git diff HEAD -- ' . list_of_files . "
> > \| git apply --stat\no\<esc>1GddO\<esc>"
>
> Why changing directory? I had to remove the cd .. to make it work.
> Otherwise git diff couldn't find the repository.

because for me, wherever I'm from, the cwd is .git/ but it's maybe due=20
to the fact that I use autochdir, I don't know.

=2D-=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--nextPart6687004.dqHsB5XBZL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFNLKMvGr7W6HudhwRAvsUAJ4/hv3Q1/Oe9CiB2on0D1uVJQCUJACdHLhO
jKvDvKQHjBPNnIAvAym8EDg=
=8Wcy
-----END PGP SIGNATURE-----

--nextPart6687004.dqHsB5XBZL--
