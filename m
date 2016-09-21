Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C001F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758687AbcIUSBT (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:01:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50241 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756159AbcIUSBR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:01:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5806A3F3D6;
        Wed, 21 Sep 2016 14:01:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tKdFGXenuvkU
        ts8fjYgr2+qkJeE=; b=w12+zMOUQOH1yvdqJ8DU4jFa+HLrpvSXBOE82NbjkZx6
        2QOYpV/8M4YHR+cJAEwDZ+KBo3hHdOIQiH3DAD50vBGFYX2bD9Igi9eAr53C99+Q
        OP5jgkcZ54zfhLAVkBO8hjVTTd/vqmONQ59Wg5su+rPy42YDVxc9nv/N+7aDekQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RZ4IzH
        728tAI8PVcCZRZEY/3q+nFvpIb6/B19OaPLGhPiONYFGDC5N2/4WqOzVEBmvwy4J
        bN4guoDAjlau0/84kYdiviCdCIDh30ucAxKvvti2O/AGdPoUOVUHHKqVY3SDtiNW
        SuBdXOoqQ/BBuzIUIvmJNYjuSSHC3HOqJUmkU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50A313F3D5;
        Wed, 21 Sep 2016 14:01:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C59AA3F3D4;
        Wed, 21 Sep 2016 14:01:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] gitweb: Link to "git describe"'d commits in log messages
References: <20160921114428.28664-1-avarab@gmail.com>
        <20160921114428.28664-3-avarab@gmail.com>
        <xmqqvaxp9oyp.fsf@gitster.mtv.corp.google.com>
        <ba9d9c82-4b5e-4d62-95f1-a1c56cfc70af@gmail.com>
Date:   Wed, 21 Sep 2016 11:01:12 -0700
In-Reply-To: <ba9d9c82-4b5e-4d62-95f1-a1c56cfc70af@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 21 Sep 2016 19:49:23
 +0200")
Message-ID: <xmqqy42l874n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 63395FA8-8025-11E6-84A4-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> When I saw 2/3 I wondered about one thing and 3/3 shares the same,
>> which is that we only use regex match and do not validate for a
>> false match.  Would it be too expensive...
>
> It's a matter of balance between false positives (and unresolving
> links) and performance...

Yes, and that is why I asked a simple yes-or-no question.  Would it
be too expensive?  Your answer seems to be yes.

Have we measured?  Is that really a bottleneck?  Would it help to
update parse_commits to call a new command "gitweb--helper" that
produces the result of what git_print_log would have done to its
$log argument, for example?

