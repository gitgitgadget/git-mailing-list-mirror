Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A7AC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 21:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCUVVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 17:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCUVVu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 17:21:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EBF57D33
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 14:21:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k2so17436527pll.8
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679433708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4gq3/VXFfk1RlGpM90hB9hpj+UbLL1zTLxh5kfGz18=;
        b=da6ihvLJREE7Ic0OURI8BcmmZiSAGotVDru1kjmWZ768Pn+ai+/LUHpMAQD9vDLu+Q
         CpJSnqKMXuR1+sqWN+Fv+1MNPptP1zhr3KYcPMWRZ3ECILDvU9PYIfKGOt0HAcoNxgK3
         2R/2aY5LuU2uGxGiJ1J1/apCo8SKUq5vbYGsM64lKkorxO3nrt9HyDOeM4LqootarfnH
         pQ+hRlvvwcwiB7Fjl+8q5Lc8/uwCRZsXXiEpY8ibb7zSs41l6HQSHjLP5U1k4nBMUMM7
         jjpyXGygMpN/dTw1UHvj65EuNGPfcUDmf6TAqFQnBlaZSCqo/GuVfYcrXnykzKk68qxb
         GkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679433708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4gq3/VXFfk1RlGpM90hB9hpj+UbLL1zTLxh5kfGz18=;
        b=RB/vtsHIlD1xIyMyD20enCywPPInGwNhpUwpBhBCWzMK9pFXAP9gACgH8LbJSbEzM0
         ru2ysYHGzonO4P6I4M+3hBe24zuP1VA60AlshBcROkrGuMJw4seZFj2rIix4o5sfHg4B
         efw8MNoDGkWHn4I28WXiBN4j23yuqVrlEOa3b+qmVb8e03vC/T1WPZ+05HW0QBvVfrPc
         4WmluqqKuV8DUjP4kQSJL/MFAzG4r+wIjwYMINxx8cLuojHJHjpCsdkbKcXKdzQcKUtI
         F+ZgU+DWituvlnOWG9GQlxj4n1xBYi1Gzd7qrFgrUAB9XWeMTabV0YrrmSVaHO1GsYi0
         FCSw==
X-Gm-Message-State: AO0yUKW0eIhXysvpDYGRzlN4jAH3SBKTgEzk5fGXMxfgGnXeuhFoMLDY
        M/NMMKror/z4bchqxC6vIyFCiI4ROcv1XCKwaQ==
X-Google-Smtp-Source: AK7set81SNrgPxCTUsH1Aw1wvQo2UvhcbYaNqpa4M+NMceas5n6KUazP68pCN97fNZqhG09tDiH7gg==
X-Received: by 2002:a17:902:c946:b0:1a0:566c:aaf8 with SMTP id i6-20020a170902c94600b001a0566caaf8mr696652pla.27.1679433708254;
        Tue, 21 Mar 2023 14:21:48 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001a19cf1b37esm9175491plt.40.2023.03.21.14.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 14:21:47 -0700 (PDT)
Message-ID: <d940fe05-de86-5069-1d77-f4c7d0d368b6@github.com>
Date:   Tue, 21 Mar 2023 14:21:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v6 1/2] t1092: add tests for `git diff-files`
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230310050021.123769-1-cheskaqiqi@gmail.com>
 <20230320205241.105476-1-cheskaqiqi@gmail.com>
 <20230320205241.105476-2-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230320205241.105476-2-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Before integrating the 'git diff-files' builtin
> with the sparse index feature, add tests to
> t1092-sparse-checkout-compatibility.sh to ensure it currently works
> with sparse-checkout and will still work with sparse index
> after that integration.
> 
> When adding tests against a sparse-checkout
> definition, we test two modes: all changes are
> within the sparse-checkout cone and some changes are outside
> the sparse-checkout cone.
> 
> In order to have staged changes outside of
> the sparse-checkout cone, make a directory called 'folder1' and
> copy `a` into 'folder1/a'. 'folder1/a' is identical to `a` in the base
> commit. These make 'folder1/a' in the index, while leaving it outside of
> the sparse-checkout definition. Test 'folder1/a'being present on-disk
> without modifications, then change content inside 'folder1/a' in order
> to test 'folder1/a' being present on-disk with modifications.

