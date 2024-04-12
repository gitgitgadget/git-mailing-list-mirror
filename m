Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27698148313
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944917; cv=none; b=NjzakhHEa+UZYXa8SYW0t62412/oRkc+PlM5zMPdG/rpRspkIu3LU0Jy4kbq6f6Wy406vhC7kh4v4nSR7/YqoVXYdu4sv3aUtNRga8qW0O9cCNy06NHhITVq0Zo5VAw39xo7/Wl9Eh7gsw9QID1W6LPLH+iaExWAkU00Az8h39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944917; c=relaxed/simple;
	bh=wpgYWkKMNWavDP0lwWXXY0PaW4LCz/5RjEK1sf32Udg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BVwYNr1ZjOwwtdVv0spo++OIFgGSegA20H4ME7Vjwb+pX6GFmyRb5BnO7rOsrpTpxwpK2+x0Cies96jQaBSdQNkTN7f+P6hy2QGRqydZslmE2PBAi4i6EbFbFRuPIcuCo5pqLkdjZAxLEWpNG67qtH9PoEGxrGtFIckhgeW1BII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hjhy0lCL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hjhy0lCL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 223DB1E18A1;
	Fri, 12 Apr 2024 14:01:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wpgYWkKMNWavDP0lwWXXY0PaW4LCz/5RjEK1sf
	32Udg=; b=hjhy0lCLm3UM5oOiA7mPFB9g8Yn+nV7BE9mln6gG4Tl5zZgXsesDIX
	XuEjMOOrTlwND2s80V2fLotLMxXDqI0dOGdGj2zgLq8YKnoiEB79vprjffpzxaDd
	uRbknBLxbIE08fn1LlVUTNllLzedqBVi8i/M/Jjf25xoVTCt9+pq4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 187041E18A0;
	Fri, 12 Apr 2024 14:01:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CABF1E189F;
	Fri, 12 Apr 2024 14:01:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/7] update-ref: add symref oriented commands
In-Reply-To: <20240412095908.1134387-1-knayak@gitlab.com> (Karthik Nayak's
	message of "Fri, 12 Apr 2024 11:59:01 +0200")
References: <20240330224623.579457-1-knayak@gitlab.com>
	<20240412095908.1134387-1-knayak@gitlab.com>
Date: Fri, 12 Apr 2024 11:01:53 -0700
Message-ID: <xmqqwmp2lasu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BF019420-F8F6-11EE-B571-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"make refs.sp" should have told you that you should not write NULL
as just 0.  I'll queue a SQUASH??? fix-up on top before merging it
into 'seen' for today's integration.

diff --git c/refs.c w/refs.c
index 010f426def..d578a2823b 100644
--- c/refs.c
+++ w/refs.c
@@ -2758,7 +2758,7 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 
 	for_each_string_list_item(item, refnames) {
 		ret = ref_transaction_delete(transaction, item->string,
-					     NULL, flags, 0, msg, &err);
+					     NULL, flags, NULL, msg, &err);
 		if (ret) {
 			warning(_("could not delete reference %s: %s"),
 				item->string, err.buf);




Also there are quite many whitespace breakages.

$ git am -s ./+kn7-v2-update-ref-symref
Applying: refs: accept symref values in `ref_transaction[_add]_update`
Applying: update-ref: add support for symref-verify
.git/rebase-apply/patch:59: indent with spaces.
        if (line_termination) {
.git/rebase-apply/patch:60: indent with spaces.
                /* Without -z, consume SP and use next argument */
.git/rebase-apply/patch:61: indent with spaces.
                if (!**next || **next == line_termination)
.git/rebase-apply/patch:62: indent with spaces.
                        return NULL;
.git/rebase-apply/patch:63: indent with spaces.
                if (**next != ' ')
warning: squelched 10 whitespace errors
warning: 15 lines applied after fixing whitespace errors.
Applying: update-ref: add support for symref-delete
.git/rebase-apply/patch:95: indent with spaces.
                die("symref-delete: cannot operate with deref mode");
.git/rebase-apply/patch:101: indent with spaces.
        old_ref = parse_next_refname(&next);
warning: 2 lines applied after fixing whitespace errors.
Applying: files-backend: extract out `create_symref_lock`
Applying: update-ref: add support for symref-create
.git/rebase-apply/patch:81: indent with spaces.
                die("symref-create: cannot operate with deref mode");
warning: 1 line applied after fixing whitespace errors.
Applying: update-ref: add support for symref-update
Applying: refs: support symrefs in 'reference-transaction' hook
