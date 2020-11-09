Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7B1C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 20:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A996206E3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 20:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CbytwKO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgKIU76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 15:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIU76 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 15:59:58 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2EC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 12:59:58 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s5so6865224qkj.21
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 12:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TVaTMMWjAQShbKY/w22aloKz+XdMSeuSu3hT3ljL03o=;
        b=CbytwKO3OKfTYQdLiAT8pHEM042L/eIlzDW7PQOR53clZXx1SUJ5NUGuZdbD8Z0FIX
         ti1TsAohaDdAPYH0rDGYsA+vtRet39RZ4qgf+ZU1n2LT7Nx4n+03Dr6aZayRPlzJHR9j
         PRsq6zwjuV34CN4h4Zo+0VXGq0WhkJur94/tmtJHsi54tSwdH+knprQCpg5h11fgCgHP
         +yEBYzq/PHHV2/UTgMgbF1WAXQHyM04PvWWfJx96J0JkyeOp4NNcLASNntCmlIPe/RGp
         /NiquRZxIH135knl1pWzWwplDFNVDvcM6YLL4idZAxhvpeDopv/GaDNO7xkUkSBoMMIO
         QM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TVaTMMWjAQShbKY/w22aloKz+XdMSeuSu3hT3ljL03o=;
        b=PezHy7ytAinkmsqBQToTyUX4ef6EQ3hAC/Z54AbQyOEmxkHpeDdvRB6J5WVOTyQdx5
         YVFYWJBx7qlDpj9/y2ILu90YoSMKqKNoYBvuLq2Rfw8o9McmRai1dGjGSCnmTtzRTnvo
         2uMf0jpb8tDeRkoD5Svd8nYf3RSalP3uVpTAN/GVTO12uWosIQ6+5tBklGvbwxigxr5d
         Vu3OcpgEIThvaE8aER34oFXgCdOGjuYpmVLWx/vAs8URphelhN68VCV0l4JeHzTVRciv
         16NVU+57C+/BOV9T61BSp7+lGJ6h+fYdmBGL4UP1YTQNSwVArgo7NNC94qm71J157cLI
         n5nQ==
X-Gm-Message-State: AOAM531aUsqE7E28hDwcGi61CkBYFsyogkjmap9CdPftXrV5G3ZoypGa
        ifUOBV0RuN1vU2gGRYiYobZDFG/v5jGlngdp0sv2
X-Google-Smtp-Source: ABdhPJwSoKYEWJ/zVez27jkUhMSE0wGOndvYTqw6G1RxyyGh3CzecHCE4zQVj8nN7T80Hi7zMWyP/t1k7Xza92i4/dXi
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:f7cb:: with SMTP id
 f11mr16590472qvo.34.1604955597281; Mon, 09 Nov 2020 12:59:57 -0800 (PST)
Date:   Mon,  9 Nov 2020 12:59:55 -0800
In-Reply-To: <CABPp-BFkAu6oO5V0jRh=ExuPxBXma1F17zaq-zEaqMagc72Ccw@mail.gmail.com>
Message-Id: <20201109205955.2523889-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BFkAu6oO5V0jRh=ExuPxBXma1F17zaq-zEaqMagc72Ccw@mail.gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH v2 06/20] merge-ort: implement a very basic collect_merge_info()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > +     unsigned mbase_null = !(mask & 1);
> > > +     unsigned side1_null = !(mask & 2);
> > > +     unsigned side2_null = !(mask & 4);
> >
> > Should these be "int"?
> 
> Does the type matter, particularly since "boolean" isn't available?

It doesn't, which is why I would expect the most generic type - if I see
something else, I would be led to think that there was a specific reason
for choosing that. But if I'm in the minority, that's fine.

> > I thought that this was written like this (instead of inlining the 2
> > double-quotes) to ensure that the string-equality-is-pointer-equality
> > characteristic holds, but I see that that characteristic is for
> > directory_name in struct merged_info, not current_dir_name in struct
> > merge_options_internal. Any reason for not inlining ""?
> 
> You're really digging in; I love it.  From setup_path_info(), the
> directory_name is set from the current_dir_name:
>         path_info->merged.directory_name = current_dir_name;
> (and if you follow where the current_dir_name parameter gets its value
> from, you find that it came indirectly from
> opt->priv->current_dir_name), so current_dir_name must meet all the
> requirements on merge_info's directory_name field.
> 
> Perhaps there's still some kind of additional simplification possible
> here, but directory rename detection is an area that has to take some
> special care around this requirement.  I simplified the code a little
> bit in this area as I was trying to break off a good first 20 patches
> to submit, but even if we can simplify it more, the structure is just
> going to come back later.

Ah, I see.