The word wrapping on this message (and your other commits/cover letter) is a
bit strange. By convention, it should be consistently wrapped to 72 columns
per line. Most text editors have some way of configuring that so you don't
need to do it manually.

> 
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 42 ++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 801919009e..c1329e2f16 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2055,4 +2055,46 @@ test_expect_success 'grep sparse directory within submodules' '
>  	test_cmp actual expect
>  '
>  
> +test_expect_success 'diff-files with pathspec inside sparse definition' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	run_on_all ../edit-contents deep/a &&
> +
> +	test_all_match git diff-files &&
> +
> +	test_all_match git diff-files deep/a && 
> +
> +	# test wildcard
> +	test_all_match git diff-files deep/*
> +'
> +
> +test_expect_failure 'diff-files with pathspec outside sparse definition' '
> +	init_repos &&
> +
> +	test_sparse_match test_must_fail git diff-files folder2/a &&

Makes sense. In a sparse-checkout, folder2/a isn't in the working tree, so 
'diff-files' (which compares working tree vs. index) doesn't really apply.

> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	# Add file to the index but outside of cone for sparse-checkout cases.
> +	# Add file to the index without sparse-checkout cases to ensure all have 
> +	# same output.
> +	run_on_all mkdir folder1 &&

The test is failing because of this line. It should be 'mkdir -p folder1';
as you have it now, the command fails because 'folder1' already exists in
'full-checkout'. Alternatively, you could use 'run_on_sparse mkdir folder1',
but using '-p' seems like the less fragile approach. 

For reference, the way I figured that out was to run 't1092' as follows:

	cd t && ./t1092-sparse-checkout-compatibility.sh -xvdi --run=1,82

What the options correspond to:
* -x: print the commands called in the test (equivalent of calling 'set -x'
      in the test script).
* -v: print stdout/stderr to the console.
* -d: do not remove the "trash directory" of the test.
* -i: stop test execution once it encounters a failure.
* --run: run only the specified tests (1 is the first test - 'setup' - and
         82 is 'diff-files with pathspec outside sparse definition').

> +	run_on_all cp a folder1/a &&
> +
> +	# file present on-disk without modifications
> +	test_all_match git diff-files &&
> +	test_all_match git diff-files folder1/a &&

The strange thing is, once I fixed the 'mkdir' issue in my local copy of
these patches, these 'test_all_match diff-files' calls succeeded. It turns
out that 'git diff-files' in the 'full-checkout', like in 'sparse-checkout',
reports a difference in 'folder1/a' that doesn't actually exist. So the bug
isn't in sparse-checkout as I initially assumed [1], but rather in
diff-files itself.

At this point, I'd say the diff-files bug is out-of-scope of this sparse
index integration; in your implementation, sparse-checkout and sparse index
work the same as a full checkout, it's just that the "normal" full checkout
behavior is wrong. My recommendation would be that you keep this test as-is
and, to force the failure, add a check that 'full-checkout-out' is empty.
Then, in a "NEEDSWORK" comment on the test (like the one on 'diff with
renames and conflicts') that indicates that the 'diff-files' behavior is
wrong.

I'll try to make some time this week to look into the 'diff-files' bug.
Sorry for the back-and-forth and distraction from your sparse index
integration. Other than the 'mkdir' issue, these updated tests look great!

[1] https://lore.kernel.org/git/b537d855-edb7-4f67-de08-d651868247a5@github.com/

> +
> +	# file present on-disk with modifications
> +	run_on_all ../edit-contents folder1/a &&
> +	test_all_match git diff-files &&
> +	test_all_match git diff-files folder1/a
> +'
> +
>  test_done

