Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4875C1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbfHZQUs (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:20:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53324 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730327AbfHZQUs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:20:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B83772F3F;
        Mon, 26 Aug 2019 12:20:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MA5wgmQdEokjMt+Tfear9qgTOqo=; b=BN2I+J
        Oza7aNdSyhoHGCtPWfAso8SvKonCWB+mTkeRaPUntRlyEfLK3PbW2frGljTuIxcR
        YCeIAEbcFNiJFOr63lx1WOYS03cYqHVaCo7rIj7mx+o5lm4Q3qP/ybEnr2tAKP5i
        QSj6lN/hRJhAwbRvn+95O4YQAOSt2apIuD4ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cy8MUxcPHKnrJqdhUK4lw3p/RDLAz0BT
        Jj40pP0vLQuFPEZFHwUcxH8U3o9U6tFOxBGq6tjMXF2HskarklYlgorZzzkrMGtt
        rtjHl7jMbKRcbsUd6vyJTEu6bRHx0Nis0RxQj2mki/mySghn2ohAxJUKzRZDzSiw
        Tss/6KCXHMo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 13AAC72F3E;
        Mon, 26 Aug 2019 12:20:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 375AE72F39;
        Mon, 26 Aug 2019 12:20:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 1/1] quote: handle null and empty strings in sq_quote_buf_pretty()
References: <pull.314.git.gitgitgadget@gmail.com>
        <pull.314.v2.git.gitgitgadget@gmail.com>
        <b9a68598d79724849995283e6967f1c52843c048.1566830682.git.gitgitgadget@gmail.com>
        <CAN+QWEZU2FqkH1jWnv==owKLsMk8XNXJh6PpF6njvB6MmKt+Dw@mail.gmail.com>
Date:   Mon, 26 Aug 2019 09:20:40 -0700
In-Reply-To: <CAN+QWEZU2FqkH1jWnv==owKLsMk8XNXJh6PpF6njvB6MmKt+Dw@mail.gmail.com>
        (Garima Singh's message of "Mon, 26 Aug 2019 11:24:45 -0400")
Message-ID: <xmqq1rx7kief.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73B5FBDC-C81D-11E9-B980-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:

>> diff --git a/quote.c b/quote.c
>> index 7f2aa6faa4..6d0f8a22a9 100644
>> --- a/quote.c
>> +++ b/quote.c
>> @@ -48,6 +48,18 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
>>         static const char ok_punct[] = "+,-./:=@_^";
>>         const char *p;
>>
>> +       /* In case of null tokens, warn the user of the BUG in their call. */
>> +       if (!src)
>> +               BUG("BUG can't append a NULL token to the buffer");

I thought that the BUG() macro already says "BUG" upfront, no?

Dereferencing to see if we have an empty string below will
immediately give us segfault, so I would omit this check if I were
writing this code, though.

>> +       /* In case of empty tokens, add a '' to ensure they
>> +        * don't get inadvertently dropped.
>> +        */

Our multi-line comments have the opening slash-asterisk and the
closing asterisk-slash on their own lines.

But more importantly, "In case of empty tokens, add a ''" in this
comment has zero information contents---you can read that from the
code.  Why we do that is what we cannot express in the code, and
deserves a comment.

	/* avoid losing a zero-length string by giving nothing */

or something like that, perhaps?

>> +       if (!*src) {
>> +               strbuf_addstr(dst, "''");
>> +               return;
>> +       }
>> +
>>         for (p = src; *p; p++) {
>>                 if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
>>                         sq_quote_buf(dst, src);
>> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
>> index a070e645d7..9c176c7cbb 100755
>> --- a/t/t0014-alias.sh
>> +++ b/t/t0014-alias.sh
>> @@ -37,4 +37,12 @@ test_expect_success 'looping aliases - internal execution' '
>>  #      test_i18ngrep "^fatal: alias loop detected: expansion of" output
>>  #'
>>
>> +test_expect_success 'run-command parses empty args properly, using sq_quote_buf_pretty' '
>> +       cat >expect <<-EOF &&
>> +       fatal: cannot change to '\''alias.foo=frotz foo '\'''\'' bar'\'': No such file or directory
>> +       EOF
>> +       test_expect_code 128 git -C "alias.foo=frotz foo '\'''\'' bar" foo 2>actual &&
>> +       test_cmp expect actual
>> +'

I think it was my mistake, but we do not ahe to use "alias" for
something like this, perhaps like:

    # 'git frotz' will fail with "no such command", but we are
    # not interested in its exit status.  We just want to see
    # how sq_quote_argv_pretty() shows arguments in the trace.
    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
    echo "git-frotz a '' b ' ' c" >expect &&
    test_cmp expect actual

>> +
>>  test_done
>> --
>> gitgitgadget
