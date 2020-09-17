Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFB9C43464
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 22:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9FB20665
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 22:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OtZTYuOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgIQW2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:28:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51473 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIQW2m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 18:28:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CFAD69DFE;
        Thu, 17 Sep 2020 18:28:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=lSvfINm4FBhphaUGchkX58EgyyU=; b=OtZTYuOOjQpSXb8qjAM5
        OEYNO/xC7md8Wpy4E5gT5gRwBe8lObR/Qk75KmK3B35YUFIZSQXYSrGxy8VaWkOm
        xWYWHJuKjIXD2NuoldpwKgLmxr/bZxREv80KfTSHRj4+LrOkezSrKtLb8Vn2DJff
        4q/g/aD5d4800kz+d/rjwHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=P77uPDSruX7fwdRRh55bx91BiwacDLrFFyHJMltYHsVyhm
        xsFpx1iLkMzZaaIDX0LDRwrsd4DWmObPwXkykpku0nZyiyhMyf03hhKC4TuREPi0
        YkT5NZsHWodfvxXDsPqdJT1iplZXkUtjLKzV/i80IgSVtJwvy58StjTMS7dL8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 136A869DFD;
        Thu, 17 Sep 2020 18:28:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90F9069DFB;
        Thu, 17 Sep 2020 18:28:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Subject: Re: [PATCH 00/15] remote-mediawiki: various fixes to make tests pass
References: <20200916102918.29805-1-avarab@gmail.com>
        <20200916185732.GE33925@coredump.intra.peff.net>
Date:   Thu, 17 Sep 2020 15:28:38 -0700
Message-ID: <xmqqimccox61.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22874578-F935-11EA-81BB-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I am a little puzzled about what we want the future of contrib/mw-to-git
> to be. It sounds like there have been a few minor improvements in the
> external GitHub project (though clearly lacking a bunch of fixes you
> have here). Should we be pushing these fixes up to that version and then
> either:
>
>   - considering that project the upstream, and reimporting from them
>     once the fixes are merged there
>
>   - ejecting it from contrib/; it can live on as a separate project

In general the latter is preferrable.

If it is not well maintained in upstream, we can keep it in our
contrib/ hierarchy forever, but given that nobody among us seems to
be motivated and qualified enough to be its true maintainer, and no
user seems to be contacting us about its bugs, it is just between
letting it wither over there or in our contrib/, which does not make
much of a difference, I would think.



