Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34E2C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 18:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjDXSBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 14:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjDXSB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 14:01:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA136A42
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:01:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a6817adde4so52683225ad.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682359288; x=1684951288;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBBHfUGOHoCJQipqt65WynJo2a94ethjzrS8FfVSrVQ=;
        b=GBTyBAADF0bWnsGAdMqWTKeENXkCQr6f884G4mTjUB2vL9qp3DnbdZewZxSnzQ419D
         FQ+r4Igvd07nvFm3on5a5IeNQCTM2b7RdA/zop/0PmV9Mg1QgmlrPP4GLch5vFTzgBCA
         BjVupFhe/gtz/e7yehn47nm0UmOrrCiwuei9HtFIt0ePfHg5tHI83ophpl29Z3voBidF
         RmjCxvB+6kZXVUiXDSGnHUOdmbbKunPP1Btp1KD+foysKEhlrdb+NolP8T25dyQ3XXtU
         cNwqangqMwibU6aZXVFsHN/1sLVBj9jInx6laXzfi5vQIj0r0NK71+yoQUhrIICejJrz
         336A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682359288; x=1684951288;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VBBHfUGOHoCJQipqt65WynJo2a94ethjzrS8FfVSrVQ=;
        b=ASvZIL6H0J3u7FVfAC70xwFvgb0fPBZw205ay9P9HAkhBxKErVBmEkkaKRX9/8m+R+
         ohIJ3kNLjl8f/blftoaZTbIdV3jE7+It0lbccxePiCXaUcA4mhDYUHWRiT1eiJZf4sK2
         Qb/K6BlEGBaIHpaHb9YT9M9IA2A4BWRL2D7FnaUoFvgwP5NGyKRzy+yKjm5OD65Km7NR
         /9Vt3llJiw17i1BtzNbNFCC0Tri4msmBfijtP1i2CaKxI/6JzoNXk77lWW1bsL29zfBW
         +qwgx+9QKIaBJR0U6H2PvJAwQx1FxamOolkE+oJJDBDUpVASQCkZ87vKXoeI/D+yCt/Y
         DGDw==
X-Gm-Message-State: AAQBX9fcCrCOuiAsmwCYLjZq2BnLGvleRhLGDhx0b4PA/TH/6WoONLTS
        TsCJ7pI0nKGaCQsiHQyzz8o=
X-Google-Smtp-Source: AKy350bwwEUccZDrfTKKKl5PNZjJz0kFxmAx+Dwi+Y8OUncKuC3SgE/qv7jO9nZJgKwIp48Ykckh6Q==
X-Received: by 2002:a17:902:ebd1:b0:1a5:2757:d40a with SMTP id p17-20020a170902ebd100b001a52757d40amr14831331plg.49.1682359287478;
        Mon, 24 Apr 2023 11:01:27 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jh10-20020a170903328a00b001a6ce2bcb3esm6913736plb.161.2023.04.24.11.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:01:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] parse_commit(): handle broken whitespace-only
 timestamp
References: <20230422135001.GA3942563@coredump.intra.peff.net>
Date:   Mon, 24 Apr 2023 11:01:26 -0700
In-Reply-To: <20230422135001.GA3942563@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 22 Apr 2023 09:50:01 -0400")
Message-ID: <xmqqy1mhdurt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The comment in parse_commit_date() claims that parse_timestamp() will
> not walk past the end of the buffer we've been given, since it will hit
> the newline at "eol" and stop. This is usually true, when dateptr
> contains actual numbers to parse. But with a line like:
>
>    committer name <email>   \n

I was wondering of this case while reading [2/3] ;-)

> ...
> In practice this can't cause us to walk off the end of an array, because
> we always add an extra NUL byte to the end of objects we load from disk
> (as a defense against exactly this kind of bug). However, you can see
> the behavior in action when "committer" is the final header (which it
> usually is, unless there's an encoding) and the subject line can be
> parsed as an integer. We walk right past the newline on the committer
> line, as well as the "\n\n" separator, and mistake the subject for the
> timestamp.


> +	/*
> +	 * trim leading whitespace; parse_timestamp() will do this itself, but
> +	 * it will walk past the newline at eol while doing so. So we insist
> +	 * that there is at least one digit here.
> +	 */

"one digit" -> "one non-whitespace".

> +	while (dateptr < eol && isspace(*dateptr))
> +		dateptr++;

This is an expected change, but

> +	if (!strchr("0123456789", *dateptr))
> +		return 0;

this is not.  Isn't the only problematic case that dateptr being at
eol?  That is what the proposed log message argued.

>  	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */

This comment is slightly stale.  dateptr < eol, *eol == '\n', and we
know the string starting at dateptr is not a run of whitespace and
that is what makes the parsing stop at eol.

> diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
> index af4b35ff56..d4ef48d646 100755
> --- a/t/t4212-log-corrupt.sh
> +++ b/t/t4212-log-corrupt.sh
> @@ -92,4 +92,33 @@ test_expect_success 'absurdly far-in-future date' '
>  	git log -1 --format=%ad $commit
>  '
>  
> +test_expect_success 'create commit with whitespace committer date' '
> +	# It is important that this subject line is numeric, since we want to
> +	# be sure we are not confused by skipping whitespace and accidentally
> +	# parsing the subject as a timestamp.

Nice.

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
>  test_done
