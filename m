From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/17] merge: force edit mode when merging a tag object
Date: Tue,  8 Nov 2011 17:01:58 -0800
Message-ID: <1320800523-5407-13-git-send-email-gitster@pobox.com>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:03:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwZ4-0003z8-Oy
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab1KIBCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828Ab1KIBCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B35265B9A
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+17b
	CwJT1OG01QNz2QLMBonyKR0=; b=f/WAkCUf6qidOeZ/BUSyUCiLNkXt9SZm1SOl
	TRrXbbbqNxOM1UiCn5Jdkpg3cPT73RUhIn9QDnLEjNG6R+z7e7+pn1xi7oNN47bw
	0y/oOaXvs7HCDaOsY6RUH1XTvB6vRKm1k8t0YN9eqIZHOCjoacNgADfrNpHE8A7t
	7LSW4L0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gdeHQC
	2ZAwEyqoj/pusCi2VL38LkJkU+JEv2ANR/PFjVMXh5F8sIu2QNlWoYPou031eGVn
	t4ScJsvhGJVRmYGka947CFwz7NNbOHMdEsOTVzhYBth5EqlECQsD506NrQ8PWYDd
	Rxvsz/rBQDGuvWWGTudN/xP0FKcAyS29te3EU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA2835B99
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FBEE5B98 for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:32 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 80E0AB10-0A6E-11E1-8F4B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185139>

Now that we allow pulling a tag from the remote site to validate the
authenticity, we should give the user the final chance to verify and
edit the merge message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 7158e8e..3b3e374 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1253,6 +1253,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			    sha1_to_hex(commit->object.sha1));
 		setenv(buf.buf, argv[i], 1);
 		strbuf_reset(&buf);
+		if (merge_remote_util(commit) &&
+		    merge_remote_util(commit)->obj &&
+		    merge_remote_util(commit)->obj->type == OBJ_TAG)
+			option_edit = 1;
 	}
 
 	if (!use_strategies) {
-- 
1.7.8.rc1.82.g90e080
