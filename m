Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89042047F
	for <e@80x24.org>; Wed, 26 Jul 2017 18:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbdGZSI0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 14:08:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60824 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750930AbdGZSI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 14:08:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87A758F6C6;
        Wed, 26 Jul 2017 14:08:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s0JWgNXXMcK5PdVcRuZmKyggAy4=; b=Fgnu48
        YygwK6bXcgu+YWzfYJ4oGPvOGJ62fv2i7lPwd1oW4sRx5LXKIihkmREL+i7g24Nu
        B3gFFR3Rxoa7uAjVI0IzS47BLj/pUBhcApQQwu3XLRELyHNfwP3Fi4sF+GcE7QuV
        xFCeywtnFLzSsNkwadm4Qkg0tPXYvfSsDm+XY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mvWCQbh+HwFLJwVyP5qXxf8ZVeEUVvdw
        YHSKVphswv2YqM+eJFiiWAXoTEJsS8NSnKDQevbJPdGFP3k1UMYfXmDCCmfwzXDE
        byv+5DjJ1yCdtjJJopQd4EVX2C3wCtKiPpflpPuorQTNAjpfHKJUi4d05sMriHgm
        4UNcLZHpfQw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F8158F6C5;
        Wed, 26 Jul 2017 14:08:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D98418F6C4;
        Wed, 26 Jul 2017 14:08:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: Reducing redundant build at Travis?
References: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com>
        <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com>
        <xmqqiniwt35e.fsf@gitster.mtv.corp.google.com>
        <20170714122401.uahk2fzvcjj3nwve@sigill.intra.peff.net>
        <xmqqbmonrrvr.fsf@gitster.mtv.corp.google.com>
        <20170714153224.6qnupcsa3pkig76k@sigill.intra.peff.net>
        <4BB4EDA1-58A5-45AD-8BEC-1CB06CDC23DD@gmail.com>
        <xmqq4lu7m94h.fsf@gitster.mtv.corp.google.com>
        <333FEA3F-BB43-4183-ADD1-14E73E668EA3@gmail.com>
        <xmqqo9sdhh9o.fsf@gitster.mtv.corp.google.com>
        <3056CC17-DDD5-406C-AA22-56309DF09DC8@gmail.com>
Date:   Wed, 26 Jul 2017 11:08:18 -0700
In-Reply-To: <3056CC17-DDD5-406C-AA22-56309DF09DC8@gmail.com> (Lars
        Schneider's message of "Wed, 26 Jul 2017 18:43:47 +0200")
Message-ID: <xmqqinifrrzh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67D291F6-722D-11E7-810B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> ... I started 
> to work on a patch that moves all TravisCI logic into scripts located 
> in the `ci` folder. These scripts share a `lib-travisci.sh` for common 
> functions such as `skip_branch_tip_with_tag ()` executed at the
> beginning of every script.
>
> Does this sound sensible to you? I am a bit busy with non Git related 
> work right now but I try to post the patch for you to review ASAP.

Absolutely fantastic.

Take your time; there is no need to rush and haste makes waste.

Thanks for working on this.
