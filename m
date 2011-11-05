From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/10] merge: notice local merging of tags and keep it
 unwrapped
Date: Fri,  4 Nov 2011 23:01:33 -0700
Message-ID: <1320472900-6601-4-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 07:02:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMZKM-0005a3-Mi
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 07:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab1KEGBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 02:01:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab1KEGBt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 02:01:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 334263C1C
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4MOf
	PSNOa/MY52VM0lQSCp7ptk4=; b=um8aSPsJ4TnuGAXhUC+Gxe93o4rtChlLwX6b
	B6xD7CsdfzpJyCt5upIIfUHM1Nb1Z/2ap2TA8Fr1P1rCSfDUTo7CYrXKr38atOni
	kRbJO58g/t5npwg0lu+E/BWkCbr78GAEt1Y2LoLkp+4u54I5dpyD8pPG/wt1bfs2
	+m2uiJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Y1sv4i
	c0WUJPHBnf2Ps8+mK2p9GYAzl5RCH1Kf6WLQTuRE1MCFgRc2keqe2PXXXm9dFYhi
	2fOnT/WxFZD6qM2OvGcAHgH8Xdn4NrD7bJqZRLNfb5PY/GsX6CRwbKZdKZycY4HR
	LyoM3FM+HTH8V2lymDhMoTaQx7tenFXc+PlcU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28A043C1B
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1AF83C1A for
 <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.8.rc0.108.g71b5ec
In-Reply-To: <1320472900-6601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A61CEA0E-0773-11E1-AF9B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184823>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I notice that Peff came up with the same patch independently.

 builtin/merge.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index dffd5ec..6a44b6d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -441,6 +441,11 @@ static void merge_name(const char *remote, struct strbuf *msg)
 				    sha1_to_hex(branch_head), remote);
 			goto cleanup;
 		}
+		if (!prefixcmp(found_ref, "refs/tags/")) {
+			strbuf_addf(msg, "%s\t\ttag '%s' of .\n",
+				    sha1_to_hex(branch_head), remote);
+			goto cleanup;
+		}
 		if (!prefixcmp(found_ref, "refs/remotes/")) {
 			strbuf_addf(msg, "%s\t\tremote-tracking branch '%s' of .\n",
 				    sha1_to_hex(branch_head), remote);
-- 
1.7.8.rc0.108.g71b5ec
