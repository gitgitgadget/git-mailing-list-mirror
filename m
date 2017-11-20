Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53ED0202A0
	for <e@80x24.org>; Mon, 20 Nov 2017 00:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdKTALK (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 19:11:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58312 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751043AbdKTALJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 19:11:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A6CBB4B2D;
        Sun, 19 Nov 2017 19:11:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6ZdTD/O6+fHK/5CheqRdtuyMqlk=; b=uDZPY7
        tN/le5uqP4ybngZLQGaKACXC2JphPCxm4NYfOgekU30U/IIq+HpBIWnwkcfl0bAW
        Dg7TLKptmytkcXq2jfu38l/rq39MgXy31zAdc3RDJa8/8M8605YUaAiiqAKdxAwX
        JwEtLZ90wucSEozPxQ8hL2RYK1fNy/xUrynFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MqxzR84VNLencMhP+gHpTnyP6S7c9kdw
        W78ivQ1xwtKrAw9hZNsH0n7B40kchIwJgr8bda2IaIE8nKzEUbZqoBXauO0bvwME
        MliRKNaRno71gVn2peeGF0vUlUUKCQofb54nRaSVkevI8SH+BnbElAv6wRe4JAi0
        Nx4W7DPglz0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 229D6B4B2C;
        Sun, 19 Nov 2017 19:11:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7FF58B4B2B;
        Sun, 19 Nov 2017 19:11:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] launch_editor(): indicate that Git waits for user input
References: <20171117135109.18071-1-lars.schneider@autodesk.com>
        <CAPig+cQ3a0guJUhnbktrjs6fL6mSrUXmPqR0BafEAOhVr7Sy-w@mail.gmail.com>
        <xmqqh8tsqs83.fsf@gitster.mtv.corp.google.com>
        <d53a655b-f51e-3f44-23db-581071010fd2@gmail.com>
Date:   Mon, 20 Nov 2017 09:11:06 +0900
In-Reply-To: <d53a655b-f51e-3f44-23db-581071010fd2@gmail.com> (Kaartic
        Sivaraam's message of "Sun, 19 Nov 2017 23:19:51 +0530")
Message-ID: <xmqqvai5ollx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E4D3488-CD87-11E7-85B5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>>> However, it's not clear how much benefit you gain from stashing this
>>> away in a static variable. Premature optimization?
>>
>> The variable being "static" could be (but it was done primarily
>> because it allowed me not to worry about freeing),

The current code happens to be safe because I do not allocate.  I do
not know what others will do to the code in the future, and at that
point, instinct kicks in to futureproof against the worst ;-).

>>> Should printing of close_notice be done before the error()? Otherwise,
>>> you get this:
>>>
>>> --- 8< ---
>>> Launched your editor (...) ...There was a problem...
>>> --- 8< ---
>>
>> In my version with a far shorter message, I deliberately chose not
>> to clear the notice.  We ran the editor, and we saw a problem.  That
>> is what happened and that is what will be left on the terminal.
>>
>
> It might be a good thing to keep the notice but I think it would be
> better to have that error message in a "new line". I'm not sure if
> it's possible or not.

Of course it is possible, if you really wanted to.  The code knows
if it gave the "we launched and waiting for you" notice, so it can
maintain not just one (i.e. "how I close the notice?") but another
one (i.e. "how I do so upon an error?") and use it in the error
codepath.

