Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EEAC433E4
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA29C207C3
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IrNNhqKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgEOPJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 11:09:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53445 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgEOPJm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 11:09:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DF78CC61F;
        Fri, 15 May 2020 11:09:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=26gvHWlRNELc
        a39rRV6GkGqsS/I=; b=IrNNhqKvTZgDvfWhcyGiv1iydqdRhl9Y6Kg5FI4mNnoZ
        wRLopgyKut6xu+BbXDZIhiwBjlABE3+y09rrH3zqlgIqMc/e9j2EJHFv0LoJ4yfR
        JK16cKffgDaRgGypEQzmLIYeUbzbtFR0Al5ATXXpttVi7gcTNG0Rr11O2velwaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uIelhj
        WJv+GPWMhk5ExxUY5IqBW7oLNFQFY5E+5onTGIzKHQlJYcA6TgjM66te9OOeD9+J
        BBE/lBq0u9xgGrqbJCnQdSOvbHtinfA+1aqvv7qG9g3Td/mtVrwDZgB1Xq9oNm2q
        knf4/SAfsTEHdJyXI7+O6Hms+sV0mKwA0Lweg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 362C2CC61E;
        Fri, 15 May 2020 11:09:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 794AFCC61D;
        Fri, 15 May 2020 11:09:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: avoid pounding on the poor ci-artifacts container
References: <pull.632.git.1589316430595.gitgitgadget@gmail.com>
        <pull.632.v2.git.1589529318969.gitgitgadget@gmail.com>
Date:   Fri, 15 May 2020 08:09:36 -0700
In-Reply-To: <pull.632.v2.git.1589529318969.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 15 May 2020 07:55:18
        +0000")
Message-ID: <xmqq4kshnsjz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 185FA588-96BE-11EA-8651-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When this developer tested how the git-sdk-64-minimal artifact could be
> served to all the GitHub workflow runs that need it, Azure Blobs looked
> like a pretty good choice: it is reliable, fast and we already use it i=
n
> Git for Windows to serve components like OpenSSL, cURL, etc
>
> It came as an unpleasant surprise just _how many_ times this artifact
> was downloaded. It exploded the bandwidth to a point where the free tie=
r
> would no longer be enough, threatening to block other, essential Git fo=
r
> Windows services.
>
> Let's switch back to using the Build Artifacts of our trusty Azure
> Pipeline for the time being.
>
> To avoid unnecessary hammering of the Azure Pipeline artifacts, we use
> the GitHub Action `actions/upload-artifact` in the `windows-build` job
> and the GitHub Action `actions/download-artifact` in the `windows-test`
> and `vs-test` jobs (the latter now depends on `windows-build` for that
> reason, too).
>
> Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>    =20
>     Change since v1:
>    =20
>      * Simplifying the scripted code by using jq (thanks, Danh!)

Thanks, both.  Will replace and let's merge it down before -rc1.

