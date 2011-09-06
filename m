From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] State what commit to expect in request-pull
Date: Tue, 06 Sep 2011 14:24:40 -0700
Message-ID: <7vwrdl749z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 23:24:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R138U-0004Vl-8f
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 23:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab1IFVYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 17:24:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab1IFVYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 17:24:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74B9A5A77;
	Tue,  6 Sep 2011 17:24:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=y
	YjEXU1pwj76uYusu6XuZO84zO4=; b=syOovGpBjkNoUpEjYUDGwqZOqsnGmKTTx
	SkBByw9NiNvJcXn8bcBYg8ExQhm5bfLX/InVaNV0v/1rGds3kl4GX3vODBiz7Rfz
	+etqT3xtA+09i5GU7KNKG1LnfiWkzr06zye5/uKPSqAoeKo/JFz8Gg37olUIvwCM
	4N3oMM/xX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=EAa
	qFlCike16lWH+QoMhPwxAwRujF6iYgiAwkoBNHckff9QL6lPKCqszTIx/LmcxgaZ
	uGM9MaTFxgD3HSRA8BCgeT6ictEPxKn28hK1wMyfyNqGpOqHHjassQBQH20wwlMX
	4VRvN3Kzs06QRtaCXRmETFfcZCFc3rnLa7tcTOuM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D2C75A76;
	Tue,  6 Sep 2011 17:24:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 036AF5A74; Tue,  6 Sep 2011
 17:24:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2610EE6-D8CE-11E0-82C9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180837>

Interestingly, we did say what commit the requesters based their changes
on, but did not give the person who performs a fetch & merge to make sure
he fetched the right branch.

This fixes it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-request-pull.sh     |    1 +
 t/t5150-request-pull.sh |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index fc080cc..9b06a87 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -71,6 +71,7 @@ git show -s --format='The following changes since commit %H:
 
 are available in the git repository at:' $baserev &&
 echo "  $url $branch" &&
+echo "for you to fetch changes up to $headrev"
 echo &&
 
 git shortlog ^$baserev $headrev &&
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 9cc0a42..9d27c43 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -194,6 +194,7 @@ test_expect_success 'pull request format' '
 
 	are available in the git repository at:
 	  URL BRANCH
+	for you to fetch changes up to OBJECT_NAME
 
 	SHORTLOG
 
