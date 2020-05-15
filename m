Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3055CC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13CA20643
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xQwc5MHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEOViO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 17:38:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55214 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgEOViN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 17:38:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C68146748B;
        Fri, 15 May 2020 17:38:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OW/cShCQzOPRJI6f4lCbgiffMyU=; b=xQwc5M
        HYbMA3pqTizOf9sBA2Y/+jVtJcdGTPI4A4kr1uleH/cwpgF9zaY+ndDSAWlqRYi9
        SQkA9V2Braj9f3KAB7YP5lXS1sOaYG9eBtoIto2bqjYiXpLEr+2FIpuF1dZl+6CJ
        THfnvb7qsF4mo/c4kwUK/TJ5ogoxktu+6UVMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SNxoH6Nl2xSdOoQBcfQtuFxg0FdMEgxf
        p52piJ7lbCOM0zBcgNfwtJG4EeWfPD8K4w3F1ttLy6CTDHRI3DyyK7sp2Wvh3eBe
        Gz7hr5RqBerVdPbc0T0DJGWpet70V1ptMMJ81qM62O+0x2mM1Knjfs0VAzESPDkN
        +42ZXgrMhyI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE8356748A;
        Fri, 15 May 2020 17:38:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4EC2F67487;
        Fri, 15 May 2020 17:38:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] ci: avoid pounding on the poor ci-artifacts container
References: <pull.632.git.1589316430595.gitgitgadget@gmail.com>
        <pull.632.v2.git.1589529318969.gitgitgadget@gmail.com>
        <xmqq4kshnsjz.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005152334550.55@tvgsbejvaqbjf.bet>
Date:   Fri, 15 May 2020 14:38:10 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005152334550.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 15 May 2020 23:35:06 +0200 (CEST)")
Message-ID: <xmqqimgwlvzx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FE6DAE4-96F4-11EA-A0A4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 15 May 2020, Junio C Hamano wrote:
>
>> Thanks, both.  Will replace and let's merge it down before -rc1.

'next' passes with this

 https://github.com/git/git/runs/679473788
 https://github.com/git/git/runs/679473866

etc.

Thanks.
