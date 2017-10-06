Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE982036B
	for <e@80x24.org>; Fri,  6 Oct 2017 09:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbdJFJkg (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 05:40:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61587 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752283AbdJFJke (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 05:40:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8AD5AD439;
        Fri,  6 Oct 2017 05:40:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TbxtIFQFRkFDt/X7Fxi/YqbIXRE=; b=vEwX44
        3F7zi74Rb9LtVy655pUWtVaiNva8OPobGIXk1Z1a3GxG94Ugf1Lb91gNp42oa9jR
        umTcQzuV7XyQNag3dQk6LsOP9iB7GX6L38y7s0RijEAYV4FAisJGcm7VnB9cRvoc
        jjgnrJ5BjYC4Gf1o+3PgrwSTwRUfzgU0bVvvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AkuSRQpVDXgwJFmKESnULRnOQzop/dcW
        IzzThE8oAzc4jgzhR2ZdZOhdis0VgDS8NTZpZr4inpgFF3RWbi+WQUq7KtSuzNF7
        B+49zd0meEsa9B5n6OHd/g8kw+0QbdCKYGHNvUaGEGFWJJC1QHPeAuJcP5hTOVPy
        FT/Gw9rFsKc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0E58AD438;
        Fri,  6 Oct 2017 05:40:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D5ECAD42B;
        Fri,  6 Oct 2017 05:40:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention mechanisms
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-4-bmwill@google.com>
        <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
Date:   Fri, 06 Oct 2017 18:40:31 +0900
In-Reply-To: <20171006090907.gbsgygulzj3bgqrg@ruderich.org> (Simon Ruderich's
        message of "Fri, 6 Oct 2017 11:09:07 +0200")
Message-ID: <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65FEC1F8-AA7A-11E7-AAB3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Ruderich <simon@ruderich.org> writes:

> Did you consider Stefan Beller's suggestion regarding a
> (white)list of allowed versions?
>
> On Mon, Sep 18, 2017 at 01:06:59PM -0700, Stefan Beller wrote:
>> Thinking about this, how about:
>>
>>   If not configured, we do as we want. (i.e. Git has full control over
>>   it's decision making process, which for now is "favor v0 over v1 as
>>   we are experimenting with v1". This strategy may change in the future
>>   to "prefer highest version number that both client and server can speak".)
>>
>>   If it is configured, "use highest configured number from the given set".
>>
>> ?
>
> It would also allow the server operator to configure only a
> specific set of versions (to handle the "version x is
> insecure/slow"-issue raised by Stefan Beller). The current code
> always uses the latest protocol supported by the git binary.

If we do anything less trivial than "highest supported by both" (and
I suspect we want to in the final production version), I'd prefer
the configuration to list versions one side supports in decreasing
order of preference (e.g. "v3 v0 v2"), and take the earliest from
this list that both sides know how to talk, so that we can skip
insecure versions altogether by omitting, and we can express that we
would rather avoid talking expensive versions unless there is no
other version that is understood by the other side.
