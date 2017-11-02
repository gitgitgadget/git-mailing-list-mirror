Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7CF020450
	for <e@80x24.org>; Thu,  2 Nov 2017 07:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755140AbdKBHvV (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 03:51:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63740 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754758AbdKBHvU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 03:51:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B745B1E53;
        Thu,  2 Nov 2017 03:51:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GMY8TY8AnIQkCudhuExcm/8aYNM=; b=yNvkcL
        8rEh1MwCEqGl+ZCG8xAF9KojwpXQriFDwob6zfDuEAyGhPU7bot8TKJs+cpzXeZy
        JSr2NJMIboiRGV32nEXEUDnDU6mHgoW4v1jgu9dIIjVReaZKGqUSDtFQAu0rudni
        6iPPzAAKuyxVvhLb5KylO0eRL40rnoRv5vVGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KhWTYfv06sBDmKxh1Xv2pcxulsCbxdFE
        vmS4r2jLl+GvhjwpwsmUQpNGBXcr6y4uBDjbzKXnJpP26Mn5y9LqoQmkiPMzlGM2
        yrCX0EvwwWk6H0Be05QXT77yQFvr8Ttwk3rkXHWVPYdrCEFHI2yj9Du27hb1QHXu
        g6yt7IZMpTo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 229A4B1E52;
        Thu,  2 Nov 2017 03:51:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 932CBB1E51;
        Thu,  2 Nov 2017 03:51:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Incosistent repository state when trying to rename HEAD in the middle of a rebase
References: <1509209933.2256.4.camel@gmail.com>
        <1509600814.9254.6.camel@gmail.com>
Date:   Thu, 02 Nov 2017 16:51:18 +0900
In-Reply-To: <1509600814.9254.6.camel@gmail.com> (Kaartic Sivaraam's message
        of "Thu, 02 Nov 2017 11:03:34 +0530")
Message-ID: <xmqqd151qft5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CE8F656-BFA2-11E7-8C4E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> I was able to spare some time to dig into this and found a few things.
>
> First, it seems that the issue is more generic and the BUG kicks in
> whenever HEAD is not a symbolic ref.

Interesting.  

Shortly we'll be rewinding the tip of 'next', and it is a good
opportunity to kick any not-so-well-cooked topic back to 'pu',
so let's figure out what is going on after that happens (at which
point let's eject the "branch name sanity" topic out of 'next').

