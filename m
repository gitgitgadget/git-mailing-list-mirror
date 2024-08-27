Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327AF64A
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775129; cv=none; b=MdhAeJEH/DrOm4f1ewSOYNw7dQnhbawIMiAdZEB1EnPMgSMZROqfwr126MH4n8cQnlaf+U9jQXwb9mMSqf/N7R3Jhyhc2QTO+ZJquYQn2uVPOE0LBrH1iXA1reE/812BJTWxCxZKRh+A/FKbkFNncS682fkxRipf8SdxPcAsfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775129; c=relaxed/simple;
	bh=z3nMBs08WYnFF1mzz62+1938zcxCU8J4/0REAWdxAlw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=omVrbms3NtuLWx3ZYZgOaWiaQnlKuQF3Hb8orhazVScOyByJbRGyAIM3VCaaiOvo+RDXAExPwmVlp1cZFXBWUFgLYCSq8OAD7i7A1lOogBTb+YLaT+Ai9p0ktWT4+ErBJHcLUiNAgW8R8sS+REqawu909BIk1FfrZF30iQAaYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fz8Kov/V; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fz8Kov/V"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D17CF35A7C;
	Tue, 27 Aug 2024 12:12:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z3nMBs08WYnFF1mzz62+1938zcxCU8J4/0REAW
	dxAlw=; b=fz8Kov/VxDh8SVI8ibvXCEpY/aTGEg0eYdl1iig3I0BQqx8f1gKdO3
	S4NlhDaZt5ubHQEP0ZRzS7yoJ1TxV1zthDdtKzt1tH6UW69mb7owRMmdL4Ts+OBp
	CmA0qyxjcz19fCaohpRQFwaWFuAESP45NKXH5OqVcKEm7X9aoVPDE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8C7035A7B;
	Tue, 27 Aug 2024 12:12:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 971F935A7A;
	Tue, 27 Aug 2024 12:12:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] apply: whitespace errors in context lines if we have
In-Reply-To: <xmqqv7zmd9a5.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	26 Aug 2024 18:49:54 -0700")
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
	<5da09529-e95b-407b-9e66-34ebac4b4128@gmail.com>
	<xmqqo75eeqx0.fsf@gitster.g> <xmqqv7zmd9a5.fsf@gitster.g>
Date: Tue, 27 Aug 2024 09:12:04 -0700
Message-ID: <xmqqplpuaqsr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A5065E6-648F-11EF-8740-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Hmph.  0a80bc9f (apply: detect and mark whitespace errors in context
>> lines when fixing, 2015-01-16) deliberately added this check because
>> we will correct the whitespace breakages on these lines after
>> parsing the hunk with this function while applying.
> ...
> So, I am inclined to say that
>
>  * we propose to get rid of that "a single input may touch the same
>    path TWICE" feature at Git 3.0 boundary.
>
>  * we at the same time apply [3/5] (and possibly others, but I do
>    not think we want [1/5]).
>
> But until we can shed our pretense that the "single input may touch
> the same path TWICE" is seriously supported, I do not think applying
> this series as-is makes sense, as it directly contradicts with that
> (mis)feature.

So, here is another thought.  Can we notice that we are dealing with
such an irregular patch that we would never produce ourselves, but
still have to support as a historical wart?  And deal with context
lines with whitespace breakages differently if that is the case.

I think that is doable.  I won't address the entire set of fixes in
your series, but a touched up version of your [3/5] may look like
the attached at the end.  This is on top of your whole series, not
as a replacement for [3/5], made just for illustration purposes.

>> It is iffy that this case arm for " " kicks in ONLY when applying in
>> the forward direction (which is not what you are changing).  When
>> applying a patch in reverse, " " is still an "unchanged" context
>> line, so we should be treating it the same way regardless of the
>> direction.

I didn't address this "why only in the forward direction?" iffyness
in the illustration patch, by the way.

 apply.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git c/apply.c w/apply.c
index e6df8b6ab4..04bb094e57 100644
--- c/apply.c
+++ w/apply.c
@@ -38,6 +38,8 @@
 #include "wildmatch.h"
 #include "ws.h"
 
+static struct patch *in_fn_table(struct apply_state *state, const char *name);
+
 struct gitdiff_data {
 	struct strbuf *root;
 	int linenr;
@@ -1697,10 +1699,13 @@ static int parse_fragment(struct apply_state *state,
 	int len = linelen(line, size), offset;
 	unsigned long oldlines, newlines;
 	unsigned long leading, trailing;
+	int touching_same_path; 
 
 	offset = parse_fragment_header(line, len, fragment);
 	if (offset < 0)
 		return -1;
+
+	touching_same_path = !!in_fn_table(state, patch->old_name);
 	if (offset > 0 && patch->recount)
 		recount_diff(line + offset, size - offset, fragment);
 	oldlines = fragment->oldlines;
@@ -1734,7 +1739,8 @@ static int parse_fragment(struct apply_state *state,
 			check_old_for_crlf(patch, line, len);
 			if (!state->apply_in_reverse &&
 			    state->ws_error_action == correct_ws_error &&
-			    state->ws_ignore_action != ignore_ws_none)
+			    (touching_same_path ||
+			     state->ws_ignore_action != ignore_ws_none))
 				check_whitespace(state, line, len, patch->ws_rule);
 			break;
 		case '-':
