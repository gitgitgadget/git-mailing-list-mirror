Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EE2C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 18:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCJSYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCJSYO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 13:24:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F0C233DD
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 10:23:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so10786038pjh.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 10:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678472633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xuhRpueX+lpKlYCsi/w9ikm0I7i3pvp9PVU7GzqZI70=;
        b=c5tdMsOjihQ0eaDhf9s/Zz4HValNOv+U0lx6wi1RlniyCKDKzDdf5gglwBCTz4ZMeU
         odqyGwZsF2WOceX8jsS6XFhmM+0L4AcUaSJhh4HUUWztwYh7K9ZQf0CJGcIGiNaCe8Hc
         LstBZElT+qjoae9eibJOJlt/zYRdAg0f61jcGkfKM3DLPvv/trLqsKRmBXLk+W1Hh79i
         VqYFpP05ayAXKRX+DVE8ttTb/h8KB2bk27yPfdM74CQTR9CGPUEMlTua+zqNP7k+hVm0
         oeAlPBfrXchCcq+hKsxI3Ll3Fk4tEMbyo8WVfrVkz6LrjIZxd2vlvAI/FYKvjY2XAoKR
         GQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678472633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuhRpueX+lpKlYCsi/w9ikm0I7i3pvp9PVU7GzqZI70=;
        b=kUpjtURxBfI7aY5lxmtkU9cS8gw4T9ZVowVdWsvuaLloYN5i3j8Jj8DDZk2LjlgzGN
         avtLjivmoEDZasvx/PO1ah1je67tUl339gnc3Z7Mg/9IxZTdLPTxzkLjN+zNVmBhf5oG
         eFKTReLpq8moqqdxwNhaWXQ/+c3w4Nkx+3V6/E5J7/DCNPj4vbsn95OJNh6UUw/Wt3G1
         fslGLoWvVjVwqEuFyg/HscBLCUt/JG5jle9dk3eNXUuoiTh/p8tT0QaSzguM39AXHtdx
         /mykI8irB+OPuaTglbNV7NjAsIN04DmUaiTPtGIP6PpUAz2OVlQW1DExn/QDvHoHt4zG
         kgBQ==
X-Gm-Message-State: AO0yUKVhtAHgoj+BhgKCP7EJFpReLarKADnoqFZRd7Hshl0uenm2WTeO
        BNr8yLzfgHRykMqT15Xd5S0X
X-Google-Smtp-Source: AK7set8Y6fpM6N/nbjyeHlPHNLmkB7XbCXmw6D+EkCtEbIRck/UVdekUvzXR/D7FcohdABUX/o8RiQ==
X-Received: by 2002:a17:902:8643:b0:19c:f80c:df90 with SMTP id y3-20020a170902864300b0019cf80cdf90mr24434556plt.45.1678472632885;
        Fri, 10 Mar 2023 10:23:52 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id kr5-20020a170903080500b0019f1027f88bsm261826plb.307.2023.03.10.10.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 10:23:52 -0800 (PST)
Message-ID: <b537d855-edb7-4f67-de08-d651868247a5@github.com>
Date:   Fri, 10 Mar 2023 10:23:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v5 1/2] t1092: add tests for `git diff-files`
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230309063952.42362-1-cheskaqiqi@gmail.com>
 <20230310050021.123769-1-cheskaqiqi@gmail.com>
 <20230310050021.123769-2-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230310050021.123769-2-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:

Hi Shuqi! 

Apologies for taking so long to review; thanks for working on this.

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
> the sparse-checkout cone, create a 'newdirectory/testfile' and
> add it to the index, while leaving it outside of
> the sparse-checkout definition.Test 'newdirectory/testfile'

nit: missing space after "definition."

> being present on-disk without modifications, then change content inside
> 'newdirectory/testfile' in order to test 'newdirectory/testfile'
> being present on-disk with modifications.

Generally, you don't need to create a new file to get to this state, and I'd
personally advise against it. Personally, I find that adding a new file can
make the test more cumbersome than is necessary. I'll see if I can suggest
an alternative later on.

> 
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 48 ++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 801919009e..9b71d7f5f9 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2055,4 +2055,52 @@ test_expect_success 'grep sparse directory within submodules' '
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
> +	test_all_match git diff-files deep/a 
> +

I'd be interested in seeing an additional test case for a pathspec with
wildcards or other "magic" [1], e.g. 'git diff-files "deep/*"'. In past
sparse index integrations, there has occasionally been a need for special
handling of those types of pathspecs [2][3], so it would be good for the
test to cover cases like that.

Otherwise, this test looks good.

