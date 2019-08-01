Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE13A1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 20:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfHAU05 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 16:26:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62849 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfHAU04 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 16:26:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8CAB6951D;
        Thu,  1 Aug 2019 16:26:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R6nXl/OVVxSZZMJRpYLxzjot+S4=; b=jCXpBL
        g4XHgPTZEKhmoL52KzrZJWkD1xpIY29IpJXDgj5EP4omFKPVwYoGlTAnlSEyfpNi
        CejFdlM5w5aVZWVP7k1UDvjBamKR4f8rTXPF1jXbO5PQif4914rxRvIsMyBfD3RI
        XSHwzhnEOpZAy73viRfMYO022ilzEXMSLL4vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yEyu6aM+H0CeefyqNcxVJqeSe9Wk1HES
        BO7Y55dnbsqVuLPnHaQZQQcSPxghYZuTzzGhItIQJqXS/XxHBtq7RF2SdoJYvk/G
        EygN+rBAH26M8PKvuUJpRc4bfvgyEJZTR8bvVzbCk8b6tyePDfEoHERg0fws4kQM
        TYWIXtKCHqg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0F1B6951C;
        Thu,  1 Aug 2019 16:26:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DD0026951A;
        Thu,  1 Aug 2019 16:26:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Support for --stdin-paths in commit, add, etc
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
        <20190731171956.GA26746@sigill.intra.peff.net>
        <ab333992-35c6-a5a9-0bcb-cef51f004679@syntevo.com>
        <06daa8c1-d955-1e49-e5e6-85d53ffce6e6@gmail.com>
Date:   Thu, 01 Aug 2019 13:26:49 -0700
In-Reply-To: <06daa8c1-d955-1e49-e5e6-85d53ffce6e6@gmail.com> (Phillip Wood's
        message of "Thu, 1 Aug 2019 18:35:26 +0100")
Message-ID: <xmqqmugsmy2e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2338F28-B49A-11E9-AA98-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> No but it only takes paths not pathspecs, can you filter out the
> ignored paths first? From a UI point of view it would be better not to
> allow users to select ignored files if you don't want to be able to
> add them. If you want to use a pathspec then you can do 'git ls-files
> --exclude-standard -o -z <pathspec ...> | git update-index --add -z
> --stdin'
> ...
> You can use a temporary index, add the files you want to commit with
> update-index --stdin and then run 'git commit'

All true.  Perhaps we need a separate tutorial for scripters to
teach them how to properly combine the plumbing commands?

> When I've been scripting I've sometimes wished that diff-index and
> diff-files had a --stdin option.

Sounds fair.
