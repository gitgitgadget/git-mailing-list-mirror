Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E35C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 10:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjDYKLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 06:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjDYKLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 06:11:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74888CC17
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 03:11:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f196e8e2c6so37774125e9.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682417470; x=1685009470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ftJ4qtJd1MNgohc1mv/80unNMOfIs4djdF9BKfFezrk=;
        b=LFtNAw7woMGIE3KKCWODahNrql4i7G4vHVeSjVx8d2bcc+EaEAvXy48vPu0mqBHrmQ
         ZC8sIKusyESYY/7nf/dARb4He/TzsTPNAJiJbOIBKg8fqmW3ua1BisEXIe1QJhPT68bR
         LNQpJ/pa/y8IlnCr9kLyTBEx7g/c4jceHnHORZoxKSahoHELOOiWx19/0wYfiEgXvBrD
         r3Wc5SBb+JTe8AZu5jZjc7lJfzmiYXzi3lMhkgZSsuxo8OKW8mRQdBiilTq6HkWoTCK+
         jTBrFK4fhzbJLUfyYUHmY/maN73LPraVzsMu8Lv7+r+WncJ83wrfchml9bT+geUOeO+0
         ai/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682417470; x=1685009470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftJ4qtJd1MNgohc1mv/80unNMOfIs4djdF9BKfFezrk=;
        b=Tr9G9x5qY1N00s12GCm0l18VtDnWepBXYIhijhQ5pqJEZ0YxviGJY0CLybV2pJb0eT
         Dby2hSXBpr5chUgKA6r7+6aDR/mlEYG7QkYTqmLWOClagyL/12CASvjpD4DRFYozoqPN
         BZMEfTJh2nK/sVpXL3odA+7erlROtneHeOPmiYiHAASI3p+vhTaDM8lQi9rb5C3mywhp
         DyScsGyrsbL9kYcROVrkxNxr/tNvvTvrUe7NrK8X7EwWI/icJKVBr3KLms/9Suwk0pyq
         F/lcHKQlbfdPYEjXt0TN5cc7bJEkE0ASRv2n2hzi9wzSCYE25AHvEnh35ZYbeSl4jm+z
         YOEg==
X-Gm-Message-State: AAQBX9f0/FPFX8Q21VWIHh9KwcyXlr8pYN+o/qXpE1i3CdGWXOB7kr0s
        TPLQBZudW3JMNrrNNV/PU14=
X-Google-Smtp-Source: AKy350YfOinkVUqnkosfTd2nzjjLdiWwnnL+y2ihV1yEv228S6FvcxTF1FUYg6p/EfrvWlw7pfUGMA==
X-Received: by 2002:a1c:4b05:0:b0:3f1:6757:6245 with SMTP id y5-20020a1c4b05000000b003f167576245mr9737294wma.7.1682417469578;
        Tue, 25 Apr 2023 03:11:09 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id v16-20020a05600c471000b003ede3f5c81fsm18059805wmo.41.2023.04.25.03.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 03:11:09 -0700 (PDT)
Message-ID: <06bc5530-55b0-7299-a6e6-fde1deab6605@gmail.com>
Date:   Tue, 25 Apr 2023 11:11:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] parse_commit(): handle broken whitespace-only
 timestamp
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Thomas Bock <bockthom@cs.uni-saarland.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20230425055244.GA4014505@coredump.intra.peff.net>
 <20230425055458.GC4015649@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230425055458.GC4015649@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 25/04/2023 06:54, Jeff King wrote:
