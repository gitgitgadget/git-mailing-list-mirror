Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C4CC77B7C
	for <git@archiver.kernel.org>; Mon,  8 May 2023 02:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjEHCIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 22:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjEHCIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 22:08:40 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133714E62
        for <git@vger.kernel.org>; Sun,  7 May 2023 19:08:39 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ab0967093dso124807a34.3
        for <git@vger.kernel.org>; Sun, 07 May 2023 19:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683511718; x=1686103718;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5CZ+44rwWCnXtCh2m6AfqwiiUoFti6qhtm4K24QjL0=;
        b=ZKMfZudHspNCbJFdJyWpbdWNPGyvtlH4IUg0lj1i5Bsx4aTdj+VDI0CrW1vnKXMk68
         ZaDPKhlBV35fdlBlsM48EgNlPhJrjZ6l8EetakkTd3LeL47Xt8/LiFH2QM/ipRKkOroP
         Kbg9VFdDvHhbSaebIT4ezNZdd48aPHeqfVMtB1ixz6oaEoKycoVYrh8CYBIlJ+CGbi+B
         Xp/ejmDiRaCqTfiO8sUv/Zwed3dfIQLAfLzwyg7GwEALyzix7QGfySRrOPp2lcXva91G
         O0TZ7s74zVneHjIEPIw7ezpIDsLx0Nn5KD6JhnPvTmWyFFQB7WOTi6v4jOIUJjztpb9H
         Egaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683511718; x=1686103718;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B5CZ+44rwWCnXtCh2m6AfqwiiUoFti6qhtm4K24QjL0=;
        b=T51SjOcC0SjToesszIA68fUssJzQK3yWjppi9pSDEfXU0+6Fc/AHAc0gD+0gQ8NBKm
         KEk6qywgSF9VquaB1RqOe9QoSp2ORs2CH3Ls/E1+YaJhQx0HRBAd5Fmw0DTyyPVzFbbS
         UsJnpyyBu2P7DP/nseUd16WWRQwmgDL6t2Lr6U6XocFXQVlh4Rq3e3UG2Wa6s0Z4vKF2
         BnRqW5Wkg44zwi7dH7C4c6+/21ILBpaAd+fDrV9gtYg37YrLHTNZh/kj1ssbpX9jqlaP
         I4TcWngFW5XGU3TE7zFVyag0azqC+XQR7GMDPt/n5egf+Dr+UW1GOo7uYiNhCablY1IG
         xg0Q==
X-Gm-Message-State: AC+VfDyKNNZQ/RDYLuu8pCZieSroX0T8TbNSNrmYxe0N4YJtlaJD3dqr
        BxWTsHAS7Tl2obMWj807K3s=
X-Google-Smtp-Source: ACHHUZ4QDnMkjVN5XTavufqLqJxsIbPVYBotYQj1ZY+El0Xsa/Kw9wFuYPHYQJnasjeMhg/1kVXwDw==
X-Received: by 2002:a05:6871:6b90:b0:17a:cbf2:a4c7 with SMTP id zh16-20020a0568716b9000b0017acbf2a4c7mr4376462oab.27.1683511718428;
        Sun, 07 May 2023 19:08:38 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id b1-20020a05687061c100b0018b22156e84sm4469118oah.38.2023.05.07.19.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 19:08:38 -0700 (PDT)
Date:   Sun, 07 May 2023 20:08:37 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Message-ID: <645859a541f23_4e612944b@chronos.notmuch>
In-Reply-To: <xmqq8re3inn4.fsf@gitster.g>
References: <20230503232349.59997-1-felipe.contreras@gmail.com>
 <xmqq8re3inn4.fsf@gitster.g>
Subject: Re: [PATCH] doc: doc-diff: specify date
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Otherwise comparing the output of commits with different dates generates
> > unnecessary diffs.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/doc-diff | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Ahh, it is a fix for a fallout from 28fde3a1 (doc: set actual
> revdate for manpages, 2023-04-13); when it is shown in the patch
> form like this, it is kind of obvious why we need to compensate for
> that change this way, but apparently "doc-diff" slipped everybody's
> mind back then when we were looking at the change.

Yes. doc-diff is an odd duck, because it can't be easily integrated to
the testing framework.

Sometimes a diff in the documentation is intentional, so the fact that
doc-diff generates an output from HEAD~ to HEAD is precisely what was
intended. However, sometimes it's not. Maybe a flag inside the commit
message such as GitHub's `[no ci]` might help, but it's beyond me how
could that be cleanly integrated to continous integration machinery.

For now doc-diff is meant to be run manually, therefore it's expected
that some unexpeced diffs are inevitably going to slip by, and more
relevantly: issues in doc-diff itself are going to slip by.

> Looking at the patch text of 28fde3a1, we pass GIT_VERSION and
> GIT_DATE to AsciiDoc since that version.  We were already covering
> GIT_VERSION by hardcoded "omitted" string, and now we compensate for
> the other one here, which means this change and the other changes
> complement each other, and there shouldn't be a need to further
> adjustment for that change around this area.  Looking good.

Yes. I think we should be passing a semi-real version instead, like
`0.0.0`, just to see how a real version would look like, but that's
orthogonal.

> > diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> > index 1694300e50..554a78a12d 100755
> > --- a/Documentation/doc-diff
> > +++ b/Documentation/doc-diff
> > @@ -153,6 +153,7 @@ render_tree () {
> >  		make -j$parallel -C "$tmp/worktree" \
> >  			$makemanflags \
> >  			GIT_VERSION=omitted \
> > +			GIT_DATE=1970-01-01 \
> >  			SOURCE_DATE_EPOCH=0 \
> >  			DESTDIR="$tmp/installed/$dname+" \
> >  			install-man &&
> 
> I wonder what the existing SOURCE_DATE_EPOCH was trying to do there,
> though.

I also wondered the same, but again: orthogonal.

Cheers.

-- 
Felipe Contreras
