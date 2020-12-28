Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE24C4332B
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 16:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B912220719
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 16:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbgL1NW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 08:22:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51824 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387582AbgL1NUj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 08:20:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBEA110FA82;
        Mon, 28 Dec 2020 08:19:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=SZVaz2Jlwq1y7aIRiiEx+kz6X8o=; b=XaQD3sPAQP5zm6oO5RUm
        I+Z+rnV3P2IqKdFTw0CCwZtaY5hLP+n2qqmBogoHpvAWvn5KgTf8i9gaD4wDL4td
        APKpHYDBX3fhGGNQZmudXwpHK8AAQJK+CEYuYGSrWS49qAY1Vod+UDgNGSGK7MLS
        Hr1AEy5zRCfiEvV6auyvLcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ogzoxL8+W7aD9cPc1adK+UYF5tSdU2nrcXBd6iEhXa+gty
        E1dRmAvO9n365deCLitOgmKmzV85SbSewdp6TT8BSqO0ZCv7PjgtwIm1BRpGbKYc
        LgqIHLKKvcU4/+ZSU1OBTgayzb8nHmxAltrwBQF23O6RGg2Pqx3KuISRhuQOc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B462D10FA7F;
        Mon, 28 Dec 2020 08:19:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 10BC610FA7A;
        Mon, 28 Dec 2020 08:19:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 4/4] mergetool: Add automerge_enabled tool-specific
 override function
References: <20201228004152.522421-1-seth@eseth.com>
        <20201228045427.1166911-1-seth@eseth.com>
        <20201228045427.1166911-5-seth@eseth.com>
Date:   Mon, 28 Dec 2020 05:19:53 -0800
Message-ID: <xmqqtus6hxty.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 601DD936-490F-11EB-AA4D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> Hat-tip to Junio C Hamano for the implementation.

That is the least interesting thing the log message for this commit
can talk about.  Instead readers should be able to learn things like
these from the log message (I am not saying the log message should
have these in an enumerated list; I am just enumerating these as
samples):

 - Why does this exist?  

 - What does a tool author want to use the mechanism for, and how
   does the tool author use it?  

 - This mechanism allows tool authors to say "never allow autoMerge
   for this tool", but there is no provision to let them say "always
   use autoMerge without allowing users to turn it off".

It also needs a bit of documentation update to mention that
individual mergetool backend can choose not to trigger the feature
at all, even if the user configures it with mergetool.autoMerge and
mergetool.<tool>.autoMerge options.

Thanks.

> Signed-off-by: Seth House <seth@eseth.com>
> ---
>  git-mergetool--lib.sh | 4 ++++
>  git-mergetool.sh      | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index e059b3559e..5084ceffeb 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -164,6 +164,10 @@ setup_tool () {
>  		return 1
>  	}
>  
> +	automerge_enabled () {
> +		true
> +	}
> +
>  	translate_merge_tool_path () {
>  		echo "$1"
>  	}
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 929192d0f8..a44afd3822 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -336,7 +336,7 @@ merge_file () {
>  
>  	initialize_merge_tool "$merge_tool"
>  
> -	if test "$(
> +	if automerge_enabled && test "$(
>  		git config --get --bool "mergetool.$merge_tool.automerge" ||
>  		git config --get --bool "mergetool.automerge" ||
>  		echo true)" = true