> The comment in parse_commit_date() claims that parse_timestamp() will
> not walk past the end of the buffer we've been given, since it will hit
> the newline at "eol" and stop. This is usually true, when dateptr
> contains actual numbers to parse. But with a line like:
> 
>     committer name <email>   \n
> 
> with just whitespace, and no numbers, parse_timestamp() will consume
> that newline as part of the leading whitespace, and we may walk past our
> "tail" pointer (which itself is set from the "size" parameter passed in
> to parse_commit_buffer()).
> 
> In practice this can't cause us to walk off the end of an array, because
> we always add an extra NUL byte to the end of objects we load from disk
> (as a defense against exactly this kind of bug). However, you can see
> the behavior in action when "committer" is the final header (which it
> usually is, unless there's an encoding) and the subject line can be
> parsed as an integer. We walk right past the newline on the committer
> line, as well as the "\n\n" separator, and mistake the subject for the
> timestamp.
> 
> The new test demonstrates such a case. I also added a test to check this
> case against the pretty-print formatter, which uses split_ident_line().
> It's not subject to the same bug, because it insists that there be one
> or more digits in the timestamp.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   commit.c               | 17 +++++++++++++++--
>   t/t4212-log-corrupt.sh | 29 +++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/commit.c b/commit.c
> index bb340f66fa..2f1b5d505b 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -120,10 +120,23 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
>   	dateptr = eol;
>   	while (dateptr > buf && dateptr[-1] != '>')
>   		dateptr--;
> -	if (dateptr == buf || dateptr == eol)
> +	if (dateptr == buf)
>   		return 0;
>   
> -	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */
> +	/*
> +	 * Trim leading whitespace; parse_timestamp() will do this itself, but
> +	 * if we have _only_ whitespace, it will walk right past the newline
> +	 * while doing so.
> +	 */
> +	while (dateptr < eol && isspace(*dateptr))
> +		dateptr++;
> +	if (dateptr == eol)
> +		return 0;
> +
> +	/*
> +	 * We know there is at least one non-whitespace character, so we'll
> +	 * begin parsing there and stop at worst case at eol.
> +	 */

This probably doesn't matter in practice but we define our own isspace() 
that does not treat '\v' and '\f' as whitespace. However 
parse_timestamp() (which is just strtoumax()) uses the standard 
library's isspace() which does treat those characters as whitespace and 
is locale dependent. This means we can potentially stop at a character 
that parse_timestamp() treats as whitespace and if there are no digits 
after it we'll still walk past the end of the line. Using Rene's 
suggestion of testing the character with isdigit() would fix that. It 
would also avoid parsing negative timestamps as positive numbers and 
reject any timestamps that begin with a locale dependent digit.

I'm not familiar with this code, but would it be worth changing 
parse_timestamp() to stop parsing if it sees a newline?

Best Wishes

Phillip

>   	return parse_timestamp(dateptr, NULL, 10);
>   }
>   
> diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
> index af4b35ff56..d4ef48d646 100755
> --- a/t/t4212-log-corrupt.sh
> +++ b/t/t4212-log-corrupt.sh
> @@ -92,4 +92,33 @@ test_expect_success 'absurdly far-in-future date' '
>   	git log -1 --format=%ad $commit
>   '
>   
> +test_expect_success 'create commit with whitespace committer date' '
> +	# It is important that this subject line is numeric, since we want to
> +	# be sure we are not confused by skipping whitespace and accidentally
> +	# parsing the subject as a timestamp.
> +	#
> +	# Do not use munge_author_date here. Besides not hitting the committer
> +	# line, it leaves the timezone intact, and we want nothing but
> +	# whitespace.
> +	test_commit 1234567890 &&
> +	git cat-file commit HEAD >commit.orig &&
> +	sed "s/>.*/>    /" <commit.orig >commit.munge &&
> +	ws_commit=$(git hash-object --literally -w -t commit commit.munge)
> +'
> +
> +test_expect_success '--until treats whitespace date as sentinel' '
> +	echo $ws_commit >expect &&
> +	git rev-list --until=1980-01-01 $ws_commit >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'pretty-printer handles whitespace date' '
> +	# as with the %ad test above, we will show these as the empty string,
> +	# not the 1970 epoch date. This is intentional; see 7d9a281941 (t4212:
> +	# test bogus timestamps with git-log, 2014-02-24) for more discussion.
> +	echo : >expect &&
> +	git log -1 --format="%at:%ct" $ws_commit >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done

