Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D75C4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 18:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77EB620775
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 18:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aiT28sZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgD0Syo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:54:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64801 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgD0Syo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 14:54:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DD8F5BA54;
        Mon, 27 Apr 2020 14:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LLPXUWr6/vxsf4o6x+EkDE+94ag=; b=aiT28s
        ZiKx2HNDCcrlht+CCgCmiETUilkoS7lisz11sJfefDfD4J1+oxdP+auOQexp0K/N
        uPLVQVHbzVoSHM1dY7Pk3thTj89k9jaZnxshxiTsxTiKxY1JwDx/CdTgo1eGKTCJ
        KclpLWDYPogkffW2Y/iUjsfep0dyEpG52UUWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HbIvNA9H3uCRw/s+NnAq87bZ7XlvqP9e
        /ZYFFMnBuaL8oJeVt/sOyt//BZdRe29oQlC6m/symVFQ/wR1RhXCLt2e2mFQRTH/
        JtXv+vw+g28hwW/oqYx8ww3Z+NUwS9tzR6Z8/rrhUgM2Kh1JXU81YtHF/9iJYc3M
        fWR+E3J1vnY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64C775BA53;
        Mon, 27 Apr 2020 14:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E11A15BA49;
        Mon, 27 Apr 2020 14:54:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andrew White <andrew.white@audinate.com>
Subject: Re: [PATCH] push: unset PARSE_OPT_OPTARG for --recurse-submodules
References: <346FFB0C-7419-4E2D-B593-9F64F9403D11@audinatedante.onmicrosoft.com>
        <c2b92691ca85029fde3bd6969252cc827ca697b5.1587969824.git.liu.denton@gmail.com>
        <20200427120225.GB1718141@coredump.intra.peff.net>
Date:   Mon, 27 Apr 2020 11:54:41 -0700
In-Reply-To: <20200427120225.GB1718141@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 27 Apr 2020 08:02:25 -0400")
Message-ID: <xmqq7dy092tq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D9C6110-88B8-11EA-8FDE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> @@ -554,7 +552,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>>  		  PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option },
>>  		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
>>  			N_("control recursive pushing of submodules"),
>> -			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
>> +			0, option_parse_recurse_submodules },
>
> This could collapse down to OPT_CALLBACK() now, though I don't think
> it's a big deal either way.

I would prefer to see OPT_CALLBACK() used; it would send a strong
signal that this place is using the canned bog-standard and boring
pattern, and nothing fancy is going on.

Thanks.
