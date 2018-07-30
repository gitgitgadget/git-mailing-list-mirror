Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BF001F597
	for <e@80x24.org>; Mon, 30 Jul 2018 17:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbeG3TVX (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:21:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40472 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeG3TVX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:21:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so13792198wrs.7
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/iUH3rltyUfwHsoFP/QCo6PVPAlhtTQGJLrkcGdLYQs=;
        b=qsFfGHS4/Bg5a2q456GkiRdF3pWATzS0TlPh6qQ3Zz7ey4QQqh1cGKx4TUmZbF1G26
         LLoc4GG63IRKJEQ+H/6zTlrTP5asPxe6e3tE3iLsBra5h3oO9xSXNWEtGuSKcXjvG+IY
         In6W/9JkbNJAdc3CpFOlJxasqbGLfKgjxh2YmVUezyUKaM5hXCvIzbAPqpJC1RFxXxIu
         dSBmNS/WD1HwkYv1D7w9yxas1vVnUcTJnPjQzQyhTvDIdmAc1peDnYyRFBcLgHCaKJ18
         BYEndkoLXe2EzfrwsBZ3AE9K92fojPPM/opSha2XNFRX1ZoTtkGiNjRFZfuglNiHzY3U
         uylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/iUH3rltyUfwHsoFP/QCo6PVPAlhtTQGJLrkcGdLYQs=;
        b=NUamLEWO4ki75apsFEk+Ai6USlEsZhqOIwSPNB3cbfOiJV7G02d8xapf/5VhHCKS7J
         lzewrShFK8LX/ckxvW5xPEF7hiyzpKLJZq23IBih7sJWei/MhMWMhgkTDBebFtDY1pi6
         ueXuTRJcTn11nO7CzTa8M1H+mIS7weOhqgN5SRgJ9Lm8Zcboqz67ZDHi57Yjjqc26eVb
         h4Gxc4Suf12ELJf1xfwAxkA71eJV1qOLzg9QHCvznHDfxoOXTNcRK3EA5hBKJH6d5FmK
         vqMyDguXlHBHjH397MmwbURwdEdWme8rBOSb/Ijy7t6VhhYY18Pw7gEMuwltwsvgueAh
         1pog==
X-Gm-Message-State: AOUpUlFGyAwX5hB/yZH0714rV0r9DAGbWZ7s0HU+FNXWI1k7cpw1ENQl
        OlAPxzYgZk/m4ah0bF2w4G0=
X-Google-Smtp-Source: AAOMgpfQ7gfbZrmXsc60wjABdFmjtugupoWsjxI9dw9AuPkqoVCc4eUXNO9KMyVFwABojiqgBYUmbA==
X-Received: by 2002:adf:c891:: with SMTP id k17-v6mr19566117wrh.6.1532972716525;
        Mon, 30 Jul 2018 10:45:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b2-v6sm264996wmh.3.2018.07.30.10.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:45:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 10/11] rerere: teach rerere to handle nested conflicts
References: <20180605215219.28783-1-t.gummerer@gmail.com>
        <20180714214443.7184-1-t.gummerer@gmail.com>
        <20180714214443.7184-11-t.gummerer@gmail.com>
Date:   Mon, 30 Jul 2018 10:45:15 -0700
In-Reply-To: <20180714214443.7184-11-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sat, 14 Jul 2018 22:44:42 +0100")
Message-ID: <xmqqzhy8hb2s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Currently rerere can't handle nested conflicts and will error out when
> it encounters such conflicts.  Do that by recursively calling the
> 'handle_conflict' function to normalize the conflict.
>
> The conflict ID calculation here deserves some explanation:
>
> As we are using the same handle_conflict function, the nested conflict
> is normalized the same way as for non-nested conflicts, which means
> the ancestor in the diff3 case is stripped out, and the parts of the
> conflict are ordered alphabetically.
>
> The conflict ID is however is only calculated in the top level
> handle_conflict call, so it will include the markers that 'rerere'
> adds to the output.  e.g. say there's the following conflict:
>
>     <<<<<<< HEAD
>     1
>     =======
>     <<<<<<< HEAD
>     3
>     =======
>     2
>     >>>>>>> branch-2
>     >>>>>>> branch-3~

Hmph, I vaguely recall that I made inner merges to use the conflict
markers automatically lengthened (by two, if I recall correctly)
than its immediate outer merge.  Wouldn't the above look more like

     <<<<<<< HEAD
     1
     =======
     <<<<<<<<< HEAD
     3
     =========
     2
     >>>>>>>>> branch-2
     >>>>>>> branch-3~
    
Perhaps I am not recalling it correctly.

