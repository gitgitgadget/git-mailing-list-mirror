Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590BEC433E9
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 19:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C21664DCF
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 19:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBOTZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 14:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhBOTZg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 14:25:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42761C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 11:24:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v9so5123094edw.8
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 11:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=z5d/BzSObW3TNxyNFfHu6QLKEQoDm3Zfau++PxyjGcc=;
        b=ftSzfUNhQA1BdmQMJHobDsLKfM05zoNy9t9Vsb+TBRMotKA882GvSaGsXWTTf0BFjD
         53VagUDbmyb1RItr2Npx/QShmlUoW540MDD1rNT0l8RTiNJiKc/49qLKKY4fg1PZs7bD
         0PwJH6A/8e7HmIKGT3/FTDgb6OAyMtHrWhrldJVgQYVepJeYx+s6hIAPSdUvZE57As07
         20KU0bgpcIbDXCEv2ezvrIn4tbY2e9OEXn6s/rfuAK3eJ4+wWMPlDDlsLnembZ/V22Np
         YHkWs5USFC0cvmpwf3wSNnCJdAxjIG68rINhuuLeEDiysqDnLJp5fj2gc7efK8H98wgr
         Q9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=z5d/BzSObW3TNxyNFfHu6QLKEQoDm3Zfau++PxyjGcc=;
        b=EFAXKJymXmB5Qj1G6wdISDChCCdQ5gSwtmu9eG1M1qWJa/El1vw5YPNLIM/cLlCDg3
         UzARSiNY2HQRNzmLD9+iRQiJZuYI48KbZBWmwhVjd6vkMiev/Lz/tqWRUjYbL7co/dAC
         34z5vbSN2GXXFzR902LmxzmnsEYzFvtQeLVDBFBA/ISlJ4VY6CaMUjrB4t5pypLR2N6g
         DhZlyg1nVoi9zBwI0C3eL80X0b+58j1MbzwriTzOlRasvNVulfKAkUkKrrNKfK7X2cyZ
         lWDfAL+gQHkwcAAjf0byhMnQwaCZLGXHBdGrKR4VcA3HVLsdpcpBiaKG96mCxck1rnDH
         rBzw==
X-Gm-Message-State: AOAM5311/xTvGE+UeyptJXGagZkKk8JjAZbe+/Yesy+AgZ9gwxvKdcOv
        KE7+3aZXKZ/vOoWGmcNmcyyHCA3kyrCz9Q==
X-Google-Smtp-Source: ABdhPJy9dWNQg/zyBsFSVyx5mPt6lwTmgX+E85T1QoqV9/RcmjIRmpI5CaCEbj6yLDaLAWMz3SDU+w==
X-Received: by 2002:a50:c00b:: with SMTP id r11mr7304984edb.35.1613417094871;
        Mon, 15 Feb 2021 11:24:54 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id f20sm11155687edd.47.2021.02.15.11.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:24:54 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diff: do not display hunk context under -W
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210215155020.2804-2-avarab@gmail.com>
 <d02c99b8-ae26-9804-480c-eae880f4a6cb@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <d02c99b8-ae26-9804-480c-eae880f4a6cb@web.de>
Date:   Mon, 15 Feb 2021 20:24:53 +0100
Message-ID: <87im6tb0ca.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 15 2021, Ren=C3=A9 Scharfe. wrote:

> Am 15.02.21 um 16:50 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Fix what I believe to be a long-standing bug in how "-W" interacts
>> with displaying the hunk context on the @@ line: It should not be
>> displayed at all under -W.
>>
>> The long-standing semantics of how -W works and interacts with -U<n>
>> are rather easy to reason about:
>>
>>  * -W extends the context line up to the start of the function. With
>>     userdiff this means the language-aware regex rules in userdiff.c,
>>     or user-supplied rules.
>>
>>  * -U<n>, which defaults to -U3 shows at least <n> lines of context,
>>     if that's greater than what we'd extend the context to under -W
>>     then -U<n> wins.
>>
>>  * When showing the hunk context we look up from the first line we
>>    show of the diff, and find whatever looks like useful context above
>>    that line.
>>
>> Thus in e.g. the xdiff/xemit.c change being made in this commit we'll
>> correctly show "xdl_emit_diff()" in the hunk context under default
>> diff settings.
>>
>> But if we viewed it with the -W option we'd show "is_empty_rec()",
>> because we'd first find the "xdl_emit_diff()" context line, extend the
>> diff to that, and then would go look for context to show again.
>>
>> I don't think this behavior makes any sense, our context in this case
>> is what we're guaranteed to show as part of the diff itself.
>>
>> The user already asked us to find that context line and show it, we
>> don't need to then start showing the context above that line, which
>> they didn't ask for.
>
> Hmm, that's subtle.
>
> Your reasoning applies to patches generated without -W as well.  If the
> precontext contains a function line then the @@ line should not contain
> a function comment.  However, e.g. with this:
>
> -- snip --
> cat >a <<EOF
> func a
>
> func b
> 1
> 2
> 3
> EOF
> sed 's/3/three/' <a >b
> diff -up a b
> -- snap --
>
> ... I get this:
>
> --- a	2021-02-15 18:30:21.000000000 +0100
> +++ b	2021-02-15 18:30:21.000000000 +0100
> @@ -3,4 +3,4 @@ func a
>  func b
>  1
>  2
> -3
> +three
>
> So diff(1) shows the previous function line.  git diff does the same.
>
> The behaviour of diff(1) and git diff does make sense to me: It's easy
> to implement and the only downside is that it produces extra output in
> some cases.
>
> I can understand that users would rather have a tidy diff without
> distractions, though.  So I like the output change you propose.

