Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0438D20756
	for <e@80x24.org>; Tue, 10 Jan 2017 19:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943019AbdAJTzR (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 14:55:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56899 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S942651AbdAJTzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 14:55:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 798E85F541;
        Tue, 10 Jan 2017 14:55:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BRbZddfuJikqFBta+5wQyvglE3k=; b=W+PwmS
        E1PU6cShwIrzfUGYZlVFYD9zYGlpgcmKJhxU5UsqLDKjJdqjvriTfy8HdYjym9U/
        J7fLExmVfRzQR1UTeNgJFCk3JkJigfWFqy5okYjjky5tgI1Z0DV4BknunoxMLMmE
        vDqxrzU+plAn554oJjX//g8xK+AoStk9rcOi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UKAnb9MyzmMK9FL3g7SBAo9WjuCfo+dJ
        y9Qii0tDDZyOCFcP3u44R9sMvTkpcjfjg1oF8hGFALDLZY2PGn1Pl3IApyQbuN++
        4JF9zTiAfHuEeQUBtJsLOdhvFD6gRD9vQwk1/00kmeKWvgy3Yg0fQPKFEVUojMT/
        L7s4XZrWoGo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 702E35F53E;
        Tue, 10 Jan 2017 14:55:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C72435F539;
        Tue, 10 Jan 2017 14:55:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, l.s.r@web.de, git@vger.kernel.org
Subject: Re: [PATCHv2 2/5] unpack-trees: remove unneeded continue
References: <20170109194621.17013-1-sbeller@google.com>
        <20170109194621.17013-3-sbeller@google.com>
Date:   Tue, 10 Jan 2017 11:55:12 -0800
In-Reply-To: <20170109194621.17013-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Jan 2017 11:46:18 -0800")
Message-ID: <xmqqinpmsna7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3716A2E-D76E-11E6-A8EB-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The continue is the last statement in the loop, so not needed.
> This situation arose in 700e66d66 (2010-07-30, unpack-trees: let
> read-tree -u remove index entries outside sparse area) when statements
> after the continue were removed.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Thanks for digging the history to find the culprit.  

This is an unrelated tangent, but I do not think of a way other than
"log -L" to find it; conceptually, "blame" ought to be usable for
it, but it is not useful for finding deleted lines.

>  unpack-trees.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 8e6768f283..d443decb23 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -253,7 +253,6 @@ static int check_updates(struct unpack_trees_options *o)
>  			display_progress(progress, ++cnt);
>  			if (o->update && !o->dry_run)
>  				unlink_entry(ce);
> -			continue;
>  		}
>  	}
>  	remove_marked_cache_entries(index);
