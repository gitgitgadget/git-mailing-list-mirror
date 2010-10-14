From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH] git-send-email.perl: fix In-Reply-To for second and subsequent patches
Date: Thu, 14 Oct 2010 11:38:58 +0200
Message-ID: <1287049138-13940-1-git-send-email-ospite@studenti.unina.it>
Cc: Antonio Ospite <ospite@studenti.unina.it>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 11:44:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6KMN-0002cF-W0
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 11:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab0JNJoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 05:44:21 -0400
Received: from smtp209.alice.it ([82.57.200.105]:46079 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805Ab0JNJoV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 05:44:21 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Oct 2010 05:44:20 EDT
Received: from jcn (87.3.192.78) by smtp209.alice.it (8.5.124.08)
        id 4C1A275907A5E58C; Thu, 14 Oct 2010 11:39:09 +0200
Received: from ao2 by jcn with local (Exim 4.72)
	(envelope-from <ospite@studenti.unina.it>)
	id 1P6KHE-0003dT-LM; Thu, 14 Oct 2010 11:39:08 +0200
X-Mailer: git-send-email 1.7.1
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159039>

Make second and subsequent patches appear as replies to the first patch,
even when an initial In-Reply-To is supplied; this is the typical
behaviour we want when we send a series with cover letter in reply to
some discussion, and this is also what the man page says about
--in-reply-to.

In order to achieve the old behaviour of a flat structure in reply to
something the user can always use "--no-thread --in-reply-to <...>".

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

---

Hi,

Right now _all_ the patches appear as reply to the message indicated as
initial In-Reply-To, and I think this is not right, the behaviour this
patch introduces can be debatable of course, but there are quite some
arguments supporting it:

  - When $initial_reply_to is asked to the user, it is asked as the
    "Message-ID to be used as In-Reply-To for the _first_ email", this
    makes me think that the second and subsequent patches are not using
    it and will be considered as reply to the first message or chained
    according to the --[no-]chain-reply-to setting.

  - git-format-patch states that clearly in the man page, and I think
    git-send-email should behave the same way, and this is explained
    also in the git-send-email man page, look at
    --in-reply-to=<identifier> explanation.

Please keep CCing me on this as I am not subscribed to git@vger.kernel.org.

Thanks,
   Antonio Ospite
   http://ao2.it


 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8cc4161..615a40d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1313,7 +1313,7 @@ foreach my $t (@files) {
 
 	# set up for the next message
 	if ($thread && $message_was_sent &&
-		(chain_reply_to() || !defined $reply_to || length($reply_to) == 0)) {
+		($message_num == 1 || chain_reply_to() || !defined $reply_to || length($reply_to) == 0)) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
 			$references .= "\n $message_id";
-- 
1.7.1
