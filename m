Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B2520D09
	for <e@80x24.org>; Mon, 17 Apr 2017 03:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbdDQDbl (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 23:31:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64796 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932441AbdDQDbk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 23:31:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55FC28BFA4;
        Sun, 16 Apr 2017 23:31:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VmCF+Eznn+sWnrxHusDtT8b0UPs=; b=cN+tg+
        hM2I3PwqmQ7+P75FHemVpu1lc+X2v4GxNf/9hhGZJAUZrSFVcKwAQ9UXVwGPDu1Q
        ck0oh9dnqtTtmNW7HVvGmqg8nyLhwrLPd/QTfwlmMVqwpZ6X5o3MWxT9f/hFDJ+A
        x5WoW3pi7DClMqfAS4WtfjuWrMn98XLvc/+4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TSVCps5lfX/o1vR/mQmWyqGqysRZvLlj
        gCmdkG740Nm4G1L69L3e8hnp1fpmmy/BAJxrH3TiPZ+4TPNzUJZovqL9DYVDWCkl
        5s8gvSPMWHJl32RLs7bRoB0M8TKA9qXpyrzL7kt0+WSM4eu3p+5hV5kOnqi19cbo
        cwZ9rChzJyc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DF2C8BFA3;
        Sun, 16 Apr 2017 23:31:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9B238BFA2;
        Sun, 16 Apr 2017 23:31:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        benpeart@microsoft.com, christian.couder@gmail.com
Subject: Re: [PATCH v5 4/8] convert: Separate generic structures and variables from the filter specific ones
References: <20170407120354.17736-1-benpeart@microsoft.com>
        <20170407120354.17736-5-benpeart@microsoft.com>
        <48FA4601-0819-4DE2-943A-7A791BA7C583@gmail.com>
Date:   Sun, 16 Apr 2017 20:31:37 -0700
In-Reply-To: <48FA4601-0819-4DE2-943A-7A791BA7C583@gmail.com> (Lars
        Schneider's message of "Mon, 10 Apr 2017 12:18:45 +0200")
Message-ID: <xmqqmvbfk8va.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DC293E0-231E-11E7-B77C-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> -static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
>> +static struct subprocess_entry *find_multi_file_filter_entry(const char *cmd)
>
> I am curious why you removed the hashmap parameter (here and in other pars of this patch). 
> I know the parameter is not strictly necessary as the hashmap is a global variable anyways. 
> However, I think it eases code maintainability in the long run if a function is "as pure as 
> possible" (IOW does rely on global state as less as possible).

If the original relied on a global hashmap and this update kept the
code like so, I wouldn't mind the end result of this series
(i.e. rely on it being global).  But that is not the case.  It is
making the code worse by stopping passing the hashmap through the
callchain.
