Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A91C001B0
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 22:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjHNWUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 18:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjHNWTw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 18:19:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1D518B
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 15:19:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 478D32784D;
        Mon, 14 Aug 2023 18:19:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v5QcFoPmSB8+D271TVS9VSJu/SWeJ4v0heNT2r
        nnTN4=; b=lEeH65007Na7uyC6t/h40of1hKKZWOEv/ax+hd3q5P+1eon6EB+HxS
        0JGNwQdt7eIpqrd85MoexJHOlyb8ljA01g5Ka2SJwAAQ/FULfAeS1DHSC51WnW9x
        Xu9IvgE77utt2fmiR8toZxd+9kQW4J1NrAx9uXywoHcKmG4+OALwc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F7A22784C;
        Mon, 14 Aug 2023 18:19:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E5CEE2784B;
        Mon, 14 Aug 2023 18:19:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, chooglen@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Subject: Re: [RFC PATCH v2 4/7] parse: create new library for parsing
 strings and env values
References: <20230814220910.60930-1-jonathantanmy@google.com>
Date:   Mon, 14 Aug 2023 15:19:45 -0700
In-Reply-To: <20230814220910.60930-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 14 Aug 2023 15:09:10 -0700")
Message-ID: <xmqqzg2tjmgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADECA072-3AF0-11EE-9EE6-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks - I think that patches 1 through 4 are worth merging even now.
> One thing we hoped to accomplish through the libification effort is to
> make changes that are beneficial even outside the libification context,
> and it seems that this is one of them. Previously, code needed to
> include config.h even when it didn't use the main functionality that
> config.h provides (config), but now it no longer needs to do so. (And
> same argument for hex, although on a smaller scale.)

Thanks for writing this down.  The parser is shared across handling
data that come from config, environ, and options, and separating it
as a component different from the config does make sense.

