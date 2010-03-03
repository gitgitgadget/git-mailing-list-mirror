From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] submodule summary: do not shift a non-existent
 positional variable
Date: Wed,  3 Mar 2010 14:19:09 -0800
Message-ID: <1267654750-30911-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 23:19:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmwuX-0001mv-LA
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 23:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910Ab0CCWTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 17:19:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab0CCWTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 17:19:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C9F69E141
	for <git@vger.kernel.org>; Wed,  3 Mar 2010 17:19:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=goI1FNhpiQKNFougZ+oLWeOy6sE
	=; b=x+UQVDuPQzH6IELq+Mi3FjKNdkz/cd+6cJEj0oGld36c1bVkIVo8U+/0H5D
	3uu/tLLtrlDtPeWPQBctkwOQeZW10SpItRuiDHqYd3rL9/gpjUKVxqiciRVb/zme
	vcjMEBOczCB2irvg4V+8+nt3MtynI0tXKFj6c/Dw8pWbcUd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=GDzxmZnM36CtoQxtHw3O5p7I1em6d
	S4wssnxu2chsv3VGklMnF0MxhA4bcpEvCeSw+uw+FsTh0xP1LMM3DrveTt95X+mT
	amLZxOcVoBZJh6bLbtAKIDiR7KBtxApTvAIGsN2qU0GSASwzn1PmhaR3i05YMBed
	oGQ6TkhWJMnqMc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C1BB9E140
	for <git@vger.kernel.org>; Wed,  3 Mar 2010 17:19:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBFD19E13E for
 <git@vger.kernel.org>; Wed,  3 Mar 2010 17:19:11 -0500 (EST)
X-Mailer: git-send-email 1.7.0.1.290.g2d87e
X-Pobox-Relay-ID: CBB10644-2712-11DF-A879-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141487>

From: Jeff King <peff@peff.net>

When "git submodule summary" is run without any argument, we default to
compare the state of index with the HEAD, but tried to shift out $1 that
does not exist (and worse yet, we didn't use it).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5869c00..383dc45 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -556,7 +556,7 @@ cmd_summary() {
 	if rev=$(git rev-parse -q --verify --default HEAD ${1+"$1"})
 	then
 		head=$rev
-		shift
+		test $# = 0 || shift
 	elif test -z "$1" -o "$1" = "HEAD"
 	then
 		return
-- 
1.7.0.1.290.g2d87e
