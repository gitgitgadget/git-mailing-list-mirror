Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F66920986
	for <e@80x24.org>; Tue, 27 Sep 2016 18:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755024AbcI0Snk (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 14:43:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51863 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753547AbcI0Sni (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 14:43:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0E6E3DBB8;
        Tue, 27 Sep 2016 14:43:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C1VtJhDml4mTir+A17JO9TrVN2g=; b=iPkiaQ
        8qNCzqbWRzwOAOe8aysKWUy2Ai/koIMtTdypU2GTNRICjrrWnTYZSztyCmbtAEg8
        dG/7CQI2bZ4agbkzKVt/NAcxM5jYTtIvkSakoovOflUv3BvN2iwMX10k4GwcDNlJ
        SJA44QIflcVUh5C2uwn/PuX8efReEVZkg82Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g5IRnhfkFpcNb6vZSixyb5T/i2s8x4Qt
        99MtBx5CqWrv74/E3Ab6T/8CmPzFxQQFfF57r44j8SJFPg0O1bnPKCOFs2lsKWsG
        htxuU3ZXx1LtV4wmk76P6Si9hq5FSdNooMNDSsY/5guv+msh8PhYQ14J/CJlFuL6
        jD0hAB+ru64=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9C863DBB7;
        Tue, 27 Sep 2016 14:43:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61DB63DBB6;
        Tue, 27 Sep 2016 14:43:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] ls-files: pass through safe options for --recurse-submodules
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1474930003-83750-4-git-send-email-bmwill@google.com>
Date:   Tue, 27 Sep 2016 11:43:34 -0700
In-Reply-To: <1474930003-83750-4-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 26 Sep 2016 15:46:42 -0700")
Message-ID: <xmqqd1jpnpyh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C9BC300-84E2-11E6-8770-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>  	if (recurse_submodules &&
> -	    (show_stage || show_deleted || show_others || show_unmerged ||
> +	    (show_deleted || show_others || show_unmerged ||
>  	     show_killed || show_modified || show_resolve_undo ||
> -	     show_valid_bit || show_tag || show_eol || with_tree ||
> -	     (line_terminator == '\0')))
> +	     with_tree))
>  		die("ls-files --recurse-submodules unsupported mode");

Ahh, one more thing, and this comment probably applies to 2/4 not
this one, but if the intention is to shrink this "not supported yet"
check as the series progresses, in the earlier step the check would
need to make sure no pathspec is given, which is first supported in
4/4, I think.  It is not a big deal to require rerolling by itself,
bit if you are rerolling 2/4 for other reasons, then...
