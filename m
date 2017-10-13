Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA3520372
	for <e@80x24.org>; Fri, 13 Oct 2017 00:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbdJMAmj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 20:42:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54585 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753278AbdJMAmi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 20:42:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8399A6A97;
        Thu, 12 Oct 2017 20:42:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qo5l0DJfr3yP3EKyk/GIf2GgkLE=; b=WfexM9
        Yc1pGXyDoc9/q/RRUVI1muSMV28U14UrT4NSZBPqVemDzy7Q0V+ltSGVRjqNI+Pz
        MCfq+FLpe7hOsR5BBJxxFoJg9tBAH7eNEGT3eyrAtdcg6YUM+4Opj6TdUb4Yn0dH
        tE1vJoZXltMRUjRDKh/NWqy0Spi3r4a3XyLII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DV6NTJ/hz78kdf0SPXUQuuuOazsO7Thk
        +UvX6Vaxli05sr/9D9t9k4OOoAKK5IDAOtbk24NRK2SlxL0MbWPTtpEtQVtCNnyX
        Rb8g/oOJZIbZC9RNWDhgamZYLz0xhUvx9WlGzMvrw2pFkz8V3ua+BSvI/dTPxjyy
        gLVzrHb54y0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E001EA6A92;
        Thu, 12 Oct 2017 20:42:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25C7DA6A91;
        Thu, 12 Oct 2017 20:42:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v2 2/5] Update documentation for new directory and status logic
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
        <20171011133504.15049-1-jamill@microsoft.com>
        <20171011133504.15049-3-jamill@microsoft.com>
        <xmqqtvz513dm.fsf@gitster.mtv.corp.google.com>
        <c71a2580-ade3-c8d0-d566-272bf3bb572b@gmail.com>
Date:   Fri, 13 Oct 2017 09:42:36 +0900
In-Reply-To: <c71a2580-ade3-c8d0-d566-272bf3bb572b@gmail.com> (Jameson
        Miller's message of "Thu, 12 Oct 2017 16:54:28 -0400")
Message-ID: <xmqqshenx4hv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68E91B7C-AFAF-11E7-B15B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jameson.miller81@gmail.com> writes:

>>> +If this is set, files and directories that explicity match an ignore
>>> +pattern are reported. Implicity ignored directories (directories that
>>> +do not match an ignore pattern, but whose contents are all ignored)
>>> +are not reported, instead all of the contents are reported.
>> Makes me wonder if DIR_SHOW_IGNORED* should be splt out into a short
>> enum.  We have:
>>
>>   - Do not show ignored ones (0)
>>
>>   - Collect ignored ones (DIR_SHOW_IGNORED)
>>
>>   - Collect ignored and untracked ones separately (DIR_SHOW_IGNORED_TOO)
>>
>>   - Collect ignored and duntracked ones separately, but limit them to
>>     those mach exclude patterns explicitly (DIR_SHOW_IGNORED_TOO|...MODE_MATCHING)
>>
>> so we need two bits to fit a 4-possiblity enum.
>>
>> Then we do not have to worry about saying quirky things like A and B
>> are incompatible, and C makes sense only when B is set, etc.
> I could see a potential for other values for the "show ignored
> mode" flags - for example: "NORMAL", "MATCHING", "ALL"... Instead
> of making more change at this point in time, how would you feel
> about waiting until the next change in this area.
>
> If you would prefer for me to change these enums now, I can do
> that.

"Makes me wonder" was just that.  I was made to wonder.  I did not
have strong opinions either way.  You thought about the area of this
code longer than I did, so I do not mind you picking the course of
action that is best for the project, and if you think it is better
to wait until we know more about the vocabulary we want to support
before we restructure these flags, that is fine by me.

Thanks.


