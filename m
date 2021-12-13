Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3973C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 09:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhLMJCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 04:02:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59157 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhLMJCn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 04:02:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBF78F837D;
        Mon, 13 Dec 2021 04:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=8qd/CR7L9q7dAVShn5cwwiHgM
        eTYGQ084m7zq3DqKAo=; b=inGh7fplTxpcsMC8taTS4g+U9023+2LkfiLdp6nlR
        zMCYUTy+MBDd5D8A03uknEgTnzOApMDkVOaonHXFxmWXjW5x1zjQNSlXHn4eUsoM
        r+UpiovCEs6viXRZVVGQpchsOMc1HkbGzzqNqNrd84L5lLzFfEtMd3gJzxHirwTb
        Kw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2048F837C;
        Mon, 13 Dec 2021 04:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D9FEF837B;
        Mon, 13 Dec 2021 04:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 5/5] branch.c: replace questionable exit() codes
References: <20211206215528.97050-1-chooglen@google.com>
        <20211209184928.71413-1-chooglen@google.com>
        <20211209184928.71413-6-chooglen@google.com>
        <211210.86ee6ldwlc.gmgdl@evledraar.gmail.com>
Date:   Mon, 13 Dec 2021 01:02:41 -0800
Message-ID: <xmqq5yrsg9n2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6DF2385C-5BF3-11EC-9D22-C48D900A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The latter should really be "exit(1)", not 128. We should reserve that
> for die().

Is it because install_branch_config_multiple_remotes() gives enough
information to the user that the caller exits without its own
message?  In other words, are messages given by the callee to the
users are morally equivalent to what the caller would call die()
with, if the callee were silent?  If so, 128 is perfectly fine.  If
not, 1 or anything positive that is not 128 may be more appropriate.

Either case, -1 is a definite no-no.