[1] https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefpathspecapathspec
[2] https://lore.kernel.org/git/822d7344587f698e73abba1ca726c3a905f7b403.1638201164.git.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/20220807041335.1790658-3-shaoxuan.yuan02@gmail.com/

> +'
> +
> +test_expect_success 'diff-files with pathspec outside sparse definition' '
> +	init_repos &&

Before messing with modified files on disk, it'd be nice to show a
"baseline" of correct behavior when a pathspec points to out-of-cone files,
e.g. 'test_all_match git diff-files folder2/a'.

> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	# add file to the index but outside of cone
> +	run_on_sparse mkdir newdirectory &&
> +	run_on_sparse ../edit-contents newdirectory/testfile &&
> +	test_sparse_match git add --sparse newdirectory/testfile &&
> +
> +	# file present on-disk without modifications

From the comment you've added here, it looks like the state you want to test
is "file outside sparse checkout definition exists on disk". However, since
one of the goals of this test is to verify sparse index behavior once its
integrated with the 'diff-files' command, whether the "outside of sparse-
checkout definition" file belongs to a sparse directory entry is an
important (and fairly nuanced) factor to consider.

The main difference between a "regular" sparse-checkout and a sparse
index-enabled sparse-checkout is the existence of "sparse directory"
entries: index entries with 'SKIP_WORKTREE' that represent directories and
their contents. In the context of these tests, the thing we really want to
verify is that the sparse index-enabled case produces the same results as
the full index when an operation needs to get some information out of a
sparse directory. 

Coming back to this test, the 'newdirectory/testfile' you create, while
outside the sparse-checkout definition, never actually belongs to a sparse
directory because 'newdirectory' is never collapsed - in fact, I don't
think it even gets the SKIP_WORKTREE bit in the index. To ensure you have a
sparse directory & SKIP_WORKTREE, you'd need to run 'git sparse-checkout
reapply' after removing 'newdirectory/testfile' from disk - which doesn't
help if you want to test what happens when the file exists on disk!

In fact, because of built-in safeguards around on-disk files and
sparse-checkout, there isn't really a way in Git to materialize a file
without also expanding its sparse directory and removing SKIP_WORKTREE. If
you want to preserve a sparse directory, you should write the contents of an
existing file inside that sparse directory to disk manually:

	run_on_sparse mkdir folder1 &&
	run_on_sparse cp a folder1/a &&  # `folder1/a` is identical to `a` in the base commit

Git's index will not be touched by doing this, meaning the next command you
invoke (in this case, 'diff-files') will need to reconcile the file on disk
with what it sees in the index.

> +	test_sparse_match git diff-files &&
> +	test_must_be_empty sparse-checkout-out &&
> +	test_must_be_empty sparse-checkout-err &&
> +	test_sparse_match git diff-files newdirectory/testfile &&
> +	test_must_be_empty sparse-checkout-out &&
> +	test_must_be_empty sparse-checkout-err &&

These checks should be 'test_all_match' rather than 'test_sparse_match'.
Since (through other tests) we're confident that 'git diff-files' on an
unmodified, non-sparse-checkout repository will give us an empty result, you
wouldn't need the additional 'test_must_be_empty' checks.

A bit of a "spoiler": when I tested this out locally, I found that the diff
was *not* empty for the sparse-checkout cases, until I ran 'git status'
(which strips the 'SKIP_WORKTREE' bit from the file and writes it to the
index). That's not the desired behavior, so there's a bug in the
sparse-checkout logic used in 'diff-files' that needs to be fixed (my first
guess would be that 'clear_skip_worktree_from_present_files()' is not being
applied when the index is read).

If you'd like any help investigating this or get stuck, please let me know -
I'd be happy to assist!

> +
> +	# file present on-disk with modifications
> +	FN=newdirectory/testfile &&
> +	OID=$(git -C sparse-checkout hash-object $FN) &&
> +	ZERO=$(test_oid zero) &&
> +	echo ":100644 100644 $OID $ZERO M	$FN" >expect &&
> +
> +	run_on_sparse ../edit-contents newdirectory/testfile &&
> +	test_sparse_match git diff-files &&
> +	test_cmp expect sparse-checkout-out &&
> +	test_sparse_match git diff-files newdirectory/testfile &&
> +	test_cmp expect sparse-checkout-out

Similarly, you should use 'run_on_all' to modify the file & 'test_all_match'
to verify that they all match here. It would demonstrate that we don't
expect any "special" behavior from sparse-checkout, meaning you can probably
avoid checking the result verbatim. 

Finally, as with the earlier test, it'd be nice to show that the result is
the same with a wildcard pathspec, e.g. 'git diff-files "folder*/a"'.

> +'
> +
>  test_done

