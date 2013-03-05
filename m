From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] commit.c: use clear_commit_marks_many() in
 in_merge_bases_many()
Date: Tue,  5 Mar 2013 14:47:18 -0800
Message-ID: <1362523639-30566-4-git-send-email-gitster@pobox.com>
References: <1362523639-30566-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 23:48:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD0eP-00053O-4p
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 23:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab3CEWr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 17:47:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052Ab3CEWr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 17:47:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F274AD61
	for <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+WRT
	hQH9ykib+FKDeCjLVv6tKM0=; b=cHe3e7mVxN3tu0/sWPyjRZgdWnm9w7R763Mm
	hF0SZa/F9mYvMKmUuKljfH/MbczQf5Tk7JNIYnZSwTzDKTg/TvpzhwI0vUiiyyME
	SRK9Yi3IUbqvZag71s7ITgy5lLVwADxVvQogSzSWiuiV8mV/UAoIAfWQgoJskYwX
	/UKDO/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wN/Hvo
	9c8CTgXzRXo7tmVu3GV9AZ9BNhSZgbCX/WaFdD1SPygh6ixEgP8JHj6ZPzJ6tFO2
	sPFuHBJc+Eb+TfE3jjGJHdtojDL03JkqA9tM3FAFTTI7/KDlPuvoNQmf20aYmGA5
	Qw1oJTHU0qTJqGB8/slI8o9orC4AjfZjTST7Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52332AD60
	for <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFB43AD5D for
 <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:26 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc2-194-g549a9ef
In-Reply-To: <1362523639-30566-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A731DEB6-85E6-11E2-B5DF-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217493>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index d12e799..b4512ab 100644
--- a/commit.c
+++ b/commit.c
@@ -876,8 +876,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
-	for (i = 0; i < nr_reference; i++)
-		clear_commit_marks(reference[i], all_flags);
+	clear_commit_marks_many(nr_reference, reference, all_flags);
 	free_commit_list(bases);
 	return ret;
 }
-- 
1.8.2-rc2-194-g549a9ef
