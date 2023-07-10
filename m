Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031ACEB64DA
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjGJVfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjGJVfX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:35:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8157DE
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:35:22 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7337318D8BE;
        Mon, 10 Jul 2023 17:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e4v9rWE3ShDg0rpbNRJxskImgqK9HCyz5qlYqT
        /2kAw=; b=R9I6NEI3dHZzDcfM6oA8zhtdGR3+KeD4gSeIozWH7pQizgob5biON3
        m3xOt4/V/xlp0cB5vw5jtufsLNWaz3LY4L/VChQd5nAZEHk9ykrgJw4wCkwuIcAg
        K8SXtj+IQ1KeeFDWYvdm3Z4h3NKhoPb/S7q7/7s4WuSMem/PlQn3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69DAC18D8BC;
        Mon, 10 Jul 2023 17:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C964B18D8BB;
        Mon, 10 Jul 2023 17:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/2] builtin/repack.c: avoid dir traversal in
 `collect_pack_filenames()`
References: <cover.1689017830.git.me@ttaylorr.com>
        <b3d0d9308ef1a0aab8dd5a65354044568c65388b.1689017830.git.me@ttaylorr.com>
Date:   Mon, 10 Jul 2023 14:35:19 -0700
In-Reply-To: <b3d0d9308ef1a0aab8dd5a65354044568c65388b.1689017830.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 10 Jul 2023 15:37:18 -0400")
Message-ID: <xmqqa5w34fhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABBDF28A-1F69-11EE-ADE8-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> However, manually enumerating a repository's packs via `readdir()` is
> confusing and error-prone. It leads to frustrating inconsistencies
> between which packs Git considers to be part of a repository (i.e.,
> could be found in the list of packs from `get_all_packs()`), and which
> packs `collect_pack_filenames()` considers to meet the same criteria.

Makes sense.

> One gotcha here is that we have to ignore non-local packs, since the
> original version of `collect_pack_filenames()` only looks at the local
> pack directory to collect existing packs.

Yup.

Does this "fix" anything, or just makes the resulting code clearer
and protects it from future breakage?  I think it is the latter and
not having any test is justified.

Thanks.
