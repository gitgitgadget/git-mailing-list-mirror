Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE140C2BBCA
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1F223D5A
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394865AbgLKLdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 06:33:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52223 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391679AbgLKLdg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 06:33:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 998AD97877;
        Fri, 11 Dec 2020 06:32:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=VdGZiuajtORPNgFD4lZzCJ/E4wg=; b=j/CalPzNLVmisyjypOWC
        rzI5MPgt4ob9mPnOcX//NNOIX1PA2hhRu3BgYXEYzJzDXhyLNA1gZV7OM/1UlHIs
        ehV0COzRibM0jM23PPAz3+idK+/837dlWPWgWKtHwHFj9md3B1BFgrhsUfi2YBoh
        1jAuA3HXGk30379ph8QWO0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=qbC+0D18ThBy7tibDqUAPAUr6/L5WEM80FfNN5gU0PBkt2
        NyrIBNx2L5jagckmY+pByS9/ZAU0ut0SH1SbI1HxKDZgK7wkJTOmGpjv+UC0GNaV
        Jl8wFzpZZGPzp0vNzQDVYZUaUSElsm/cyV5+lmkw7itbeJHpNDyqA0oRy10h4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 923EB97876;
        Fri, 11 Dec 2020 06:32:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1036C97870;
        Fri, 11 Dec 2020 06:32:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
Date:   Thu, 10 Dec 2020 23:17:24 -0800
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
        <xmqqk0tq1xf3.fsf@gitster.c.googlers.com>
        <20201210152715.GQ52960@mit.edu>
        <xmqqim99wm61.fsf@gitster.c.googlers.com>
        <CAMP44s2Po25VyHs-xQG0_oKhAOvPK_PNu5edQkYYsScZeBw1nw@mail.gmail.com>
Message-ID: <xmqqim98inml.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A17F3CE-3BA4-11EB-BBCE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Dec 10, 2020 at 12:28 PM Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> how much damage are we causing to
>> existing users who expect the command to work the way it currently
>> does?
>
> Zero. Because my proposal does *not* make the pull fail, it merely
> prints a warning that it will change in the future.

The approach to hold the "future" patch of and keep giving a
"warning" is still likely to cause damage to people like Ted and
Dscho (both gave examples of workflowsand automation that currently
happily creating merges as the user expects, while the user just
ignores the warning, without being configured at all), when finally
the "future" patch (after fixing the test breakages, of course)
lands.  They just ignored the current loud messages---I do not see
any reason to expect the updated "warning" would have any effect on
them and help them to prepare for the future default change.

It is either being dishonest or deliberatly closing eyes to say
"Zero" after hearing what they said, I would have to say.



