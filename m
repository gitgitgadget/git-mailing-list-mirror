Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15011C433E6
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 05:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08AA64E92
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 05:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhBGFHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 00:07:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53434 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGFHe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 00:07:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A077A1F94;
        Sun,  7 Feb 2021 00:06:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i/eg1xTbWpb5AUSvr97U9pgnmsk=; b=sad8Q8
        5VyHBVJJj+xy/gnm4JsPykgpe1F57USKzbU83zo/jPrpv/azdv5IYt59cFjc7LNl
        YtHSULI+gcxu7VRF9z4kRe/1zb3vGMrMRy59AhrxEXh0bNj0J5VgMSBKlf5ynMxw
        odqRpVjYaRJyH5/QM4n+gxRPk7g2IPjIIB0bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=py9Whx6GtZMXgGG+YM4/hffyBeZBNgnc
        ccbMMx2msYKzgxe92dxzfTqkvPU0zV4WCN7b/54wVxwue0S0WS4MyOSDmHyZY7wZ
        XmCqpdXhPaYVwGilG+zqQnsBLHHh5YOT1XOVjgweEQl9gorqRzaS22yY3oi4MNv0
        GTQqHO1/TFs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41AB4A1F93;
        Sun,  7 Feb 2021 00:06:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C30A6A1F91;
        Sun,  7 Feb 2021 00:06:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 0/3] Unify trailers formatting logic for pretty.c and
 ref-filter.c
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
        <xmqqim74a6x1.fsf@gitster.c.googlers.com>
Date:   Sat, 06 Feb 2021 21:06:44 -0800
In-Reply-To: <xmqqim74a6x1.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 06 Feb 2021 19:33:14 -0800")
Message-ID: <xmqqy2g08o0r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47127178-6902-11EB-962B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>      @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:only) and %(trailers:un
>>       +	option="$2"
>>       +	expect="$3"
>>       +	test_expect_success "$title" '
>>      -+		echo $expect >expect &&
>>      ++		printf "$expect\n" >expect &&
>
> Are we sure that "$expect" would not ever have any '%' in it, to
> confuse printf?

Just to make sure we won't waste your time in useless roundtrip(s),
let me say that possible unacceptable answers are:

 - no, right now nobody passes a % in it
 - no, I do not expect anybody needs to pass a % in it
 - when somebody really needs to pass a %, they can write it as %%

The last one is the worst one, by the way.

The point of adding a test_trailer_option HELPER function is to HELP
the developers who write tests, now and in the future.  There are
some things they MUST know to use the helper successfully, like it
takes three parameters, the first one being the test title, the
second one is the string you'd give as the "--format=<format>"
option to the for-each-ref command, and the third one is the
expected output.

Forcing them to know any more than that is *not* helping them.

The shell programming language is perfectly capable of passing an
argument that happens to be a multi-line string to functions and
external commands, and the developers who are writing test knows
that already (the last argument to test_expect_success used
everywhere in the test suite, that is a multi-line code snippet, is
a good example).  When they need to write an expected output that is
two lines, they expect to be able to write things like

	test_trailer_option title format-string \
	'expected line #1
	expected line #2'

without having to worry about the need for special formatting that
is applicable *only* when passing argument to this helper.  They do
not need to know that they cannot pass backslash-en literally, and
have to say '\\n' instead, or they have to double a per-cent sign,
only when using this helper but not other helper functions.

In the message I am replying to, I used

	printf "%s\n" "$expect"

for a reason.  We expect that trailer options output are complete
lines, so it is annoying to force the caller to write the final
newline, especially if many of the callers have only one line of
expected output.  So

    test_trailer_option title format-string 'expected output'

would end up doing

	printf "%s\n" "expected output" >expect

to write a complete line, i.e. a caller does not have to say any of

    test_trailer_option title format-string 'expected output\n'

    test_trailer_option title format-string 'expected output
    '

    lf='
    '
    test_trailer_option title format-string "expected output$lf"

If we do not need to extend test_trailer_option with further
"features" (like "check output case insensitively this time" or
"allow output lines in any order"), we can make it even nicer and
easier to use for callers, by the way.

For example, with this (by the way, make sure there are SP on both
sides around "()", that's our house style):

	test_trailer_option () {
		title=$1 option=$2
		shift 2
		if test $# != 0
		then
			printf "%s\n" "$@"
		fi >expect
		test_expect_success "$title" '
			... >actual &&
			test_cmp expect actual &&
			... >actual &&
			test_cmp expect actual
		'
	}

the caller can do

	test_trailer_option 'single line output' \
		'trailers:key=Signed-off-by' \
		'Signed-off-by: A U Thor <author@example.com>'

	test_trailer_option 'expect two lines' \
		'trailers:key=Reviewed-by' \
		'Reviewed-by: A U Thor <author@example.com>' \
		'Reviewed-by: R E Viewer <reviewer@example.com>'

	test_trailer_option 'no output expected' 'trailers:key=no-such:' ''

That is, instead of "the first arg is title, the second is format
and the third is the entire expected output", the helper's manual
can say "give title and format as the first and the second argument.
Each argument after that is an expected output, one line per arg."

Another possibility is to feed the expected output from the standard
input of the helper, e.g.

	test_trailer_option () {
		title=$1 option=$2
		cat >expect
		test_expect_success "$title" '
			... >actual &&
			test_cmp expect actual &&
			... >actual &&
			test_cmp expect actual
		'
	}

And the caller can now do:

	test_trailer_option 'expect two lines' 'trailers:key=Reviewed-by' <<-\EOF
        Reviewed-by: A U Thor <author@example.com>
        Reviewed-by: R E Viewer <reviewer@example.com>
	EOF

It is a bit cumbersome when the expected output is a single line:

	test_trailer_option 'single line output' 'trailers:key=Signed-off-by' <<-\EOF
	Signed-off-by: A U Thor <author@example.com>
	EOF

but the contrast between the "two-line expected" case and this one
would be easy to see when reading the tests.  The pattern to write
"expect no output" would be quite simple, too:

	test_trailer_option 'no output expected' 'trailers:key=no-such:' </dev/null

Among the ones designed while writing this response, I would think I
like the last one, i.e. "the first arg is title, the second arg is
format, and the expected output is given from the standasd output"
probably the best.

Thanks.
