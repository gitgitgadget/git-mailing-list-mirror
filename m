From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Implement a new patch identification scheme and id command
Date: Sat, 14 Jun 2008 11:47:14 +0200
Message-ID: <20080614094714.GC14282@diana.vm.bytemark.co.uk>
References: <20080614072833.7899.91460.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 11:48:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7SMr-0005Lv-DF
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbYFNJrW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 05:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbYFNJrW
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:47:22 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1110 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106AbYFNJrV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 05:47:21 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K7SLq-0003wM-00; Sat, 14 Jun 2008 10:47:14 +0100
Content-Disposition: inline
In-Reply-To: <20080614072833.7899.91460.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85002>

On 2008-06-14 08:28:33 +0100, Catalin Marinas wrote:

> The new scheme allows '[<branch>:]<patch>' and '[<branch>:]{base}'
> (the latter showing the base of a stack). The former format allows
> symbols like ^, ^{...} etc.

I like your choices.

> +def git_sha1(repository, branch, name):
> +    """Return the SHA1 value if 'name' is a patch name or Git commit=
=2E
> +    The patch names allowed are in the form '<branch>:<patch>' and c=
an be
> +    followed by standard symbols used by git-rev-parse. If <patch> i=
s '{base}',
> +    it represents the bottom of the stack.
> +    """

Why not return the Commit directly, and let the caller extract its
sha1 if that's what it wants?

You don't remove the old parse_rev() and git_id(), and particularly
the latter has a lot of callers. Meaning that the rest of StGit still
speaks the old syntax.

> +    # Try a Git commit first
> +    try:
> +        return repository.rev_parse(name, discard_stderr =3D True).s=
ha1
> +    except libgit.RepositoryException:
> +        pass

What if you have a branch or tag with the same name as a patch? This
will prefer the branch, which might not be the best choice.

> +current one. The bottom of a patch is accessible with the
> +'[<branch>:]<patch>]^' format."""

You have an extra ] here.

> -directory =3D DirectoryHasRepository()
> +directory =3D common.DirectoryHasRepositoryLib()
>  options =3D [make_option('-b', '--branch',
>                         help =3D 'use BRANCH instead of the default o=
ne')]

Couldn't we kill this option? (And in the process, the branch argument
to git_sha1.)

> -test_expect_success 'Try new form of id with slashy branch' \
> +test_expect_success 'Try new id with slashy branch' \

Strictly speaking, this isn't so new anymore.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
