Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF17C091
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126889; cv=none; b=FsevXJLbfaK0XLnVnYkJMB7TeiJfF5uVHaEzYCNlMPYy8koW+kqYIjslaLBX+RAmQ4uBXDp7Ieg9t3IbwWR9wdVl+V3I83fef6HqkopWc8okky9Lktk8dA23z91zDSWUGrVBtG4arq1Rp8dFzvk0gOtiCqZA9x0AMQCf0nKGYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126889; c=relaxed/simple;
	bh=OM9NKQijo2A4vbo3cTHaiT3tkTIWZDd0YNAQj8+X+5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NBRaEGlILX7cZfCncV4WEsSrPIkj4Xku11ETvJi2b6tKksCvC+DP1zLvPenrlJeuf3zXHmtQ49OFMwmYQh8iQelAl9fD3y8twmScPpIXkFz3l9a77LQaJY99InHN4UAVaXnkxSjFFjQmKZZIFdojAqV1jBkZDYzDlEwenz8r224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ejHUyf9T; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ejHUyf9T"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 256F91E5864;
	Wed, 24 Jan 2024 15:08:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OM9NKQijo2A4vbo3cTHaiT3tkTIWZDd0YNAQj8
	+X+5U=; b=ejHUyf9T+HvdEadO4SL3KoutotZks1BZEsRHwt2vhSkEZizNpnQkfA
	a/oz7hHuCeBhbgerJNrDnaM2I3ctCU7vAy2YSOH/CJwPLxuVSGpMipbrpUxAonZB
	NLo6KWG1fvpZGrpVCkjC+AaZ8/rYa+ZktDSTuJfXbkQe1AJhoHmek=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09A811E5861;
	Wed, 24 Jan 2024 15:08:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12C511E5860;
	Wed, 24 Jan 2024 15:08:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Md Isfarul Haque via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Md Isfarul Haque <isfarul.876@gmail.com>
Subject: Re: [PATCH 1/2] FIX: use utf8_strnwidth for line_prefix in diff.c
In-Reply-To: <ac9338533c9096c090d1463c1b29505bde019731.1706105064.git.gitgitgadget@gmail.com>
	(Md Isfarul Haque via GitGitGadget's message of "Wed, 24 Jan 2024
	14:04:23 +0000")
References: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com>
	<ac9338533c9096c090d1463c1b29505bde019731.1706105064.git.gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 12:08:02 -0800
Message-ID: <xmqqplxqcx5p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 482FE166-BAF4-11EE-9798-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Md Isfarul Haque via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Md Isfarul Haque <isfarul.876@gmail.com>
>
> This patch adresses diff.c:2721 and proposes the fix using a new function.

Once the issue has fully been addressed, it is expected that the
NEEDSWORK comment there would be removed, making this proposed log
message useless.  Make it a habit to write a log message that is
self-contained enough to help readers (including yourself in the
future when you have forgotten the details of what you did in this
commit).

> +const struct strbuf *diff_line_prefix_buf(struct diff_options *opt)
> +{

Given that there is only one caller of this function in the same
file, I do not see a reason why this needs to be extern and exported
in diff.h (actually I do not see a need for this helper at all).

When dealing with a string buffer, it is much more common in this
codebase for the caller to prepare a strbuf (often on its stack) and
pass a pointer to it to helper functions.  I.e.

	static void prepare_diff_line_prefix_buf(struct strbuf *buf,
						struct diff_options *opt)
	{
		... stuff whatever you need into the string buffer ...
                strbuf_add(buf, ...);
	}

	/* in show_stats() */
	struct strbuf line_prefix = STRBUF_INIT;
	...
	prepare_diff_line_prefix_buf(&line_prefix, options);
	... use line_prefix and ...
	... release the resource before returning ...
	strbuf_release(&line_prefix);
	
is more common and less prone to resource leak over time.

> @@ -2635,7 +2649,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	int width, name_width, graph_width, number_width = 0, bin_width = 0;
>  	const char *reset, *add_c, *del_c;
>  	int extra_shown = 0;
> -	const char *line_prefix = diff_line_prefix(options);
> +	const struct strbuf *line_prefix = diff_line_prefix_buf(options);
>  	struct strbuf out = STRBUF_INIT;
>  
>  	if (data->nr == 0)
> @@ -2718,7 +2732,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	 * used to correctly count the display width instead of strlen().
>  	 */
>  	if (options->stat_width == -1)
> -		width = term_columns() - strlen(line_prefix);
> +		width = term_columns() - utf8_strnwidth(line_prefix->buf, line_prefix->len, 1);

I do not see the need for any of the diff_line_prefix_buf() related
changes, only to do this change.  You have a const char *line_prefix
at this point, and utf8_strnwidth() wants to know its length, so
what you need is to massage the parameter to match what it wants.
Perhaps even something simple and dumb like

	utf8_strnwidth(line_prefix, strlen(line_prefix), 1);

might be sufficient to replace strlen(line_prefix) in the original?

This patch hopefully will change the behaviour of the command.  A
patch needs to also protect the change from future breakages by
adding a test or two to demonstrate the desired behaviour.  Such a
test should pass with the code change in the patch, and should fail
when the code change in the patch gets reverted.

Thanks.
