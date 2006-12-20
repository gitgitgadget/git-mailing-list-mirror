X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-merge-recursive segmentation error
Date: Tue, 19 Dec 2006 18:30:30 -0800
Message-ID: <7vpsafmh89.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612191709320.6766@woody.osdl.org>
	<929899.78332.qm@web31809.mail.mud.yahoo.com>
	<7vtzzrmhhd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 02:30:54 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vtzzrmhhd.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 19 Dec 2006 18:25:02 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34895>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwrE3-0000zc-Hs for gcvg-git@gmane.org; Wed, 20 Dec
 2006 03:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964776AbWLTCac (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 21:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWLTCac
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 21:30:32 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33650 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964776AbWLTCab (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 21:30:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220023031.OQRO7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 21:30:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0qVp1W00R1kojtg0000000; Tue, 19 Dec 2006
 21:29:50 -0500
To: ltuikov@yahoo.com
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Luben Tuikov <ltuikov@yahoo.com> writes:
>
>> I also ran git-bisect twice over two well known but overlapping
>> good-bad regions and I get the same commit as being the culprit.
>> It seems to be commit 1510fea781cb0517eeba8c378964f7bc4f9577ab.
>>
>>     Luben
>
> Ooooooops.

1510fe is buggy and it is my fault.

For now, this _should_ get you keep going.

However, if this fixes it for you, that means we would still
have the problem on Cygwin X-<.

-- >8 --
[PATCH] fix populate-filespec

I hand munged the original patch when committing 1510fea78.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 9974435..6e6f2a7 100644
--- a/diff.c
+++ b/diff.c
@@ -1223,7 +1223,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * objects however would tend to be slower as they need
 	 * to be individually opened and inflated.
 	 */
-	if (FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1, NULL))
+	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1, NULL))
 		return 0;
 
 	len = strlen(name);
-- 
1.4.4.2.g205bf

