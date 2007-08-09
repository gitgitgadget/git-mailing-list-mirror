From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: 'pu' branch for StGIT
Date: Thu, 9 Aug 2007 16:18:48 +0200
Message-ID: <20070809141848.GA6342@diana.vm.bytemark.co.uk>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk> <1186549433.2112.34.camel@dv> <20070808092027.GB7860@diana.vm.bytemark.co.uk> <20070808213917.GA22521@diana.vm.bytemark.co.uk> <1186611514.7383.4.camel@dv> <20070808232349.GA23172@diana.vm.bytemark.co.uk> <20070808201003.nm90u2s5ny888wcc@webmailbeta.spamcop.net> <20070809073801.GA31482@diana.vm.bytemark.co.uk> <1186665883.28228.31.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 16:19:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ8rD-00037l-P3
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 16:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765724AbXHIOTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 10:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933000AbXHIOTK
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 10:19:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3987 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758770AbXHIOTI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 10:19:08 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IJ8qe-0001la-00; Thu, 09 Aug 2007 15:18:48 +0100
Content-Disposition: inline
In-Reply-To: <1186665883.28228.31.camel@dv>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55453>

On 2007-08-09 09:24:43 -0400, Pavel Roskin wrote:

> On Thu, 2007-08-09 at 09:38 +0200, Karl Hasselstr=F6m wrote:
>
> > I take it this all means you're actually using my branch? What's
> > your opinion on its usefulness?
>
> Well, I tried it, and then ran a script to update all local
> repositories. It converted everything to "version 3", so I'm sort of
> stuck with it. If the "version 3" code is not committed to the
> mainline StGIT, I'll have to convert my repositories back or even
> re-fetch them.

Thanks for the vote of confidence. :-)

You should be able to do something like

  $ stg applied > .git/patches/branch/applied
  $ stg unapplied > .git/patches/branch/unapplied

and then manually change the version from 3 to 2, and be ready to go.
I haven't tested this, though!

> I have noticed two problems so far, but I cannot tell is they are
> specific to the "pu" branch.
>
> 1) Undead patches.

I saw the same problem today. I haven't had time to look into it, but
I believe it's due to stgit trying to directly modify files under
=2Egit/refs instead of using git-update-ref, which breaks with packed
refs. The DAG patches rely much more on the refs, so the bug is more
severe in that case.

https://gna.org/bugs/?9710

> There is also a file .git/patches/wireless-dev/patchorder, which
> contains "at76_usb".

The patchorder file should be harmless. It's only used to determine
patch order for those cases where the DAG information isn't
sufficient. (That is, for unapplied patches.) It's strictly advisory,
and _not_ used to determine which patches exist.

> I was updating the repository by "stg pull", there were two patches,
> "at76_usb" being first. It couldn't be merged, so I deleted it. I
> deleted the other patch as well, since I new it was applied
> upstream. After another "stg pull" at76_usb became "undead".

Until this is fixed, you can use git-show-ref and git-update-ref to
manually delete the offending ref. That fixed the problem for me.

> 2) Invisible branches.

I haven't seen this problem at all -- in my repositories, "stg branch
-l" just works. Will try to reproduce (hopefully tonight). Do you have
a recepie on how to reproduce this from scratch?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
