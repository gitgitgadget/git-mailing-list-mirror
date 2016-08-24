Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA471F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 21:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757065AbcHXV0s (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 17:26:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54519 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757055AbcHXV0q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 17:26:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E661C37790;
        Wed, 24 Aug 2016 17:26:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lgIz5bM37WTpMOrl/EcOdI5pJ6U=; b=r/SePc
        Zcx8Fu2nkqrMvXooDTKDbEwDgO0qDQNsL8PTUEe61J7cje309VjCivQdRoQtfut5
        luNcvPfvX9n+48o37PLf6kn0ZiWUq0go36fDNQ+l7tk1qUttf7RW5ubMxxrFAxm2
        bg1UNEQjhkxlr1S65TpaoRl8LgYC8GFNGSGG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wPV0omN4TSb7lKuAN1AtErK3WWeUj/4+
        ZzOzW6BdO91EJwjHZjd49wi7bcoJLs+YTEo3ajBdXUGg193PJTsMy2h3ecGE7T22
        BXVtbLN+OmzTcVv1IAeyeZ0JfwPr0PvbNiWkuXOFozJPoUP1iDRXswkOL3SVBqmw
        2IPwTpB7RHY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF2013778F;
        Wed, 24 Aug 2016 17:26:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66EAD3778E;
        Wed, 24 Aug 2016 17:26:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        hvoigt@hvoigt.net, Jens.Lehmann@web.de, iveqy@iveqy.com,
        leandro.lucarella@sociomantic.com
Subject: Re: [PATCHv2] push: change submodule default to check
References: <20160824173017.24782-1-sbeller@google.com>
        <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
        <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 24 Aug 2016 14:26:43 -0700
In-Reply-To: <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 24 Aug 2016 12:37:58 -0700")
Message-ID: <xmqqtwe9oo30.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75500A56-6A41-11E6-B720-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> For instance, try this from a checkout of linux.git:
>>
>>   for i in no check; do
>> 	rm -rf dst.git
>> 	git init --bare dst.git
>> 	echo "==> Pushing with submodules=$i"
>> 	time git push --recurse-submodules=$i dst.git HEAD
>>   done
>>
>> The second case takes 30-40 seconds longer. This is a full push of
>> history, so it's an extreme case[1], but it's still rather unfortunate.

This actually bit me just now.  github.com/gitster/git.git is
mirror pushed, and it would seem to take forever, so I killed it,
and flipped the configuration variable off.  Which means the feature
won't ever get any testing from me in real life.

People, git.git is not a large project in any sense of the word.

Why wasn't it discovered that "push.recursesubmodules = check" is
UNUSABLE since it was introduced is simply beyond me.

I am mad (which is unusual for me, isn't it? -- I've seen somebody
else saying "I am mad", but I do not think I ever said it here).
