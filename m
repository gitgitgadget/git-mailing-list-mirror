Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86579C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 21:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbiHQVpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 17:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiHQVpS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 17:45:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D12AE5
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 14:45:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00A7312E4FB;
        Wed, 17 Aug 2022 17:45:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NeKJXd39kMeaf8A7f6BTJ4Inokz6Acd/gfS7t1
        AR0zo=; b=cc3E/YGZh6n8hk64gOh9zHnowcRSiea8TZUjcta2hdBez88Tzr8Vdt
        qBCvKl0ctU6LpSF1lOeX/Mk3XF/z1MiPIV8vDCyrKzPzPuoHo4EVzbneQykgG2Ht
        84O2WMc5Mm4/W09jeI6/EDuYiaPMaIh3QQFnFNB341bgFfcxcYtJM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED6F812E4F9;
        Wed, 17 Aug 2022 17:45:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 540D212E4F6;
        Wed, 17 Aug 2022 17:45:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/3] merge-ort: add comment to avoid surprise with
 new sub_flag variable
References: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
        <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
        <340c0f46f74acd641945fceba5ab5feac011ae60.1660718028.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 14:45:15 -0700
In-Reply-To: <340c0f46f74acd641945fceba5ab5feac011ae60.1660718028.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 17 Aug 2022
        06:33:47 +0000")
Message-ID: <xmqqedxetuhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E19E56B0-1E75-11ED-8158-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Commit 4057523a40 ("submodule merge: update conflict error message",
> 2022-08-04) added a sub_flag variable that is used to store a value from
> enum conflict_and_info_types, but initializes it with an invalid value
> of -1.  The code may never set it to a valid value, and use the invalid
> one.  This can be surprising when reading over the code at first, but it
> was intentional.  Add a comment making it clear that it is okay to be
> using an invalid value, due to how it is used later.

The current code uses -1 as the "suggest the default course of
action", so -1 is very much a "valid value" from the viewpoint of
the code that suggests how to resolve.  It indeed is an invalid
value from the viewpoint of those who maintain conflict_and_info_types
enum.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 67159fc6ef9..0a935a8135f 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1886,7 +1886,7 @@ cleanup:
>  		const char *abbrev;
>  
>  		util = xmalloc(sizeof(*util));
> -		util->flag = sub_flag;
> +		util->flag = sub_flag; /* May still be -1 */
>  		util->abbrev = NULL;
>  		if (!sub_not_initialized) {
>  			abbrev = repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV);

This new comment may be a slight improvement, but a valid value of
sub_flag is used only to signal the situation where the code does
not know what to suggest, which feels backwards for longer-term code
evolution.  Presumably, we would use the util->flag field to store
which of the known cases we know what to suggest as we know better.

I wonder if we should initialize the variable to the most generic
CONFLICT_SUBMODULE_FAILED_TO_MERGE instead of -1.  The value would
mean "use the default suggestion", and the two known unworkable
values (not-initialized and history-not-available) are currently
handled according to what these two values mean.  We may later add
more specialization based on other CONFLICT_SUBMODULE_* values.

Thanks.

