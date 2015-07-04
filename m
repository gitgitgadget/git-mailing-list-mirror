From: Chris Jones <chris@christopherjones.us>
Subject: [PATCH] git-filter-branch.sh: clarify an error message
Date: Sat, 04 Jul 2015 19:39:04 -0400
Message-ID: <1436053144.3463091.315316457.1BAF8BA7@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 05 10:37:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBfQp-0002d2-3D
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 10:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbbGEIhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 04:37:43 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60015 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751235AbbGEIhl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jul 2015 04:37:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id DEDD2203A8
	for <git@vger.kernel.org>; Sat,  4 Jul 2015 19:39:04 -0400 (EDT)
Received: from web4 ([10.202.2.214])
  by compute5.internal (MEProxy); Sat, 04 Jul 2015 19:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	christopherjones.us; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=pmpc0PMVU+dZXRnQjndGauiU6Eo=; b=QT5MUM
	rJ+HCOW6L0lacWo6Nmlhf6BVJGcfilPWcf/KVzW+PncPGWCj6DvybuNp1NdmZTAC
	0MdDz5+MhfkIDWjHr9Pty/QJNqqpbFDEGTuQjhE6JuCqzGahSvEniEhoZTBNaOtj
	BP4WKf9004DqfyxLrpVnpnDLaBXb9xJ+8SIyw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=pmpc0PMVU+dZXRnQjndGauiU6Eo=; b=BadWD
	n++/9CITMmzfBI8GWzPrcqgQVjRu4Ev5Uqs8L6W3g6e2/DJQWIoqXInc+/2XmgqX
	3qxHnr4AbCI1tgxZoDheuHyyQIHiLn0GRoETWQ4AHw06liigsv9AN0LrkA580NF7
	/ji9N5oAKbZC1yI8M+306dPJsjpSmsBassrZgM=
Received: by web4.nyi.internal (Postfix, from userid 99)
	id AA7EA112FEE; Sat,  4 Jul 2015 19:39:04 -0400 (EDT)
X-Sasl-Enc: 70Uu/LyXxGSqMaGZVCXKVYSaljX4uP8dWU/XIi7eEw2g 1436053144
X-Mailer: MessagingEngine.com Webmail Interface - ajax-eecef38c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273351>

Make git filter-branch output a useful error message when a single
commit is given instead of a range.  Currently, when given a command
like git filter-branch --msg-filter 'echo "TEST"' -- abc123, it will
give the message "Which ref do you want to rewrite?".  Instead, what
is needed is a range of commits to rewrite.  This makes it give an
error message that says "You didn't provide a valid range of
commits".

Signed-off-by: Chris W Jones <chris@christopherjones.us>
---
 git-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5b3f63d..78e7499 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -237,7 +237,7 @@ git rev-parse --no-flags --revs-only
--symbolic-full-name \
 sed -e '/^^/d' "$tempdir"/raw-heads >"$tempdir"/heads
 
 test -s "$tempdir"/heads ||
-       die "Which ref do you want to rewrite?"
+       die "You didn't provide a valid range of commits."
 
 GIT_INDEX_FILE="$(pwd)/../index"
 export GIT_INDEX_FILE
-- 
1.9.3
