Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3051F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 03:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbfJWDsk (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 23:48:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60203 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbfJWDsk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 23:48:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 558C03B6D1;
        Tue, 22 Oct 2019 23:48:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l3sWnWLEd+EZ6dNSnviePiIopQM=; b=T2EYxf
        jIyS+BeYRDUE4NQw5Ih49u8nPCISiyqMz4uUZIyuaD3VFp0JWKli3gWl0JgfcfuQ
        /rlrfh1J1JVDmnHrOaPuWCUh+1jplk5LE4gZOdlKMf+ge7IlYYAcA9WkQ35ArD0i
        1L6b8l6eWNwfHIXKWqdlOfy5ulNHe/zN3Lhtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fbl6zpB5TNsRBy9Xa+jwQpisjw0eS3nv
        IKTabH9WVxfo3Urc10vC1hF0uBnoWP8908ComHXgXLJJVjbAoSp68v22PXbBNnEo
        lZ1e3I+oTB8dhexI9POWXHPI+qWvFwcF8orRe2pOKS3ThVYx2QIpnth3hICCBKJx
        FFyQ0yZ5da4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CCE93B6D0;
        Tue, 22 Oct 2019 23:48:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B29683B6CF;
        Tue, 22 Oct 2019 23:48:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 13/17] read-tree: show progress by default
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <a229e1ee0cb96c5f8c2c5d430641c386bc082a2d.1571666187.git.gitgitgadget@gmail.com>
        <3de0f590-c75c-2470-232f-73a07876df88@gmail.com>
        <857e23df-c447-7297-df74-3546424386d9@gmail.com>
Date:   Wed, 23 Oct 2019 12:48:37 +0900
In-Reply-To: <857e23df-c447-7297-df74-3546424386d9@gmail.com> (Derrick
        Stolee's message of "Mon, 21 Oct 2019 11:14:08 -0400")
Message-ID: <xmqqimogi0kq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF60E514-F547-11E9-91E0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> I'm slightly wary of changing the output of plumbing commands
>> like this. If a script wants progress output it can already get
>> it by passing --verbose. With this change a script that does not
>> want that output now has to pass --no-verbose.
>
> If a script is calling this, then won't stderr not be a terminal window, and
> isatty(2) return 0?

Unless the script tries to capture the error output and react
differently depending on the error message from the plumbing (which
is not localized), iow most of the time, standard error stream is
left unredirected and likely to be connected to the terminal if the
script is driven from a terminal command line.

> Or, if the script is run with stderr passing through to
> a terminal, then the user would see progress while running the script, which
> seems like a side-effect but not one that will cause a broken script.

It will show unwanted output to the end users, no?  That is the
complaint about having to pass --no-verbose, if I understand
correctly, if the script does not want to show the progress output.

