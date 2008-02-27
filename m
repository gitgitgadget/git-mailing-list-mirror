From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit - continue rebase after merge conflict?
Date: Wed, 27 Feb 2008 10:38:08 +0100
Message-ID: <20080227093808.GA7795@diana.vm.bytemark.co.uk>
References: <20080226145725.GA24987@ldl.fc.hp.com> <b0943d9e0802260856j6e9b0053ne4916149d8e4387c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Chiang <achiang@hp.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 10:39:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUIl9-0004ey-QZ
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 10:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbYB0Jic convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 04:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbYB0Jic
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 04:38:32 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3461 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbYB0Jib (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 04:38:31 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JUIjo-0002Vr-00; Wed, 27 Feb 2008 09:38:08 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0802260856j6e9b0053ne4916149d8e4387c@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75217>

On 2008-02-26 16:56:53 +0000, Catalin Marinas wrote:

> or (if you want to skip that patch):
>
> $ stg push --undo
> $ stg push next-patch..

Better use

  $ stg push next-patch..top-patch

which works even if you don't want to push _all_ patches.

> The 'rebase' command doesn't store any information about the state
> of the stack and cannot continue it. Maybe we'll do something in the
> next release as the refactored code has support for transactions.

Hmm, that's an interesting idea. Maybe an "stg resume" command that
one would run after having resolved the conflicts.

One implementation would be to save a .stgit-todo file with contents
like this:

  push foo
  push bar
  push baz

It would have to handle more than just pushes, however. For example,
stg coalesce will try to first push the given patches in order, and
then coalesce them, so for that case .stgit-todo might look like this:

  push bar
  push baz
  coalesce foo bar baz
  push frotz

We should be able to redefine each non-atomic stgit command in terms
of such atomic commands, and get resumeability all over the place.

I'm not sure this is a good idea, but it is intriguing.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
