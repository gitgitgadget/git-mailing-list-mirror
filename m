Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD1BC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 18:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9987D20B1F
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 18:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w6RkqG0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgD2SGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:06:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64187 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2SGs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 14:06:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B302745F89;
        Wed, 29 Apr 2020 14:06:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fMpiNeqDaShL1wh7bmGnYb5+V+8=; b=w6RkqG
        0VQqAXi195OQVSX71GicKrQWr4V4ibHFGbkNeeYcCZxk1F+nmpBiiGrIo21b3kjh
        x+WDsEPa2ArRvkXbhVGZsvZ0lEnqt2MLRT9j8gizfvZnpOUlV0aAONG8bPlirUyA
        zW7qmFeY5vAWviqR2/tZ4HTv/IOrOHNxUk5uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eM7hTU+LO8UVBIIJBPV12Vqa+sjf6UFg
        RczlC9YHhN0Gwo+l1MoezDdHA0UujJnHh+9RY/2oZzfw1LnTDDDaXrfky484Yi19
        22SQfervzYv9rHb6SGNFQ1Xvrkv0S5DMLXD2oSPy4kguE67rerNWu7dceE2C0N7g
        Q3qol8UG7UE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AABB145F88;
        Wed, 29 Apr 2020 14:06:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 343AC45F87;
        Wed, 29 Apr 2020 14:06:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] lib-submodule-update: consolidate --recurse-submodules
References: <cover.1588162842.git.liu.denton@gmail.com>
        <d5809877af3e20eb9ff459a91d3099846fd32197.1588162842.git.liu.denton@gmail.com>
Date:   Wed, 29 Apr 2020 11:06:45 -0700
In-Reply-To: <d5809877af3e20eb9ff459a91d3099846fd32197.1588162842.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 29 Apr 2020 08:22:24 -0400")
Message-ID: <xmqqtv12w4i2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3060D138-8A44-11EA-9E53-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Both test_submodule_switch_recursing_with_args() and
> test_submodule_forced_switch_recursing_with_args() call the internal
> function test_submodule_recursing_with_args_common() with the final
> argument of `--recurse-submodules`. Consolidate this duplication by
> appending the argument in test_submodule_recursing_with_args_common().
>

OK, I just made sure that these two are the only callers and they
both pass the "--recurse-submodules", so the patch looks quite
sensible.

Thanks.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/lib-submodule-update.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index a3732d3f6c..81457b4c31 100644
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -632,7 +632,7 @@ test_submodule_forced_switch () {
>  # Internal function; use test_submodule_switch_recursing_with_args() or
>  # test_submodule_forced_switch_recursing_with_args() instead.
>  test_submodule_recursing_with_args_common () {
> -	command="$1"
> +	command="$1 --recurse-submodules"
>  
>  	######################### Appearing submodule #########################
>  	# Switching to a commit letting a submodule appear checks it out ...
> @@ -840,7 +840,7 @@ test_submodule_recursing_with_args_common () {
>  # test_submodule_switch_recursing_with_args "$GIT_COMMAND"
>  test_submodule_switch_recursing_with_args () {
>  	cmd_args="$1"
> -	command="git $cmd_args --recurse-submodules"
> +	command="git $cmd_args"
>  	test_submodule_recursing_with_args_common "$command"
>  
>  	RESULTDS=success
> @@ -957,7 +957,7 @@ test_submodule_switch_recursing_with_args () {
>  # away local changes in the superproject is allowed.
>  test_submodule_forced_switch_recursing_with_args () {
>  	cmd_args="$1"
> -	command="git $cmd_args --recurse-submodules"
> +	command="git $cmd_args"
>  	test_submodule_recursing_with_args_common "$command"
>  
>  	RESULT=success
