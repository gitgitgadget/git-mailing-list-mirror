Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E8FC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 16:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjBFQ6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjBFQ6t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 11:58:49 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D6298FC
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 08:58:44 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e22so6733151ejb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 08:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aw+ZEGiew/XC9Sj6maqwZ5b3ZpNPhLOcljXY28UQtvQ=;
        b=myHDbpPLk+0agxSRJA/j6ThMmOc/9XKM9R4xiXmnuoGwGm2l5Sxkzj3Z7ujYrDB5mj
         174idF9Cpq3t4l4vUcEjLLPgGF3vIM6nNvOGpKCgmW3ZLqftAuepB6bEnOLm+9mFvR/1
         qfUKJr5rqTda30tZrbh795PCQPyJg+clDPRaiWtuD1H+VMFSCuLZ+AHGYFKj9UTstMUx
         liDt6uReiHimLe0/shlUgUJfaMmjeEUmTnR2xQ63GYkoWfptrWqJEHPIXDBtulk/oKcC
         7hJhCbFK/rHvGR1XAMf+1hrn49JnQ8Zx1v7Z1NNH3b5BVboksyVobv6IC01yEx+NCQu3
         24qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aw+ZEGiew/XC9Sj6maqwZ5b3ZpNPhLOcljXY28UQtvQ=;
        b=3212LRmnuK0NNLZOLnkrVACO0/KeGxRUrtyy075xLEAq1DcyrMjGHt+aSdKe2U0nCh
         NpWBnJrIOZPuCSz1a4CVpmO9rfoMG+vRx+6hsvNk+/73GOzQWYeC2UtMv4J9E0mLCu/c
         FGVHz0r9vtOCrVM0dXBei26ULV80Q13vDyzCrDM1KjrPq+3GpSShFAfo5IWJya5XC80h
         0U41J6Xt6Q7XPM5XOoHBnWxhXV+vaqAWVjwQ0py5WLMD6JVf42xV5caa3tskgMdCqYNQ
         ICgy7Q7FcXzmeE7G7spJPcxiuxxjml0xMVR20O6z9AJNL9OB5r0Qiy3avnhIvktHW5tQ
         hGnQ==
X-Gm-Message-State: AO0yUKWl7amQt9k0aEw4Ktn4E26/UJMDVQxDy1xJr+eFDFnx45JhSA7b
        8g+5MCDwRY+bOZTLTTH593Y=
X-Google-Smtp-Source: AK7set8vu5PLcZ2zBNdgcRzIizlu2s8ST/eyCwTu+2uyoWx1+DaUIRBrg1iABFQhFQq+GkKUsB0qEg==
X-Received: by 2002:a17:906:b1d0:b0:88b:a30:25f0 with SMTP id bv16-20020a170906b1d000b0088b0a3025f0mr12531ejb.32.1675702723520;
        Mon, 06 Feb 2023 08:58:43 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id p2-20020a170906498200b00878803d4049sm5717289eju.93.2023.02.06.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:58:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP4pG-000QPi-1P;
        Mon, 06 Feb 2023 17:58:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 2/4] branch: fix die_if_checked_out() when
 ignore_current_worktree
Date:   Mon, 06 Feb 2023 17:56:55 +0100
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <8670d6c6-b5cd-a1e3-8fbf-b948cb687388@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <8670d6c6-b5cd-a1e3-8fbf-b948cb687388@gmail.com>
Message-ID: <230206.861qn27mt9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 05 2023, Rub=C3=A9n Justo wrote:

> -	wt =3D find_shared_symref(worktrees, "HEAD", branch);
> -	if (wt && (!ignore_current_worktree || !wt->is_current)) {
> -		skip_prefix(branch, "refs/heads/", &branch);
> -		die(_("'%s' is already checked out at '%s'"), branch, wt->path);
> +	for (int i =3D 0; worktrees[i]; i++) {

I see that there are existing "int i" for counting worktrees in
worktree.c, FWIW for new code I wouldn't mind if it's "size_t i"
instead, to make it future proof (and to eventually get rid of cast
warnings as we move more things from "int" to "size_t").
> @@ -435,10 +435,9 @@ const struct worktree *find_shared_symref(struct wor=
ktree **worktrees,
>  					  const char *target)
>  {
>=20=20
> -	for (int i =3D 0; worktrees[i]; i++) {
> +	for (int i =3D 0; worktrees[i]; i++)
>  		if (is_shared_symref(worktrees[i], symref, target))
>  			return worktrees[i];
> -	}

You added this function in the last commit, let's just skip adding the
braces to begin with, rather than this style-fix after the fact.
