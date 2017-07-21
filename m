Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A678920288
	for <e@80x24.org>; Fri, 21 Jul 2017 14:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbdGUOir (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 10:38:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50754 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752034AbdGUOhb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 10:37:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4F4393C66;
        Fri, 21 Jul 2017 10:37:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9vsqH8/9IApvUKkCwV+vw69oOQc=; b=qqQFRf
        1uBaGZdErRKnQG2Z60w3F5rOXJV6SnF62jRWbr53hblU4CCAyjkQXbA4/0jGuXF+
        vc3pwx5pEOoKdFlN6f55XPqoz8Ov1r4eOqW5dN9TiVlD/E5nS8rTc6XQWvFEjiW/
        3qKiCULGQucaf4+6EU6MuAc0CWiHn8YeYG3/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h0krg/qUKHLBPnfb0C7f+ziNXMvG3Ahg
        +y9MVOTgEaNdCCZHgq6f58dXcG/dviVIgvILhPrVX8SPKd3uvkeva24hXQbJzZqw
        2r2fzhXc2ufzqSIjz083k9MuhgNIrkl30ZzXL8A9Sx4FLwFiKiOWKyPe/ed028WI
        K3iUhDyBBOs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D24993C65;
        Fri, 21 Jul 2017 10:37:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 108F693C62;
        Fri, 21 Jul 2017 10:37:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Blake <eblake@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-contacts: Add recognition of Reported-by
References: <20170721141530.25907-1-eblake@redhat.com>
Date:   Fri, 21 Jul 2017 07:37:21 -0700
In-Reply-To: <20170721141530.25907-1-eblake@redhat.com> (Eric Blake's message
        of "Fri, 21 Jul 2017 09:15:30 -0500")
Message-ID: <xmqqbmodj1pa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BB38CF8-6E22-11E7-8414-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Blake <eblake@redhat.com> writes:

> It's nice to cc someone that reported a bug, in order to let
> them know that a fix is being considered, and possibly even
> get their help in reviewing/testing the patch.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

I don't know if this new one deserves to be part of the hardcoded
defaults; it would be different between the projects and depends on
their convention.  I notice that there is no way to configure this
script and I suspect that it would be a more generally useful update
to have it read a configuration variable that lists what kind of sob
like things to take addresses from.

Thanks.

>  contrib/contacts/git-contacts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
> index dbe2abf27..85ad732fc 100755
> --- a/contrib/contacts/git-contacts
> +++ b/contrib/contacts/git-contacts
> @@ -11,7 +11,7 @@ use IPC::Open2;
>
>  my $since = '5-years-ago';
>  my $min_percent = 10;
> -my $labels_rx = qr/Signed-off-by|Reviewed-by|Acked-by|Cc/i;
> +my $labels_rx = qr/Signed-off-by|Reviewed-by|Acked-by|Cc|Reported-by/i;
>  my %seen;
>
>  sub format_contact {
