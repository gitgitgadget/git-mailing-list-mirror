Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9BCFA373D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 16:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJUQ21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJUQ20 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 12:28:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350B72745BE
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 09:28:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t16so7894272edd.2
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+eQu1IyiXOvQFZievNe6hAW1C/kE5RvXgiaVSiDvo2s=;
        b=Wglgi6TdCdtMbz8+SW1cl6GmgAoz/5xIAMOZQ4uENLds0DMu81Up5561TBtIeQTItc
         5/piZ0imIb5OL4HYL3qlgYURiUVNZ86031jtXHAbHabM42Tr81OMOXwyFmQtNJgS2m+j
         FLqXpIqEwGc/DShjszV7+kH6YPc5C0wnJ9ZUoXBYc27ouHwMLXtR0AFqr5RVNA64Is3b
         yv89UZiGVEbU476c4MLy3AtPo7gqixirwbXMHyPxZTPA9Gt0yjPr0fAt9YUzY0G0YvV/
         UogFWQR1qvIAtlaNcs6DaXf/Ykw0Jz/TmCzw9rMZlaKU9Gcxbv1sR8erNVCVquvIICy6
         G+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eQu1IyiXOvQFZievNe6hAW1C/kE5RvXgiaVSiDvo2s=;
        b=LGJmFjBCv9CtPe/zIgRagknYzxmYi1IQuRlQRNaofHM6hl0WtRLKwoJo5t/3c7ZH5S
         fF0yKt+l/oDdvWZn0enNQjMNJaLuM6oQJ4ZdmW+L8tOzJqf5NiHZhTU+ZegSQdhoMhBa
         4CDID3WNNm1UwEePWELGN97Z3FZz8heKLiDqB8M8mps2jl8ilAdCGAe79BR2+qj+owK+
         ciW05gkF0l8D/ggB7pn9hqzRMsbM/NOe0nMnxNOOAwRFsSBQEqKu3Qe2OavZRFrh+pQ0
         VoMuSg4GPuLYUEg7T9Wv5quhDPEElMHiGm6/zmhLXCIAHoDEC+zmgD3a9XioqhYM83L1
         UZug==
X-Gm-Message-State: ACrzQf34Vm2ikYnHcHMMUL4BoIjY1scnNocKzslaxMob9TqAn2KP2KjD
        SQpJKqEIoEwy/Yjyn8iTZF4A0WxLxwZHzQ==
X-Google-Smtp-Source: AMsMyM5J8S7M3NIwmBfbY1xYR379hY5X/VjL25emuKQnlk9FVFnvB7cZC82MedIKEmnM5QDpsYsloQ==
X-Received: by 2002:a05:6402:8cc:b0:45c:a5c9:c0a with SMTP id d12-20020a05640208cc00b0045ca5c90c0amr17925220edz.135.1666369702233;
        Fri, 21 Oct 2022 09:28:22 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090623ea00b007919ba4295esm5305334ejg.216.2022.10.21.09.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:28:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oluse-0075JF-0O;
        Fri, 21 Oct 2022 18:28:20 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/9] subtree: add 'die_incompatible_opt' function to
 reduce duplication
Date:   Fri, 21 Oct 2022 18:22:39 +0200
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
 <c890f55f59994231be6114f76f020510eb824453.1666365220.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <c890f55f59994231be6114f76f020510eb824453.1666365220.git.gitgitgadget@gmail.com>
Message-ID: <221021.86v8oddtuj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 21 2022, Philippe Blain via GitGitGadget wrote:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> 9a3e3ca2ba (subtree: be stricter about validating flags, 2021-04-27)
> added validation code to check that options given to 'git subtree <cmd>'
> made sense with the command being used.
>
> Refactor these checks by adding a 'die_incompatible_opt' function to
> reduce code duplication.

This looks good, but...

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  contrib/subtree/git-subtree.sh | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 49ef493ef92..f5eab198c80 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -102,6 +102,14 @@ assert () {
>  	fi
>  }
>  
> +# Usage: die_incompatible_opt OPTION COMMAND
> +die_incompatible_opt () {
> +	assert test "$#" = 2
> +	opt="$1"
> +	arg_command="$2"
> +	die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
> +}
> +
>  main () {
>  	if test $# -eq 0
>  	then
> @@ -176,16 +184,16 @@ main () {
>  			arg_debug=1
>  			;;
>  		--annotate)
> -			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
> +			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
>  			arg_split_annotate="$1"
>  			shift
>  			;;

Since this is all in this form I wonder why not (maybe adding some "local" and/or "&&" too while at it):

	die_if_other_opt {
		assert test "$#" = 3
		other="$1"
                shift
                if test -z "$other"
		then
			return
		fi
		[...the rest of your version]
	}

Then:

>  		--no-annotate)
> -			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
> +			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"

Instead of this:

	die_if_other_opt "$allow_split" "$opt" "$arg_command"

Or actually just:

	die_if_other_opt "$allow_split"

Maybe you disagree, but since the function will see the variables & this
is purely a helper for this getopts parse loop I think it's fine just to
assume we can read "$opt" and "$arg_command" there..., so, urm, maybe just:

	test -n "$allow_split" || die_incompatible_opt

? :) Anyway, an easy bike shed, you should go for whatever variant you
prefer :) Thanks for indulging me.
