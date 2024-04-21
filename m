Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6E25761
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713725926; cv=none; b=kUrFbyex7IUymy0eNb6il9N/I261JDo296gdFSi5/+wsw/ofzdt519f+WicMlCY7cb6wB9+GFoUOhm+9JTwF5krlggoQEBUu5en/ghBQ1JTKUjGi0UsTcWSd6n7uqThwjh3FbhCiVRiVuZYbcy3DMEXLcQwVJ3GoN+kt3V0kUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713725926; c=relaxed/simple;
	bh=PZkWFQru5oYjVNy05YtVz6zkbMKvPAs+oEk9wWWyFVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FY8GtwngyYJOq54ndrrB3A34xDyWCzIyJMgqXUTX+fZB7tG9fyQfG/xCCo5JJVOZl6Svnq6ZZm9dcR6erPzW73rU5yWjMM1PnsWzGio4VRxqO8iQgfr18dFZGpyogmCc9jAxFwC4ZFaJfuHMOYlMLo2xkGzdtp/12ppphB+7/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FoH8Uhlu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FoH8Uhlu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EBA661E19A2;
	Sun, 21 Apr 2024 14:58:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PZkWFQru5oYjVNy05YtVz6zkbMKvPAs+oEk9wW
	WyFVQ=; b=FoH8UhluJqz9Z7VqkdAfVwpFwg8hxoiNLqK7+ZUP8S/qZ6KYym3RJZ
	cbK8vtStFqT5cVj89e2khyU/u1Q3b9PL4QY/XNdTeGBSiTHSmDdhFV2JguZOgOdj
	mGTKGeq5lFAG28g301VTPC0XtnrlOhgGMAl2wnRa+Jl1Mp9FyTKKg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E2FC31E19A1;
	Sun, 21 Apr 2024 14:58:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53FF31E19A0;
	Sun, 21 Apr 2024 14:58:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v2] format-patch: allow --rfc to optionally take a
 value, like --rfc=WIP
In-Reply-To: <440ee2b7-2ed8-4c8b-96e8-623ef45efe42@gmail.com> (Phillip Wood's
	message of "Sun, 21 Apr 2024 16:41:23 +0100")
References: <xmqqzftqnuxq.fsf@gitster.g> <xmqqy1993tc1.fsf@gitster.g>
	<440ee2b7-2ed8-4c8b-96e8-623ef45efe42@gmail.com>
Date: Sun, 21 Apr 2024 11:58:36 -0700
Message-ID: <xmqqle561r1f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 28F8825A-0011-11EF-A02A-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	struct strbuf rfc = STRBUF_INIT;
>
> Looking at this again, do we really need an strbuf here? I think we
> could we use "const char *" instead as we always store a static string
> in it which would avoid a memory leak from not calling
> strbuf_release().

Thanks for spotting the leak ;-)

And indeed, unlike sprefix, we do not need it to be an editable
strbuf.

Should be sufficient to squash in something like this.

 builtin/log.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git c/builtin/log.c w/builtin/log.c
index 0e9c84e51d..5c1c6f9b15 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -1497,12 +1497,11 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
 static int rfc_callback(const struct option *opt, const char *arg,
 			int unset)
 {
-	struct strbuf *rfc;
+	const char **rfc = opt->value;
 
-	rfc = opt->value;
-	strbuf_reset(rfc);
+	*rfc = opt->value;
 	if (!unset)
-		strbuf_addstr(rfc, arg ? arg : "RFC");
+		*rfc = arg ? arg : "RFC";
 	return 0;
 }
 
@@ -1919,7 +1918,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
 	struct strbuf sprefix = STRBUF_INIT;
-	struct strbuf rfc = STRBUF_INIT;
+	const char *rfc = NULL;
 	int creation_factor = -1;
 
 	const struct option builtin_format_patch_options[] = {
@@ -2064,8 +2063,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
-	if (rfc.len)
-		strbuf_insertf(&sprefix, 0, "%s ", rfc.buf);
+	if (rfc)
+		strbuf_insertf(&sprefix, 0, "%s ", rfc);
 
 	if (reroll_count) {
 		strbuf_addf(&sprefix, " v%s", reroll_count);
