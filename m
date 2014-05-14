From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 25/29] "guilt push" now fails when there are no more
 patches to push.
Date: Wed, 14 May 2014 09:07:15 -0400
Message-ID: <20140514130715.GB1582@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-26-git-send-email-cederp@opera.com>
 <20140513214114.GI4791@meili.valhalla.31bits.net>
 <CAP=KgsRrtkRZB24CebZsunE=Mc55+NNjoGKLxCPa=KY-GDJ-+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Wed May 14 15:07:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkYtw-0003ym-8l
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 15:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbaENNHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 09:07:10 -0400
Received: from josefsipek.net ([64.9.206.49]:1695 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbaENNHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 09:07:09 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 92AB855659;
	Wed, 14 May 2014 09:07:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAP=KgsRrtkRZB24CebZsunE=Mc55+NNjoGKLxCPa=KY-GDJ-+w@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248914>

On Wed, May 14, 2014 at 11:27:19AM +0200, Per Cederqvist wrote:
> On Tue, May 13, 2014 at 11:41 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> > On Tue, May 13, 2014 at 10:31:01PM +0200, Per Cederqvist wrote:
> >> This makes it easier to script operations on the entire queue, for
> >> example run the test suite on each patch in the queue:
> >>
> >>     guilt pop -a;while guilt push; do make test||break; done
> >>
> >> This brings "guilt push" in line with the push operation in Mercurial
> >> Queues (hg qpush), which fails when there are no patches to apply.
> >>
> >> Updated the test suite.
> >>
> >> "guilt push -a" still does not fail.  (It successfully manages to
> >> ensure that all patches are pushed, even if it did not have to do
> >> anything to make it so.)
> >>
> >> Signed-off-by: Per Cederqvist <cederp@opera.com>
> >> ---
> >>  guilt-push           | 19 ++++++-----
> >>  regression/t-020.out | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  regression/t-020.sh  | 13 +++++++-
> >>  3 files changed, 113 insertions(+), 8 deletions(-)
> > ...
> >> diff --git a/regression/t-020.sh b/regression/t-020.sh
> >> index 906aec6..0f9f85d 100755
> >> --- a/regression/t-020.sh
> >> +++ b/regression/t-020.sh
> >> @@ -26,6 +26,17 @@ guilt series | while read n ; do
> >>  done
> >>
> >>  #
> >> +# pushing when there is nothing to push
> >> +#
> >> +
> >> +shouldfail guilt push
> >> +cmd guilt push -a
> >> +
> >> +cmd list_files
> >> +
> >> +cmd git log -p
> >
> > I don't particularly care for the git-log.  Otherwise it looks good.
> >
> > Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
> 
> In my defense, I was just continuing the pattern already
> established in that file. Anyhow, I'll add a new commit to
> the patch series that removes all "git log -p" from all tests.
> (They are present in both t-020.sh and t-021.sh.)

Sounds good.  Thanks,

Jeff.

>     /ceder
> 
> >> +
> >> +#
> >>  # pop all
> >>  #
> >>  cmd guilt pop --all
> >> @@ -61,7 +72,7 @@ cmd guilt pop --all
> >>
> >>  npatches=`guilt series | wc -l`
> >>  for n in `_seq -2 $npatches`; do
> >> -     if [ $n -ge 0 ]; then
> >> +     if [ $n -gt 0 ]; then
> >>               cmd guilt push -n $n
> >>       else
> >>               shouldfail guilt push -n $n
> >> --
> >> 1.8.3.1
> >>
> >
> > --
> > Evolution, n.:
> >   A hypothetical process whereby infinitely improbable events occur with
> >   alarming frequency, order arises from chaos, and no one is given credit.

-- 
UNIX is user-friendly ... it's just selective about who its friends are
