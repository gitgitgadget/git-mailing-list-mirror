Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A9FC001DF
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 17:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbjHPRRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 13:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345156AbjHPRQn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 13:16:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6562701
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 10:16:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4035C2D136;
        Wed, 16 Aug 2023 13:16:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wBLfqNUnarByNxD2HPHJ6qgt+aRJ8z8lVAwLfb
        Se0OQ=; b=eP4OANCa8V1LP0jdg7UaiMFBYkkBqoQNgPm1p9lO9zWHNIZ5kPdSof
        lmt3PLhWr62ksZY/MlEJBAiiwCGH0iWzyvrph2+gquXxIXU8187Zz9Sw/yLyF7VY
        Yw+SbFkhN2eTYVWij38Y4rcl/4/ZkDQy5BkvYrNSCFfJSvnrfeJbM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3863B2D135;
        Wed, 16 Aug 2023 13:16:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 425CF2D134;
        Wed, 16 Aug 2023 13:16:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/8] Repack objects into separate packfiles based on
 a filter
References: <20230808082608.582319-1-christian.couder@gmail.com>
        <20230812000011.1227371-1-christian.couder@gmail.com>
        <xmqqv8dhjfgm.fsf@gitster.g> <ZNvxg7BVJ+C5XFY4@nand.local>
        <xmqqjztwgcnc.fsf@gitster.g> <ZNwFlcS3SOS9h77N@nand.local>
        <xmqqfs4jhp3p.fsf@gitster.g> <ZNwaoGBNrpdzlPUq@nand.local>
Date:   Wed, 16 Aug 2023 10:16:34 -0700
In-Reply-To: <ZNwaoGBNrpdzlPUq@nand.local> (Taylor Blau's message of "Tue, 15
        Aug 2023 20:38:56 -0400")
Message-ID: <xmqqil9egb65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7AB9E7A-3C58-11EE-B870-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I think that there is a bug lurking in the sense of trying to reuse
> bitmaps when covering a pack that doesn't have reachability closure in
> this particular scenario.
>
> But there are no "blessed" use-cases for doing this. So I think that we
> should indeed fix this, but I am not immediately concerned here.

OK.

> No; we can either reuse a complete bitmap or not. So it's fine to OR
> all of the (permuted) bits into ent->bitmap, but it's not OK to fill in
> just part of them.

Sounds sane.

