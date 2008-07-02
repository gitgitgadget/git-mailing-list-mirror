From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/3] git-add--interactive: use --recount, editing
Date: Wed,  2 Jul 2008 23:58:26 +0200
Message-ID: <1215035909-26110-1-git-send-email-trast@student.ethz.ch>
References: <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 23:59:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEAM7-0001Z2-Js
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 23:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbYGBV6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754847AbYGBV6S
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 17:58:18 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:19380 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078AbYGBV6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 17:58:17 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 23:58:15 +0200
Received: from localhost.localdomain ([84.75.156.10]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 23:58:15 +0200
X-Mailer: git-send-email 1.5.6.1.276.gde9a
In-Reply-To: <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 02 Jul 2008 21:58:15.0455 (UTC) FILETIME=[BA9FA2F0:01C8DC8E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87197>

Junio C Hamano wrote:
> 
> I recall that the original "add--interactive" carefully counted numbers in
> hunks it reassembles (as it can let you split and then you can choose to
> use both parts, which requires it to merge overlapping hunks back), but if
> you are going to use --recount anyway, perhaps we can discard that logic?
> It may make the patch application less robust, though.  I dunno.

This series takes it a bit further.  I played around with 'apply', and
it seems there is no reason to even merge the hunks.  (It would be
great if someone who knows builtin-apply.c could confirm this.)  So we
can get rid of all recounting except for the correct splitting
boundaries.  These are the first two patches.

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I wonder why bother trying to import things when you do not need them to 
> > begin with!  I mean, it is _obvious_ that in this case, we want .git/ to 
> > be writable _anyway_, so why not stick with a fixed name in that?
> 
> Good suggestion -- I love that simplicity.  Thomas?

Well, changed that back.

Apart from that, no real changes to 3/3, but the $needs_recount code
has become unnecessary because 1/3 already forces --recount.

- Thomas



 Documentation/git-add.txt  |    1 +
 git-add--interactive.perl  |  203 ++++++++++++++++++++++---------------------
 t/t3701-add-interactive.sh |   67 +++++++++++++++
 3 files changed, 172 insertions(+), 99 deletions(-)
