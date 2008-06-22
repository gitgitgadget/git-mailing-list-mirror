From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 2/4] Implement a new patch identification scheme and id command
Date: Sun, 22 Jun 2008 17:27:58 +0200
Message-ID: <20080622152758.GB4468@diana.vm.bytemark.co.uk>
References: <20080619214023.27794.97039.stgit@localhost.localdomain> <20080619214210.27794.76950.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 17:29:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KARV1-0005fX-63
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 17:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbYFVP2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2008 11:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbYFVP2H
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 11:28:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4026 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbYFVP2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 11:28:06 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KARTy-0001Hc-00; Sun, 22 Jun 2008 16:27:58 +0100
Content-Disposition: inline
In-Reply-To: <20080619214210.27794.76950.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85784>

On 2008-06-19 22:42:10 +0100, Catalin Marinas wrote:

> The new scheme allows '[<branch>:]<patch>' and '[<branch>:]{base}'
> (the latter showing the base of a stack). The former format allows
> symbols like ^ and ^{...}.

Hmm. Why only the former? Supporting it for the latter should be easy.
(Though it would take some extra work, I guess.)

Other than that, it looks good to me.

> +def git_commit(name, repository, branch =3D None):
> +    """Return the a Commit object if 'name' is a patch name or Git c=
ommit.
> +    The patch names allowed are in the form '<branch>:<patch>' and c=
an be
> +    followed by standard symbols used by git-rev-parse. If <patch> i=
s '{base}',

Long line.

> +    # The stack base
> +    if patch =3D=3D '{base}':
> +        return repository.get_stack(branch).base

Should be a simple matter of

  if patch.startswith('{base}'):
      foo =3D repository.get_stack(branch).base + drop_prefix(patch, '{=
base}')
      return repository.rev_parse(foo)

or something.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
