Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36F802047F
	for <e@80x24.org>; Tue,  1 Aug 2017 20:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdHAU0j (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 16:26:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54097 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752025AbdHAU0i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 16:26:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CC72AB4B2;
        Tue,  1 Aug 2017 16:26:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L77ltXNHvl5KGuWO0qmZZMKixcI=; b=cGrsVv
        T8O4dwxqw/lU5VdC7GRKTPu/2FL8QDLyKsghuXWfSb6w51B6Z023x31amiGi9sUM
        +uiHy4+Llta0WFSAgTte2RryjhmG82NJCz3T05FaD7xPesfiEtuDx7fM7sRDWSDV
        uqOXfLy1c2rsbOPlmmX2p7PqUjJw51P+AEjI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hcyJcmrqrxjy4yTB30xvpucINtpmTQUv
        43Xy/np6M6+tKzxWimOhwMQIbg1dC0dlK6VFCA2S2UPcZucVAQehJ8tv723RPoyk
        lFoZUr/4TioRz19brwuTHj0iBcl9RmutxEMGj1PMexu79Z90bOIJkM8Q8cZkSIF8
        YAiMOupiCdY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34347AB4B1;
        Tue,  1 Aug 2017 16:26:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B2EFAB4AF;
        Tue,  1 Aug 2017 16:26:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] convert any hard coded .gitmodules file string to the MACRO
References: <20170718190527.78049-4-bmwill@google.com>
        <20170731231142.15053-1-sbeller@google.com>
        <413e4f55-5f8b-a80f-775b-b456c4de8a46@jeffhostetler.com>
        <CAGZ79kY-H7rWW_h-k4fHXkwqfMJvd8MtGBooNH8J7PaA2Gj1Yg@mail.gmail.com>
Date:   Tue, 01 Aug 2017 13:26:29 -0700
In-Reply-To: <CAGZ79kY-H7rWW_h-k4fHXkwqfMJvd8MtGBooNH8J7PaA2Gj1Yg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 1 Aug 2017 10:35:29 -0700")
Message-ID: <xmqq4ltrf30q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3DB27EC-76F7-11E7-B41C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>>   @@ -233,18 +233,18 @@ void gitmodules_config(void)
>>>                 strbuf_addstr(&gitmodules_path, "/.gitmodules");
>>
>>
>> Did you mean to also change "/.gitmodules" ??
>
> Goog point. We should pick that up as well. However as we do not have
> a macro for that, we'd have to have 2 calls to strbuf API
>
>     strbuf_addch(&sb, '/');
>     strbuf_addstr(&sb, GITMODULES);

Ehh, doesn't string literal concatenation work here?  I.e. something
like:

    strbuf_addstr(&gitmodules_path, "/" GITMODULES_FILE);


>>>                 if (pos < 0) { /* .gitmodules not found or isn't merged */
>>>                         pos = -1 - pos;
>>>                         if (active_nr > pos) {  /* there is a .gitmodules
>>> */
>>
>>
>> It might also be nice to change the literals in the comments to
>> use the macro.

The reason you want this patch is not like we want to make it easy
to rename the file to ".gitprojects" later, right?  The patch is
about avoiding misspelled string constant, like "/.gitmdoules",
without getting caught by the compiler, no?

Assuming that I am correctly guessing the intention, I think it is a
bad idea to rename these in the comments.


