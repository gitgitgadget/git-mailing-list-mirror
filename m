Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B71C27C76
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 01:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjAVBu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 20:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAVBu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 20:50:57 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5851F90F
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:50:56 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z4-20020a17090a170400b00226d331390cso8280370pjd.5
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri6Ild9+iOgmuAu5/Gkz/BUWY/K184a0frLtl8bZhww=;
        b=KWRsVVtj3orerHHrLX5+2uKJjHprMmilQkNcSAI1ZSfLPGSkzYVyMj/sTFRhjUTgEX
         pF61bsonVTmfRGiyztD+ntnURPgrYzdjTBNZzoVKHsx/xrHwyC3itDG7rUIqeHrOWltA
         34KU8Pz8o30Xnwr9Hh0JMhpfz/mjgOzAVC1I92vR/V+KS8EyzJrhBEcQf/0TPXDDl/U9
         PAckWG3Kre0aeRyBKHp+yApn6yee69JL3DQRjcdhVYZCXmAiYDa98Z8g/gGj3f2+d9Fq
         p43B7JTV+hkSXUywSlN58yQVkciTNJ7OJ30ov56Z6GO8xW4KZkXPBZDk2T8cdcHLKZbZ
         qqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri6Ild9+iOgmuAu5/Gkz/BUWY/K184a0frLtl8bZhww=;
        b=3HKU6eoliIsc0LPouXUvw1ztU91EY5UiGY53koPo0i3YfsMz8M5NeYKUGRMx+FE7rh
         hmXxaP+LhihwdcnHkQcvJ4uLsKwb64IS/xKFKPRlo/DamO5D9LMt/Hs6MqHvMRJ7Shtm
         TGsgGg1yDxoNaHuuG5m3yhDeVmadYuRXN1hgosG+5AXyXB0Iggt2DRua7Y/cDDJzmF4G
         fZ0FRsiiTI7Y+XSbmPOrpZ8qAYzyWNzqNH5hNp1SXaIvYiMBxojg1d8zjehmfhYVXWQ4
         BERXeUDzPJ/LLDhqCSVYkCVWGw2Bngt3MqVTml5niQRXKIOCwZc/kjKAcTntxb6X46lr
         IjpQ==
X-Gm-Message-State: AFqh2krDD2SZ3r71UylC922FISO32uL79Q0Cb6gnsRx1+Z4+XOpEsjvg
        sxPEO3RN4jr6H4BODeFPnI7wWTl9hLw=
X-Google-Smtp-Source: AMrXdXvxSyzUyzsF0WlX3wnTbHU8U+sXF6g2tlONC0GvAJJMdRbMOpPly6M9ZCV64XQ8NLv6Hyux3A==
X-Received: by 2002:a17:90b:3802:b0:229:ffd4:b0ca with SMTP id mq2-20020a17090b380200b00229ffd4b0camr10283103pjb.17.1674352255914;
        Sat, 21 Jan 2023 17:50:55 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id mt19-20020a17090b231300b0022704cc03ebsm4058020pjb.41.2023.01.21.17.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 17:50:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/3] branch: fix die_if_checked_out() when
 ignore_current_worktree
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
        <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
        <17f267b1-7f5e-2fb6-fb14-1c37ec355e65@gmail.com>
Date:   Sat, 21 Jan 2023 17:50:55 -0800
In-Reply-To: <17f267b1-7f5e-2fb6-fb14-1c37ec355e65@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sun, 22 Jan 2023 02:23:53 +0100")
Message-ID: <xmqqbkmruykg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Let's stop using find_shared_symref() in die_if_checked_out(), to handle
> correctly ignore_current_worktree.

This says what the code stops using, but does not say what it uses
instead.

Factoring is_shared_symref() out of find_shared_symref() is probably
a good idea that can stand alone without any other change in this
patch as a single step, and then a second step can update
die_if_checked_out() using the new function.

As the proposed log message explained, updating die_if_checked_out()
with this patch would fix a bug---can we demonstrate the existing
breakage and protect the fix from future breakages by adding a test
or two?

Other than that, it looks like it is going in the right direction.
Thanks for working on the topic.

> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>  branch.c   | 16 +++++++++++-----
>  worktree.c | 54 +++++++++++++++++++++++++++++-------------------------
>  worktree.h |  6 ++++++
>  3 files changed, 46 insertions(+), 30 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index d182756827..2378368415 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -820,12 +820,18 @@ void remove_branch_state(struct repository *r, int verbose)
>  void die_if_checked_out(const char *branch, int ignore_current_worktree)
>  {
>  	struct worktree **worktrees = get_worktrees();
> -	const struct worktree *wt;
> +	int i;
> +
> +	for (i = 0; worktrees[i]; i++)
> +	{

Style.  WRite the above on a single line, i.e.

	for (i = 0; worktrees[i]; i++) {

Optionally, we can lose the separate declaration of "i" by using C99
variable declaration, i.e.

	for (int i = 0; worktrees[i]; i++) {

> diff --git a/worktree.c b/worktree.c
> index aa43c64119..d500d69e4c 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -403,6 +403,33 @@ int is_worktree_being_bisected(const struct worktree *wt,
>   * bisect). New commands that do similar things should update this
>   * function as well.
>   */

The above comment is about find_shared_symref() which iterates over
worktrees and find the one that uses the named symref.  Now the
comment appears to apply to is_shared_symref() which does not
iterate but takes one specific worktree instance.  Do their
differences necessitate some updates to the comment?

> +int is_shared_symref(const struct worktree *wt, const char *symref,
> +		     const char *target)
> +{

What this function does sound more like "is target in use in this
particular worktree by being pointed at by the symref?"  IOW, I do
not see where "shared" comes into its name from.

"HEAD" that is tentatively detached while bisecting or rebasing the
"target" branch is still considered to point at the "target", so
perhaps symref_points_at_target() or something?

>  const struct worktree *find_shared_symref(struct worktree **worktrees,
>  					  const char *symref,
>  					  const char *target)
> @@ -411,31 +438,8 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
>  	int i = 0;
>  
>  	for (i = 0; worktrees[i]; i++) {

Not a new problem, but the initialization on the declaration of "i"
is redundant and unnecessary.  Again, we can use the C99 style, i.e.

	const struct worktree *existing = NULL;
-	int i = 0;
-
-	for (i = 0; worktrees[i]; i++) {
+	for (int i = 0; worktrees[i]; i++) {

> +		if (is_shared_symref(worktrees[i], symref, target)) {
> +			existing = worktrees[i];
>  			break;
>  		}
>  	}
> diff --git a/worktree.h b/worktree.h
> index 9dcea6fc8c..7889c4761d 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -149,6 +149,12 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
>  					  const char *symref,
>  					  const char *target);
>  
> +/*
> + * Returns true if a symref points to a ref in a worktree.
> + */

Make it clear that what you called "a ref" in the above is what is
called "target" below.

> +int is_shared_symref(const struct worktree *wt,
> +		     const char *symref, const char *target);
> +
>  /*
>   * Similar to head_ref() for all HEADs _except_ one from the current
>   * worktree, which is covered by head_ref().
