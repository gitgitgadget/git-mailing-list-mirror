Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1481E1FD09
	for <e@80x24.org>; Wed, 31 May 2017 19:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751080AbdEaTC5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 15:02:57 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:58021 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdEaTC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 15:02:57 -0400
Received: from [192.168.2.240] ([92.22.34.189])
        by smtp.talktalk.net with SMTP
        id G8tSdjy1vHGLwG8tSdGzEO; Wed, 31 May 2017 20:02:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1496257375; bh=MIMTypvEArvuDEgKx9AwaRUJW+MtTHMbBeVtXSjmxDI=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=iPcmkUefZYZWMtXxq13rtkMFMK6BWJm35+10gh0VCrOXrRco6X6Cfd2Piu5weFWr2
         npbyiLtaJCcOoblQJ1T0lqjr+wBZ2PW4Ete2yrbIIxTMT7sCKWJlc3mFYHVhatZICC
         MbdXDq+OUBa0AEyNfv107uyKaQY+bAXeqDmjifFc=
X-Originating-IP: [92.22.34.189]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=vjpdqwq13QoU7KiiDtdC/A==:117
 a=vjpdqwq13QoU7KiiDtdC/A==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=A1X0JdhQAAAA:8 a=J0bozyjmhRP38CFvKPIA:9 a=shKY6gTsdA-D4Ph0:21
 a=1z6z2SDjsy-nUKZz:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
 a=Df3jFdWbhGDLdZNm0fyq:22
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] rebase: Add tests for console output
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net>
Message-ID: <39cd140a-4ba1-f3ee-d945-bf43199d4a82@talktalk.net>
Date:   Wed, 31 May 2017 20:02:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170531104213.16944-3-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPIFMCn2ck8xE8ENCkN2/vLV9M+fjD6vTNNLY4lLvI9QEcwcJ8iRgHyvM+4b++SSWY4z58zTso1/I8sHNwEeSKdVUWLgbsvKO/otH1v8yP6W1t2GXDFq
 gBPTd565b9vScUOgR+sIREHoSvZ9My6V3eeUJX+0OPlGUVAV+V6i6s/NizwpEsqI+qa0r/jVw5NT4uFV+gvqr3ISVwSJNYOY3DA9RQQBBklGjCAuBxOCSOhH
 sd32YvLm10l6nGnuENtTzj9Y+mc0i3QpUh17Ot0MpG3DoR87X/1onsbV7Z+M7tj0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/17 11:42, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Check the console output when using --autostash and the stash applies
> cleanly is what we expect. To avoid this test depending on commit and
> stash hashes it uses sed to replace them with XXX. The sed script also
> replaces carriage returns in the output with '\r' to avoid embedded
> '^M's in the expected output files. Unfortunately this means we still
> end up with an embedded '^M' in the sed script which may not be
> preserved when sending this. The last line of the sed script should be
> +s/^M/\\r/g

