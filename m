Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA50C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F090D2086A
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OOBZogRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgHEW0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:26:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55287 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHEW0x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:26:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCE4BE02DC;
        Wed,  5 Aug 2020 18:26:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CjVbAs0N07Ga5AjnlnjoKMePrlI=; b=OOBZog
        ReCT/SqsPTS9aCgPxPblmtoTsMy8KIrXhS5XRjjY4MYRBBuztgtmZI5hiXH1m+Nn
        EOsavvzqjcfrf4WbqOWS/fcfqPKNHA3u8FCGg78ZY/0ZZ2aeIT+a1NN23987/VDb
        gp9OMLVBLJpV1kCZZHL1D/XCIK8+USLuqBOg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DlXFmBE9uTmgwUSnAT0wna2MKpX4ti//
        elLJS3qn6tgBS6UthtUoQDka7D7Sp2jKaN5NazqjbM7jKTjmYxWzv5feeYlcw8oW
        ZbMEgee2ayUpGebJRo7svwFXPje3NRzEtbmQLIXihhxzsKsYaWH+nXSQp234QiSm
        pAN5Ouu4tAY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4651E02DB;
        Wed,  5 Aug 2020 18:26:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 46D82E02DA;
        Wed,  5 Aug 2020 18:26:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: avoid garbled merge machinery messages due to commit labels
References: <pull.828.git.git.1596654345718.gitgitgadget@gmail.com>
        <20200805212032.GK9546@syl.lan>
Date:   Wed, 05 Aug 2020 15:26:47 -0700
In-Reply-To: <20200805212032.GK9546@syl.lan> (Taylor Blau's message of "Wed, 5
        Aug 2020 17:20:32 -0400")
Message-ID: <xmqq8sesn2zc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1052356-D76A-11EA-B1FE-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> ...
>>     <<<<<<<< HEAD:foo.c
>>       int j;
>>     ========
>>       int counter;
>>     >>>>>>>> b01dface (Removed unnecessary stuff):bar.c
>>
>>     CONFLICT (rename/delete): foo.c deleted in b01dface (Removed
>>     unnecessary stuff) and renamed in HEAD.  Version HEAD of foo.c left
>>     in tree.
>>
>>     CONFLICT (file location): dir1/foo.c added in b01dface (Removed
>>     unnecessary stuff) inside a directory that was renamed in HEAD,
>>     suggesting it should perhaps be moved to dir2/foo.c.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>
> This is much easier to read, and the change below is obviously correct.
> Thanks for working to improve the readability of these markers.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks.  Looks good.
