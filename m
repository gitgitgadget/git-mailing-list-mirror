Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923BAC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 20:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E9C208D5
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 20:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A1A6mT6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgI1U6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 16:58:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63165 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1U6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 16:58:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C99BC74D22;
        Mon, 28 Sep 2020 16:58:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yV04nZIHIzynD9hS+CZqAtbbRr0=; b=A1A6mT
        6V3V+pdRjVacNiZmZlpzUKd+Z0rrfMzTgIu8QijiRec2KAY38s/dHby4LZB0mJCJ
        4fYMFtqrrsAL4FkAp5Jmg00ZJR5UayQdAqEFy3s5yFtaMw3N7gi/LPz2dPXiwG1f
        MEZ2cnrhqziitZ/E8ktenIqMXaF4tjAAHjoCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a+ut5IKbi/7G3z5AKRnupoYBYzkIjGrH
        LAjkjy3lmg2Vx0lhPBYPIpX33xYAMWll8B2IQjyJ3wXBF+eaPQClYS5CmXZWOoD4
        lQAvWf1AKSwcj67+lbHry3TbPhW+BYvZ7LHgHDJaNiQZjkhlRb5DB4Jc5zPZJK9z
        vq/soGKz99Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9351E74D20;
        Mon, 28 Sep 2020 16:58:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43ABE74D1F;
        Mon, 28 Sep 2020 16:58:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nikita Leonov via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
        <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
        <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 13:58:03 -0700
In-Reply-To: <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
        (Nikita Leonov via GitGitGadget's message of "Mon, 28 Sep 2020
        11:40:23 +0000")
Message-ID: <xmqqk0wdliuc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D60B5B8-01CD-11EB-9F58-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nikita Leonov via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nikita Leonov <nykyta.leonov@gmail.com>
>
> This commit makes reading process regarding credentials compatible with
> 'CR/LF' line ending. It makes using git more convenient on systems like
> Windows.

I can see why this is a good thing for "store" and the two updated
pieces of the test script demonstrate it very well.  

But it is unclear why and how cache-daemon benefits from this change.
That needs to be justified.

As to the log message (this is 70% style, but there are
consequences), we tend not to say "This commit does X"---because
such a statement is often insufficient to illustrate if the commit
indeed does X, and explain why it is a good thing to do X in the
first place.

Instead, we first explain that the current system does not do X (in
present tense, so we do NOT say "previously we did not do X"), then
explain why doing X would be a good thing, and finally give an order
to the codebase to start doing X.  For this change, it might look
like this:

    The credential subsystem has assumed that lines always end with
    LF.  On a system whose text file ends with CRLF (e.g. Windows),
    this assumption causes the CR at the end of the line as an extra
    byte appended to the data, and worse, there is no way to send an
    "empty line" to signal an end of a group of lines, because such
    a line would be taken as a line with a lone CR on it.

    Because credential-store writes to and reads from a text file on
    disk, which users may manually edit with their editor and turn
    the line-ending to CRLF.

    Accept lines that end with CR/LF, as well as those that end with
    LF.

    Note that the credential-cache--daemon is not touched, because
    it is only about interacting with in-core cache, and there is
    nowhere CRLF comes into the picture.



Note: I didn't know why we need to touch the daemon, and that is why
I wrote the paragraph on it as such, but I expect that the real log
message to justify the change would be quite different and explain
why the daemon code needs the same change well---such a description
would not be "Note that", but would come before the "Accept lines
that end with..." and after the paragraph about credential-store.

Thanks.

> Signed-off-by: Nikita Leonov <nykyta.leonov@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/credential-cache--daemon.c |  4 ++--
>  builtin/credential-store.c         |  2 +-
>  t/t0302-credential-store.sh        | 16 ++++++----------
>  3 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index c61f123a3b..17664bb0d5 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -99,12 +99,12 @@ static int read_request(FILE *fh, struct credential *c,
>  	static struct strbuf item = STRBUF_INIT;
>  	const char *p;
>  
> -	strbuf_getline_lf(&item, fh);
> +	strbuf_getline(&item, fh);
>  	if (!skip_prefix(item.buf, "action=", &p))
>  		return error("client sent bogus action line: %s", item.buf);
>  	strbuf_addstr(action, p);
>  
> -	strbuf_getline_lf(&item, fh);
> +	strbuf_getline(&item, fh);
>  	if (!skip_prefix(item.buf, "timeout=", &p))
>  		return error("client sent bogus timeout line: %s", item.buf);
>  	*timeout = atoi(p);
> diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> index 5331ab151a..d4e90b68df 100644
> --- a/builtin/credential-store.c
> +++ b/builtin/credential-store.c
> @@ -23,7 +23,7 @@ static int parse_credential_file(const char *fn,
>  		return found_credential;
>  	}
>  
> -	while (strbuf_getline_lf(&line, fh) != EOF) {
> +	while (strbuf_getline(&line, fh) != EOF) {
>  		if (!credential_from_url_gently(&entry, line.buf, 1) &&
>  		    entry.username && entry.password &&
>  		    credential_match(c, &entry)) {
> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index 716bf1af9f..f2c672e4b6 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -142,7 +142,7 @@ invalid_credential_test "scheme" ://user:pass@example.com
>  invalid_credential_test "valid host/path" https://user:pass@
>  invalid_credential_test "username/password" https://pass@example.com
>  
> -test_expect_success 'get: credentials with DOS line endings are invalid' '
> +test_expect_success 'get: credentials with DOS line endings are valid' '
>  	printf "https://user:pass@example.com\r\n" >"$HOME/.git-credentials" &&
>  	check fill store <<-\EOF
>  	protocol=https
> @@ -150,11 +150,9 @@ test_expect_success 'get: credentials with DOS line endings are invalid' '
>  	--
>  	protocol=https
>  	host=example.com
> -	username=askpass-username
> -	password=askpass-password
> +	username=user
> +	password=pass
>  	--
> -	askpass: Username for '\''https://example.com'\'':
> -	askpass: Password for '\''https://askpass-username@example.com'\'':
>  	--
>  	EOF
>  '
> @@ -172,7 +170,7 @@ test_expect_success 'get: credentials with path and DOS line endings are valid'
>  	EOF
>  '
>  
> -test_expect_success 'get: credentials with DOS line endings are invalid if path is relevant' '
> +test_expect_success 'get: credentials with DOS line endings are valid if path is relevant' '
>  	printf "https://user:pass@example.com/repo.git\r\n" >"$HOME/.git-credentials" &&
>  	test_config credential.useHttpPath true &&
>  	check fill store <<-\EOF
> @@ -181,11 +179,9 @@ test_expect_success 'get: credentials with DOS line endings are invalid if path
>  	protocol=https
>  	host=example.com
>  	path=repo.git
> -	username=askpass-username
> -	password=askpass-password
> +	username=user
> +	password=pass
>  	--
> -	askpass: Username for '\''https://example.com/repo.git'\'':
> -	askpass: Password for '\''https://askpass-username@example.com/repo.git'\'':
>  	--
>  	EOF
>  '
