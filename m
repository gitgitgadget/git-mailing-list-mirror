Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25ADC001DF
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 14:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGUOiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 10:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGUOhl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 10:37:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4BF10C3
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 07:37:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE70E1A7CD2;
        Fri, 21 Jul 2023 10:37:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jhjMEzjn0gRp
        9mDj+kX0JID2LQRQL/xwjsqO5J+D9zE=; b=XLxFdY1zqpEHAH1GZwlRMQsj9cEc
        J8+Fgewi3nAl5+j23y1uKgIYU5Gc19rvwe8krveDauAPedoSvOyoslWeKqE5ILD2
        HXM2HScV+5BFCBMNBCIy4Itb4H5Infn2rAV+G5Pe+4KAfejUydZy5JzOFW2b6ayo
        YMTRV/0pX5LTzTg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4A051A7CD1;
        Fri, 21 Jul 2023 10:37:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2267F1A7CD0;
        Fri, 21 Jul 2023 10:37:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] ls-tree: fix --no-full-name
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
Date:   Fri, 21 Jul 2023 07:37:38 -0700
In-Reply-To: <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 21 Jul 2023 14:41:35 +0200")
Message-ID: <xmqq351hz5xp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 245B0F9E-27D4-11EE-8ADF-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Overall I get the impression that having the negative form enabled by
> default was not a good idea.  For boolean options it makes sense, for
> options with arguments perhaps as well, but for OPT_SET_INT we would
> have less confusion if the negated form was opt-in.
>
> To make it easier discoverable we could let the short help include
> the optional "no-" part, which would look like this:
>
> usage: git ls-tree [<options>] <tree-ish> [<path>...]
>
>     -d                    only show trees
>     -r                    recurse into subtrees
>     -t                    show trees when recursing
>     -z                    terminate entries with NUL byte
>     -l, --long            include object size
>     --name-only           list only filenames
>     --name-status         list only filenames
>     --object-only         list only objects
>     --[no-]full-name      use full path names
>     --[no-]full-tree      list entire tree; not just current directory =
(implies --full-name)
>     --format <format>     format to use for the output
>     --[no-]abbrev[=3D<n>]   use <n> digits to display object names
>
> Thoughts?

I like the "optional no- accepted" markings, but I suspect there may
be quite a lot of fallouts.

