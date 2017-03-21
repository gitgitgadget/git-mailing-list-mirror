Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3072095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933261AbdCUReh (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 13:34:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60399 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933036AbdCUReX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 13:34:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38B546466A;
        Tue, 21 Mar 2017 13:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gub/ItO0mxOyZKjHVXE2iEScPAM=; b=vMf47G
        JHbRPZMQI5UAwqlEoQ9aDy/OKSLH8t6A8XhOlPp5I0rUUfxa9aS9FGBcbInt4ITv
        jq0kBp8PK9pozZIaXRp2nHXz6cisLbJbsbPLkJ7nKSHpg8tPOGlPC7Cq4lO4rKTo
        GRbfaFui1NIIXKFFpdpfWGERK0KpKkDUaRqAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Abc4hF+wKzb8GFIhn3y3ETHFsmb8JAZA
        hDld4C5si2pgP1UuF579dvLgIFO1fLUTBJjzvqesiFjMfTMSla/Ia38prqTUPD7Z
        aHOMTmPpEamB9K8kW+ZX7OvOSQ+LDiLABjfesq7UvfAZlta3Vk7fqsTUrAJgSBQJ
        2bS4X+/XRdQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31ED364669;
        Tue, 21 Mar 2017 13:34:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B45364668;
        Tue, 21 Mar 2017 13:34:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] log: if --decorate is not given, default to --decorate=auto
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
Date:   Tue, 21 Mar 2017 10:34:19 -0700
In-Reply-To: <20170321055203.26488-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Mon, 20 Mar 2017 23:52:03 -0600")
Message-ID: <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DD47F42-0E5C-11E7-8FB3-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Git's branching and merging system can be confusing, especially to new
> users. When teaching people Git, I tell them to set log.decorate=auto.
> This preference greatly improves the user's awareness of the local and
> remote branches. So for the sake of user friendliness, I'd like to
> change the default from log.decorate=no to log.decorate=auto.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>

I guess this is an analog of making color.ui default to "auto" we
did earlier. After having shipped with a more conservative default
while letting willing users experiment/experience to help us get the
kinks out of the "auto" setting, it probably is about time to flip
the default.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 48b55bfd2..3aa8daba3 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -520,7 +520,7 @@ test_expect_success 'log --graph with merge' '
>  '
>  
>  test_expect_success 'log.decorate configuration' '
> -	git log --oneline >expect.none &&
> +	git log --oneline --no-decorate >expect.none &&
>  	git log --oneline --decorate >expect.short &&
>  	git log --oneline --decorate=full >expect.full &&

This ensures that an explicit --no-decorate from the command line
does give "none" output, which we failed to do so far, and is a good
change.  Don't we also need a _new_ test to ensure that "auto" kicks
in without any explicit request?  Knowing the implementation that
pager-in-use triggers the "auto" behaviour, perhaps testing the
output from "git -p log" would be sufficient?

