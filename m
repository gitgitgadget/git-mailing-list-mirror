Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D6D20986
	for <e@80x24.org>; Tue,  4 Oct 2016 18:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbcJDSAN (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 14:00:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60245 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750700AbcJDSAN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 14:00:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3D3741A8C;
        Tue,  4 Oct 2016 14:00:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cXUxda/kPDVfB5xinFLEie7UVD8=; b=uJHHTI
        /0FH7QxRQPLbVWNF/Heq7BFZtg3eSLIPhq3J/l0LSk0WCK+mIzCUubJ9yqQEVSSA
        0BYxVTOn9F8xdjhUdVTUGIiTWjo0UneaO7ZH/ZRXJfn6A3HBLEperQseOadAGEsV
        LhXzQf9zmr71NdFqxzjsswdna5XgFiFlIOaz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wcnDIa0WzLt3X0huOqxmvuyNtlPntrxD
        xTabc0aewNIsjw0w342Jgvl7IWGh1lKaxyE8AgfKicpuH1qcMLy4gVUFfqotblhn
        J/ps6MjyV+TMADMIebzKO+YP7DnEJtump/QIf7itNGW8HDzo0eD06DHOtXmRyNOj
        pVlm2q26Buk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBD7E41A8B;
        Tue,  4 Oct 2016 14:00:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60F2E41A8A;
        Tue,  4 Oct 2016 14:00:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] push: change submodule default to check
References: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
        <20161004164036.6584-1-sbeller@google.com>
Date:   Tue, 04 Oct 2016 11:00:09 -0700
In-Reply-To: <20161004164036.6584-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 4 Oct 2016 09:40:36 -0700")
Message-ID: <xmqqfuocuh92.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64CC2C42-8A5C-11E6-B23A-43C713518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +static void preset_submodule_default(void)
> +{
> +	if (file_exists(".gitmodules"))

Don't we need to see if we are in a bare repository?

> +		recurse_submodules = RECURSE_SUBMODULES_CHECK;
> +	else
> +		recurse_submodules = RECURSE_SUBMODULES_DEFAULT;

Hmph, why "_DEFAULT" not "_OFF"?

> +}
> +
>  static void add_refspec(const char *ref)
>  {
>  	refspec_nr++;
> @@ -552,6 +560,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  	};
>  
>  	packet_trace_identity("push");
> +	preset_submodule_default();
>  	git_config(git_push_config, &flags);
>  	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
>  	set_push_cert_flags(&flags, push_cert);
