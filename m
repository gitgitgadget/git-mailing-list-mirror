Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E9EC10F27
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 15:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5DB21655
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 15:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yt5HERLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCIPE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:04:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65415 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgCIPE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 11:04:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F73CC7F0C;
        Mon,  9 Mar 2020 11:04:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=atZGDebfTTLH
        o+A8AcE1AqIEctc=; b=Yt5HERLbyufphVbvf930YyuUy4i9P1YHu2PSJISIlLIk
        pxOTW1Q/PD7t8C8PcEn/kUfhq0VuiCkpKp+tPk2BhBTtVPblpytxVbaW7R00AbFM
        /UyeCeKZzGt23CgiN/BMhn3ytWznmR3Bux0usYYLOwymG8DFoiHPFgedFi0kAao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WpeWDe
        LPdcooBFG2doFtSiXZaGdvJyqA8LraynwsjsIigFH02+bTTMCRbz+BSda+S7ruBU
        IuqEqcey7mXTHpa9c7APBAkQUm1VDyd6WFo8B42S5gTLox2NtgAryVsjXS3Wc3nO
        s3hN+3PcPR+mbx5D5VpbYXa7a/VmvJFpnsZh4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1638AC7F0B;
        Mon,  9 Mar 2020 11:04:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 337C7C7F07;
        Mon,  9 Mar 2020 11:04:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     "Randall S . Becker" <rsbecker@nexbridge.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] t1091: don't grep for `strerror()` string
References: <018001d5f305$0c709af0$2551d0d0$@nexbridge.com>
        <20200308084627.26677-1-martin.agren@gmail.com>
Date:   Mon, 09 Mar 2020 08:04:22 -0700
In-Reply-To: <20200308084627.26677-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sun, 8 Mar 2020 09:46:27 +0100")
Message-ID: <xmqqmu8p1seh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 43F7A5D2-6217-11EA-B574-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> We grep for "File exists" in stderr of the failing `git sparse-checkout=
`
> to make sure that it failed for the right reason. We expect the string
> to show up there since we call `strerror(errno)` in
> `unable_to_lock_message()` in lockfile.c.
>
> On the NonStop platform, this fails because the error string is "File
> already exists", which doesn't match our grepping.

Thanks for a quick fix.  I agree that looking for our own string
makes a lot more sense here.
