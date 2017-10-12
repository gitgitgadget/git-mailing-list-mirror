Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17591FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 06:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751490AbdJLGPI (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 02:15:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55286 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751237AbdJLGPI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 02:15:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DFAB93017;
        Thu, 12 Oct 2017 02:15:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kFk7Tbe4Nq1Ni7dCZByGj+cFut4=; b=AB34Qw
        1NrMQbr0Hxb4pXP/oHCAHdeFw2JeoGC6MrF71LqXJcnYXydtxVvFV6/e2dhm3AO6
        Z10oDYgJ+5UmtRtoeJRHRoQB/CbigU3rVrSexX/GxlA7ZnGg80w0CT18nZeXyViZ
        pUL7Ar+Z7BXM3OlOU+9mNGBcBY8VzecKPJngE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aIkCaFIqXgBM1sB3MiWaxYGmpG9sC/np
        9ewrLexA03XNbK3x6DaJL8ojvcj/wntfvt7+nd4ntryWYLO7c+khy5WMaGnRfdOk
        zESDSMfrUz4VFQKgqlhFwmfr/K4xwjYvZfWNMJaCY28XNOFTfKtCgyVcE1IG2sra
        ROKwYuL/tnk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45A4C93016;
        Thu, 12 Oct 2017 02:15:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0C1E93015;
        Thu, 12 Oct 2017 02:15:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk configuration
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
        <20171012021007.7441-1-gitster@pobox.com>
        <20171012021007.7441-2-gitster@pobox.com>
        <20171012044724.GD155740@aiede.mtv.corp.google.com>
        <xmqqa80x0xcw.fsf@gitster.mtv.corp.google.com>
        <20171012054049.GF155740@aiede.mtv.corp.google.com>
Date:   Thu, 12 Oct 2017 15:15:05 +0900
In-Reply-To: <20171012054049.GF155740@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 11 Oct 2017 22:40:49 -0700")
Message-ID: <xmqq1sm828pi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B15E00F2-AF14-11E7-BBB6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Should we document this special case treatment of color.* in -c
>>> somewhere?  E.g.
>>
>> Perhaps, although I'd save that until we actually add the new option
>> to "git" potty, which hasn't happened yet, if I were thinking about
>> adding some text like that.  Also I'd call that --default-color=always
>> or something like that, to avoid having to answer: what are the
>> differences between these two --color thing in the following?
>>
>>     git --color=foo cmd --color=bar
>
> I agree that the color.status text in the example doc is unfortunate.
> But the surprising thing I found when writing that doc is that
> color.status ("git status", "git commit --dry-run") and
> color.interactive are the only items that needed it (aside from
> color.ui that needed it for those two).  All the other commands that
> use color already accept
>
> 	git cmd --color=bar

Ahh, I take it that you mean by "it" (in "needed it") the "git
potty" option, not a "--color=<what>" option individual "git cmd"
takes?  If so, then it makes sense to say "that's another way to
spell --color=always from the command line".

We need to be able to answer "why does '-c color.ui=always' work
only from the command line?", but I doubt we want to actively
encourage the use of it, though, so I dunno.

