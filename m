From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 1/5] Check for local changes with "goto"
Date: Fri, 13 Mar 2009 02:57:55 +0100
Message-ID: <20090313015755.GA15393@diana.vm.bytemark.co.uk>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com> <20090312120856.2992.48548.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 02:59:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhwgQ-000424-09
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 02:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbZCMB6G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 21:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbZCMB6E
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 21:58:04 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:45830 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZCMB6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 21:58:03 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lhwep-00048r-00; Fri, 13 Mar 2009 01:57:55 +0000
Content-Disposition: inline
In-Reply-To: <20090312120856.2992.48548.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113128>

On 2009-03-12 12:08:56 +0000, Catalin Marinas wrote:

> This is done by default, unless the --keep option is passed, for
> consistency with the "pop" command. The index is checked in the
> Transaction.run() function so that other commands could benefit from
> this feature (off by default).
>
> This behaviour can be overridden by setting the stgit.autokeep option=
=2E

Two small nits; otherwise,

  Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

> -    trans =3D transaction.StackTransaction(stack, 'goto')
> +    clean_iw =3D not options.keep and iw or None

Add some parentheses here, please! I know that "and" binds tighter
than "or", but I have to think for too long to remember which is
which, and I'll bet I'm not alone ...

> +    def __assert_index_worktree_clean(self, iw):
> +        if not iw.worktree_clean() or \
> +           not iw.index.is_clean(self.stack.head):
> +            self.__halt('Repository not clean. Use "refresh" or '
> +                        '"status --reset"')

"Repository" is misleading here. Maybe something like

   ix_c =3D iw.index.is_clean(self.stack.head)
   wt_c =3D iw.worktree_clean()
   if not ix_c or not wt_c:
       self.__halt('%s not clean. Use "refresh" or "status --reset"'
                   % { (False, True): 'Index', (True, False): 'Worktree=
',
                       (False, False): 'Index and worktree' }[(ix_c, wt=
_c)])

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
