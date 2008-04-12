From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH v2] bisect: fix bad rev checking in "git bisect good"
Date: Sat, 12 Apr 2008 02:17:36 -0700
Message-ID: <7vd4ovjutr.fsf@gitster.siamese.dyndns.org>
References: <20080412090335.e92d3da3.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Apr 12 11:18:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkbsY-0001No-Fy
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 11:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225AbYDLJRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 05:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018AbYDLJRu
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 05:17:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbYDLJRt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 05:17:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9675E2FC0;
	Sat, 12 Apr 2008 05:17:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D9DD42E1F; Sat, 12 Apr 2008 05:17:43 -0400 (EDT)
In-Reply-To: <20080412090335.e92d3da3.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat, 12 Apr 2008 09:03:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79338>

I've applied your earlier one to maint and propagated it all the way up,
and pushed the results out for tonight.  I'll apply the following as a
follow-up patch later on top of what I've already pushed out, which is the
difference between the one applied and your v2.

-- >8 --
bisect: report bad rev better

The previous one overwrote the variable used to report the bad input
when the input is actually bad, and we did not give a useful enough
information.  This corrects it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index c8be9f7..c99ffee 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -155,9 +155,9 @@ bisect_state() {
 		shift
 		for rev in "$@"
 		do
-			rev=$(git rev-parse --verify "$rev^{commit}") ||
+			sha=$(git rev-parse --verify "$rev^{commit}") ||
 				die "Bad rev input: $rev"
-			bisect_write "$state" "$rev"
+			bisect_write "$state" "$sha"
 		done ;;
 	*,bad)
 		die "'git bisect bad' can take only one argument." ;;
