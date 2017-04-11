Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4681FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 08:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbdDKIao (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 04:30:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52956 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751365AbdDKIan (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 04:30:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93930875B3;
        Tue, 11 Apr 2017 04:30:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fyj3b7aLTPmt
        qt2yXOSip75wVco=; b=Yv4w8FKXwPye2WZ0ZB5SHxlnhrU9m6k4eggW678DnvMA
        zyZOcxP6bMLd8+5F+DZC1wobEM8HKWhS2khOF4CEZyZEJ2U5ITMnLaoLC5edpIpg
        IkuDmLgi/YCdC33X1tAeSXjXjzbKC9mi62OZYrkzZz6053/IvzNIhhWTtrTMohY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eU5k+D
        L0xk9mDaMK/EJd9fEwbJFXSrokXCkS/f4k4pC6uXY1fRo1wEhHiYRMB/u3heeBaC
        e+foC6bPbDU0jwE0cuHgwDPWYegXTTMFxe5ONvBMGFDiebWzHWP5XDPNXtJNVHPd
        yj5d+SmtxtJYN7nyLrYaZ1Q4ymtp356JZCDXA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BDE6875B2;
        Tue, 11 Apr 2017 04:30:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CACF0875B0;
        Tue, 11 Apr 2017 04:30:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
Subject: Re: [PATCH v7 00/28] Remove submodule from files-backend.c
References: <20170318020337.22767-1-pclouds@gmail.com>
        <20170326024241.31984-1-pclouds@gmail.com>
        <24c2d384-b719-6a36-5b65-8edf86191fdd@alum.mit.edu>
Date:   Tue, 11 Apr 2017 01:30:39 -0700
In-Reply-To: <24c2d384-b719-6a36-5b65-8edf86191fdd@alum.mit.edu> (Michael
        Haggerty's message of "Sat, 1 Apr 2017 07:09:54 +0200")
Message-ID: <xmqqmvbnqrbk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25AA2856-1E91-11E7-B18C-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 03/26/2017 04:42 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
>> v7 is mostly about style changes except the one bug in
>> test-ref-store.c, missing setup_git_directory().
>>=20
>> There's one new patch, 03/28, which maps to the "if (!refs)" deletion
>> in the interdiff.
>>=20
>> The one comment from v6 I haven't addressed in v7 is whether to delete
>> REF_STORE_READ. But if it is deleted, I think I'm doing it in
>> nd/worktree-kill-parse-ref, which is partly about cleanup refs code
>> anyway, to avoid another re-roll in this series.
>
> I reviewed v7 pretty carefully, and send a couple of minor comments. Bu=
t
> with or without changes, it looks good to me and the whole series is
>
> Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
>
> Thanks!

Thanks.  The "What's cooking" report at the end of the last month
marked this topic to wait for a few days for comments before moving
to 'next'.  Now it has been more than a few days, so I'll move it to
the normal "will merge to 'next'" category.

