From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't update unchanged merge entries
Date: Sun, 16 Mar 2008 14:25:46 -0700
Message-ID: <7v1w6aico5.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803161136060.3020@woody.linux-foundation.org>
 <alpine.LNX.1.00.0803161548250.19665@iabervon.org>
 <alpine.LFD.1.00.0803161338100.3020@woody.linux-foundation.org>
 <alpine.LNX.1.00.0803161700430.19665@iabervon.org>
 <alpine.LFD.1.00.0803161413250.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 22:26:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb0NO-0001vQ-5r
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 22:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbYCPV0C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 17:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbYCPV0B
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 17:26:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbYCPV0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 17:26:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 56BD91485;
	Sun, 16 Mar 2008 17:25:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 577BC1483; Sun, 16 Mar 2008 17:25:55 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803161413250.3020@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sun, 16 Mar 2008 14:15:10 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77388>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 16 Mar 2008, Daniel Barkalow wrote:
>> 
>> Well, the top part of the comment suggests that this is just an 
>> optimization (don't bother to write out a file that you know is 
>> unchanged), when it's actually necessary for correctness (since we don't 
>> know if the working tree matches the old index).
>
> Ahh, that part. Yeah, maybe we could expand/clarify it. I don't think the 
> comment is wrong per se, but yes, I'm sure it could be improved. 

Will squash this in (together with the test updates I sent out earlier).

 unpack-trees.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index a72ac03..4b359e0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -602,8 +602,8 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		 * See if we can re-use the old CE directly?
 		 * That way we get the uptodate stat info.
 		 *
-		 * This also removes the UPDATE flag on
-		 * a match.
+		 * This also removes the UPDATE flag on a match; otherwise
+		 * we will end up overwriting local changes in the work tree.
 		 */
 		if (same(old, merge)) {
 			copy_cache_entry(merge, old);
