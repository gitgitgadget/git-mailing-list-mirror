Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE98C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 21:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiAMVhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 16:37:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56092 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiAMVhL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 16:37:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BBA710924A;
        Thu, 13 Jan 2022 16:37:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YFZbEfc4XQHjpPXtsr7R5VqtSiMBU/XZ+kAvhN
        YAIfs=; b=tvRijKF/sfhwUAA7DxsuQXdSVEovbHC0g5Y0MfQuXrv2xd9lMU/+WG
        Nz6dRLnoE+gzrHzrYqbL1/0I72s++2WQ0qD5kLqPbuLA8/XY7vfXWoInjpwHqoZu
        I1UqiqVWxpOrQ3d3YXF1T+AZy2Sfy6Yx2Dv8XHTfgeRYhQTvm8vck=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40FAB109249;
        Thu, 13 Jan 2022 16:37:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97C23109247;
        Thu, 13 Jan 2022 16:37:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/3] reftable: remove unreachable "return" statements
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
        <patch-2.3-7a6a69314b5-20220111T163908Z-avarab@gmail.com>
        <Yd3XpLaZ3qc25PzQ@nand.local>
        <220112.865yqpxge2.gmgdl@evledraar.gmail.com>
        <9ce034fd-b696-60d2-c292-98285aff180a@kdbg.org>
Date:   Thu, 13 Jan 2022 13:37:08 -0800
In-Reply-To: <9ce034fd-b696-60d2-c292-98285aff180a@kdbg.org> (Johannes Sixt's
        message of "Thu, 13 Jan 2022 21:17:30 +0100")
Message-ID: <xmqqlezjgvwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F649054A-74B8-11EC-A69E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Why not just sidestep the problematic case:
>
> diff --git a/reftable/refname.c b/reftable/refname.c
> index 9573496932..4f89956187 100644
> --- a/reftable/refname.c
> +++ b/reftable/refname.c
> @@ -120,17 +120,17 @@ static int modification_has_ref_with_prefix(struct modification *mod,
>  static int validate_refname(const char *name)
>  {
>  	while (1) {
>  		char *next = strchr(name, '/');
>  		if (!*name) {
>  			return REFTABLE_REFNAME_ERROR;
>  		}
>  		if (!next) {
> -			return 0;
> +			break;
>  		}
>  		if (next - name == 0 || (next - name == 1 && *name == '.') ||
>  		    (next - name == 2 && name[0] == '.' && name[1] == '.'))
>  			return REFTABLE_REFNAME_ERROR;
>  		name = next + 1;
>  	}
>  	return 0;
>  }
>
> Sure, there are returns in the loop, but they are clearly error cases.
> The regular exit is now at the end of the function.

;-)
