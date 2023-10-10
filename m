Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BA1CD8CA6
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 16:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjJJQNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 12:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjJJQNn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 12:13:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60CCCA
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 09:13:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0187431FCA;
        Tue, 10 Oct 2023 12:13:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=PmkYbroUbaICc49mWs4IdE+umPxkLynYDmY61A
        cneMc=; b=Y7IPRzouXPh1J+F7oJXAncQOkWo8Cob067lowHD0HHZ/pCL7wvlOl4
        cZdc2VOMBi2RCxR9WGwT/utHiotqg2SLYAOu8A34ZEyPGWUxhX9iVyOcMK1pz3Ny
        Mxfrut6OrfXl2PoMrTD3krPgxDHMgXz0IxlvF8WxCk1mETlFy/rco=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE2CA31FC9;
        Tue, 10 Oct 2023 12:13:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6A31631FC5;
        Tue, 10 Oct 2023 12:13:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     phillip.wood123@gmail.com
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v4 2/4] wrapper: reduce scope of remove_or_warn()
In-Reply-To: <066b3162-6a81-45d7-b164-17b74e6c92dc@gmail.com> (phillip's
        message of "Tue, 10 Oct 2023 10:59:38 +0100")
References: <20230627195251.1973421-1-calvinwan@google.com>
        <cover.1696021277.git.jonathantanmy@google.com>
        <c9e7cd78576527571fd70b953e340b5bdd196221.1696021277.git.jonathantanmy@google.com>
        <066b3162-6a81-45d7-b164-17b74e6c92dc@gmail.com>
Date:   Tue, 10 Oct 2023 09:13:34 -0700
Message-ID: <xmqqjzruv4k1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F76E365C-6787-11EE-A33B-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

phillip.wood123@gmail.com writes:

> Hi Jonathan
>
> On 29/09/2023 22:20, Jonathan Tan wrote:
>> From: Calvin Wan <calvinwan@google.com>
>> remove_or_warn() is only used by entry.c and apply.c, but it is
>> currently declared and defined in wrapper.{h,c}, so it has a scope much
>> greater than it needs. This needlessly large scope also causes wrapper.c
>> to need to include object.h, when this file is largely unconcerned with
>> Git objects.
>> Move remove_or_warn() to entry.{h,c}. The file apply.c still has
>> access
>> to it, since it already includes entry.h for another reason.
>
> This looks good. On a related note wrapper.c includes repository.h but
> does use anything declared in that header.
>
> Best Wishes
>
> Phillip

Thanks for a review.  I just checked 'master', 'next', and 'seen'
and in all '#include <repository.h>' can safely be dropped from
there, it seems.  It may be too trivial even for a microproject,
but nevertheless a nice clean-up.

