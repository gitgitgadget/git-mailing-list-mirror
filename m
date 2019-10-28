Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9C11F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 01:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfJ1BEe (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 21:04:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46458 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfJ1BEd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 21:04:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so12221917qtq.13
        for <git@vger.kernel.org>; Sun, 27 Oct 2019 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f7wMVFNkE35ryavf3nFBG0YIQdodE59Ej98TiXsKOMw=;
        b=fQWjfoDc5+7Slx897ot3WNJx5LPs07YxmMCGuFn9FjyZWCr78HnAjXVMhZwAovDZq/
         Awfv+SJz8KwvbP9BKnrm1ZyO4Q1yJmzrAgEy3muN+H/zXRKC9aad+xm7g/H89NJj9jzA
         snBuV7WZLb3LwRVztnT5MDPuPjvSHTj0IbmgWkqY438Sbgz1jNsmIk/DPqLDbKnO4fl7
         oaepzDurAijng3eEF7mJ99WiBgwI9kcGdjbRnEoNDgVMFOc1LbAD/ThX5V4RZxm0ap3y
         00gEAVkb4xXdIEiyoLC3QKni8t3RHJDuAsesZo7hi/PjORqlpU1fd2Pji59KNzntTeWg
         am1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f7wMVFNkE35ryavf3nFBG0YIQdodE59Ej98TiXsKOMw=;
        b=MMAtfcz4CmDmJ6lMobAQay9MdAh35Rakm4nwbGTZwctKYSffNRgvBoYCBaA4WMEYvt
         6bEALfQJJSy1cS+tdJQEOJwWJ3TCe8T+w+GW5aoCvwoe93e6remZXD5soQLBOFbsAySz
         55rhv1oH3Riy3TN157pEG0t1NKVSJFAyrLe7orsQ5CAcACDr2AqggeVgfR332EhKul/I
         8xbxWouh9/YyCA2g7gkTweZvVFQuZVWeToY25NVdHG393Pk6lmahFDrXbQCzoNtBROzs
         T67dutw/tYmQPGsb0acdG5QT70Yeveh0ox4zH965/4HttHWPum7+dx1VnNfQxq8urjMf
         r6PQ==
X-Gm-Message-State: APjAAAWB52lMnJ5rkQ6qX+JqdxdY27lAekZmwGSZentBUSsOOX+KN6hw
        Mea/DfWMyE5AJOJDRO7KmfBnKkKUrBw=
X-Google-Smtp-Source: APXvYqwepgw805auVISmvBYOh+U46x19N32+OwUBXwUJiNG+Qv3cUkHijfDZEkqZYtQLu9I1yViBkg==
X-Received: by 2002:a0c:ec0b:: with SMTP id y11mr13797755qvo.123.1572224671819;
        Sun, 27 Oct 2019 18:04:31 -0700 (PDT)
Received: from [192.168.1.3] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id h3sm7207640qte.62.2019.10.27.18.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 18:04:31 -0700 (PDT)
Subject: Re: [BUG] commit-graph path normalization reads uninitialized bytes
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org
References: <20191027042116.GA5801@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <913e40a1-01c6-f740-3aac-c8cdea774a63@gmail.com>
Date:   Sun, 27 Oct 2019 21:04:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191027042116.GA5801@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27/2019 12:21 AM, Jeff King wrote:
> I noticed an interesting bug related to 16110c9348 (commit-graph:
> normalize commit-graph filenames, 2019-06-18). It calls
> normalize_path_copy() on the object directory without checking the
> result. That function can fail when the path can't be normalized (e.g.,
> a relative path that goes above the cwd, like "../foo"). That leaves
> nonsense in the destination buffer, which we then call open() on.
> 
> Try this from a git.git build:
> 
>   (cd t && GIT_DIR=../.git valgrind ./git rev-parse HEAD^)
> 
> which yields:
> 
>   ==5907== Syscall param openat(filename) points to uninitialised byte(s)
>   ==5907==    at 0x4914A35: open (open64.c:48)
>   ==5907==    by 0x31C58B: git_open_cloexec (sha1-file.c:1021)
>   ==5907==    by 0x217BF1: open_commit_graph (commit-graph.c:107)
>   ==5907==    by 0x2182BF: load_commit_graph_one (commit-graph.c:314)
>   ...etc...
> 
> This is even triggered in the test suite, but we don't notice because
> the exit code from that invocation is thrown away. Doing this:
> 
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index df34c994d2..eebb49ecc5 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -222,7 +222,9 @@ test_expect_success 'submodule update --remote should fetch upstream changes' '
>  	(cd super &&
>  	 git submodule update --remote --force submodule &&
>  	 cd submodule &&
> -	 test "$(git log -1 --oneline)" = "$(GIT_DIR=../../submodule/.git git log -1 --oneline)"
> +	 git log -1 --oneline >expect &&
> +	 GIT_DIR=../../submodule/.git git log -1 --oneline >actual &&
> +	 test_cmp expect actual
>  	)
>  '
>  
> 
> and then running t7406 with --valgrind-only=10 yields a similar error
> (and a test failure). Interestingly, neither ASan nor MSan seem to catch
> it. But even more interesting is that it generally does something
> sensible! If I "strace -e openat" that test, I get:
> 
>   openat(AT_FDCWD, "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZB\245\245\245\245\245\245\245\10\261\v", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
>   openat(AT_FDCWD, "../../submodule/.git/objects/info/commit-graphs/commit-graph-chain", O_RDONLY) = -1 ENOENT (No such file or directory)
> 
> Whoops. That's obviously nonsense, but the kernel tells us only ENOENT
> (I suppose if there was no NUL in the uninitialized bytes, it'd perhaps
> run off the buffer and return EFAULT). But either way, we decide there
> is no commit-graph file and fall back to operating without it. So we
> produce the correct output either way. But obviously using uninitialized
> bytes is bad, and of course it could end up opening some random file
> (less likely than you might think, if we reuse a heap buffer).

These all sound bad. Thanks for finding this issue!

> We could "fix" it like this (there are a few other sites, too, so this
> is just illustrating the idea):
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index fc4a43b8d6..422092d3a9 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -45,7 +45,10 @@ char *get_commit_graph_filename(const char *obj_dir)
>  {
>  	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
>  	char *normalized = xmalloc(strlen(filename) + 1);
> -	normalize_path_copy(normalized, filename);
> +	if (normalize_path_copy(normalized, filename) < 0) {
> +		free(normalized);
> +		return filename;
> +	}
>  	free(filename);
>  	return normalized;
>  }
> 
> But it really makes me wonder what we're trying to get out of the
> normalization. If you want to compare two paths reliably, then you
> really need to create an absolute path and normalize that. And then
> you'd probably want to handle symlinks, too, so you'd end using
> real_path().
>
> So it's not clear to me if this is a kind of "best effort"
> normalization, and the patch above is the right approach. Or if we need
> to be doing it more carefully.

The reason for the normalization is _mostly_ so we know when to expire a
commit-graph that is no longer referenced by the current commit-graph-chain
file. There are some issues around if the commit-graph is in an alternate,
too, which is likely the reason around this example (it only uses "info/commit-graph"
instead of "info/commit-graphs/graph-{hash}.graph").

In the case that someone runs `git commit-graph write --split` in a repo
with an alternate, and the alternate has a commit-graph at
"{alternate}/info/commit-graph", we want to make sure that file does not
get moved to ".git/objects/info/commit-graphs/graph-{hash}.graph" to be
the base of a new split commit-graph in the current repo. The normalization
seemed to be necessary for that.

With that in mind, I'm not sure your proposed fix is the best solution,
but the "create an absolute path and normalize that" is really what we
want. Or maybe I just misunderstood what normalizing did (a canonical
absolute path would have been sufficient, I think).

Thanks,
-Stolee
