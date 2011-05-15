From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] Declare lookup_replace_object() in cache.h, not in
 commit.h
Date: Sun, 15 May 2011 12:54:50 -0700
Message-ID: <1305489294-14341-2-git-send-email-gitster@pobox.com>
References: <1305489294-14341-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 21:55:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhPC-0004j1-Na
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 21:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab1EOTzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 15:55:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab1EOTy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 15:54:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 04ACC4D30
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=MkAw
	EEoUFNF3DqJxLuJpurqJRw0=; b=qeBUSuy/PSRxdSjttAak2nu0/HfFPjenYSvc
	spj0wP5/Y0fz+ca3pICVe9kOB3WdlXIdAXGDbxlR14M3q9/6ivPJJtYdsDFEHQIO
	zlIIK0/y9gA2ou5zOzH7A+hjfs53FVNA9VYe5nSNcxSeSqGfKZq0dF1IDLhic564
	dDfOnfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=kwKulu
	BgkEtRcPMBcTfqr95g6fztBHjOBIvuY5orAEPNWJxlX6VrGRscIrl5BOZQZ+x7iM
	UsHBEfqTvvG/0BbEk7YhMfz4YmlGx3ZPPawxDYlYGhIflTaGxLKPSGJ/X5IMafpc
	agSjj0m5+cyJuv5OwfKA1u4aZjdiynbIpJbHg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2D884D2F
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3B3D54D2E for
 <git@vger.kernel.org>; Sun, 15 May 2011 15:57:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.334.gdfd07
In-Reply-To: <1305489294-14341-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 81CAF052-7F2D-11E0-914B-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173650>

The declaration is misplaced as the replace API is supposed to affect
not just commits, but all types of objects.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h  |    1 +
 commit.h |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 2b34116..e09cf75 100644
--- a/cache.h
+++ b/cache.h
@@ -763,6 +763,7 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
 {
 	return read_sha1_file_repl(sha1, type, size, NULL);
 }
+extern const unsigned char *lookup_replace_object(const unsigned char *sha1);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
diff --git a/commit.h b/commit.h
index b3c3bb7..f251e75 100644
--- a/commit.h
+++ b/commit.h
@@ -145,8 +145,6 @@ struct commit_graft *read_graft_line(char *buf, int len);
 int register_commit_graft(struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
-const unsigned char *lookup_replace_object(const unsigned char *sha1);
-
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos, int cleanup);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
-- 
1.7.5.1.334.gdfd07
