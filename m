Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0079D203EA
	for <e@80x24.org>; Fri, 19 Aug 2016 00:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbcHSA4C (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:56:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52435 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753776AbcHSAzg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:55:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4CEA34C9E;
        Thu, 18 Aug 2016 12:37:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uguOSpPNm8ITgyCTW0uqWd6Vpuo=; b=bjQ/Eh
        UhPlSWaNi89BTgsskSbnGroH8PKRKVtKJwzQX/RmsVzeHyMrAku0xdWGT6FQa1I+
        DZJgguhE9jannsbKOH5Z4pCJT0s3Yhe9ZCrf9o8E6J02EkUeUVGQlMw9r2kH2pm1
        6ypbeRTnVaTm/i8JT5VvUqEaiohGOeQV8p03Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WNvKhb5ucyo5J+OHMFRi5FoQsvr6uKr6
        ATMJJoJuvZZDIM9eLKcgkyRLUvYBV7xhhJYmK8DZs0gidyY2601wHIbnzTxSyhhS
        Uq/t2TIXpBDW1qEoSSFJA3u0gBVXh3qKkRy/VQJctvjIpv/+kTxXwXg2EPh0Wsq7
        4+diSbpAAr8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D373C34C9C;
        Thu, 18 Aug 2016 12:37:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55F4134C9B;
        Thu, 18 Aug 2016 12:37:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] cat-file: introduce the --filters option
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de>
Date:   Thu, 18 Aug 2016 09:37:27 -0700
In-Reply-To: <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 18 Aug 2016 14:46:17 +0200
        (CEST)")
Message-ID: <xmqqk2fe6njs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DC5CD8C-6562-11E6-AB7E-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> As suggested by its name, the --filters option applies the filters
> that are currently configured for the specified path.
>
> This feature comes in handy when a 3rd-party tool wants to work with
> the contents of files from past revisions as if they had been checked
> out, but without detouring via temporary files.
>
> Note that we ensure that symbolic links are unaffected (we know from
> looking at the mode whether it refers to a symbolic link or a regular
> file).

I think you can lose the last paragraph and enrich the first one
instead.  The text as-given does not even say anything about the new
option affecting only blobs.

	The --filters option applies the convert_to_working_tree()
	filter for the path when showing the contents of a regular
	file blob object.

or something like that.

> +--filters::
> +	Show the content as transformed by the filters configured in
> +	the current working tree for the given <path> (i.e. smudge filters,
> +	end-of-line conversion, etc). In this case, <object> has to be of
> +	the form <tree-ish>:<path>, or :<path>.

Makes sense.  We show the contents as if we are checking the blob
out to the given <path>, in other words.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 2dfe626..0b74afa 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -20,6 +20,33 @@ struct batch_options {
>  	const char *format;
>  };
>  
> +static int filter_object(const char *path, unsigned mode,
> +			 const unsigned char *sha1,
> +			 char **buf, unsigned long *size)
> +{
> +	enum object_type type;
> +
> +	*buf = read_sha1_file(sha1, &type, size);
> +	if (!*buf)
> +		return error(_("cannot read object %s '%s'"),
> +			sha1_to_hex(sha1), path);
> +	if (type != OBJ_BLOB) {
> +		free(*buf);
> +		return error(_("blob expected for %s '%s'"),
> +			sha1_to_hex(sha1), path);
> +	}
> +	if (S_ISREG(mode)) {
> +		struct strbuf strbuf = STRBUF_INIT;
> +		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
> +			free(*buf);
> +			*size = strbuf.len;
> +			*buf = strbuf_detach(&strbuf, NULL);
> +		}
> +	}

This is just a tangent for future clean-up of the coding convention,
but if we used size_t internally throughout the system, we would be
able to use strbuf_detach(&strbuf, size) instead.  With the current
coding convention, all internal sizes are ulong, and this is the
best we could do.

> @@ -61,6 +88,16 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  	case 'e':
>  		return !has_sha1_file(sha1);
>  
> +	case 'w':
> +		if (!obj_context.path[0])
> +			die("git cat-file --filters %s: <object> must be "
> +			    "<sha1:path>", obj_name);
> +
> +		if (filter_object(obj_context.path, obj_context.mode,
> +				  sha1, &buf, &size))
> +			return -1;
> +		break;
> +

Makes sense.

> diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
> new file mode 100755
> index 0000000..e466634
> --- /dev/null
> +++ b/t/t8010-cat-file-filters.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +
> +test_description='git cat-file filters support'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup ' '
> +	echo "*.txt eol=crlf diff=txt" >.gitattributes &&
> +	echo "hello" | append_cr >world.txt &&
> +	git add .gitattributes world.txt &&
> +	test_tick &&
> +	git commit -m "Initial commit"
> +'

OK, so we ask *.txt in the working tree to be CRLF (and presumably
that means the in-repository objects are LF).

> +has_cr () {
> +	tr '\015' Q <"$1" | grep Q >/dev/null
> +}
> +
> +test_expect_success 'no filters with `git show`' '
> +	git show HEAD:world.txt >actual &&
> +	! has_cr actual
> +
> +'
> +
> +test_expect_success 'no filters with cat-file' '
> +	git cat-file blob HEAD:world.txt >actual &&
> +	! has_cr actual
> +'

OK.

> +test_expect_success 'cat-file --filters converts to worktree version' '
> +	git cat-file --filters HEAD:world.txt >actual &&
> +	has_cr actual
> +'

OK.
