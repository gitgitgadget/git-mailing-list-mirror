Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E18C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 12:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CD12075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 12:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="FTrrldF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbgAXMpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 07:45:40 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:36470 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387574AbgAXMpj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 07:45:39 -0500
Received: by mail-il1-f170.google.com with SMTP id b15so1470711iln.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 04:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CanvjNJxMT1LGjzqNHri7BCENT3jhzR0SX727yXglwE=;
        b=FTrrldF4bJ6ai/sbo8p+TQti9oJY/bZxKfqKomdBPKlSLKK34NABOgq71IV7z4ORVo
         xEW/eRSaaOnfwvqAT9eS16Fc5p22ee86qKRuBVFTDlUrp1Lj9pLU1zuBSIZ4Gr/pz81e
         t29MQ6wtFY2UEvu9Hu6u9SsNsR+UsoZHg1owQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CanvjNJxMT1LGjzqNHri7BCENT3jhzR0SX727yXglwE=;
        b=f5bl0ESTBkdv5+ISsdk0FMh84mgu8x3OtOzSlS4x1TrsyoDOJHq40/70gF3gSLuz9b
         U/8z92tBSOGurXNrvkxp/jI1wd9E8LEPedB+PeuKozpIDv7D+gq1LQPrQnG1yQG52YQo
         qZ7xEmKnsR8QFjrX5FD9qLg0pzU98OI+38KVT5YP6AjMRLeOdFxwqlL3Oqr9U9HPXnvd
         97wFYejUKd386XFwHLX8a9bTaF+SyONre8WZJlROqbhevMkSvQwZNjv6S0rVKxUgls6v
         5WHX4Ni61UaW0uylyk+kSHpz/3ncBzdR311nkmpdRRoY+p/ouW54aO8s1huMer3AWLPO
         HfEA==
X-Gm-Message-State: APjAAAVrWSyQNgwtELwhel5RdHiv25XzRMTl45dfDn+Z7noKULqneLmM
        Nl1oSzM3gIBrIOhixI4ShDQiz0qNgzxhDSIC8vr/29Quzto=
X-Google-Smtp-Source: APXvYqzNIRPD11JEJjj5JCarHnossEvQ8hUoCezQgoBjlwZLpkZCS+yrsSfCx4mufO1UcWOPc6/Wa0lbRFeudErdPeU=
X-Received: by 2002:a92:51:: with SMTP id 78mr2912216ila.121.1579869938999;
 Fri, 24 Jan 2020 04:45:38 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?David_Burstr=C3=B6m?= <davidburstrom@spotify.com>
Date:   Fri, 24 Jan 2020 13:45:28 +0100
Message-ID: <CAA-mk2_jB2X1J-NCXQ92spa-fmEct9G9f1iQo7t8=rvD5coFDA@mail.gmail.com>
Subject: Bug or unexpected behaviour in git show <rev>:a\b
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

As part of some experiments on running git on Windows, I found
something unexpected. If I use e.g. bash to run the following in a
repository:

git show HEAD:a\\b

the command stalls for a short while and then exits with 0 and prints
nothing on stdout. I've verified this on git 2.25.0 and 2.21.0. I
would have expected either "fatal: Path 'a\b' does not exist in
'HEAD'" or something of that nature. Nothing in "man git revisions"
hint that backslash is treated specially. Is this a bug or is it an
undocumented feature?

Best regards,
  David Burstr=C3=B6m
