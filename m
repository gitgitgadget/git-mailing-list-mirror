Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0D720C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbdLHRVl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:21:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54508 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750865AbdLHRVl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:21:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98712AAE5F;
        Fri,  8 Dec 2017 12:21:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=46IdRwfl1dhe0KZEP34nnatSM0E=; b=lij6X7
        suvNKQa5mTc+Lt730B6e3VvG3s1btanSlWVDwSqTYnajo25F5+tfwYGROA521jr5
        k2WBYz5gxmoVn5VMBbk6fwFSheLNPkV49BmhgRCWjwj3bYd/E6dOm5cg4NzEe7Zy
        pIGLiTsKrJIXlY+BueXTbtaZ0ZBVZ/5oxAIWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xLVdq1K600ISNjYgabxk/tdP43mpGy0T
        E/dvYj/4US5DkvSOk1SauATYWj+hDdwyItrM19wZuDg13lhYJkOf4nR1CEwszH2U
        CXl8nsepGDc6qTg2UPKEaLTr38ozelt56gaSkK6Cq9pbBk0UhQtzSg1G1zajnBkz
        g11+NS2uhzM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EEFDAAE5E;
        Fri,  8 Dec 2017 12:21:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0223BAAE5D;
        Fri,  8 Dec 2017 12:21:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
References: <20171208002447.20261-1-sbeller@google.com>
        <20171208002447.20261-2-sbeller@google.com>
        <xmqq1sk5b6rx.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 08 Dec 2017 09:21:38 -0800
In-Reply-To: <xmqq1sk5b6rx.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 08 Dec 2017 07:04:18 -0800")
Message-ID: <xmqqbmj99lul.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40BB0372-DC3C-11E7-9012-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
> ...
>> @@ -2883,6 +2884,8 @@ int prepare_revision_walk(struct rev_info *revs)
>>  		simplify_merges(revs);
>>  	if (revs->children.name)
>>  		set_children(revs);
>> +	if (revs->diffopt.blobfind)
>> +		revs->simplify_history = 0;
>>  	return 0;
>>  }
>
> It makes sense to clear this bit by default, but is this an
> unconditonal clearing?  In other words, is there a way for the user
> to countermand this default and ask for merge simplification from
> the command line, e.g. "diff --simplify-history --blobfind=<blob>"?

Looking at the places that assign to revs->simplify_history in
revision.c it seems that "this option turns the merge simplification
off unconditionally" is pretty much the norm, and this change just
follows suit.  So perhaps it is OK to let this pass, at least for
now.

