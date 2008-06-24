From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/3] Manual editing for 'add' and 'add -p'
Date: Tue, 24 Jun 2008 21:07:54 +0200
Message-ID: <200806242108.08654.trast@student.ethz.ch>
References: <20080624050901.GA19224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 21:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDw9-0004ER-Ji
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbYFXTLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbYFXTLV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:11:21 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:52328 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbYFXTLU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:11:20 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 21:11:18 +0200
Received: from [192.168.0.2] ([84.75.156.10]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 21:11:18 +0200
In-Reply-To: <20080624050901.GA19224@sigill.intra.peff.net>
Content-Disposition: inline
X-OriginalArrivalTime: 24 Jun 2008 19:11:18.0462 (UTC) FILETIME=[14B9CDE0:01C8D62E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86112>

Jeff King wrote:
> Thomas, do you want to just re-submit the "--recount" patches when you
> re-submit your patch?

If that is the right thing to do :-)

I rebased Johannes' patches to current 'next', which had some trivial
merge conflicts, and made one actual change: By analogy with one
earlier patch that caused some of the conflicts, I split '-e' and
'--edit' across two lines in the documentation.

I also integrated your last suggestion:

> # Abort if nothing remains
> if (!grep { /\S/ } @newtext) {
>   return undef;
> }

I'm not really convinced it is needed, but any such patch can
obviously not change anything, so it can't hurt.  Who knows, perhaps
there are editors brain-damaged enough to always save at least one
newline.  (This is the only change to my patch compared to v4.)

Johannes Schindelin wrote:
>
> To spare you following that link: Junio wanted to reuse "git apply 
> --recount" to apply mboxes, where a separator "^-- $" to the signature is 
> quite common, and could be mistaken for a "-" line of a hunk.
[...]
> However, I think that this issue should not concern us _now_.  As long as 
> --recount is only to be used in "add -i" and "add -e", I think the patch 
> is good as is:

I'm wondering if this should be turned into docs.  After all, it's not
some DWIM option.  It just says that instead of trusting the counts,
lines starting with "diff " or "@@ " start hunks, implying that all
/^[-+ ]/ lines in between are significant.


I hope this series turns out right in mail; I'm struggling a bit to
properly import the mails to KMail.  Most annoyingly, format-patch
apparently cannot turn other people's patches into mails by myself
with an appropriate "From:" line. :-(

- Thomas


Johannes Schindelin (2):
  Allow git-apply to ignore the hunk headers (AKA recountdiff)
  git-add: introduce --edit (to edit the diff vs. the index)

Thomas Rast (1):
  git-add--interactive: manual hunk editing mode

 Documentation/git-add.txt   |   13 ++++-
 Documentation/git-apply.txt |    7 ++-
 builtin-add.c               |   55 ++++++++++++++++++-
 builtin-apply.c             |   64 ++++++++++++++++++++--
 git-add--interactive.perl   |  124 +++++++++++++++++++++++++++++++++++++++++-
 t/t3701-add-interactive.sh  |   67 +++++++++++++++++++++++
 t/t3702-add-edit.sh         |  126 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 448 insertions(+), 8 deletions(-)
 create mode 100755 t/t3702-add-edit.sh
