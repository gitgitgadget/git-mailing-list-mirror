Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF99C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 19:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhLOTuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 14:50:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52116 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhLOTuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 14:50:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FF51171171;
        Wed, 15 Dec 2021 14:50:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GZXObun67cUSc7WfwV6Ut2ImJP2CvFBcyVLWnA
        rhb1k=; b=XlD8a7V3VRm1l5ngxyfAZz6oJEh0s1YLifn5hpSLtJYo66DWJxVXVt
        1yVYo/2VBXsRpWPGyoLaOSQnZs6oxOkR7HM0Uc8eHZritAK3sCJAXIqfsqCnUvRQ
        vghdMLwiLXUl5oP3+sJQzbIIk6o+W4yNBFWw6/agCqqbd7+RaRAPw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68A5A17116F;
        Wed, 15 Dec 2021 14:50:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66EE217116E;
        Wed, 15 Dec 2021 14:50:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 1/1] upload-pack.c: increase output buffer size
References: <YbizfdGq+RSu9BGe@coredump.intra.peff.net>
        <20211214194626.33814-1-jacob@gitlab.com>
        <20211214194626.33814-2-jacob@gitlab.com>
Date:   Wed, 15 Dec 2021 11:50:47 -0800
In-Reply-To: <20211214194626.33814-2-jacob@gitlab.com> (Jacob Vosmaer's
        message of "Tue, 14 Dec 2021 20:46:26 +0100")
Message-ID: <xmqqa6h16414.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CCFB52A-5DE0-11EC-ABCE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Vosmaer <jacob@gitlab.com> writes:

> When serving a fetch, git upload-pack copies data from a git
> pack-objects stdout pipe to its stdout. This commit increases the size
> of the buffer used for that copying from 8192 to 65515, the maximum
> sideband-64k packet size.

Thanks.  I agree with others that extra configurability is not
needed in this case, and allocating this on the heap (as long as we
correctly deallocate it when we are done) is the right thing.

Will queue.  Thanks.
