Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E284C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 09:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3077861003
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 09:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhFUJK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 05:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUJK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 05:10:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B5CC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 02:08:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w13so3331491wmc.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 02:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L5etHSBGoGFNSEQnJy3zk7MRVSuj6BOD2TtZj/fLcAk=;
        b=nSInhzWMFtn8SKIuYFgoeL9lT+fu7EddxyBCiId49QnGbxkpnthX9ayzOZ8BLRwmKQ
         mUW+o/i8INWMlUKqD1NNVZ2GtoEUuBbyTx0hcNNxLLNzdwTXcRnYwpwkJpE6pyrm4i8K
         AY6jZuDHf7z/vmvqDpCNQdBKyBKMn0MKjV7YNTSlUv+v5oTms/fwuoZyDCh70OXDTKRl
         UJaUyxaISOFGAThDAI+66tOpNXz2d7ZuK40eOnwHpYpv9lcOgwX5oJ7C9mgzaYU/Zzz0
         pdQvS/Oxa0JgYMoSUd/VsljYKYpqTnIf/n4BEtN2nnKsJO73nkGjzzoQOmE5TNIlD3jq
         WlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L5etHSBGoGFNSEQnJy3zk7MRVSuj6BOD2TtZj/fLcAk=;
        b=LkIoIcp0ExOtg5nLNrYsNPRGiWC9xT47jKiRW1wrF5Auk6i5cvf9uxNkHZeAxz1B/o
         zLnVdB1OsVDojFHuK8Lhtwz2IV982lzs3gjf1WG7nteNyiv6Vs1sOjcW8ZpbkFg9hZtD
         WEgjdNy0zxm3Ola6788qwFrWDmZKB/ivav9o5sCX3UYJZx5gBnO0i94tprCPOjgOsyeV
         naidT6fg0Tst57W7VHr2UZ7o88RiPiOSVi8vT3Vv8sCwI/vDTb/vLSUfVBExLXdEBlHm
         vAOtq3kEhVbcACGUuyNnHCj/mgyF93Wf/YrgolCQoSIWudL0K5SfXbkJoVsalJflGiD/
         KMYA==
X-Gm-Message-State: AOAM531+iXr4I7O785P8eu7kmIP2L58YrVYpC1suJAvarshxAcXCq9ik
        aKwC/Af0MSeJig1m7OAWZJg=
X-Google-Smtp-Source: ABdhPJxKdYTFTR9R3rshHGC9SKBbAqvxIXiD0WkyL/hy0MstVqzKwjbyMcAK5refQ17tOYvStQ805Q==
X-Received: by 2002:a7b:c253:: with SMTP id b19mr127913wmj.172.1624266491164;
        Mon, 21 Jun 2021 02:08:11 -0700 (PDT)
Received: from [10.36.18.2] ([46.246.3.216])
        by smtp.gmail.com with ESMTPSA id o203sm1422577wmo.36.2021.06.21.02.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 02:08:09 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] test-lib-functions: introduce test_line_count_cmd
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
 <20210619013035.26313-2-congdanhqx@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <54bf7756-5578-4fe4-dbe5-f63b368c4d63@gmail.com>
Date:   Mon, 21 Jun 2021 11:08:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210619013035.26313-2-congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/06/2021 03:30, Đoàn Trần Công Danh wrote:
> In the Git project, we have multiple instances that requires

s/requires/require/

> checking number of lines of text in the stdout of a command.
> One of such examples is t6400, that checks number of files
> in various states.
> 
> Some of those commands are Git command, and we would like to check
> their exit status.  In some of those checks, we pipe the stdout of
> those commands to "wc -l" to count the number lines, thus losing
> the exit status.
> 
> Introduce a helper function to check for the number of lines in stdout
> from those commands.
> 
> This helper will create a temporary file in the process, thus it may
> affect the output of some checks.
> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>   t/test-lib-functions.sh | 80 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 80 insertions(+)
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index f0448daa74..e055a4f808 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -845,6 +845,86 @@ test_line_count () {
>   	fi
>   }
>   
> +# test_line_count_cmd checks the exit status, and the number of lines in
> +# the captured stdout of a command.
> +#
> +# SYNOPSIS:
> +#
> +#	test_line_count_cmd <binop> <value> [!] cmd [args...]
> +#
> +# Expect succeed exit status when running
> +#
> +#	cmd [args...]
> +#
> +# then, run sh's "test <# of lines in stdout> <binop> <value>"
> +#
> +# OPTIONS:
> +# !:
> +#	Instead of expecting "cmd [args...]" succeed, expect its failure.
> +#	Note, if the command under testing is "git",
> +#	test_must_fail should be used instead of "!".
> +#
> +# EXAMPLE:
> +#	test_line_count_cmd -ge 10 git tag --no-contains v1.0.0
> +#	test_line_count_cmd -le 10 ! grep some-text a-file
> +#	test_line_count_cmd = 0 test_must_fail git rev-parse --verify abcd1234
> +#
> +# NOTE:
> +# * a temporary file named test_line_count_cmd_.out will be created under
> +# $TRASH_DIRECTORY/.git/trash iff $TRASH_DIRECTORY/.git/ exists.
> +# Otherwise, created in $TRASH_DIRECTORY. This temporary file will be
> +# cleaned by test_when_finished
> +test_line_count_cmd () {
> +	{
> +		local outop outval outfile
> +		local expect_failure actual_failure
> +		local trashdir="$TRASH_DIRECTORY"
> +
> +		if test -d "$TRASH_DIRECTORY/.git"
> +		then
> +			trashdir="$TRASH_DIRECTORY/.git/trash" &&
> +			mkdir -p "$trashdir"
> +		fi &&
> +		if test $# -lt 3
> +		then
> +			BUG "missing <binary-ops> and <value>"

Nit: s/binary-ops/binop/ for consistency with documentation comment
above.  Also, technically the invocation of test_line_count_cmd could be
missing any of its required three parameters, including "cmd".  How
about something similar to the call to BUG in test_i18ngrep:

	BUG "too few parameters to test_line_count_cmd"

?

> +		fi &&
> +		outop="$1" &&
> +		outval="$2" &&
> +		shift 2 &&
> +		outfile="$trashdir/test_line_count_cmd_.out" &&
> +		if test "x$1" = "x!"
> +		then
> +			shift &&
> +			expect_failure=yes
> +		fi &&
> +		if test $# = 0
> +		then
> +			BUG "test_line_count_cmd: no command to be run"
> +		else
> +			test_when_finished "rm -f '$outfile'" &&
> +			exec 8>"$outfile"
> +			# We need to redirect stderr to &9,
> +			# and redirect this function's 9>&2
> +			# in order to not messed with -x
> +			if ! "$@" >&8 2>&9
> +			then
> +				actual_failure=yes
> +			fi
> +		fi 8>&1 &&
> +		case "$expect_failure,$actual_failure" in
> +		yes,)
> +			echo >&4 "error: '$@' succeed!" &&

It seems that function error() could be used here and below instead of
"echo >&4".

s/succeed/succeeded/ --- it might be worth borrowing wording from
test_must_fail().  Something like:

	error "test_line_count_cmd: command succeeded: '$@'"

> +			return 1
> +			;;
> +		,yes)
> +			echo >&4 "error: '$@' run into failure!" &&
> +			return 1
> +		esac &&

Missing ";;" in the last branch of `case`.

> +		test_line_count "$outop" "$outval" "$outfile" >&4
> +	} 9>&2 2>&4
> +}
> +
>   test_file_size () {
>   	test "$#" -ne 1 && BUG "1 param"
>   	test-tool path-utils file-size "$1"
> 