Does GNU diff have something like git's -W, both "diff -U 0 -F func a b"
and "diff -U 0 -p a b" don't extend the context window as we do.

I don't think the patch I'm submitting here would make sense for GNU
diff, since there it just shows the context without being guaranteed to
show the full set of lines leading up to it under -W, but with Git diff
we do that, so I think it makes sense to omit the context.

> However, I'm not sure it would be a good idea to clear @@ lines of hunks
> generated without -W that have function lines in their precontext, even
> though it would be a logical thing to do.

Yes, I don't think that's a good idea either. I think it only makes
sense under -W where the user explicitly asks "show me the function this
change was in", and we're (before this patch) showing different context
on the basis of emergent behavior.

>> This new behavior does give us the edge case that if we e.g. view the
>> diff here with "-U150 -W" we'd previously extend the context to the
>> middle of the "is_func_rec()" function, and show that function in the
>> hunk context. Now we'll show nothing.
>
> Well, the 150 lines of context are still shown (as they should be), but
> the @@ line contains no function name anymore.

Yes, indeed. I'll reword that to "now we'll show no context in that
case" or something...

>> I think that change also makes sense. We're showing a change in the
>> "xdl_emit_diff()" function. That's our context for the change. It
>> doesn't make sense with -W to start fishing around for other
>> context.
>
> It does make sense in the context of the diff(1) -p implementation, but
> your change is consistent with the description of that option: "Show
> which C function each change is in."

I hadn't spotted that, we just said:

    Show whole function as context lines for each change. The function
    names are determined in the same way as git diff works out patch
    hunk headers

Which I think can more obviously be read as the existing behavior being
desired, and this patch being a change to documented behavior.

(I think it is, I just think it makes sense to change the docs &
behavior int this case)

>> Arguably in that case we could save away the context we found in the
>> "XDL_EMIT_FUNCCONTEXT" in "xdl_emit_diff()" and show that if we end up
>> extending the diff past the function, either because of a high -U<n>
>> value, or because our change was right at the start.
>>
>> I wouldn't really mind if we did that, perhaps it would be a useful
>> marker with high -U<n> values to remind the user of what they're
>> looking at, but I also don't see the usefulness in practice, so let's
>> punt that for now.
>
> It could be confusing for someone who expects the old behaviour, leaving
> it empty makes more sense to me.

FWIW it would be useful for:

    git log -U1000 -W

And then searching for "@@" in the pager to find changes to specific
functions.

>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  Documentation/diff-options.txt | 4 ++++
>>  t/t4015-diff-whitespace.sh     | 2 +-
>>  t/t4018-diff-funcname.sh       | 7 +++++++
>>  xdiff/xemit.c                  | 4 +++-
>>  4 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options=
.txt
>> index e5733ccb2d..8ca59effa7 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -759,6 +759,10 @@ endif::git-format-patch[]
>>  	The function names are determined in the same way as
>>  	`git diff` works out patch hunk headers (see 'Defining a
>>  	custom hunk-header' in linkgit:gitattributes[5]).
>> ++
>> +When showing the whole function for context the "@@" context line
>> +itself will always be empty, since the context that would otherwise be
>> +shown there will be the first line of the hunk being shown.
>>
>>  ifndef::git-format-patch[]
>>  ifndef::git-log[]
>> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
>> index 8c574221b2..0ffc845cdd 100755
>> --- a/t/t4015-diff-whitespace.sh
>> +++ b/t/t4015-diff-whitespace.sh
>> @@ -2133,7 +2133,7 @@ test_expect_success 'combine --ignore-blank-lines =
with --function-context 2' '
>>  		--ignore-blank-lines --function-context a b >actual.raw &&
>>  	sed -n "/@@/,\$p" <actual.raw >actual &&
>>  	cat <<-\EOF >expect &&
>> -	@@ -5,11 +6,9 @@ c
>> +	@@ -5,11 +6,9 @@
>>  	 function
>>  	 1
>>  	 2
>> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
>> index 80f35c5e16..f3374abd98 100755
>> --- a/t/t4018-diff-funcname.sh
>> +++ b/t/t4018-diff-funcname.sh
>> @@ -91,6 +91,13 @@ test_diff_funcname () {
>>  		fi
>>  	' &&
>>
>> +	test_expect_success "$desc -W" '
>> +		git diff -U0 -W "$what" >W-U0-diff &&
>> +		echo >W-U0-expected &&
>> +		last_diff_context_line W-U0-diff >W-U0-actual &&
>> +		test_cmp W-U0-expected W-U0-actual
>> +	' &&
>> +
>>  	test_expect_success "$desc (accumulated)" '
>>  		git diff -U1 "$what".acc >diff &&
>>  		last_diff_context_line diff >actual.lines &&
>> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
>> index 9d7d6c5087..02b5dbcc70 100644
>> --- a/xdiff/xemit.c
>> +++ b/xdiff/xemit.c
>> @@ -274,7 +274,9 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xd=
emitcb_t *ecb,
>>  		 */
>>
>>  		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
>> -			get_func_line(xe, xecfg, &func_line,
>> +			get_func_line(xe, xecfg,
>> +				      xecfg->flags & XDL_EMIT_FUNCCONTEXT
>> +				      ? NULL : &func_line,
>
> Why still search?  It would be better to turn off XDL_EMIT_FUNCNAMES if
> XDL_EMIT_FUNCCONTEXT is enabled -- a one-character change in diff.c.

I just didn't read the diff/xdiff code carefully enough. Will fix.

>>  				      s1 - 1, funclineprev);
>>  			funclineprev =3D s1 - 1;
>>  		}
>>

