Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ED4C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 19:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C5B2070A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 19:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L4TSggci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCZT1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:27:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65074 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZT1K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 15:27:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54F0EC871D;
        Thu, 26 Mar 2020 15:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Z0vPA+vI4HqdUVtKKszOC/8cWQQ=; b=L4TSgg
        ciVYXKUmlcASn1HwEMXNgiVqC3cYXMCB2KaySdvTJWTSzW705luCGt9j1HOC0OrO
        VWKaDObmzNRJ9OAH7qYWfxBKNCQ7wGuLkEr/vr2wWQOq/boiOgiZWf4wNfbimXrq
        9BwP+CQI1wzn10wdZAA9ztewDDAKunz0aCwyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rvTCMhF7jmxt9+VTLWovxNDDwWdE2Zvi
        ANvFdCFgwyK9LEJRvFB2GNcPa/xZoW+GT9I9bJvtKAn8DJZTQ+yxcjmQlRVqojdK
        I+6shg6l/Gn6g0kaJCNirmpWf9Mjkx5i8AOi4oGNXY60ZWaASTSjj4S+dVnybGDR
        vPcObjpwcFE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CDADC871C;
        Thu, 26 Mar 2020 15:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 94C09C871B;
        Thu, 26 Mar 2020 15:27:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH v2] rebase --merge: optionally skip upstreamed commits
In-Reply-To: <20200326175033.35944-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 26 Mar 2020 10:50:33 -0700")
References: <20200318173051.25875-1-jonathantanmy@google.com>
        <20200326175033.35944-1-jonathantanmy@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Thu, 26 Mar 2020 12:27:04 -0700
Message-ID: <xmqq4kuakjcn.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6EAC46E-6F97-11EA-9AF7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> New in V2: changed parameter name, used Taylor's commit message
>> suggestions, and used Elijah's documentation suggestions.
>
> I think the discussion has shifted away from whether this functionality
> is desirable (or desirable and we should implement this functionality
> without any CLI option) to the name and nature of the CLI option. Before
> I send out a new version, what do you think of using this name and
> documenting it this way:
>
>   --keep-cherry-pick=(always|never)::
>   ...
>   The default is 'never'.
>   +
>   See also INCOMPATIBLE OPTIONS below.

Sounds much better to me.  I do not mind --[no-]keep-cherry-pick,
either, by the way.  I know I raised the possibility of having to
make it non-bool later, but since then I haven't thought of a good
third option myself anyway, so...

Thanks for keeping the ball rolling.

