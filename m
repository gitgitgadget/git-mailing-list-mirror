Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB180C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 19:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjB0Tjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 14:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjB0Tj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 14:39:29 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C6226CC3
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:38:49 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c6ce8d74so159338777b3.9
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdJZ/mDkNOxIzFMKHrfXjduh6F1wLwRvDGDlMoOchUk=;
        b=YmqOvd4MLVH8F+wGqMCV80T5Ydf38gzwCTEBPxIk6K2S49WcFHBZS8TX1dT+tZXTg5
         K2iRV0HZEt8qen4nqOIP1vs4dIGHPXj3fOpO6i5ExwM5hsW7VUSqilD5WefmQiSl7BfH
         T724fHFUEtFbaN0Ip+LlligYgWe4MlO5feHwSUH6CD5+zuXwjQFbh/FObg779FoXvMMX
         RADRW2kSOwOXbLSQFDsRyyL0A6YsDZMhCe2fSAfjY5f0Z0am5I6dAo7laB43TNBU9Uro
         75OUpD/zQSD1oordPQ6/K8NTArjxtxDKdZJJhZnxuVUk34afVum+Hm0wHSGMrbamz90K
         rIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kdJZ/mDkNOxIzFMKHrfXjduh6F1wLwRvDGDlMoOchUk=;
        b=keSSZkQwT1pHrv8aUUJ7pVAYlQXmTqfc0eJ1YLyxy3ZGM2547MbtVjI65MTtr05Hls
         oOV2h9Xt29C1pIM+/TmBX08I+xER92jAwBL4+M6taF/pnrxqP+fhMY+/Hz0oK+7iCqiR
         r69wuhlYErCsB/kaR82loZ51Hr7u1AxYlvba/H7G3A0p5br3Ji0y3GPdrvSYdo0hX74U
         8VCSNRUdeJmOfJ82AVXG/hSJaPzO8BppIrN8u1NqRXVPIOrsX4b4CN77z/4BtH8YjhBQ
         IJeDo4+aliEfouX02eYSR7oJscJ4ELB2eK0eFABBHtUjgJA2n7IMRcYwY32PYE8C6Jw6
         neAg==
X-Gm-Message-State: AO0yUKVk1ZlZWdxgIDy72yFqot9zjNITB98SpvcdCFykec9FZ3qySmU7
        mCIBN1foSz1TRLIR9SeysYv2tG3fGAglrg7iZey6
X-Google-Smtp-Source: AK7set+B4q/kzexqe7VnUcPlWw2n0tsdsueuKleUvBfSfExiq5Da+7dreEt16CxGkp7GJRVY9IQAG1vkg+7fow2nsIxa
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:e547:b66a:7a19:4376])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8284:0:b0:a4b:a813:46de with
 SMTP id r4-20020a258284000000b00a4ba81346demr5368883ybk.4.1677526721312; Mon,
 27 Feb 2023 11:38:41 -0800 (PST)
Date:   Mon, 27 Feb 2023 11:38:39 -0800
In-Reply-To: <76bac570-147e-7c74-c18c-1da88bc3d342@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227193839.2416545-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 2/3] branch: description for orphan branch errors
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?Rub=C3=A9n=20Justo?=" <rjusto@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firstly, the subject could be more precise. Maybe "branch: check all
worktrees for orphan branches" (47 characters) or something like that.

Rub=C3=A9n Justo <rjusto@gmail.com> writes:
> In bcfc82bd48 (branch: description for non-existent branch errors,
> 2022-10-08) we checked the current HEAD

Probably clearer to say "HEAD in the current worktree" instead of
"current HEAD".

> to detect if the branch to
> operate with is an orphan branch, so as to avoid the confusing error:
> "No branch named...".
>=20
> If we are asked to operate with an orphan branch in a different working
> tree than the current one, we need to check the HEAD in that different
> working tree.

Probably clearer to just say "But there might be orphan branches in
other worktrees".

> Let's extend the check we did in bcfc82bd48, to all HEADs in the
> repository, using the helper introduced in 31ad6b61bd (branch: add
> branch_checked_out() helper, 2022-06-15)

s/HEADs/worktrees/

> @@ -493,8 +496,9 @@ static void copy_or_rename_branch(const char *oldname=
, const char *newname, int
>  	struct strbuf oldsection =3D STRBUF_INIT, newsection =3D STRBUF_INIT;
>  	const char *interpreted_oldname =3D NULL;
>  	const char *interpreted_newname =3D NULL;
> -	int recovery =3D 0;
> +	int recovery =3D 0, oldref_usage =3D 0;
>  	struct worktree **worktrees =3D get_worktrees();
> +	struct worktree *oldref_wt =3D NULL;

Better to have 2 variables (one for rebased, and one for bisected) to
avoid the situation in which the last problematic worktree seen was a
bisected one, but a prior one was a rebased one.

> @@ -818,7 +835,7 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
> =20
>  		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
>  		if (!ref_exists(branch_ref.buf))
> -			error((!argc || !strcmp(head, branch_name))
> +			error((!argc || branch_checked_out(branch_ref.buf))
>  			      ? _("No commit on branch '%s' yet.")
>  			      : _("No branch named '%s'."),
>  			      branch_name);
> @@ -863,7 +880,7 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>  		}
> =20
>  		if (!ref_exists(branch->refname)) {
> -			if (!argc || !strcmp(head, branch->name))
> +			if (!argc || branch_checked_out(branch->refname))
>  				die(_("No commit on branch '%s' yet."), branch->name);
>  			die(_("branch '%s' does not exist"), branch->name);
>  		}

What is the relevance of these changes?

