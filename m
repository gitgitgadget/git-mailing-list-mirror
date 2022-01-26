Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB24C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 20:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiAZUHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:07:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51582 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiAZUHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 15:07:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42AE816A9E2;
        Wed, 26 Jan 2022 15:07:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/lAoI4X0fwK8yr7CzIrDZ2sr5Bl+pHX+ee7JEz
        bf/yM=; b=hwn/DkCjsGY1y3INgpeNks6aoU5ov/01G8TlKh7j4HTeRLPhv068/8
        GZcVIyA32jLLGlYkMNj2KIL81ZL4vr6/Mm6i5iZN1+KmhJwVvHYydEavSiBXEXyJ
        xvrKOSVZ5Qp+CYkxxCgkWTtLOshaFPV0kkctDP6uvWrhanTh2mYDE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C63D16A9DF;
        Wed, 26 Jan 2022 15:07:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AFF1016A9DE;
        Wed, 26 Jan 2022 15:06:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josef Wolf <jw@raven.inka.de>
Cc:     git@vger.kernel.org
Subject: Re: clean/smudge-filter with "attached file"?
References: <20220126125209.GD16463@raven.inka.de>
Date:   Wed, 26 Jan 2022 12:06:56 -0800
In-Reply-To: <20220126125209.GD16463@raven.inka.de> (Josef Wolf's message of
        "Wed, 26 Jan 2022 13:52:09 +0100")
Message-ID: <xmqqbkzyqn1b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83E8670E-7EE3-11EC-AF8A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josef Wolf <jw@raven.inka.de> writes:

> Those files seemed to be good candidates for git's clean/smudge-filter.

Perhaps post-checkout hook to notice missing checksum files and
recompute them would work, but this is clearly outside of what
clean/smudge wants to do and what they were invented for (i.e. the
contents of the file in the working tree itself need to be adjusted
in the working tree and in the repository, hence there is a filter
in each direction).  As the mechanism being "filter", i.e. a
bytestream is converted into another bytestream, it is not even
designed to muck with other things on the filesystem.


