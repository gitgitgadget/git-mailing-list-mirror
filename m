Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1CD2047F
	for <e@80x24.org>; Mon, 25 Sep 2017 05:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbdIYFxc (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 01:53:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57004 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753159AbdIYFxb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 01:53:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D548A9E47E;
        Mon, 25 Sep 2017 01:53:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lM+GOJbCjeBC4UpL2YGqjSwTL5g=; b=RtAkbj
        bxGDcBB1haTPFvAgJXL82s8aaeOgwsuh+grqgocRDUTjkoqrrp6GE3dSFLSFPBVa
        v5AlwGaZP8Cjjr9UuoSiFHL7XcvzkfMQyCWOL6aWPk3Uer7gHS9jHk5GBWn01wka
        jJzxqPQ55CiJ8guij1KiCN8cit2VMc1tMNzhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CUYjqpiC37KzbXGFQ6uWWJ5TD8Ok8vuy
        R86K5fpFrsK0Byp/LLRAIR/M4W/FqOZWCLmQtKPn9Eb49Vh01265R3cP1jd/mzDj
        6j6dWiKftZoVHU+Q7TsaRa1jOkaumXvqg+q53W4SjH20nAfBmi3Fkg1xbKlE3amw
        c7Xas9R3wlU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE0FD9E47D;
        Mon, 25 Sep 2017 01:53:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32EDE9E47C;
        Mon, 25 Sep 2017 01:53:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Casey <drafnel@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/3] parse-options: only insert newline in help text if needed
References: <1506312485-8370-1-git-send-email-drafnel@gmail.com>
        <1506312485-8370-3-git-send-email-drafnel@gmail.com>
        <xmqqing7e3qs.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 25 Sep 2017 14:53:28 +0900
In-Reply-To: <xmqqing7e3qs.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 25 Sep 2017 14:39:23 +0900")
Message-ID: <xmqqefqve33b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB8666EC-A1B5-11E7-9657-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Casey <drafnel@gmail.com> writes:
>
>> Currently, when parse_options() produces a help message it always emits
>> a blank line after the usage text to separate it from the options text.
>> If the option spec does not define any switches, or only defines hidden
>> switches that will not be displayed, then the help text will end up with
>> two trailing blank lines instead of one.  Let's defer emitting the blank
>> line between the usage text and the options text until it is clear that
>> the options section will not be empty.
>
> This somehow looks familiar.  I think (together with the fix in 2/3)
> this makes it definitely better.  
>
> I also wonder if we want the final blank line, but that is sort-of a
> different issue.
>
> Thanks.

Oh, no wonder that this looked familiar.  It solves the same issue
as 48b8d3cf ("usage_with_options: omit double new line on empty
option list", 2017-08-25) and of course it conflicts with it.

I find the solution presented with this patch is more direct and
straightforward, leaving less chance to future breakage.  Besides
it comes with tests ;-), so perhaps I should drop the other one.


