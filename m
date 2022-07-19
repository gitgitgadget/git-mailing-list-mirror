Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2E7C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbiGSSX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiGSSX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:23:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E56C5C968
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:23:55 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C101F197B1D;
        Tue, 19 Jul 2022 14:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=waA0o4SqNenj5gZbDtcPnOympwly3ftdn0Og1X
        ROFJQ=; b=Qs+flcZHPimPoZJlHYe80WFH6XTkXm3SKEs26DFCyUGys1YPgUjTqb
        lX5N7oKe+QV40nSokH/nLqF0zegIPphJLpkNuY2KcEQ62JGALda5ergz2uB24RFk
        MWBjICz7LlCS1QOhIGe4DRSmOo7+HCFcvM0pR1+BX6PagnVd6dqbM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8FD8197B1C;
        Tue, 19 Jul 2022 14:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4D024197B1A;
        Tue, 19 Jul 2022 14:23:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Celeste Liu <coelacanthus@outlook.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Raman Gupta <rocketraman@gmail.com>
Subject: Re: [PATCH v3] contrib/rerere-train: avoid useless gpg sign in
 training
References: <PH7PR14MB5594A27B9295E95ACA4D6A69CE8F9@PH7PR14MB5594.namprd14.prod.outlook.com>
Date:   Tue, 19 Jul 2022 11:23:50 -0700
In-Reply-To: <PH7PR14MB5594A27B9295E95ACA4D6A69CE8F9@PH7PR14MB5594.namprd14.prod.outlook.com>
        (Celeste Liu's message of "Wed, 20 Jul 2022 01:21:44 +0800")
Message-ID: <xmqqcze1arm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0663796-078F-11ED-B3AB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Celeste Liu <coelacanthus@outlook.com> writes:

> Users may have configured "git merge" to always require GPG
> signing the resulting commits. We are not running "git merge" to
> re-create merge commits, but merely to replay merge conflicts,
> and we will immediately discard the resulting commits; there
> is no point in signing them.
>
> Override such configuration that forces useless signing from the
> command line with the "--no-gpg-sign" option.
>
> Signed-off-by: Celeste Liu <coelacanthus@outlook.com>
> ---
> v2: add problem detail in commit message.
> v3: more detailed reason

Makes sense.

Not a suggestion to change anything, but another possibility may be
to run the command with the --no-commit option, perhaps.  If we ever
gained more features added a knob to enable it by default, we would
need to add --no-that-feature as well to refuse it, just like we are
doing so for GPG here, and telling the command that there is no need
to make a commit could turn out to be an easier way to do so for all
extra features that will be invented in the future.

Thanks.  Will queue.

>
>  contrib/rerere-train.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
> index 26b724c8c6..bd01e430ef 100755
> --- a/contrib/rerere-train.sh
> +++ b/contrib/rerere-train.sh
> @@ -75,7 +75,7 @@ do
>  		continue
>  	fi
>  	git checkout -q "$parent1^0"
> -	if git merge $other_parents >/dev/null 2>&1
> +	if git merge --no-gpg-sign $other_parents >/dev/null 2>&1
>  	then
>  		# Cleanly merges
>  		continue
