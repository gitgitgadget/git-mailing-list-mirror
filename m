From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 5/9] Convert 'hide' to the lib infrastructure
Date: Wed, 29 Apr 2009 08:27:49 +0200
Message-ID: <20090429062749.GE18483@diana.vm.bytemark.co.uk>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com> <20090428151003.27261.72531.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 08:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz3Gx-0002pQ-Lb
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 08:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbZD2G1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 02:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbZD2G1v
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 02:27:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:56028 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZD2G1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 02:27:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lz3Gn-0004vM-00; Wed, 29 Apr 2009 07:27:49 +0100
Content-Disposition: inline
In-Reply-To: <20090428151003.27261.72531.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117852>

On 2009-04-28 16:10:03 +0100, Catalin Marinas wrote:

> -args =3D [argparse.patch_range(argparse.applied_patches,
> -                             argparse.unapplied_patches)]
> +args =3D [argparse.patch_range(argparse.unapplied_patches)]

Why not simply allow all patches? reorder_patches() below will happily
pop unapplied patches before hiding them IIRC, and for already hidden
patches you could just say "already hidden".

Hmm, but this is for the tab completion, so I guess we'd only want the
applied and unapplied patches here.

> +    patches =3D common.parse_patches(args, trans.all_patches)
> +    for p in patches:
> +        if p in trans.applied:
> +            raise common.CmdException('Cannot hide applied patch "%s=
"' % p)
> +        elif p in trans.hidden:
> +            raise common.CmdException('Patch "%s" already hidden' % =
p)
> +
> +    applied =3D list(trans.applied)
> +    unapplied =3D [p for p in trans.unapplied if not p in set(patche=
s)]
> +    hidden =3D patches + trans.hidden
> +
> +    trans.reorder_patches(applied, unapplied, hidden)
> +    return trans.run()

As I said,

  * Why not simply allow hiding of applied patches?

  * Hiding a hidden patch should probably be a warning (if that), not
    an error.

Otherwise it looks good.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
