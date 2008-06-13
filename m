From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] git-svn: don't append extra newlines at the end of commit messages.
Date: Fri, 13 Jun 2008 08:29:51 +0200
Message-ID: <20080613062951.GB24245@diana.vm.bytemark.co.uk>
References: <1213312251-8081-1-git-send-email-apenwarr@gmail.com> <7vfxrhyjqd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 08:31:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K72pC-0001Dm-6e
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 08:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbYFMGaq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 02:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbYFMGaq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 02:30:46 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4517 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbYFMGap (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 02:30:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K72nH-0006dd-00; Fri, 13 Jun 2008 07:29:51 +0100
Content-Disposition: inline
In-Reply-To: <7vfxrhyjqd.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84841>

On 2008-06-12 22:41:46 -0700, Junio C Hamano wrote:

> Avery Pennarun <apenwarr@gmail.com> writes:
>
> > In git, all commits end in exactly one newline character. In svn,
> > commits end in zero or more newlines. Thus, when importing commits
> > from svn into git, git-svn always appends two extra newlines to
> > ensure that the git-svn-id: line is separated from the main commit
> > message by at least one blank line.
> >
> > Combined with the terminating newline that's always present in svn
> > commits produced by git, you usually end up with two blank lines
> > instead of one between the commit message and git-svn-id: line,
> > which is undesirable.
> >
> > Instead, let's remove all trailing whitespace from the git commit
> > on the way through to svn.
>
> Perl part of the code looks fine but I am unsure if we like the
> ramifications of this patch on existing git-svn managed
> repositories. Doesn't this change the commit object name on our end
> for almost all of them?

You're correct that this will change the commit id of imported svn
revisions -- the new verson of git-svn will give other ids than the
old version. However, the only thing that's going to "break" is that
two separate imports of the same repository with the two different
versions of git-svn will not give the exact same result on the git
side.

I think this is a good change, and it would be a pity if this and
other changes like it had to be dropped out of a desire to keep the
svn -> git transformation function forever fixed. (IIRC, such changes
have been allowed in the past -- e.g. 0bed5eaa: "enable follow-parent
functionality by default".)

One could imagine a policy of not introducing this kind of change
during a stable version, or some such, but historically that's not
been the case as far as I can remember.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
