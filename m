Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9829C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DB461185
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhD2IhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 04:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhD2IhC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 04:37:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35B5C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 01:36:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 10so3057204pfl.1
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=smWtSO6NOTRMtOyyx8Owd6CD+jzb0nK3ezPWqaRoVqw=;
        b=MGGwoOiMSqXD+3zZ6zIFQEs423QjpF1fsqOaNWq6BAxTU9NhEYDTcXS0yvY/s5mJVQ
         AjPJ8DJTt2oq15L9fCzVRVhlRdWYizHxx5k7T+vraFNoiNIBid82Uwm9GR+rbR1meRy/
         niAiR8/+q1Ef0oWnUoj0ACxxGNa8b3Zq0eovI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=smWtSO6NOTRMtOyyx8Owd6CD+jzb0nK3ezPWqaRoVqw=;
        b=uB6qZeoejb8w3+iX9XC1AknEObpNUDpjHGYez1tVzv80Xk0r1o1kCaWkCknFZIDOHP
         QSD0RQuAJ8Z5apH3oQQj25nF5AzXZ5USCE26vQ+/WXaD+0yHSNzLFpcabR7I/56kF9yH
         fo6xTl0TgTDxVlzzlfzJD8rsqSP0im4uXMNrUcNv45UYOu4l4JeIQp8j+e+4qm0yApdS
         L5rCbSFBt/URb5CT0G+x5Urr77Fn1BnrikJZdwGEYHt7LKsTqNWZCLHWNy0dSQK5/XRv
         lUymTfbxHXAGnAJYjbNunxq0jay6Zt9nhn/V1pOCwzN9MrxzM7SVq14NbQOdhcOrwXcK
         0kVA==
X-Gm-Message-State: AOAM533fM3ZS4cBFT0/IkP/pyPRtoxFCt5jkABbApYhTfzePAAoX63la
        YnubOB6MNbXfHJKPYp6Oa7owo/9ZIJX1bA==
X-Google-Smtp-Source: ABdhPJxvFzuI/028dSGCPuKj8seXWwWg0L52W0htObbq0L3XpoDKcjCSIg4aGJow0yjIgvmAkKYBSA==
X-Received: by 2002:aa7:84d0:0:b029:27d:fff:40c9 with SMTP id x16-20020aa784d00000b029027d0fff40c9mr7136940pfn.7.1619685375390;
        Thu, 29 Apr 2021 01:36:15 -0700 (PDT)
Received: from [192.168.245.142] (cpc108961-cmbg20-2-0-cust748.5-4.cable.virginm.net. [80.5.130.237])
        by smtp.gmail.com with ESMTPSA id n203sm1819040pfd.31.2021.04.29.01.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 01:36:14 -0700 (PDT)
Subject: Re: [PATCH v6] Add git-p4.fallbackEncoding
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pete Wyckoff <pw@padd.com>, Anders Bakken <abakken@netflix.com>
References: <20210428145824.43c4t7hkjfqjyspb@tb-raspi4>
 <20210429073905.837-1-tzadik.vanderhoof@gmail.com>
Cc:     Andrew Oakley <andrew@adoakley.name>
From:   Luke Diamand <luke@diamand.org>
Message-ID: <179cd4f0-def6-1b3a-2802-139b19d3301d@diamand.org>
Date:   Thu, 29 Apr 2021 08:36:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429073905.837-1-tzadik.vanderhoof@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/04/2021 07:39, Tzadik Vanderhoof wrote:
> Add git-p4.fallbackEncoding config variable, to prevent git-p4 from
> crashing on non UTF-8 changeset descriptions.
> 
> When git-p4 reads the output from a p4 command, it assumes it will
> be 100% UTF-8. If even one character in the output of one p4 command is
> not UTF-8, git-p4 crashes with:
> 
>      File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
>          value = value.decode() UnicodeDecodeError: 'utf-8' codec can't
>          decode byte Ox93 in position 42: invalid start byte
> 
> This is especially a problem for the "git p4 clone ... @all" command,
> where git-p4 needs to read thousands of changeset descriptions, one of
> which may have a stray smart quote, causing the whole clone operation
> to fail.
> 
> Add a new config setting, allowing git-p4 to try a fallback encoding
> (for example, "cp1252") and/or use the Unicode replacement character,
> to prevent the whole program from crashing on such a minor problem.

I think Andrew Oakley pointed this out earlier - but in the days of 
Python2 this was (I think) never a problem. Python2 just took in the 
binary data, in whatever encoding, and passed it untouched on to git, 
which in turn just stored it.

https://lore.kernel.org/git/20210412085251.51475-1-andrew@adoakley.name/

It was only whatever was trying to render the bytestream that needed to 
worry about the encoding.

Now we're making the decision in git-p4 when we ingest it - did we 
consider just passing it along untouched?

