Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9971954F86
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180401; cv=none; b=dMuvXhYlkWM+s7f48C44FVmYX57jIQFVO2MDH/eqZl2nLlvwow7gDTWu9FKJ8ggxGazQNbnRvIgW8vIsdTUTcSqVNXpWlBn3mpY03RicM7hmnJy0REGkudAaSN+McZooigrU9x+hUAfWGlISDOlBm2YPFo/3SvDpmbypf4wHSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180401; c=relaxed/simple;
	bh=d8skABLWUmsf74aiO3PKXUV/CbB8TUaaH6I5zYjegJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DbvfSwPB+nYzOVigtxaSKzld5U8n7qEDys1Ku/LhH2Y1EYVBGadn8cahRuSOlNMJN3hFbfKWosXA8Oc+waH8G6RQzHNTpt8CD48XjRuZq7cYqHXpo5nna+IjUqWF2AFFpHDR7YFHeNjm4GpY+JFNlVdnlb22KCJ+XwRvStq8g8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=twZduUYC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="twZduUYC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F70F1EE2EB;
	Mon, 11 Mar 2024 14:06:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=d8skABLWUmsf74aiO3PKXUV/CbB8TUaaH6I5zY
	jegJM=; b=twZduUYCIETJTWH+O6dqrQzLGKoqLeE1riwZdUGeB5x3kCOSasVG6H
	maTOXafPoQUj/gJIGFT4NtLk7/5pgaf0+mkD6PB5NJltS12TPdunh+9wIk6zcx6/
	VHzykWck7B6yn52cSvYJGtqt/j+it6wKBSy9jbwwTNnnaOV83q4dI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 664111EE2E9;
	Mon, 11 Mar 2024 14:06:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C53131EE2E8;
	Mon, 11 Mar 2024 14:06:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: git@vger.kernel.org,  David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] diff: add diff.srcprefix and diff.dstprefix option support
In-Reply-To: <20240311023217.GA2345739@quokka> (Peter Hutterer's message of
	"Mon, 11 Mar 2024 12:32:17 +1000")
References: <20240311023217.GA2345739@quokka>
Date: Mon, 11 Mar 2024 11:06:36 -0700
Message-ID: <xmqqplw0r6c3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1AA5CE88-DFD2-11EE-B937-25B3960A682E-77302942!pb-smtp2.pobox.com

Peter Hutterer <peter.hutterer@who-t.net> writes:

> Subject: Re: [PATCH] diff: add diff.srcprefix and diff.dstprefix option support

"option support" -> "configuration variables"

> The git option equivalent to --src-prefix and --dst-prefix.
> Both of these are of lower precedence than the diff.noprefix and
> diff.mnemonicprefix option.

I think it will become simpler to sell and explain if you do not
mention these options, and instead say that we are tweaking the
default prefixes used when none of the other options are used,
something like:

	Allow the default prefixes "a/" and "b/" to be tweaked by
	diff.srcprefix and diff.dstprefix configuration variables.
	
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
> +diff.srcprefix::
> +	If set, 'git diff' uses this source prefix.

Add "Defaults to 'a/'", perhaps?

> @@ -3429,6 +3437,14 @@ void diff_set_default_prefix(struct diff_options *options)
>  	options->b_prefix = "b/";
>  }
>  
> +void diff_set_custom_prefix(struct diff_options *options, const char *src_prefix, const char *dst_prefix)
> +{
> +	if (src_prefix)
> +		options->a_prefix = src_prefix;
> +	if (dst_prefix)
> +		options->b_prefix = dst_prefix;
> +}
> +
>  struct userdiff_driver *get_textconv(struct repository *r,
>  				     struct diff_filespec *one)
>  {
> @@ -4736,6 +4752,8 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
>  		diff_set_noprefix(options);
>  	} else if (!diff_mnemonic_prefix) {
>  		diff_set_default_prefix(options);
> +		if (diff_src_prefix || diff_dst_prefix)
> +			diff_set_custom_prefix(options, diff_src_prefix, diff_dst_prefix);
>  	}

This feels somewhat roundabout way to do this.  Instead of touching
this part at all, and not adding diff_set_custom_prefix() function,
how about just patching diff_set_default_prefix()?  The function
does not even have to be public and there is no need to touch the
header file.

Here is how I would simplify the code change part if I were doing
this patch.  It seems to pass t4013 (including your additional
ones).

Thanks.


 diff.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git i/diff.c w/diff.c
index e50def4538..4439b1a958 100644
--- i/diff.c
+++ w/diff.c
@@ -62,6 +62,8 @@ static const char *diff_order_file_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
+static const char *diff_src_prefix = "a/";
+static const char *diff_dst_prefix = "b/";
 static int diff_relative;
 static int diff_stat_name_width;
 static int diff_stat_graph_width;
@@ -408,6 +410,12 @@ int git_diff_ui_config(const char *var, const char *value,
 		diff_no_prefix = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.srcprefix")) {
+		return git_config_string(&diff_src_prefix, var, value);
+	}
+	if (!strcmp(var, "diff.dstprefix")) {
+		return git_config_string(&diff_dst_prefix, var, value);
+	}
 	if (!strcmp(var, "diff.relative")) {
 		diff_relative = git_config_bool(var, value);
 		return 0;
@@ -3425,8 +3433,8 @@ void diff_set_noprefix(struct diff_options *options)
 
 void diff_set_default_prefix(struct diff_options *options)
 {
-	options->a_prefix = "a/";
-	options->b_prefix = "b/";
+	options->a_prefix = diff_src_prefix;
+	options->b_prefix = diff_dst_prefix;
 }
 
 struct userdiff_driver *get_textconv(struct repository *r,
