Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC8820248
	for <e@80x24.org>; Fri, 22 Mar 2019 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfCVRSr (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 13:18:47 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:36107 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfCVRSq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 13:18:46 -0400
Received: from [192.168.1.12] ([2.101.244.128])
        by smtp.talktalk.net with SMTP
        id 7NoZhfOcodrax7NoZhNgxT; Fri, 22 Mar 2019 17:18:43 +0000
X-Originating-IP: [2.101.244.128]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=8nsoD1t2XaTH5iSUU4dp1Q==:117
 a=8nsoD1t2XaTH5iSUU4dp1Q==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=VmrKRvbLY6Vl8-nRlB0A:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH 3/4] read-tree: add --quiet
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20190322093138.13765-1-pclouds@gmail.com>
 <20190322093138.13765-4-pclouds@gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <04d888be-d66b-110a-b1e4-35ff4897fcab@iee.org>
Date:   Fri, 22 Mar 2019 17:18:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190322093138.13765-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfM+m4Bf1GYmRZnCo8SDMWnBIeFtt5oUwnHn+f4AC9tZ3y8EqmnTbwLbKuAdoi7vfidF86RY0u+TdhckF4LmMSj/Ww8yatwL6VpuUrR73oTty7gJKGraz
 zmDu04Wol+0lLC9X0UrLl9l7FR7JhjSRtNKVMDVHteoEVLRR3homg+qPcro+zGnI+k+vawEmWNtk2hlwq5NHMgKFDrCzZrnoiwdYi+d+RwPE5seUA2bXOq42
 ueGzF8ZLwDv+t0K3Gk3o4n24Lwbifn/TyZ1zfNZP4ZHW51FM6XbL9Q5hBREBcYedw6eGNVbQugl8wSnPr9NN2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/03/2019 09:31, Nguyễn Thái Ngọc Duy wrote:
> read-tree is basically the front end of unpack-trees code and shoud

s/shoud/should/

Philip

> expose all of its functionality (unless it's designed for internal
> use). This "opts.quiet" (formerly "opts.gently") was added for
> builtin/checkout.c but there is no reason why other read-tree users
> won't find this useful.
>
> The test that is updated to run 'read-tree --quiet' was added because
> unpack-trees was accidentally not being quiet [1] in 6a143aa2b2
> (checkout -m: attempt merge when deletion of path was staged -
> 2014-08-12). Because checkout is the only "opts.quiet" user, there was
> no other way to test quiet behavior. But we can now test it directly.
>
> 6a143aa2b2 was manually reverted to verify that read-tree --quiet
> works correctly (i.e. test_must_be_empty fails).
>
> [1] the commit message there say "errors out instead of performing a
>      merge" but I'm pretty sure the "performing a merge" happens anyway
>      even before that commit. That line should say "errors out
>      _in addition to_ performing a merge"
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   Documentation/git-read-tree.txt | 4 ++++
>   builtin/read-tree.c             | 1 +
>   t/t7201-co.sh                   | 3 +++
>   3 files changed, 8 insertions(+)
>
> diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
> index 5c70bc2878..1e81f9c4e6 100644
> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -128,6 +128,10 @@ OPTIONS
>   	Instead of reading tree object(s) into the index, just empty
>   	it.
>   
> +-q::
> +--quiet::
> +	Quiet, suppress feedback messages.
> +
>   <tree-ish#>::
>   	The id of the tree object(s) to be read/merged.
>   
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 9083dcfa28..5c9c082595 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -154,6 +154,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>   		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
>   			    "checkout", "control recursive updating of submodules",
>   			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
> +		OPT__QUIET(&opts.quiet, N_("suppress feedback messages")),
>   		OPT_END()
>   	};
>   
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 72b9b375ba..f165582019 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -223,6 +223,9 @@ test_expect_success 'switch to another branch while carrying a deletion' '
>   	test_must_fail git checkout simple 2>errs &&
>   	test_i18ngrep overwritten errs &&
>   
> +	test_must_fail git read-tree --quiet -m -u HEAD simple 2>errs &&
> +	test_must_be_empty errs &&
> +
>   	git checkout --merge simple 2>errs &&
>   	test_i18ngrep ! overwritten errs &&
>   	git ls-files -u &&
