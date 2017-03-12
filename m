Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E22201C2
	for <e@80x24.org>; Sun, 12 Mar 2017 03:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755658AbdCLDA6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 22:00:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60101 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755548AbdCLDA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 22:00:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2C32798F8;
        Sat, 11 Mar 2017 22:00:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3O7d/IXcG18f7787FEhl2WFUTCg=; b=qw0pUE
        GhGGCbj0SVP1vm2B2PsA/lOddwjttyCWAwC/NwoUjHHhjXDYoNyOOleViEvyyFF1
        LocjojsSGVBaHmRkpR4hipxWfXfWwnDIhtCUv9J82fZEOoZpACA8GMIJDvCEi4k4
        lgtOlBbC4/iS7407ajCMdsax+WRn7MC2WniSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bU/x2S5U+8aPHufnuCWItDjJHRk8w4X+
        BAQZvlgu9uqm21Y98v3pX0wTeGR79kA+jhp2USmMsiK5kx56XoU1fI5AdzxQkcup
        ICncqFoBvQMzxSOIVR6reHcU0khcjk3LfUoWImCLeLomzMM/Ei6lzPsqLyRjlK0I
        9MYrdYp+41s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AF22798F7;
        Sat, 11 Mar 2017 22:00:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A45C798F6;
        Sat, 11 Mar 2017 22:00:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jake Goulding <goulding@vivisimo.com>,
        Jeff King <peff@peff.net>, Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] tag: Implicitly supply --list given another list-like option
References: <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net>
        <20170311120855.16756-1-avarab@gmail.com>
        <CACBZZX4AJqvtZQdZZFU8+1So5G9F11_SN4=za+8p=KYim9SFSQ@mail.gmail.com>
        <xmqqefy3w6k0.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 11 Mar 2017 19:00:53 -0800
In-Reply-To: <xmqqefy3w6k0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 11 Mar 2017 18:51:59 -0800")
Message-ID: <xmqqa88rw656.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C0553D0-06D0-11E7-8463-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I haven't looked at the patch text of this one closely yet, but I
> think the goals of both make sense, so we would eventually want to
> have them both.
> ...
> So perhaps you would want this applied first, so that existing three
> can already benefit from "implicit --list" before waiting for the
> other one?

Ah, I see that you already have the other topic polished to v4
(sorry, but I am a bit behind the list traffic).  If it makes your
life easier, it is OK to make the current three to four by adding
"--no-contains" first and then make all/any of them imply "--list"
on top.  

IOW, either is fine.  Personally, I have a suspicion that sending
both at the same time, expecting the maintainer to be able to
resolve the potential conflicts correctly, would also be fine ;-)

Thanks.
