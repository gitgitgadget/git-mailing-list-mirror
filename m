From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pretty: add %D format specifier
Date: Mon, 15 Sep 2014 15:44:25 -0700
Message-ID: <xmqq7g144i7q.fsf@gitster.dls.corp.google.com>
References: <54175F2D.3070209@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 16 00:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTf0e-0004vt-0N
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071AbaIOWob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:44:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51298 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755680AbaIOWo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:44:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 442973B50D;
	Mon, 15 Sep 2014 18:44:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qNK7JvjG39Lgzixl1FI2LrzfInQ=; b=SMTwU5
	8UMdDpWQjO7WhXkmrRlRxMQHeYB61+HVF04pXg3yJddQMj2H0XKNzNEmcuxMHDTx
	DGILtwjV0u3FfLcgJMNk2YNu+w2PxUgZ5aSYRhbPT2oGcW+DT34rn2U9EKUUqoOI
	3qy2s4rXUUyJ7ckYqKk+pF4ZwjsmdRdcy9BSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XLwgmLuDCeut+9EUuzw8THDfuE7wp3Gs
	NQG5HFveiKlujS0bT7bqNt71tosdSJM1SZyOCbI3OJzUfJDvUYEjg5NtS+VGZFWl
	Ki55PWlIxrVx/yNmTcfYuV7SzwUQcsFit9jvsFb9/lV5WG1F98eIVzFwS5BEmXyL
	Ff2TgA8cUWE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B72D3B50C;
	Mon, 15 Sep 2014 18:44:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF8E23B50A;
	Mon, 15 Sep 2014 18:44:26 -0400 (EDT)
In-Reply-To: <54175F2D.3070209@exec64.co.uk> (Harry Jeffery's message of "Mon,
	15 Sep 2014 22:50:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D8BEC0D8-3D29-11E4-998B-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257115>

Harry Jeffery <harry@exec64.co.uk> writes:

> Add a new format specifier, '%D' that is identical in behaviour to '%d',
> except that it does not include the ' (' prefix or ')' suffix provided
> by '%d'.
>
> Signed-off-by: Harry Jeffery <harry@exec64.co.uk>
> ---

The patch is broken and does not apply with "git am" here.  Please
first try sending a patch to yourself and make sure it comes through
OK.

Thanks.

> diff --git a/log-tree.h b/log-tree.h
> index d6ecd4d..b26160c 100644
> --- a/log-tree.h
> +++ b/log-tree.h
> @@ -13,7 +13,13 @@ int log_tree_diff_flush(struct rev_info *);
>  int log_tree_commit(struct rev_info *, struct commit *);
>  int log_tree_opt_parse(struct rev_info *, const char **, int);
>  void show_log(struct rev_info *opt);
> -void format_decorations(struct strbuf *sb, const struct commit
> *commit, int use_color);
> +void format_decorations_extended(struct strbuf *sb, const struct
> commit *commit,

Broken lines...

> +			     int use_color,
> +			     const char *prefix,
> +			     const char *separator,
> +			     const char *suffix);
> +#define format_decorations(strbuf, commit, color) \
> +			     format_decorations_extended((strbuf),
> (commit), (color), " (", ", ", ")")

Broken line here, too.

>  void show_decorations(struct rev_info *opt, struct commit *commit);
>  void log_write_email_headers(struct rev_info *opt, struct commit *commit,
>  			     const char **subject_p,
> diff --git a/pretty.c b/pretty.c
> index 44b9f64..46d65b9 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1197,6 +1197,10 @@ static size_t format_commit_one(struct strbuf
> *sb, /* in UTF-8 */
>  		load_ref_decorations(DECORATE_SHORT_REFS);
>  		format_decorations(sb, commit, c->auto_color);
>  		return 1;
> +	case 'D':
> +		load_ref_decorations(DECORATE_SHORT_REFS);
> +		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
> +		return 1;
>  	case 'g':		/* reflog info */
>  		switch(placeholder[1]) {
>  		case 'd':	/* reflog selector */
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index de0cc4a..38148c1 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -457,4 +457,15 @@ EOF
>  	test_cmp expected actual1
>  '
>
> +test_expect_success 'clean log decoration' '
> +	git log --no-walk --tags --pretty="%H %D" --decorate=full >actual &&
> +	cat <<EOF >expected &&
> +$head1 tag: refs/tags/tag2
> +$head2 tag: refs/tags/message-one
> +$old_head1 tag: refs/tags/message-two
> +EOF
> +	sort actual >actual1 &&
> +	test_cmp expected actual1
> +'
> +
>  test_done