The problem at hand is that git-p4 is trying to store it internally as a 
`string' which now is unicode-aware, when perhaps it should not be.

It's going to get very confusing if anyone ingests something from 
Perforce having set the encoding to one thing, and it turns out to be a 
different encoding, or worse, multiple encodings for the same repo.

I also worry that if someone has connected to a Unicode-aware Perforce 
server, and then unwittingly set P4CHARSET, then are we going to end up 
silently scrambling everything?

I'm not sure, encodings make my head hurt.

Luke



> 
> Signed-off-by: Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
> ---
>   Documentation/git-p4.txt                   |  9 ++
>   git-p4.py                                  | 11 ++-
>   t/t9836-git-p4-config-fallback-encoding.sh | 98 ++++++++++++++++++++++
>   3 files changed, 117 insertions(+), 1 deletion(-)
>   create mode 100755 t/t9836-git-p4-config-fallback-encoding.sh
> 
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index f89e68b424..86d3ffa644 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -638,6 +638,15 @@ git-p4.pathEncoding::
>   	to transcode the paths to UTF-8. As an example, Perforce on Windows
>   	often uses "cp1252" to encode path names.
>   
> +git-p4.fallbackEncoding::
> +	Perforce changeset descriptions can be stored in any encoding.
> +	Git-p4 first tries to interpret each description as UTF-8. If that
> +	fails, this config allows another encoding to be tried. You can specify,
> +	for example, "cp1252". If git-p4.fallbackEncoding is "replace", UTF-8 will
> +	be used, with invalid UTF-8 characters replaced by the Unicode replacement
> +	character. The default is "none": there is no fallback, and any non UTF-8
> +	character will cause git-p4 to immediately fail.
> +
>   git-p4.largeFileSystem::
>   	Specify the system that is used for large (binary) files. Please note
>   	that large file systems do not support the 'git p4 submit' command.
> diff --git a/git-p4.py b/git-p4.py
> index 09c9e93ac4..202fb01bdf 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -771,7 +771,16 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
>                   for key, value in entry.items():
>                       key = key.decode()
>                       if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
> -                        value = value.decode()
> +                        try:
> +                            value = value.decode()
> +                        except UnicodeDecodeError:
> +                            fallbackEncoding = gitConfig("git-p4.fallbackEncoding").lower() or 'none'
> +                            if fallbackEncoding == 'none':
> +                                raise Exception("UTF-8 decoding failed. Consider using git config git-p4.fallbackEncoding")
> +                            elif fallbackEncoding == 'replace':
> +                                value = value.decode(errors='replace')
> +                            else:
> +                                value = value.decode(encoding=fallbackEncoding)
>                       decoded_entry[key] = value
>                   # Parse out data if it's an error response
>                   if decoded_entry.get('code') == 'error' and 'data' in decoded_entry:
> diff --git a/t/t9836-git-p4-config-fallback-encoding.sh b/t/t9836-git-p4-config-fallback-encoding.sh
> new file mode 100755
> index 0000000000..901bb3759d
> --- /dev/null
> +++ b/t/t9836-git-p4-config-fallback-encoding.sh
> @@ -0,0 +1,98 @@
> +#!/bin/sh
> +
> +test_description='test git-p4.fallbackEncoding config'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'add Unicode description' '
> +	cd "$cli" &&
> +	echo file1 >file1 &&
> +	p4 add file1 &&
> +	p4 submit -d documentación
> +'
> +
> +# Unicode descriptions cause "git p4 clone" to crash with a UnicodeDecodeError in some
> +# environments. This test determines if that is the case in our environment. If so,
> +# we create a file called "clone_fails". In subsequent tests, we check whether that
> +# file exists to determine what behavior to expect.
> +
> +clone_fails="$TRASH_DIRECTORY/clone_fails"
> +
> +# If clone fails with git-p4.fallbackEncoding set to "none", create the "clone_fails" file,
> +# and make sure the error message is correct
> +
> +test_expect_success 'clone with git-p4.fallbackEncoding set to "none"' '
> +	git config --global git-p4.fallbackEncoding none &&
> +	test_when_finished cleanup_git && {
> +		git p4 clone --dest="$git" //depot@all 2>error || (
> +			>"$clone_fails" &&
> +			grep "UTF-8 decoding failed. Consider using git config git-p4.fallbackEncoding" error
> +		)
> +	}
> +'
> +
> +# If clone fails with git-p4.fallbackEncoding set to "none", it should also fail when it's unset,
> +# also with the correct error message.  Otherwise the clone should succeed.
> +
> +test_expect_success 'clone with git-p4.fallbackEncoding unset' '
> +	git config --global --unset git-p4.fallbackEncoding &&
> +	test_when_finished cleanup_git && {
> +		(
> +			test -f "$clone_fails" &&
> +			test_must_fail git p4 clone --dest="$git" //depot@all 2>error &&
> +			grep "UTF-8 decoding failed. Consider using git config git-p4.fallbackEncoding" error
> +		) ||
> +		(
> +			! test -f "$clone_fails" &&
> +			git p4 clone --dest="$git" //depot@all 2>error
> +		)
> +	}
> +'
> +
> +# Whether or not "clone_fails" exists, setting git-p4.fallbackEncoding
> +# to "cp1252" should cause clone to succeed and get the right description
> +
> +test_expect_success 'clone with git-p4.fallbackEncoding set to "cp1252"' '
> +	git config --global git-p4.fallbackEncoding cp1252 &&
> +	test_when_finished cleanup_git &&
> +	(
> +		git p4 clone --dest="$git" //depot@all &&
> +		cd "$git" &&
> +		git log --oneline >log &&
> +		desc=$(head -1 log | cut -d" " -f2) &&
> +		test "$desc" = "documentación"
> +	)
> +'
> +
> +# Setting git-p4.fallbackEncoding to "replace" should always cause clone to succeed.
> +# If "clone_fails" exists, the description should contain the Unicode replacement
> +# character, otherwise the description should be correct (since we're on a system that
> +# doesn't have the Unicode issue)
> +
> +test_expect_success 'clone with git-p4.fallbackEncoding set to "replace"' '
> +	git config --global git-p4.fallbackEncoding replace &&
> +	test_when_finished cleanup_git &&
> +	(
> +		git p4 clone --dest="$git" //depot@all &&
> +		cd "$git" &&
> +		git log --oneline >log &&
> +		desc=$(head -1 log | cut -d" " -f2) &&
> +		{
> +			(test -f "$clone_fails" &&
> +				test "$desc" = "documentaci�n"
> +			) ||
> +			(! test -f "$clone_fails" &&
> +				test "$desc" = "documentación"
> +			)
> +		}
> +	)
> +'
> +
> +test_done
> 
