Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A516C2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE9F20724
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sorrel.sh header.i=@sorrel.sh header.b="Hc3eRGc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgDWX6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:58:14 -0400
Received: from balrog.mythic-beasts.com ([46.235.227.24]:60977 "EHLO
        balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDWX6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 19:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sorrel.sh;
         s=mythic-beasts-k1; h=To:From:Subject:Date;
        bh=XhwXzOvJohW59k0ODbAlsCyi08rm88herUVN3GdNUVI=; b=Hc3eRGc1GsSQCjvXfWBwfpn8WE
        58GMmLgZIqGE38pkCYAxGlTx3LGum8A+A8iD0mPNuXBFFNTct02Fkx5/g6tU+AsbD3P5vZiCwxpuG
        jQLPzFW3CP6cyFX0gnivGLvli7tTfEaBNmBHltcMAK4IH2n3s9qARobK7VR5poGLivYpTJuAL69sf
        t9snXTpIFk6+l5MqCYS/i/pSO9UL0ucU+E66wmSl7Ax3aM3m/YVCT/PGEUTs/mFaA8W/EY3DfwbwO
        6YEyw539QYEBIU7Y58t3FL+EOVKmE7DJCSd9ZOHFOk+v99riqfS9ebxLp4ASbfWTtcRo0+wojtU5w
        Y+BlD2Aw==;
Received: from [212.56.100.202] (port=63873 helo=localhost)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <ash@sorrel.sh>)
        id 1jRljL-0000F0-Gi; Fri, 24 Apr 2020 00:58:11 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <33f037a9-d3d5-042a-d3ba-7e4b8364663a@kdbg.org>
Date:   Fri, 24 Apr 2020 00:42:12 +0100
Subject: Re: [PATCH] userdiff: support Markdown
From:   "Ash Holland" <ash@sorrel.sh>
To:     "Johannes Sixt" <j6t@kdbg.org>
Cc:     <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
        "Boxuan Li" <liboxuan@connect.hku.hk>,
        "Alban Gruin" <alban.gruin@gmail.com>
Message-Id: <C28ZH8NBU8BS.1WKC7DSJANUIM@what>
X-BlackCat-Spam-Score: 39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Apr 23, 2020 at 9:17 PM PST, Johannes Sixt wrote:
> Am 21.04.20 um 03:00 schrieb Ash Holland:
> > diff --git a/userdiff.c b/userdiff.c
> > index efbe05e5a..f79adb3a3 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -79,6 +79,9 @@ PATTERNS("java",
> >  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> >  	 "|[-+*/<>%&^|=3D!]=3D"
> >  	 "|--|\\+\\+|<<=3D?|>>>?=3D?|&&|\\|\\|"),
> > +PATTERNS("markdown",
> > +	 "^ {0,3}#{1,6}( .*)?$",
>
> What is the purpose of making the heading text optional? Why would you
> want to match a sequence of hash marks without any text following it?

Strictly speaking, a markdown heading is allowed to be empty -- see for
example https://spec.commonmark.org/0.29/#example-49. I'm happy to
change it if you think it's more useful to show a previous heading which
contains text than an empty one, though.
