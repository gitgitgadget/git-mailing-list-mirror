Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76054BE8
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179379; cv=none; b=W/tfBP7/Wodvjs978oftTkS2OGIatRR11ojYm3kuP+pZzPVQj8j03owg4nDglGOqR92ojK41PR+6mlVZ7xBJhkmeRaYqYyxikTOsuI+JLCDKJSrAFgEjzKzuBLzESgZKna5iOANCsxyyDtNELTq+TDbZhrvUvdlKCy88O5Sgbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179379; c=relaxed/simple;
	bh=/NsRTnMWSGASwYxN1EfcGwsjuTgbggZqVsGYdj851d4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XLDLPjZgypQ35Fa6lAOd3juoLRT89tqfP+eEddTFnQsw6Ek8hwa5m00ZKhks/ATmaTr4/gu8MteXtL4/y5THTHXMf/K+BzdHie/gQxibJgvR9/zQ9UhZp8VGOtLft8Fj7bqg9ymo9rBiz4biEgUCR5p7O4fa4NjgFT6kqZNq0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C8cGTiKU; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C8cGTiKU"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 262292D58E;
	Mon, 11 Mar 2024 13:49:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/NsRTnMWSGASwYxN1EfcGwsjuTgbggZqVsGYdj
	851d4=; b=C8cGTiKUkpk4Jb61e19Oc81T5gohaecj1OVYmoYlmwjaADawrK73BN
	lOzAsd/uHaMdTuOtCM2VkaSX7TtKcQAqULFSIx2ddLbt+f/Axuo3QAFVckPdNVut
	wUxX0AIt7pUlhrrSWNkMDfRdN7IpmnIYDa6+a26Z64tg5fd5/tgWU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D6ED2D58D;
	Mon, 11 Mar 2024 13:49:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B88CA2D58A;
	Mon, 11 Mar 2024 13:49:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  ZheNing Hu <adlternative@gmail.com>,
  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 2/2] builtin/am: allow disabling conflict advice
In-Reply-To: <xmqq5xxsu1z5.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	11 Mar 2024 10:12:30 -0700")
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
	<pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
	<3235542cc6f77779cca1aeff65236e16b0a15d76.1710100261.git.gitgitgadget@gmail.com>
	<f06dcfad-e4b8-4cb7-8728-f5fb018f7be0@gmail.com>
	<xmqq5xxsu1z5.fsf@gitster.g>
Date: Mon, 11 Mar 2024 10:49:32 -0700
Message-ID: <xmqq1q8gsloz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B8439196-DFCF-11EE-9669-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> I think you need to append "\n" to the message strings here (and
>> below) to match the behavior of printf_ln().
>
> Good eyes.  You'll get the final "\n" but the line breaks inside the
> paragraph you give to advise*() functions are your responsibility.
> Even though advice.c:vadvise() handles multi-line message better
> (unlike usage.c:vreportf() that is used for error() and die()) by
> giving a line header for each line of the message, we do not wrap
> lines at runtime.

Perhaps something like this.

The overly long lines are getting a bit annoying but I do not
offhand think of a good way to shorten them.

Also, having to assemble the message in a buffer and emit them all
once with ("%s" % sb.buf) is a highly annoying pattern.  Perhaps
given enough examples, somebody will come up with a simpler API to
do the same thing, but that is not in the scope of this series.

 builtin/am.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git i/builtin/am.c w/builtin/am.c
index 0e97b827e4..227036d732 100644
--- i/builtin/am.c
+++ w/builtin/am.c
@@ -1155,14 +1155,13 @@ static void NORETURN die_user_resolve(const struct am_state *state)
 		const char *cmdline = state->interactive ? "git am -i" : "git am";
 		struct strbuf sb = STRBUF_INIT;
 
-		strbuf_addf(&sb, _("When you have resolved this problem, run \"%s --continue\"."), cmdline);
-		strbuf_addf(&sb, _("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
+		strbuf_addf(&sb, _("When you have resolved this problem, run \"%s --continue\".\n"), cmdline);
+		strbuf_addf(&sb, _("If you prefer to skip this patch, run \"%s --skip\" instead.\n"), cmdline);
 
 		if (advice_enabled(ADVICE_AM_WORK_DIR) &&
 		    is_empty_or_missing_file(am_path(state, "patch")) &&
 		    !repo_index_has_changes(the_repository, NULL, NULL))
-			strbuf_addf(&sb, _("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
-
+			strbuf_addf(&sb, _("To record the empty patch as an empty commit, run \"%s --allow-empty\".\n"), cmdline);
 		strbuf_addf(&sb, _("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);
 
 		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s", sb.buf);
