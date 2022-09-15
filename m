Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C84ECAAD8
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 02:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIOC1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 22:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIOC1O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 22:27:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D1340554
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 19:27:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 996781AB64E;
        Wed, 14 Sep 2022 22:27:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=MSTKScAjE1jgvgglO/U9CfeeY
        gvyxF2cHHTXQJ5gR8I=; b=JTS24okuvCVjc+kZIU/dfxyjBZnfLF9rDNLeiZJEh
        K1WRHrkEGYtKcFnQeXxXHQjV/NhO82dJEXbtZCkrw4rJNJnwdSu4r42TkJwzHYsv
        4DP+yUd2GNq3dzBjFQ4+Fp5dIwXkDxA5OHYBf9UHmR6uEbSUE5QhWeKAOixsAtoF
        Wk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91B491AB64D;
        Wed, 14 Sep 2022 22:27:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3E23A1AB64B;
        Wed, 14 Sep 2022 22:27:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     David Plumpton <david.plumpton@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] add -p: fix worktree patch mode prompts
References: <CAJXaddZwqGabdjmgc22eCYCdBw6nxcPbPfom26PwG3xvKEN93w@mail.gmail.com>
        <2463c4b9-313b-032f-9313-d1421f71f111@web.de>
Date:   Wed, 14 Sep 2022 19:27:07 -0700
Message-ID: <xmqqy1ulpe2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E6104850-349D-11ED-9D3A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> cee6cb7300 (built-in add -p: implement the "worktree" patch modes,
> 2019-12-21) added the worktree patch modes to the built-in add -p.
> Its commit message claims to be a port of 2f0896ec3ad4 (restore:
> support --patch, 2019-04-25), which did the same for the script
> git-add--interactive.perl.
>
> The script mentioned only the worktree in its prompt messages in
> worktree mode, while the built-in mentions the worktree and also the
> index, even though the command doesn't actually affect the index.
>
> 2c8bd8471a (checkout -p: handle new files correctly, 2020-05-27)
> added new prompt messages for addition that also mention the index in
> worktree mode in the built-in, but not in the script.
>
> Correct these prompts to state that only the worktree will be affected.
>
> Reported-by: David Plumpton <david.plumpton@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Patch created using --function-context for easier review.  Note that
> help_patch_text is already correct.

Thanks, both of you.

Queued.



>
>  add-patch.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 29f9456df3..33ecd8398a 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -188,22 +188,22 @@ static struct patch_mode patch_mode_checkout_noth=
ead =3D {
>  static struct patch_mode patch_mode_worktree_head =3D {
>  	.diff_cmd =3D { "diff-index", NULL },
>  	.apply_args =3D { "-R", NULL },
>  	.apply_check_args =3D { "-R", NULL },
>  	.is_reverse =3D 1,
>  	.prompt_mode =3D {
> -		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
> -		N_("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
> -		N_("Discard addition from index and worktree [y,n,q,a,d%s,?]? "),
> -		N_("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
> +		N_("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
> +		N_("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
> +		N_("Discard addition from worktree [y,n,q,a,d%s,?]? "),
> +		N_("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
>  	},
>  	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk=
 "
>  			     "will immediately be marked for discarding."),
>  	.help_patch_text =3D
>  		N_("y - discard this hunk from worktree\n"
>  		   "n - do not discard this hunk from worktree\n"
>  		   "q - quit; do not discard this hunk or any of the remaining "
>  			"ones\n"
>  		   "a - discard this hunk and all later hunks in the file\n"
>  		   "d - do not discard this hunk or any of the later hunks in "
>  			"the file\n"),
>  };
> @@ -211,21 +211,21 @@ static struct patch_mode patch_mode_worktree_head=
 =3D {
>  static struct patch_mode patch_mode_worktree_nothead =3D {
>  	.diff_cmd =3D { "diff-index", "-R", NULL },
>  	.apply_args =3D { NULL },
>  	.apply_check_args =3D { NULL },
>  	.prompt_mode =3D {
> -		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
> -		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
> -		N_("Apply addition to index and worktree [y,n,q,a,d%s,?]? "),
> -		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
> +		N_("Apply mode change to worktree [y,n,q,a,d%s,?]? "),
> +		N_("Apply deletion to worktree [y,n,q,a,d%s,?]? "),
> +		N_("Apply addition to worktree [y,n,q,a,d%s,?]? "),
> +		N_("Apply this hunk to worktree [y,n,q,a,d%s,?]? "),
>  	},
>  	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk=
 "
>  			     "will immediately be marked for applying."),
>  	.help_patch_text =3D
>  		N_("y - apply this hunk to worktree\n"
>  		   "n - do not apply this hunk to worktree\n"
>  		   "q - quit; do not apply this hunk or any of the remaining "
>  			"ones\n"
>  		   "a - apply this hunk and all later hunks in the file\n"
>  		   "d - do not apply this hunk or any of the later hunks in "
>  			"the file\n"),
>  };
> --
> 2.37.2
