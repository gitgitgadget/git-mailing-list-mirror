Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C98A20986
	for <e@80x24.org>; Tue,  4 Oct 2016 18:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbcJDSCf (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 14:02:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63455 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753714AbcJDSCe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 14:02:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 860A641B0F;
        Tue,  4 Oct 2016 14:02:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LCcQt0UlsqYFuNjJs0LtQOdofVY=; b=YSjjKB
        LcLoyKUWzBwDq480GJhMNaP444Xj3qw8yyuOc8M6McHY3j1hDZL760170FcxsrLx
        DViBoUEGpOm9iE6515sRiZR3mD380Ad5WMv05WVo/2rSPlQeaofQHtvf+bNS8eS/
        kFp51fK0ZZHkbnovTZ6LmaKVUGwLDHH+hg9L0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w9T5b6TGgzoFsFAsnvzs/82IZ4qsw22N
        Oq1yyKqLi5Mwe69ZPMC9UU3/OabiQ0V105ARUfnxgrB4hEvTmCsHYAiMxjPO3KPD
        3CfGNv3xmHer77jhm7RbHgfyC1E9L5GTCrRo4VFM8xgToMj6jKzCgK5FB5W4rKAM
        13q9yYwbLAc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D93E41B0E;
        Tue,  4 Oct 2016 14:02:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00EB141B0D;
        Tue,  4 Oct 2016 14:02:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] push: change submodule default to check
References: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
        <20161004164036.6584-1-sbeller@google.com>
        <xmqqfuocuh92.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 04 Oct 2016 11:02:31 -0700
In-Reply-To: <xmqqfuocuh92.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 04 Oct 2016 11:00:09 -0700")
Message-ID: <xmqqbmz0uh54.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B933D74E-8A5C-11E6-8B37-43C713518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> +static void preset_submodule_default(void)
>> +{
>> +	if (file_exists(".gitmodules"))
>
> Don't we need to see if we are in a bare repository?
>
>> +		recurse_submodules = RECURSE_SUBMODULES_CHECK;
>> +	else
>> +		recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>
> Hmph, why "_DEFAULT" not "_OFF"?

... because you wanted to keep the same behaviour, i.e. keep
recurse_submodules set to _DEFAULT just like the compiled-in
initialization does.

Perhaps we can lose "else" clause altogether?
