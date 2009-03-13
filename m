From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 5/5] Convert "float" to the lib infrastructure
Date: Fri, 13 Mar 2009 03:41:37 +0100
Message-ID: <20090313024137.GE15393@diana.vm.bytemark.co.uk>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com> <20090312120918.2992.82713.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 03:45:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhxPE-0006Ob-D3
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 03:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758243AbZCMCln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 22:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758158AbZCMCll
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 22:41:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:60883 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758304AbZCMClk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 22:41:40 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LhxL7-0004O2-00; Fri, 13 Mar 2009 02:41:37 +0000
Content-Disposition: inline
In-Reply-To: <20090312120918.2992.82713.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113138>

Nice job here too.

On 2009-03-12 12:09:18 +0000, Catalin Marinas wrote:

>  options =3D [
>      opt('-s', '--series', action =3D 'store_true',
> -        short =3D 'Rearrange according to a series file')]
> +        short =3D 'Rearrange according to a series file')
> +    ] + argparse.keep_option()

This flag should take the filename as a parameter, both because it's
the right thing to do and because it'll make the tab completion work
right (as is, it'll complete on patch names after the -s flag).

Something like

  opt('-s', '--series', type =3D 'string')

ought to do it.

> +    applied =3D [p for p in stack.patchorder.applied if p not in pat=
ches] + \
> +            patches
> +    unapplied =3D [p for p in stack.patchorder.unapplied if p not in=
 patches]

It may be just me, but I find "not p in patches" more readable than "p
not in patches". Oh, and the backslash.

=46eel free to ignore, of course. :-)

> +    hidden =3D list(stack.patchorder.hidden)
> +
> +    iw =3D stack.repository.default_iw
> +    clean_iw =3D not options.keep and iw or None
> +    trans =3D transaction.StackTransaction(stack, 'sink',
> +                                         check_clean_iw =3D clean_iw=
)
> +
> +    try:
> +        trans.reorder_patches(applied, unapplied, hidden, iw)

That default value for hidden would've come in handy here too!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
