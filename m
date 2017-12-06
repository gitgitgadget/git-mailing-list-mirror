Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C73220C32
	for <e@80x24.org>; Wed,  6 Dec 2017 21:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbdLFV7j (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 16:59:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51706 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752085AbdLFV7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 16:59:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DFFEB1CBC;
        Wed,  6 Dec 2017 16:59:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XicJGmfpdaspxuUEO4GYXitYAVM=; b=LqtNlM
        RyAxm+JvOm/mzaq9aaoBHVOyI0+IDOd9e2cT71eHkHnHwVrrXWKgFd4YAnLlr1jv
        VntmjpaUFEuKgI37zMdI/hcCFOnv5QoJP2hV40COZsng5Im1/4uyv2U55kPIGWZv
        9tDEpGWJZsIoDKn84+2o5XCKlwixNRpfCeoBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hkgGrFSiaNxKKs1kwVDP4BlnElJr/jAA
        JdCK8M3r0RGrAFRHO9o9y2pgAOyRPLaioLNA8UKzbf0fmKLHbNlBTRBY4zXMmCWf
        Spr2zqajN8SG6TyiGuWSAj7wJCuIZ4tBr/18LIKR1b5zxj8u2KxYEZRHmDo/1YvP
        itcqM7SoPig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 960D8B1CBB;
        Wed,  6 Dec 2017 16:59:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3419B1CBA;
        Wed,  6 Dec 2017 16:59:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 04/15] upload-pack: convert to a builtin
References: <20171020171839.4188-1-bmwill@google.com>
        <20171204235823.63299-1-bmwill@google.com>
        <20171204235823.63299-5-bmwill@google.com>
Date:   Wed, 06 Dec 2017 13:59:33 -0800
In-Reply-To: <20171204235823.63299-5-bmwill@google.com> (Brandon Williams's
        message of "Mon, 4 Dec 2017 15:58:12 -0800")
Message-ID: <xmqqr2s7frga.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEE52768-DAD0-11E7-97C9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> In order to allow for code sharing with the server-side of fetch in
> protocol-v2 convert upload-pack to be a builtin.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

This looks obvious and straight-forward to a cursory look.

I vaguely recalled and feared that we on purpose kept this program
separate from the rest of the system for a reason, but my mailing
list search is coming up empty.

>  Makefile      | 3 ++-
>  builtin.h     | 1 +
>  git.c         | 1 +
>  upload-pack.c | 2 +-
>  4 files changed, 5 insertions(+), 2 deletions(-)
> ...
> diff --git a/upload-pack.c b/upload-pack.c
> index ef99a029c..2d16952a3 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1033,7 +1033,7 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
>  	return parse_hide_refs_config(var, value, "uploadpack");
>  }
>  
> -int cmd_main(int argc, const char **argv)
> +int cmd_upload_pack(int argc, const char **argv, const char *prefix)
>  {
>  	const char *dir;
>  	int strict = 0;

Shouldn't this file be moved to builtin/ directory, though?
