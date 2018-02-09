Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A07A1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBITuz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:50:55 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:38773 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBITux (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:50:53 -0500
Received: by mail-pg0-f52.google.com with SMTP id l18so4282590pgc.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/6gP57UG+I00YgaF/Zkk5E5QDgBacW0Ih2c5I7lD5o=;
        b=Fys5oK5Uq6DSwk2NmAu3JNrm3dVt28EeYHvAdFNOysq8brmlhu+tTnbrVmJN02MMUm
         Jp89Lp9KonloCDfhfxeQRpBztCckOv2a6a4j5TmTINedc2vC7AQ9WMh4W9s/1o/M0/i0
         ua4XVYkVzm7Xen8KZmRFclvX0LMTKmZO7VXWTP2WoE/zZqNBdP5T5ApXERoM90r60/hF
         YZXnJ7CMUlSocFcENFlx3GS4h8oOp2N5TU58LxUHj2L6sIH6zoKi7qyV87MnS5o7BsQ+
         u+YH9O4duB06vIQS2VIwFqIKRVoEvzpwPXLcdiLcrSphWVOqcHUaQZG9WoH1tUZzYoM5
         F9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/6gP57UG+I00YgaF/Zkk5E5QDgBacW0Ih2c5I7lD5o=;
        b=Nz2JxS6XNXqxh1ahHTF26yon2lfCIMatDcLbrAujnSL3Cd3FPoox8tao/A1s5BT3wy
         Mx1IL214AJejbxWCVYIsxRnyDOfugyy13gr0Ho3XNN4LZV7pR6R+tCtGDjx1neLkyghc
         Qnd04p+ltk3b8OS+H4aDr89MNmilV2apK7lyWYbtislCQAEvbkU0OGnleqcarrrYjzeX
         wlE1bJboyz5X71VTBYO6zkoWU/HxMJfaGr929sJFknocEb3wLL7yVUXuHofNiAIKCE0e
         DnVCG9HlMsDblntQYLU/9pBQQYlboznBHQddcvAIV+BmppyUW84ecrg9ey9McPEcSI8l
         LeUQ==
X-Gm-Message-State: APf1xPCrJ4gH7oTBD5YoOecH7k5e19arMu5+HuDhHG+uHN70Ukto7l+D
        +2Ovjf1dZA+2TwjbJoQXwoNKzA==
X-Google-Smtp-Source: AH8x2249lvRhWNKNVskYo0nsMCDaFNhXx12iIABGeOoD5PfeFFnULIlZaCk9P1WoUgNgqG21RXR0cA==
X-Received: by 10.98.166.86 with SMTP id t83mr3899064pfe.80.1518205853273;
        Fri, 09 Feb 2018 11:50:53 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:402:7570:b525:af9b:18f3])
        by smtp.gmail.com with ESMTPSA id z128sm8071050pfb.36.2018.02.09.11.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 11:50:52 -0800 (PST)
Date:   Fri, 9 Feb 2018 11:50:51 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH 2/2] packfile: refactor hash search with fanout table
Message-Id: <20180209115051.b9356543f3f7d07f3bae213f@google.com>
In-Reply-To: <cfbde137-dbac-8796-f49f-2a543303d33a@web.de>
References: <cover.1517609773.git.jonathantanmy@google.com>
        <007f3a4c84cb1c07255404ad1ea9f797129c5cf0.1517609773.git.jonathantanmy@google.com>
        <cfbde137-dbac-8796-f49f-2a543303d33a@web.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 9 Feb 2018 19:03:48 +0100
Ren=E9 Scharfe <l.s.r@web.de> wrote:

> Going from unsigned to signed int means the patch breaks support for
> more than 2G pack entries, which was put with 326bf39677 (Use uint32_t
> for all packed object counts.) in 2007.

Ah, good catch. I'll wait to see if there are any more comments, then
send out a new version.

> > +int bsearch_hash(const unsigned char *sha1, const void *fanout_,
> > +		 const void *table_, size_t stride)
> > +{
> > +	const uint32_t *fanout =3D fanout_;
>=20
> Why hide the type?  It doesn't make the function more generic.

I thought that the fanout_ parameter could come from a variety of
sources (e.g. direct mmap - void *, or mmap with some pointer arithmetic
- char *) so I just picked the generic one. But now I realize that that
could lead to unaligned reads, which is probably not a good idea. I'll
update it.

For consistency, I'll also update table_ to be unsigned char *.
(Unsigned because it is primarily interpreted as hashes, which use
"unsigned char *" in the Git code.)

> Why not use sha1_pos()?  I guess because it avoids the overhead of the
> accessor function, right?  And I wonder how much of difference it makes.

Yes, overhead of the accessor function. We would also need to modify
sha1_pos to take in a function that we can pass userdata to (to contain
the stride).

> A binary search function for embedded hashes just needs the key, a
> pointer to the first hash in the array, the stride and the number of
> elements.  It can then be used with or without a fanout table, making it
> more versatile.  Just a thought.

I specifically want to include the fanout table in the calculation here,
because it will be used by subsequent patches that also incorporate the
fanout table.
