Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA13C20135
	for <e@80x24.org>; Wed,  8 Mar 2017 22:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754619AbdCHWnO (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 17:43:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61990 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750869AbdCHWnM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 17:43:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9DFA6F1E7;
        Wed,  8 Mar 2017 17:43:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uI+rKHloBYZXc1hyHZeqd9+qP6o=; b=EeVIzs
        JEEpPrfM4HcViSnqcWShNO5i1apIHyJrNvCgexzlwqx0QF2MEFEKXYgOUi/clP2e
        dc2RQKTW/wh8XkB6HujTJvk/qkAPqDxQDhl2b4RA27FwISf+GskpY0hU20i4KSlm
        w0kfNLuSMmmBI6MHwKi4DQNN0rO2AyzjV9RIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u0WAuFA8lggIFCjogly8Z2EnlAV+EOUM
        UgtyVoy9yGTXun8akxp+VZs6OPhy4qkJcvKyeb2cBXHkrGl/TeULQNGmsZ19DLxt
        4gUrLxVhmzHCS/6LMdCjNLoGE93HBo8XpwQ+WnFSzcGecgNwEEDH8cDKVnd8Mm9U
        P/djlaq65WM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D33D26F1E6;
        Wed,  8 Mar 2017 17:43:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 546E76F1E5;
        Wed,  8 Mar 2017 17:43:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
References: <cover.1488506615.git.johannes.schindelin@gmx.de>
        <cover.1488562287.git.johannes.schindelin@gmx.de>
        <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
        <alpine.DEB.2.20.1703071314180.3767@virtualbox>
        <20170308073035.pt5ysp6bzpozoqps@sigill.intra.peff.net>
        <xmqqy3wf3dbo.fsf@gitster.mtv.corp.google.com>
        <20170308174237.cm6e5uvve6hu7lpf@sigill.intra.peff.net>
Date:   Wed, 08 Mar 2017 14:43:09 -0800
In-Reply-To: <20170308174237.cm6e5uvve6hu7lpf@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 8 Mar 2017 12:42:37 -0500")
Message-ID: <xmqqinnj1jb6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B10F026-0450-11E7-9110-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Or are you discussing a more general issue, iow, anything that can
>> work without repository (i.e. those who do _gently version of the
>> setup and act on *nongit_ok) should pretend as if there were no
>> (broken) repository and take the "no we are not in a repository"
>> codepath?
>
> Yes, exactly.  It would have been less confusing if I picked something
> that passed nongit_ok. Like hash-object:
>
>   $ git init
>   $ echo content >file
>   $ git hash-object file
>   d95f3ad14dee633a758d2e331151e950dd13e4ed
>
>   $ echo '[core]repositoryformatversion = 10' >.git/config
>   $ git hash-object file
>   warning: Expected git repo version <= 1, found 10
>   d95f3ad14dee633a758d2e331151e950dd13e4ed
>
> The warning is fine and reasonable here. But then:
>
>   $ echo '[core]repositoryformatversion = foobar' >.git/config
>   $ git hash-object file
>   fatal: bad numeric config value 'foobar' for 'core.repositoryformatversion' in file .git/config: invalid unit
>
> That's wrong. We're supposed to be gentle. And ditto:
>
>   $ echo '[co' >.git/config
>   $ git hash-object file
>   fatal: bad config line 1 in file .git/config
>
> Those last two should issue a warning at most, and then let the command
> continue.

Yeah, I agree with that as one of the worthy goals.  IIUC, we
decided to leave that outside of this series and later fix on top,
which is fine by me, too.

