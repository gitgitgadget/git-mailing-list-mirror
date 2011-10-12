From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Wed, 12 Oct 2011 09:52:33 -0700
Message-ID: <7vk48ab19q.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011203903.GA23069@sigill.intra.peff.net>
 <7vpqi3dxkr.fsf@alter.siamese.dyndns.org>
 <20111011225434.GA24142@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 18:52:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE22u-0005tC-GW
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 18:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab1JLQwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 12:52:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50319 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031Ab1JLQwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 12:52:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1B8164E5;
	Wed, 12 Oct 2011 12:52:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l1/QWI65VFhGpbAkTrN+ZTocasc=; b=Qeu3/f
	D1fCGGrplKtLSIa88QZc5p+Xp+3HlwS5+R3Dk0+308RUcuGMK5UQ8FYBiG8VBu5K
	VwPQmDqwuOFQbArSenypIOu3mebZqDH6656bxcH6PpN5vjJAVbY8kPl4kTWx6x3I
	r8ooJEOslLstZ0M4XuRp7lAa+6nCxgp1V9oNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NqWuileaYPQ74k8eZV1llL9yju82fv/4
	cypCI/kmsY4gu2UcHwwCek2V2V0G9sKVVW2rfKkgJJRFiDJGsnvMS+C78FEbC2Ro
	j/LM5XG7afV502bP0g4paS5PqoSlmMLXNGgXYpNig3znavXLFusNiXaXIkELJbPl
	jxoaEEQcLgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E925E64E4;
	Wed, 12 Oct 2011 12:52:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 442B464E3; Wed, 12 Oct 2011
 12:52:35 -0400 (EDT)
In-Reply-To: <20111011225434.GA24142@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 11 Oct 2011 18:54:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95C64170-F4F2-11E0-8406-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183376>

Subject: [PATCH] branch -m/-M: remove undocumented RENAMED-REF

The commit message for c976d41 (git-branch: add options and tests for
branch renaming, 2006-11-28) mentions RENAME_REF but otherwise this is not
documented anywhere, and it does not appear in any of the tests.

Worse yet, the name of the actual file is "RENAMED-REF".

This was supposed to hold the commit object name at the tip of the branch
the most recent "branch -m/-M" renamed, but that is not necessary in order
to be able to recover from a mistake. Even when "branch -M A B" overwrites
an existing branch B, what is kept in RENAMED-REF is the commit at the tip
of the original branch A, not the commit B from the now-lost branch.

Just remove this unused "feature".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Let's do this.

 refs.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index cdedb45..ecfc22c 100644
--- a/refs.c
+++ b/refs.c
@@ -786,7 +786,6 @@ int delete_ref(const char *refname, unsigned char *sha1)
 
 int rename_ref(const char *oldref, const char *newref)
 {
-	static const char renamed_ref[] = "RENAMED-REF";
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
@@ -809,13 +808,6 @@ int rename_ref(const char *oldref, const char *newref)
 	if (snprintf(msg, sizeof(msg), "renamed %s to %s", oldref, newref) > sizeof(msg))
 		return error("Refnames to long");
 
-	lock = lock_ref_sha1_basic(renamed_ref, NULL, NULL);
-	if (!lock)
-		return error("unable to lock %s", renamed_ref);
-	lock->force_write = 1;
-	if (write_ref_sha1(lock, orig_sha1, msg))
-		return error("unable to save current sha1 in %s", renamed_ref);
-
 	if (log && rename(git_path("logs/%s", oldref), git_path("tmp-renamed-log")))
 		return error("unable to move logfile logs/%s to tmp-renamed-log: %s",
 			oldref, strerror(errno));
-- 
1.7.7.213.g8b0e1