> it would be recorde as follows in the preimage:
>
>     <<<<<<<
>     1
>     =======
>     <<<<<<<
>     2
>     =======
>     3
>     >>>>>>>
>     >>>>>>>
>
> and the conflict ID would be calculated as
>
>     sha1(1<NUL><<<<<<<
>     2
>     =======
>     3
>     >>>>>>><NUL>)
>
> Stripping out vs. leaving the conflict markers in place in the inner
> conflict should have no practical impact, but it simplifies the
> implementation.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  Documentation/technical/rerere.txt | 42 ++++++++++++++++++++++++++++++
>  rerere.c                           | 10 +++++--
>  t/t4200-rerere.sh                  | 37 ++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
> index 4102cce7aa..60d48dc4fe 100644
> --- a/Documentation/technical/rerere.txt
> +++ b/Documentation/technical/rerere.txt
> @@ -138,3 +138,45 @@ SHA1('B<NUL>C<NUL>').
>  If there are multiple conflicts in one file, the sha1 is calculated
>  the same way with all hunks appended to each other, in the order in
>  which they appear in the file, separated by a <NUL> character.
> +
> +Nested conflicts
> +~~~~~~~~~~~~~~~~
> +
> +Nested conflicts are handled very similarly to "simple" conflicts.
> +Similar to simple conflicts, the conflict is first normalized by
> +stripping the labels from conflict markers, stripping the diff3
> +output, and the sorting the conflict hunks, both for the outer and the
> +inner conflict.  This is done recursively, so any number of nested
> +conflicts can be handled.
> +
> +The only difference is in how the conflict ID is calculated.  For the
> +inner conflict, the conflict markers themselves are not stripped out
> +before calculating the sha1.
> +
> +Say we have the following conflict for example:
> +
> +    <<<<<<< HEAD
> +    1
> +    =======
> +    <<<<<<< HEAD
> +    3
> +    =======
> +    2
> +    >>>>>>> branch-2
> +    >>>>>>> branch-3~
> +
> +After stripping out the labels of the conflict markers, and sorting
> +the hunks, the conflict would look as follows:
> +
> +    <<<<<<<
> +    1
> +    =======
> +    <<<<<<<
> +    2
> +    =======
> +    3
> +    >>>>>>>
> +    >>>>>>>
> +
> +and finally the conflict ID would be calculated as:
> +`sha1('1<NUL><<<<<<<\n3\n=======\n2\n>>>>>>><NUL>')`
> diff --git a/rerere.c b/rerere.c
> index a35b88916c..f78bef80b1 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -365,12 +365,18 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
>  		RR_SIDE_1 = 0, RR_SIDE_2, RR_ORIGINAL
>  	} hunk = RR_SIDE_1;
>  	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
> -	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT, conflict = STRBUF_INIT;
>  	int has_conflicts = -1;
>  
>  	while (!io->getline(&buf, io)) {
>  		if (is_cmarker(buf.buf, '<', marker_size)) {
> -			break;
> +			if (handle_conflict(&conflict, io, marker_size, NULL) < 0)
> +				break;
> +			if (hunk == RR_SIDE_1)
> +				strbuf_addbuf(&one, &conflict);
> +			else
> +				strbuf_addbuf(&two, &conflict);

Hmph, do we ever see the inner conflict block while we are skipping
and ignoring the common ancestor version, or it is impossible that
we see '<' only while processing either our or their side?

> +			strbuf_release(&conflict);
>  		} else if (is_cmarker(buf.buf, '|', marker_size)) {
>  			if (hunk != RR_SIDE_1)
>  				break;
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index 34f0518a5e..d63fe2b33b 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -602,4 +602,41 @@ test_expect_success 'rerere with unexpected conflict markers does not crash' '
>  	git rerere clear
>  '
>  
> +test_expect_success 'rerere with inner conflict markers' '
> +	git reset --hard &&
> +
> +	git checkout -b A master &&
> +	echo "bar" >test &&
> +	git add test &&
> +	git commit -q -m two &&
> +	echo "baz" >test &&
> +	git add test &&
> +	git commit -q -m three &&
> +
> +	git reset --hard &&
> +	git checkout -b B master &&
> +	echo "foo" >test &&
> +	git add test &&
> +	git commit -q -a -m one &&
> +
> +	test_must_fail git merge A~ &&
> +	git add test &&
> +	git commit -q -m "will solve conflicts later" &&
> +	test_must_fail git merge A &&
> +
> +	echo "resolved" >test &&
> +	git add test &&
> +	git commit -q -m "solved conflict" &&
> +
> +	echo "resolved" >expect &&
> +
> +	git reset --hard HEAD~~ &&
> +	test_must_fail git merge A~ &&
> +	git add test &&
> +	git commit -q -m "will solve conflicts later" &&
> +	test_must_fail git merge A &&
> +	cat test >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
