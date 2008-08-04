From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT] Not working on Windows with msysgit.
Date: Mon, 4 Aug 2008 11:25:51 +0200
Message-ID: <20080804092551.GC9425@diana.vm.bytemark.co.uk>
References: <g6kvmc$sqr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Jurko Gospodneti? <jurko.gospodnetic@docte.hr>
X-From: git-owner@vger.kernel.org Mon Aug 04 11:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPvzo-0006ZX-U5
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 11:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbYHDJDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 05:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbYHDJDx
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 05:03:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2643 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYHDJDw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 05:03:52 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KPwK7-0002cZ-00; Mon, 04 Aug 2008 10:25:51 +0100
Content-Disposition: inline
In-Reply-To: <g6kvmc$sqr$1@ger.gmane.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91333>

On 2008-07-28 19:29:49 +0200, Jurko Gospodneti? wrote:

> I believe StGIT fails to work on Windows with msysgit installed
> because of the way it runs its external executables. It assumes that
> the executable is available on the path and is named exactly 'git'.

Yes, that's correct.

> This however is not the case on Windows with msysgit installed.
> There the 'git executable' is a batch script named git.cmd and stgit
> fails to find it causing all git calls to return an error code.
>
> Popen() calls in StGIT's run.py module seem to run their executables
> (git & gitk only as far as I saw from the sources) directly instead
> of running them through the shell in order to have the shell try all
> the default extensions (configured on Windows using the PATHEXT
> environment variable).
>
> One 'fix' that corrects this in all the use cases on Windows that I
> tried is to add the shell=3DTrue parameter to all Popen() calls in
> StGIT's run.py module (one in __run_io() and one in __run_noio()).
> This would however require more testing

Don't do that, please.

The reason to not go via the shell is that that way, we don't have to
worry about quoting. That's a big pile of bugs that we never have to
see again.

Plus, it's also slightly faster (especially on Windows, I guess) not
to have to spawn a shell.

It'd be _much_ better to just be a little more flexible about which
git command to use. Maybe look at PATHEXT if we're on Windows, or
maybe let the user configure the location of git at stg install time.
(RFC) patches welcome: :-)

> I do recall Python having some serious problems with these quoting
> in executed commands... something about external quotes getting
> stripped in some cases... I might be able to dig up a workaround
> from somewhere if needed...

That's the shell doing a level of unquoting. Nothing Python specific.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
