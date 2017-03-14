Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80197201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 19:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbdCNTsV (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 15:48:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62632 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750815AbdCNTsU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 15:48:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA7CC70A7C;
        Tue, 14 Mar 2017 15:48:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2+RUMm0WGtX5pkHRu3Ty0QFAubw=; b=kmo3ji
        F5MuLz8N6J+Eoqh327JqTbECFONCctxGPTL/Hd4ZR2YZpPJdamcla0iGg+C1ODhn
        hbr48IXhJyc0a8v6OuC3RHBOjOOQXoW7SXHiYOfmAgjM103+7X8Xdej7yMDYns/O
        Xj1eY3zqGdyeC/Z16A5EdJbjzLS9hiaVqqYjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JsT9hWGjq6suDLVCoyw4Q0/OCvFxvoCV
        DZah1KvX64TXaFbwcTfpDcsxCEZcgiBd+0lBqGIpnkLb490NS2z7Lj3GggCihMP3
        /fEsOW0/YPDsSqv0EX5OAjc4PdtzE6vFCwFqx1BwFNJzHgxn4L38us9gABzdSNHq
        dcOMENsNqNc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B267470A7B;
        Tue, 14 Mar 2017 15:48:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C21D70A79;
        Tue, 14 Mar 2017 15:48:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 10/10] submodule add: respect submodule.active and submodule.<name>.active
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-11-bmwill@google.com>
Date:   Tue, 14 Mar 2017 12:48:16 -0700
In-Reply-To: <20170313214341.172676-11-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 14:43:41 -0700")
Message-ID: <xmqqefxziqrj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BBA3338-08EF-11E7-83B0-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +	if git config --get submodule.active >/dev/null
> +	then
> +		# If the submodule being adding isn't already covered by the
> +		# current configured pathspec, set the submodule's active flag
> +		if ! git submodule--helper is-active "$sm_path"
> +		then
> +			git config --add submodule."$sm_name".active "true"
> +		fi
> +	else
> +		git config --add submodule."$sm_name".active "true"
> +	fi

Why "--add"?  That's a way to add new entry for multi-valued
configuration, but you do not care if the old value (if existed)
were false or true---you want to replace it to true here, no?

