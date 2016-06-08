From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] fixup! d5ad6c13
Date: Wed,  8 Jun 2016 15:58:16 -0700
Message-ID: <20160608225818.726-4-gitster@pobox.com>
References: <20160608225818.726-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 00:58:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAmQq-0005Gq-BK
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 00:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423789AbcFHW6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 18:58:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423064AbcFHW6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 18:58:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ACAC21EEA;
	Wed,  8 Jun 2016 18:58:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xCwJ
	rs3/OpIWRdMGicNaNf0qShI=; b=MQGc5ArisqHpuKsqoYEuO8Pe9wb/zuNPdR1a
	h/t5ZOwOBUNQS8mJjHd86+m1dr7THFHsF9SX9s3Uvt1GLs52OWFX3zYq4smAaY6M
	gkuxbno4KeKweK9ypwhFQ1B5RygHqvma8J1le+PuoFUJHTKAc7jqv+1Z1dBCq7Pp
	E97n/dU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=EYWd0N
	10o4U/n+kzfL3cGeiVeAMwG6V48/V+JspRGGIAnEuey++rVLiPhIiiMegDYgTkJO
	0VWUIhLhrFXx8+gPtt0cqOxkajvXR6DewZu188R1z3V2odpi2lbGwQ3lsj/fwE2v
	psFubu4BntBUu5+F4hD2aQGVvKXKEQ1KLCt0M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52EAA21EE9;
	Wed,  8 Jun 2016 18:58:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CFAC121EE8;
	Wed,  8 Jun 2016 18:58:25 -0400 (EDT)
X-Mailer: git-send-email 2.9.0-rc2-262-g9161bbf
In-Reply-To: <20160608225818.726-1-gitster@pobox.com>
X-Pobox-Relay-ID: 81FA7A72-2DCC-11E6-9609-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296855>

As the topic is in 'next' already, I'll leave this floating near the
tip for now, until we can rewind the topic after the next release.
---
 attr.c | 9 ++++++---
 attr.h | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index 4e2172a..0e61950 100644
--- a/attr.c
+++ b/attr.c
@@ -899,13 +899,16 @@ struct git_attr_check *git_attr_check_alloc(void)
 	return xcalloc(1, sizeof(struct git_attr_check));
 }
 
-void git_attr_check_append(struct git_attr_check *check,
-			   const struct git_attr *attr)
+struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *check,
+						  const struct git_attr *attr)
 {
+	struct git_attr_check_elem *elem;
 	if (check->finalized)
 		die("BUG: append after git_attr_check structure is finalized");
 	ALLOC_GROW(check->check, check->check_nr + 1, check->check_alloc);
-	check->check[check->check_nr++].attr = attr;
+	elem = &check->check[check->check_nr++];
+	elem->attr = attr;
+	return elem;
 }
 
 void git_attr_check_clear(struct git_attr_check *check)
diff --git a/attr.h b/attr.h
index fc72030..40abc16 100644
--- a/attr.h
+++ b/attr.h
@@ -47,7 +47,7 @@ extern int git_check_attr(const char *path, struct git_attr_check *);
 extern int git_check_attr_counted(const char *, int, struct git_attr_check *);
 
 extern struct git_attr_check *git_attr_check_alloc(void);
-extern void git_attr_check_append(struct git_attr_check *, const struct git_attr *);
+extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
 
 extern void git_attr_check_clear(struct git_attr_check *);
 extern void git_attr_check_free(struct git_attr_check *);
-- 
2.9.0-rc2-262-g9161bbf
