Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49B3C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC68650C2
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhCDBzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhCDBz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 20:55:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2318EC061574
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 17:54:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a63so29115747yba.2
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 17:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=TWisgQJbXiSX2kIjS7RVcTZdThISbokfurh+xwzt6T0=;
        b=X4sk9m5r710Qh2niFjt13q3qKoydb6Xj8qpI4bU/5kNr/UNwI3iK5UdJlSr8y2UTuY
         ioDRg8XiCmSsPIYGgApnxqKzATLiprEoaubxTidPyzjEsEp3A/zaAVQ4pXRLKr2PGeO8
         qrlA3h9+gq3h/FnKtWcgCzXZIQtT7XF+5nwy1L27YuGPp/TAnRQZ8EJNmGW3EPLDtSfx
         YiyBAPwdg9PW1PJxFXIxzfYtYzHwYfjqiBUxWtLe4xvdSB0aha8SfnC0XRy2pBAB+5Bb
         m21I/UPopcgkjAN3o1BVtvCeGdh2/mI9tWKPw73Be2S47duBJIO9iAoosbn6vUugxTZ/
         zOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=TWisgQJbXiSX2kIjS7RVcTZdThISbokfurh+xwzt6T0=;
        b=XA+D+gxfv9/2eWFB9o2HEWph5CcdKsm+g15VG2Q6wJ2v9IB3UAW4n5oOZ2hbZIsUpp
         MJYXwlalE0Wb7PqpfLAPvE5sdhDUMr0Usv4cTjHG6soHJNFo/8OLsoEEqQLjSQtP1eCg
         fsKMEPPVHaPFRDkscMcoLy2mrTOlRIkZexVdZwoWZuAMIy9kTYBaTPhyw7nsR1cMX3aP
         k7pOm+K2brZ21hdljW9dVI++XZzzhxkVIZ1dyRAijv5CgMUwnEcxitpi+uFSKYCEdFEL
         9N5vJt00ESZ05hmYlDksjyrSUmpd9YRjKwuscxueoJ3rj1g2UHQHY4k2hii9bFEjhSvu
         FBDg==
X-Gm-Message-State: AOAM531XdRiHAWbJk+nsAbBazH00vD+7/aoxCeanfQFWoKHkkgDKykdy
        12hn9ZzEoDTtdDZ7bOdeLy7RZcIo4wANS6CyzdcW
X-Google-Smtp-Source: ABdhPJz0usETbD2iWAV4UgfUAC7R3pv3zlJ81mMZZ3AHMamWoMGrNJPRCGrzoLDNyf07p6QOWc4RxjnLp3cla9xmqYfj
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:4643:: with SMTP id
 t64mr3283647yba.44.1614822887374; Wed, 03 Mar 2021 17:54:47 -0800 (PST)
Date:   Wed,  3 Mar 2021 17:54:44 -0800
In-Reply-To: <YD6Ly6EIcz4PT6uB@nand.local>
Message-Id: <20210304015444.1801419-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YD6Ly6EIcz4PT6uB@nand.local>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v2 04/15] builtin/multi-pack-index.c: split sub-commands
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, avarab@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Mar 01, 2021 at 08:06:25PM -0800, Jonathan Tan wrote:
> > > +static char const * const builtin_multi_pack_index_write_usage[] =3D=
 {
> > >  #define BUILTIN_MIDX_WRITE_USAGE \
> > >  	N_("git multi-pack-index [<options>] write")
> > > +	BUILTIN_MIDX_WRITE_USAGE,
> > > +	NULL
> > > +};
> >
> > I think this way of writing is vulnerable to confusing errors if a
> > missing or extra backslash happens, so I would prefer the #define to be
> > outside the variable declaration.
>=20
> Yeah, I can't say that I disagree with you. Of course, having the
> #define's outside of the declaration makes the whole thing a little more
> verbose, which isn't a huge deal.

I think it's the same verbosity - you just need to move the lines?

> But I was mirroring what =C3=86var was doing in the sub-thread he started=
 at:
>=20
>     https://public-inbox.org/git/20210215184118.11306-1-avarab@gmail.com/
>=20
> Unless you feel strongly, I think that what we have isn't so bad here.

Yeah I don't feel that strongly about it.
