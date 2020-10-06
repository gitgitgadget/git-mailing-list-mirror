Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0380FC41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 18:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFAF20760
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 18:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgJFSoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 14:44:13 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:57806 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgJFSoN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 14:44:13 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4C5RFl4kt1z5tlD;
        Tue,  6 Oct 2020 20:44:11 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D3CCC212C;
        Tue,  6 Oct 2020 20:44:10 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] userdiff: support Rust macros
To:     Konrad Borowski via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Konrad Borowski <github@borowski.pw>,
        Konrad Borowski <konrad@borowski.pw>
References: <pull.865.git.git.1601986430388.gitgitgadget@gmail.com>
Message-ID: <42808d58-6472-5959-a471-3d09d06d8fd3@kdbg.org>
Date:   Tue, 6 Oct 2020 20:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <pull.865.git.git.1601986430388.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.10.20 um 14:13 schrieb Konrad Borowski via GitGitGadget:
> From: Konrad Borowski <konrad@borowski.pw>
> 
> This adds a support for macro_rules! keyword which declares
> a macro. It also includes a test case.

We would write this sentence in imperative mood, i.e., give the codebase
the order to become so. That a test case is included can be seen from
the patch text and need not be mentioned.

In this case, if I were the only one to judge, I would accept this
commit without a message if the commit summary were:

  userdiff: permit Rust's macro_rules! keyword in hunk headers

> 
> Signed-off-by: Konrad Borowski <konrad@borowski.pw>
> ---
>     userdiff: support Rust macros
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-865%2Fxfix%2Fuserdiff-macro-rules-rust-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-865/xfix/userdiff-macro-rules-rust-v1
> Pull-Request: https://github.com/git/git/pull/865
> 
>  t/t4018/rust-macro-rules | 6 ++++++
>  userdiff.c               | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>  create mode 100644 t/t4018/rust-macro-rules
> 
> diff --git a/t/t4018/rust-macro-rules b/t/t4018/rust-macro-rules
> new file mode 100644
> index 0000000000..ec610c5b62
> --- /dev/null
> +++ b/t/t4018/rust-macro-rules
> @@ -0,0 +1,6 @@
> +macro_rules! RIGHT {
> +    () => {
> +        // a comment
> +        let x = ChangeMe;
> +    };
> +}
> diff --git a/userdiff.c b/userdiff.c
> index fde02f225b..f13a913697 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -165,7 +165,7 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
>  	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
>  	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
>  PATTERNS("rust",
> -	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
> +	 "^[\t ]*(((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+|macro_rules[\t ]*!)[^;]*)$",
>  	 /* -- */
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"

Technically, this looks fine. Originally I thought that the new keyword
could just be thrown into the mix of struct|enum etc, but judging from
the (existing) test cases, this new case looks fairly different (I am
not a Rust expert, so I cannot really tell). Therefore, it is OK to put
it in an alternative branch in the regexp.

Reviewed-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
