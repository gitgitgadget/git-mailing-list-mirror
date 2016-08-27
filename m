Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A404C1F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 20:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754806AbcH0Uxo (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 16:53:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53959 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752002AbcH0Uxn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 16:53:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2151B3804D;
        Sat, 27 Aug 2016 16:53:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d44Zmt2un0Cu+HSsmIWfiL/qy8Q=; b=a6mAVu
        9/UrDjSUbFHUPf/TwmqNsOa7D0wRSrvfvoED9Q1CpiovZn73Bt19B/sFglRP6ErI
        IyCaTbruFJGbGH0dj4YtnqibriN/PL/zLdnjfyKA7ab0odDCCbpfNCCll2dDjEzg
        vQydTUMgMV+z0ADCDRAbWVM1bdN/h+oDFcJlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ihv0tGXj6duddq4dJ6lNANoHddBF3Rif
        If1J+8oROv45KsrxrPRzdsnEEy8PYpNaLEvXq1CSOStvl1gLUw4DDnFjo0jioFmI
        f4Wo9bJaG7xSW5/QFKDACowtpKhL3zPbM6b7iuGpdUViC6b0csT8myfSnbIT2EpJ
        tq26d/8f5H0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10B183804C;
        Sat, 27 Aug 2016 16:53:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82D093804B;
        Sat, 27 Aug 2016 16:53:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v14 13/27] bisect--helper: `bisect_start` shell function partially in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6b9-5e500c96-9bc3-4a6b-beb9-b5988dc9ee85-000000@eu-west-1.amazonses.com>
        <xmqqd1kwn035.fsf@gitster.mtv.corp.google.com>
        <CAFZEwPMotQ1k0EZN-buEt9MhJUKhXLS8eB5zV5A3Qr-j=DEwfQ@mail.gmail.com>
Date:   Sat, 27 Aug 2016 13:53:29 -0700
In-Reply-To: <CAFZEwPMotQ1k0EZN-buEt9MhJUKhXLS8eB5zV5A3Qr-j=DEwfQ@mail.gmail.com>
        (Pranit Bauva's message of "Sun, 28 Aug 2016 01:17:10 +0530")
Message-ID: <xmqqzinyc4s6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5010B5C0-6C98-11E6-A5CB-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

>> I wonder the whole thing above is better restructured to avoid
>> repeated checks of the same thing.
>>
>>         if (is it 40-hex, i.e. detached?) {
>>                 stuff it to start_head;
>>         } else if (skip_prefix(head, "refs/heads/", &branchname)) {
>>                 do the "cogito" check;
>>                 stuff it to start_head;
>>         } else {
>>                 that's a strange symbolic ref HEAD you have there;
>>         }
>
> I guess it changes the behaviour. Its a strange symbolic ref if it
> does not start with "refs/heads".

I did not think my suggestion would change the behaviour at all.  It
would change the code structure a bit to make it more readable, though.
