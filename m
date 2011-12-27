From: Junio C Hamano <gitster@pobox.com>
Subject: [Wish] use postimage when showing common context in "diff -w"?
Date: Tue, 27 Dec 2011 14:16:56 -0800
Message-ID: <7vlipx4q3r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 23:17:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RffKg-0005NB-7g
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 23:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab1L0WRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 17:17:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759Ab1L0WQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 17:16:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7BE06A5D;
	Tue, 27 Dec 2011 17:16:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=npj7kIWnQ1xwZ0rmKcPHJt2o+48=; b=Pnk5hLL/BS+gghEVbjPRRUvSpinI
	/9sW3TxCxaLm8YtZ+Tn/Wt2NEESQUtEsOSbwmTvVTIiqvoTmprf6mOR37k+mUJ+c
	C7oLQsGZ3ZxDdQlYkhcoln9AgA4uYeekw/Djgg3rcCUhp/Umlyb7a1vhq/Dtm+AH
	u6cb6JoHfSNdrtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	NfbGTJO1QjYsZUStm/gaeYN3uqbSJAUK+g9x6LMOhCuFuEvm3Ua71MfceVAKla8h
	hL3+FXfCKH5AYveOtPeXa+y5KWucvrVQdfSJbtKqsU3AmdXXGW+7xALhLVg9uTN8
	st5cfu9KDJFPxOEzFxZDdluyykYOi7yeV8w22D+pPfs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE4066A5C;
	Tue, 27 Dec 2011 17:16:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D3736A5B; Tue, 27 Dec 2011
 17:16:58 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DF2C1DC-30D8-11E1-95A2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187734>

Joey's "write first for-merge ref to FETCH_HEAD first" ($gmane/187699)
wraps an existing large for(;;) loop inside another new loop, making the
existing code indented deeper.  After queuing the patch, "git show -w"
displays a hunk like this [*1*]:

+	/*
+	 * The first pass writes objects to be merged and then the
+	 * second pass writes the rest, in order to allow using
+	 * FETCH_HEAD as a refname to refer to the ref to be merged.
+	 */
+	for (want_merge = 1; 0 <= want_merge; want_merge--) {
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
 
+			commit = lookup_commit_reference_gently(rm->old_sha1, 1);
+			if (!commit)
+				rm->merge = 0;
+
+			if (rm->merge != want_merge)
+				continue;
+
 		if (rm->peer_ref) {
 			ref = xcalloc(1, sizeof(*ref) + strlen(rm->peer_ref->name) + 1);
 			strcpy(ref->name, rm->peer_ref->name);

The context lines we can see in the above hunk are shown with incorrect
indentation level; I think we are showing the lines from the preimage.

It would be a really nice holiday gift to us, if somebody can fix this to
show lines from the postimage. It would make reviewing the change much
more pleasant.  I obviously cannot throw this into my Amazon wishlist, so
instead I am posting it here ;-)


[Footnote]

*1* The text has my style fix-ups in it and does not match what was
posted. The patch lacked a sign-off and needs to be amended anyway. Also
it needs to adjust some existing tests (at least 5515 seems to break for
obvious reasons).
