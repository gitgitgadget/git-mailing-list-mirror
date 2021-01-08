Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B126C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E1823AA7
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbhAHTvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbhAHTvt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 14:51:49 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B3C061380
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 11:51:09 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id bd6so4841332qvb.9
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6b9zt7Qi6PFvbRL8ZjC9tVBnQfr3MSwwxTNQLeNIYL4=;
        b=in9lboS2WDMDo9Y86C5ubM5RCEtYPZk40+EPZ3WIbfLbbANxkLLUHMKFZ4OTbkX7FQ
         GJmMpXcZJU+2oa3CXdnPPw8GeFo+hybJo1JF9CRaBgwnBjx25Pvql73qtAXgUCbMEQu8
         BcLyyXQU2XdTtKwZOmxtXbS2yunPgbGX+s7tlHQQlcwU7EDrsd1qDJ7JdPlQMnb147fH
         K+l7hixwbHNsm7etTI1GkYZEHgc5JibtMN1hSpkw4/5h2LAi0Knii1mk26dOGoKTXFgh
         +L27oC86EjL6APKF+7VcBtTTSl7F9+T2V87g6S0h4ckvY74hvy0qpzu8+1WIsZM92eY+
         mogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6b9zt7Qi6PFvbRL8ZjC9tVBnQfr3MSwwxTNQLeNIYL4=;
        b=YKbg2DhQ7ObW8u/A9ewIiVwFt6+g2ZR0JUbr0dDZC5xDj7gCxcLbSwlInlOFIqW8Pk
         YRM98teSQUf9zRXMv/ZSSY5KidwPl3bGXdmBC1KrUeCoIzWciJq/uIYETO+r48Z622i/
         RSqvMvwuZzUL3vARtAJIvJYxC4FlSCAqG2fQ4bRurygdEmWmLKmYJB1+JLrqSSxZ04mB
         ksZNg8ThL/evTbkxL1R+7/4iDeuPKZLu+znQq60dW8eTo6trKCrktpnbUbBpRgUuw4hp
         8e1sOGR0dgCu2IEmbzl1RdvY1GUC2xxVUNXYGYjifaZY7NMhhbzguPZCtt9YnWKbOTgI
         S8BA==
X-Gm-Message-State: AOAM533hApku3N2+Bkhi1moSVDdl2HuVsDRw+/HeIVRzIIBZI+jhBYxU
        PxvLVyjgR4j2n8dGlRRhTTE=
X-Google-Smtp-Source: ABdhPJzTUXQzqHAHi0KizFUxJTupcdpe7Bx8IrJ1Dq90IeTBemTSlAC+PWC1fHiKXVmGcYKMgwbhwQ==
X-Received: by 2002:a0c:fa4c:: with SMTP id k12mr8288161qvo.16.1610135468499;
        Fri, 08 Jan 2021 11:51:08 -0800 (PST)
Received: from [192.168.103.12] (cpe00fc8d50b7d3-cm00fc8d50b7d0.cpe.net.fido.ca. [72.141.221.184])
        by smtp.gmail.com with ESMTPSA id h25sm4755658qtp.80.2021.01.08.11.51.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 11:51:07 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] doc: remove "directory cache" from man pages
From:   Utku <ugultopu@gmail.com>
In-Reply-To: <X/ilPZ71woYI5vT+@nand.local>
Date:   Fri, 8 Jan 2021 14:51:05 -0500
Cc:     Utku Gultopu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB7BB287-A18B-45FE-B147-F3CF92FE3114@gmail.com>
References: <pull.943.git.git.1610124896385.gitgitgadget@gmail.com>
 <X/ilPZ71woYI5vT+@nand.local>
To:     Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

I left that one on purpose. I initially thought that
"Documentation/user-manual.txt" was just an outdated, "dead" file that
wasn't being updated anymore and Pro Git 2 was the de-facto user manual
now. Hence, I left it there so that it would provide historical context.

However, after having a look at the history of it, I realize that it is
not a dead file at all. Also a web search for "git user manual" returns
it as the first result, so I understand that it is still very much
relevant.

On the other hand, the document clearly states that the terms "directory
cache" and "cache" have been obsoleted by "index", so there is no source
of confusion there. On the man pages, there was, which was the reason I
felt the need to make this change. I thought that keeping at least one
definition of "directory cache" (where this definition clearly states
that it is an obsolete term for "index") would be helpful.

So what are your thoughts about it? If you think it is better to remove
it, please let me know and I will remove it.

Best

> On Jan 8, 2021, at 1:32 PM, Taylor Blau <me@ttaylorr.com> wrote:
>=20
> Hi Utku,
>=20
> On Fri, Jan 08, 2021 at 04:54:56PM +0000, Utku Gultopu via =
GitGitGadget wrote:
>> From: Utku Gultopu <ugultopu@gmail.com>
>>=20
>> "directory cache" (or "directory cache index", "cache") are obsolete
>> terms which have been superseded by "index". Keeping them in the
>> documentation may be a source of confusion. This commit replaces
>> them with the current term, "index", on man pages.
>=20
> This patch looks good to me. There is another mention of the old-style
> "directory cache" in the user manual (Documentation/user-manual.txt)
> which could probably be removed:
>=20
>    Note that in older documentation you may see the index called the
>    "current directory cache" or just the "cache".  It has three =
important
>    properties:
>=20
> Thanks,
> Taylor

