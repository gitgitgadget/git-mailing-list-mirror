Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5224C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 00:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhLVAGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 19:06:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58158 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhLVAGH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 19:06:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F81F15995B;
        Tue, 21 Dec 2021 19:06:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HBM+va+NFZkj0CP8cv38IQBLtNKbInQEn27xcZ
        RpSF4=; b=E2k9niIiDo1N2FBpgZwOL8vmiBa9b0MJtXwMAtcJx4ptb9kfPTfbz+
        TaqaOYN1MInRZUwL5JihWoM8CdXNWGFVzQIBi6DSNrrYQyangf34fwwk+aEZo7D3
        6FlHCyabPMrHO3lkwt/264ig1knANJg6yQ6n9Fwi+FT1dNmi0xAAk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7947915995A;
        Tue, 21 Dec 2021 19:06:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AFAC3159959;
        Tue, 21 Dec 2021 19:06:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH 4/9] merge-ort: mark a few more conflict messages as
 omittable
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
        <1e7eef7705e2f7b4a456056e4335d82267680214.1640109948.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 16:06:02 -0800
In-Reply-To: <1e7eef7705e2f7b4a456056e4335d82267680214.1640109948.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 21 Dec 2021
        18:05:43 +0000")
Message-ID: <xmqq1r25o651.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3EB183E-62BA-11EC-A589-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> path_msg() has the ability to mark messages as omittable, designed for
> remerge-diff where we'll instead be showing conflict messages as diff
> headers for a subsequent diff.  While all these messages are very useful
> when trying to create a merge initially, early use with the
> --remerge-diff feature (the only user of this omittable conflict message
> capability), suggests that the particular messages marked in this commit
> are just noise when trying to see what changes users made to create a
> merge commit.

It is likely because when somebody is looking at the output of
remerge-diff, they are mostly concentrating on the _content_ level
merges and they are not keenly looking for a merge whose result is
deposited at a wrong path.  Since what is shown is something that
has already recorded in the history, we can safely assume that it is
no longer a relevant (or "it is way too late to matter"), I would
say, to show these messages about "file location".

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index a18f47e23c5..fe27870e73e 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2420,7 +2420,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
>  		 */
>  		ci->path_conflict = 1;
>  		if (pair->status == 'A')
> -			path_msg(opt, new_path, 0,
> +			path_msg(opt, new_path, 1,
>  				 _("CONFLICT (file location): %s added in %s "
>  				   "inside a directory that was renamed in %s, "
>  				   "suggesting it should perhaps be moved to "
> @@ -2428,7 +2428,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
>  				 old_path, branch_with_new_path,
>  				 branch_with_dir_rename, new_path);
>  		else
> -			path_msg(opt, new_path, 0,
> +			path_msg(opt, new_path, 1,
>  				 _("CONFLICT (file location): %s renamed to %s "
>  				   "in %s, inside a directory that was renamed "
>  				   "in %s, suggesting it should perhaps be "
> @@ -3825,7 +3825,7 @@ static void process_entry(struct merge_options *opt,
>  				reason = _("add/add");
>  			if (S_ISGITLINK(merged_file.mode))
>  				reason = _("submodule");
> -			path_msg(opt, path, 0,
> +			path_msg(opt, path, 1,
>  				 _("CONFLICT (%s): Merge conflict in %s"),
>  				 reason, path);

I am not as sure about this one as the other two, though.  I guess
in the context of remerge-diff, resolving the add/add conflict into
the same file is also something that happened long time ago and
these messages are too late to matter the same way as the other two.

OK.


