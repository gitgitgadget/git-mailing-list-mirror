Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E015FC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33E6613CD
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbhI2GLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 02:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244076AbhI2GLG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 02:11:06 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA26FC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:09:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b78so1717982iof.2
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GLwXAibSF63TEL+AehzvfDzuwCBFHQxcjNJZVUZUdBY=;
        b=BIPm1SWCEK6rgfxtdjqdF6H82zkllRhQdv7wt0GdqRDQlhmwMILiyh65k8vYre4wf+
         Q9QbrUxmBzVk6R3VaxGhWLcS990MlNaB6tglXKxCr0BZqH8RtZdLwSY0CEdNXkUEU5uO
         KLbEFY+F6QVzKctJzp5IBE24fIepyfY3OaMvjienK7fDSkqatM3jL6CaoYCD6zccdZ6M
         kREGGL0x8ufzzp2WG2MFstXxm/SJkGm0maAacAiVIknIaQCoxu2kbFDZvuPViIvZSpio
         ND4s3aywiQgd7yGi/1JDjZb+3Vdknm1rCXeP+qsBHgGVMGWh4lUpSCFes97QOj/cm6lw
         arew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLwXAibSF63TEL+AehzvfDzuwCBFHQxcjNJZVUZUdBY=;
        b=PPZJLefglyueQb6zRyfT+qpt1KRjs6N3ymVgV4oEU+I6/v745Nk4rca+ivsAeow0r4
         2qB3SLahxBHAmTlDWQSBkSSbJaCTqEbm4LY9PTGWxYib/7na3f9loERYusIcO8NzAqF6
         tiyuMVCyko1TsUshG/Cz3rgB5ybHnB40VYaGAvvv5fSM0CehEsyxdDM7ur8BVKNcN989
         T73PPGh9A6X/hspcxOP8NZigYmwzAdG2EyokqOGHsOSdRMdQtSU2Vo9QeK2ZDqAG5SoB
         izI4i+iIHhk8tzregqYxJg+idfxtlhKvw/1aIM2ejZzOalL5r13ZCyzxbJmhtc/KptHM
         dh1w==
X-Gm-Message-State: AOAM53307LfL0kT+8A5hLDEP1VasGqIH1l6uI0AcUWdVB8hDFaOKCYRY
        Q03U/hqNJtel492SSRT9w3ylzIeREF6/Ig==
X-Google-Smtp-Source: ABdhPJwzy3mBUFDFj+MmFn83MPmvTsi5FU14xUm3Yt9VnVSiem28yEhmR+CcjKjpPUEMug2F+npinQ==
X-Received: by 2002:a6b:f805:: with SMTP id o5mr6589649ioh.131.1632895765139;
        Tue, 28 Sep 2021 23:09:25 -0700 (PDT)
Received: from flurp.local (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id x9sm798635ilg.76.2021.09.28.23.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 23:09:24 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v2 1/3] fsck: verify commit graph when implicitly enabled
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <20210913181221.42635-1-chooglen@google.com>
 <20210917225459.68086-1-chooglen@google.com>
 <20210917225459.68086-2-chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <e1447d0e-091d-c659-b702-c5b33fffdb59@sunshineco.com>
Date:   Wed, 29 Sep 2021 02:09:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210917225459.68086-2-chooglen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/17/21 6:54 PM, Glen Choo wrote:
> the_repository->settings is the preferred way to get certain
> settings (such as "core.commitGraph") because it gets default values
> from prepare_repo_settings(). However, cmd_fsck() reads the config
> directly via git_config_get_bool(), which bypasses these default values.
> This causes fsck to ignore the commit graph if "core.commitgraph" is not
> explicitly set in the config. This worked fine until commit-graph was
> enabled by default in 31b1de6a09 (commit-graph: turn on commit-graph by
> default, 2019-08-13).
> 
> Replace git_config_get_bool("core.commitgraph") in fsck with the
> equivalent call to the_repository->settings.core_commit_graph.
> [...]
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> @@ -674,7 +674,7 @@ test_expect_success 'detect incorrect chunk count' '
> -test_expect_success 'git fsck (checks commit-graph)' '
> +test_expect_success 'git fsck (checks commit-graph when config set to true)' '
>   	cd "$TRASH_DIRECTORY/full" &&
>   	git fsck &&
>   	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> @@ -683,6 +683,28 @@ test_expect_success 'git fsck (checks commit-graph)' '
>   	test_must_fail git fsck
>   '

Because I took the time to scan backward through this test script, I 
understand that `core.commitGraph` is already `true` by the time this 
test is reached, thus the new test title is accurate (for now). However, 
it would be a bit easier to reason about this and make it more robust by 
having the test itself guarantee that it is set to `true` by invoking 
`git config core.commitGraph true`.

> +test_expect_success 'git fsck (ignores commit-graph when config set to false)' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git fsck &&
> +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> +		"incorrect checksum" &&
> +	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
> +	test_config core.commitGraph false &&
> +	git fsck
> +'

test_config() unsets the config variable when the test completes, so I'm 
wondering if its use is in fact desirable here. I ask because, from a 
quick scan through the file, it appears that many tests in this script 
assume that `core.commitGraph` is `true`, so it's not clear that 
unsetting it at the end of this test is a good idea in general.

> +test_expect_success 'git fsck (checks commit-graph when config unset)' '
> +	test_when_finished "git config core.commitGraph true" &&
> +
> +	cd "$TRASH_DIRECTORY/full" &&

I find it somewhat confusing to reason about the behavior of 
test_when_finished() when it is invoked like this before the `cd`. It's 
true that the end-of-test `git config core.commitGraph true` will be 
invoked within `full` as desired (except in the very unusual case of the 
`cd` failing), so it's probably correct, but it requires extra thought 
to come to that conclusion. Switching the order of these two lines might 
lower the cognitive load a bit.

> +	git fsck &&
> +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> +		"incorrect checksum" &&
> +	test_unconfig core.commitGraph &&
> +	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
> +	test_must_fail git fsck
> +'

Taking Taylor's comment[1] on v1 patch [2/3] into account, I wonder if 
it would be simpler for these all to be combined into a single test. 
Something like (untested):

     cd "$TRASH_DIRECTORY/full" &&
     test_when_finished "git config core.commitGraph true" &&
     git config core.commitGraph true &&
     git fsck &&
     corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
         "incorrect checksum" &&
     cp commit-graph-pre-write-test $objdir/info/commit-graph &&
     test_must_fail git fsck &&
     git config core.commitGraph false &&
     git fsck &&
     git config --unset-all core.commitGraph &&
     test_must_fail git fsck

I didn't bother using test_unconfig() since, in this case, we _know_ 
that the config variable is set, thus don't have to worry about `git 
config --unset-all` failing.

A downside of combining the tests like this is that it makes it a bit 
more cumbersome to diagnose a failure (because there is more code and 
more cases to wade through).

Anyhow, I don't have a strong feeling one way or the other about 
combining the test or leaving them separate.

[1]: https://lore.kernel.org/git/YT+n81yGPYEiMXwQ@nand.local/