Thinking about this it might be better to create the sed script with 
printf when running the test

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>   t/t3420-rebase-autostash.sh          | 10 +++++++++-
>   t/t3420/expected-success-am          |  6 ++++++
>   t/t3420/expected-success-interactive |  4 ++++
>   t/t3420/expected-success-merge       | 30 ++++++++++++++++++++++++++++++
>   t/t3420/remove-ids.sed               |  6 ++++++
>   5 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index ab8a63e8d6dc643b28eb0c74ba3f032b7532226f..886be63c6d13e1ac4197a1b185659fb3d7d7eb26 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -53,12 +53,20 @@ testrebase() {
>   		git checkout -b rebased-feature-branch feature-branch &&
>   		test_when_finished git branch -D rebased-feature-branch &&
>   		echo dirty >>file3 &&
> -		git rebase$type unrelated-onto-branch &&
> +		git rebase$type unrelated-onto-branch >tmp 2>&1 &&
>   		grep unrelated file4 &&
>   		grep dirty file3 &&
>   		git checkout feature-branch
>   	'
>   
> +	test_expect_success "rebase$type --autostash: check output" '
> +		suffix=${type#\ -} && suffix=${suffix:--am} &&
> +		sed -f $TEST_DIRECTORY/t3420/remove-ids.sed tmp \
> +			>actual-success$suffix &&
> +		test_cmp $TEST_DIRECTORY/t3420/expected-success$suffix \
> +			actual-success$suffix
> +	'
> +
>   	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
>   		test_config rebase.autostash true &&
>   		git reset --hard &&
> diff --git a/t/t3420/expected-success-am b/t/t3420/expected-success-am
> new file mode 100644
> index 0000000000000000000000000000000000000000..c18ded04f703ed2aa83d5e62589a908d0a44cf7e
> --- /dev/null
> +++ b/t/t3420/expected-success-am
> @@ -0,0 +1,6 @@
> +Created autostash: XXX
> +HEAD is now at XXX third commit
> +First, rewinding head to replay your work on top of it...
> +Applying: second commit
> +Applying: third commit
> +Applied autostash.
> diff --git a/t/t3420/expected-success-interactive b/t/t3420/expected-success-interactive
> new file mode 100644
> index 0000000000000000000000000000000000000000..b31f71c95ddc9c18ce9956c1aadf53cedd966801
> --- /dev/null
> +++ b/t/t3420/expected-success-interactive
> @@ -0,0 +1,4 @@
> +Created autostash: XXX
> +HEAD is now at XXX third commit
> +Rebasing (1/2)\rRebasing (2/2)\rSuccessfully rebased and updated refs/heads/rebased-feature-branch.
> +Applied autostash.
> diff --git a/t/t3420/expected-success-merge b/t/t3420/expected-success-merge
> new file mode 100644
> index 0000000000000000000000000000000000000000..66386f7cb5242a255d9cc64aad741e651ec7ec1e
> --- /dev/null
> +++ b/t/t3420/expected-success-merge
> @@ -0,0 +1,30 @@
> +Created autostash: XXX
> +HEAD is now at XXX third commit
> +First, rewinding head to replay your work on top of it...
> +Merging unrelated-onto-branch with HEAD~1
> +Merging:
> +XXX unrelated commit
> +XXX second commit
> +found 1 common ancestor:
> +XXX initial commit
> +[detached HEAD XXX] second commit
> + Author: A U Thor <author@example.com>
> + Date: Thu Apr 7 15:14:13 2005 -0700
> + 2 files changed, 2 insertions(+)
> + create mode 100644 file1
> + create mode 100644 file2
> +Committed: 0001 second commit
> +Merging unrelated-onto-branch with HEAD~0
> +Merging:
> +XXX second commit
> +XXX third commit
> +found 1 common ancestor:
> +XXX second commit
> +[detached HEAD XXX] third commit
> + Author: A U Thor <author@example.com>
> + Date: Thu Apr 7 15:15:13 2005 -0700
> + 1 file changed, 1 insertion(+)
> + create mode 100644 file3
> +Committed: 0002 third commit
> +All done.
> +Applied autostash.
> diff --git a/t/t3420/remove-ids.sed b/t/t3420/remove-ids.sed
> new file mode 100644
> index 0000000000000000000000000000000000000000..9e9048b02bd04d287461543d85db0bb715b89f8c
> --- /dev/null
> +++ b/t/t3420/remove-ids.sed
> @@ -0,0 +1,6 @@
> +s/^\(Created autostash: \)[0-9a-f]\{6,\}$/\1XXX/
> +s/^\(HEAD is now at \)[0-9a-f]\{6,\}\( .* commit\)$/\1XXX\2/
> +s/^[0-9a-f]\{6,\}\( .* commit\)$/XXX\1/
> +s/\(detached HEAD \)[0-9a-f]\{6,\}/\1XXX/
> +s/\(could not apply \)[0-9a-f]\{6,\}/\1XXX/g
> +s//\\r/g
> 

