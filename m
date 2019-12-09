Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CCDC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E0A207FF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyNJI42u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLIPtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:49:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50499 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbfLIPth (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 10:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575906576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OkuYZKI0tTsp2HOTuPLVQqvXgsAteiDEFqSjIaTJFgU=;
        b=gyNJI42ucFEf9qaQzaiu07ovPPlzOoo1TkcjoAu3T4FrvNMaIKuTQA2+BmnzJUx2k/7OMi
        C842gDG/67XNcRnFYE1iaPlRiy9o4NBqlQbxnBXGvRzmCYqhUEJtuBvvA/SsBwWx1X3cgB
        0PueIjInLj6HZsFCtt1Gd7ffvvFAZTw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-YAykxBOcMEe0DzSdwdApOg-1; Mon, 09 Dec 2019 10:49:35 -0500
Received: by mail-qv1-f71.google.com with SMTP id w13so4877522qvb.4
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 07:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2u2wKC7jg2tqi2z1Pq6p4hJkcn+P/bGzPFhGTpaDcRI=;
        b=GCQ4KdPwl+e61GurFKwydyYtVeyOknmQJnkHK96IqafsZml4bDwiS9q3fvhV2z2GCi
         mVdzP9ZhHSguYnP/Qrdf6E+/BKI4N8zSHS6fZ2SDA1Qq/SxBuou5mh7oDHfa2F08NKZh
         YGYJogMIzxDx4ZK1oq3r5SVwyf+RLqALUsOMJfcUiITgV3DNaUSwyZEyQBySVWS4J/bo
         NGEkAaFR5kkHuJQC+PsmMQWwlPe5OA/0JSdxWtMCF4xI/C3kW+KolMWhbSTbilP5gLLs
         K2NXmfSVl6wfsGkDCJATufQaj9EivuoWxH5IymT8YKxeb8HLOvrjC+YZ+Yh3jiGGyWQh
         /kCw==
X-Gm-Message-State: APjAAAV1zELP4GpeAaCAd9et2ckI1ay6pScetlJH/GEDwnUcm1TirWNq
        FXIp9M+d1vZbfgTC1Ro2jyqCaz4+roeSQhjOKxFUbgUZxjlwcVTa2pMskehZt5gpY604GkkqG8+
        mXfvIhRu9Tvu8
X-Received: by 2002:a05:620a:a1a:: with SMTP id i26mr26936887qka.383.1575906574581;
        Mon, 09 Dec 2019 07:49:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQOnWnmVqcUnTxKmzBhCC0Uya7zVkKyW9CGJqvgA2OshY9gFl07r94O+l6b9K67U77qkcZuQ==
X-Received: by 2002:a05:620a:a1a:: with SMTP id i26mr26936862qka.383.1575906574231;
        Mon, 09 Dec 2019 07:49:34 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id f21sm3818109qto.82.2019.12.09.07.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 07:49:33 -0800 (PST)
Date:   Mon, 9 Dec 2019 10:49:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] contrib: git-cpcover: copy cover letter
Message-ID: <20191209102727-mutt-send-email-mst@kernel.org>
References: <20191203201233.661696-1-mst@redhat.com>
 <20191204044449.GB226135@google.com>
MIME-Version: 1.0
In-Reply-To: <20191204044449.GB226135@google.com>
X-MC-Unique: YAykxBOcMEe0DzSdwdApOg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 03, 2019 at 08:44:49PM -0800, Jonathan Nieder wrote:
> Hi,
>=20
> Michael S. Tsirkin wrote:
>=20
> > My flow looks like this:
> > 1. git format-patch -v<n> --cover-letter <params> -o <dir>
> > 2. vi <dir>/v<n-1>-0000-cover-letter.patch <dir>/v<n>-0000-cover-letter=
.patch
> >
> > copy subject and blurb, avoiding patchset stats
> >
> > 3. add changelog update blurb as appropriate
> >
> > 4. git send-email <dir>/v<n>-*
> >
> > The following perl script automates step 2 above.
>=20
> Neat.  I wonder, should "git format-patch" learn an option for this?
> E.g.
>=20
> =09git format-patch -v<n> --cover-letter \
> =09=09--last-cover-letter=3D<dir>/v<n-1>-0000-cover-letter.patch \
> =09=09-o <dir>
>=20
> What would your ideal interface for this flow look like?

I use it in several ways
- new version - generate a new version from previous one
=09git format-patch -o patches/series ....
=09git cpcover patches/series/saved-cover-letter.patch patches/series/vN-co=
ver-letter.patch

=09So ideally it would automatically pick up vN-1 cover letter if it's ther=
e.

- update - I generate patches but don't post yet.
=09write a cover letter with e.g. an explanation, decide
=09to make some changes before posting. Then:
=09cp patches/series/vN-cover-letter.patch patches/series/saved-cover-lette=
r.patch
=09git format-patch -o patches/series ....
=09git cpcover patches/series/saved-cover-letter.patch patches/series/vN-co=
ver-letter.patch


=09So ideally if cover letter already exists, ask whether to copy it.
=09or at least whether it's ok to over-write it...

- series history
=09I start with a non-versioned cover letter,
        and maintain it in a directory:
=09cp patches/series/0000-cover-letter.patch patches/series/cover-letter.pa=
tch
=09This is where
=09I then put notes about design changes, list questions
=09to be answered, add people who contributed
=09to the discussion and should be Cc'd on new versions
=09Then each time I do
=09git format-patch -o patches/series ....
=09git cpcover patches/series/cover-letter.patch patches/series/vN-cover-le=
tter.patch
- public-inbox
=09get series from public inbox (from someone else
=09or myself) and work on it

=09Ideally if cover-letter without a version exists, pick it up.

During all of this, it's important to pick up description, subject, to/cc.

Also one thing I need to remember to do is update changelog.

If there's a standard way to document version changes, ideally it will
be possible to check whether latest version changes have been
documented, and print a reminder if not.


> [...]
> > Any feedback on this? Interest in taking this into contrib/ for now?
>=20
> I don't know what Junio's preferences are for new contrib/
> contributions, but I kind of like it.  If putting it in contrib/, my
> main advice would be to put it in a subdirectory there with a README.
> That way, we have a good place to document what it was replaced by
> once it has graduated to a standard format-patch feature.
>=20
> Thanks and hope that helps,
> Jonathan

OK so contrib/format-patch/ ?

--=20
MST

