Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF87C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 17:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbiEXRpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiEXRpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 13:45:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ACE5B3E8
        for <git@vger.kernel.org>; Tue, 24 May 2022 10:45:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 112C717FB8B;
        Tue, 24 May 2022 13:45:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=57WKUgaJ3iTzGLKQ3ioUCmR8ZcWlas9RgrV5O4p0Rsk=; b=whp+
        sGdDOtCyDa6ywNqi53/ilVLzfMIElZ6FZvZZ19tXPw4LNMlwrYqlfw9M9LkFKLQe
        YmfxVkQ35YTC7OXQcflo1dusiDJ+gV8ejNsU1VgsQmVgU86xa2gSJzn7IYOBRUga
        KDmYgQ659hYrsS/2txT2cTe4uKXGPXDhlnSX9bU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A08017FB89;
        Tue, 24 May 2022 13:45:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B745717FB88;
        Tue, 24 May 2022 13:45:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
        <xmqqa6b7lrw6.fsf@gitster.g>
        <q274s3nn-pp38-4sn-53ro-o2q63447r341@unkk.fr>
Date:   Tue, 24 May 2022 10:45:08 -0700
Message-ID: <xmqqa6b6j04b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4181CD62-DB89-11EC-A0C8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Stenberg <daniel@haxx.se> writes:

> On Mon, 23 May 2022, Junio C Hamano wrote:
>
>>> It calls into cURL, which I suspect has a multi-threaded mode of
>>> operation,
>>
>> https://curl.se/libcurl/c/threadsafe.html ;-)
>>
>> My understanding is that what we have is pretty much select() driven
>> single-threaded multi-fd transfer.
>
> Confirmed. libcurl *can* use threads (if built that way), but the only
> use it has for such subthreads is for resolving host names. libcurl,
> its API and its callbacks etc always operate in the same single
> thread.

Thanks.  

It always is nice to have the authority/expert readily answering our
stupid questions ;-)

