Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B686C20437
	for <e@80x24.org>; Wed, 11 Oct 2017 00:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756650AbdJKAjP (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 20:39:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53900 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756608AbdJKAjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 20:39:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CEB8A4922;
        Tue, 10 Oct 2017 20:39:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uzDflcYizvtykWx3rUkV6uTlpFo=; b=GqBhhF
        W4e+VBpvX7ioMYwEyT68BtMr2k9mByyTHqLUqTPhfA2+zMwbQx8qpnBlZBJDE7Db
        7yhUlqzy+q1YV41Jc2im994UrzySz/l8kur6ZfuO1tmVkDn4gwZ/OScipdOJR+ek
        /pBMh2g92g7TuI6C09r471ktvNH8towCVfc58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PeILM1czwE+iJmLLZDv9t0tqgIU82CX4
        3Bec/WNXV9EuxF9iAORE1XSnr9KX90yZWsj1vfJYN1mOfsXl69WDmEUqFBiLabbj
        kxAfzgxReuTK8+UuftDOrHO0zMESrLvLgqRUcdpjwBHanpE/qrC5++RCX21cwUL3
        ovCgTRj6S7c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45939A4921;
        Tue, 10 Oct 2017 20:39:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A53B7A4920;
        Tue, 10 Oct 2017 20:39:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Simon Ruderich <simon@ruderich.org>,
        Git Mailing List <git@vger.kernel.org>,
        bturner@atlassian.com, Jeff Hostetler <git@jeffhostetler.com>,
        jonathantanmy@google.com, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention mechanisms
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-4-bmwill@google.com>
        <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
        <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com>
        <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
        <20171010210049.GA77383@google.com>
        <20171010211755.GY19555@aiede.mtv.corp.google.com>
Date:   Wed, 11 Oct 2017 09:39:05 +0900
In-Reply-To: <20171010211755.GY19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 10 Oct 2017 14:17:55 -0700")
Message-ID: <xmqqvajmo6vq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9739DDC0-AE1C-11E7-A7A8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> If we want to make the advertised protocol versions on the server side
> configurable, I think it should be independent from the configuration
> for protocol versions to use on the client side.  Rationale:
>
>  - As a client-side user, I may want to (after reporting the bug, of
>    course!) blacklist certain protocol versions to work around server
>    bugs.  But this should not affect my behavior as a server --- in
>    my role as a server, these server-side bugs have no effect on me.
>
>  - As a server operator, I may want to (after reporting the bug, of
>    course!) blacklist certain protocol versions to work around client
>    bugs.  But this should not affect my behavior as a client --- in my
>    role as a client, these client-side bugs have no effect on me.

Good point.  

> Making the client-side case configurable seems important since Git is
> widely used in environments where it may not be easy to control the
> deployed version (so having configuration as an escape hatch is
> important).
>
> Making the server-side case configurable seems less important since
> Git server operators usually have tight control over the deployed Git
> version and can apply a targetted fix or workaround.

The above also suggests that the configuration variable that lets
you specify the protocol version should hint in its name which
direction of the protocol it controls.  Even if we decide that we'd
add only the variable for the initiator side for now, if it is
possible that we later may want to add another for the acceptor
side, we need to do it right from day one.

Perhaps protocol.connectVersion(s) vs protocol.acceptVersion(s) or
something like that?
