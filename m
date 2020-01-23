Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05686C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF59F2253D
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hmL9Fc7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAWTCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:02:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58150 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgAWTCt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:02:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C3C9B3E09;
        Thu, 23 Jan 2020 14:02:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=doP1YHM6mpxRUcjgaa5L8VGseMo=; b=hmL9Fc
        7zy4/EaV67G1ozPljmQRWaF0tersJOvmLrjPbcvfi8drR6juCzC28qTypGI/6/ol
        rd1XYhsCSj3SxHwC0a8HbOOltoPQEPTqI0amiT3F+f2DGn5xoaswyyEl2HCRJ7mv
        9vfGNQV4conCmBhkmkgTCDGy4y4M+dpSGElBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uyTSWJ0ubLBrQyphdgpB903qxEJAZWmj
        WRmvCwZxG9ymmCxpfoDq23nqKpaFFsAXIJ8gM+p0p8y023Wc7EQOpZPpTdjP5lUq
        3JUPf9F1CsQA4NmMAX7BnstCNBHIidG4RFAyjdL4Fvbi1qLyz8xGV2ZoQWxn7rbw
        TI3Po943Vzs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 74389B3E08;
        Thu, 23 Jan 2020 14:02:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 956F3B3DFD;
        Thu, 23 Jan 2020 14:02:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        ch <cr@onlinehome.de>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [REGRESSION] gitk can't be run from non-worktree folders
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
        <20200123163151.GC6837@szeder.dev>
        <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
Date:   Thu, 23 Jan 2020 11:02:42 -0800
In-Reply-To: <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 23 Jan 2020 11:36:49 -0500")
Message-ID: <xmqqpnfa3sj1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F012133A-3E12-11EA-BA2B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> It's a new regression introduced by 2d92ab32fd (rev-parse: make
> --show-toplevel without a worktree an error, 2019-11-19), as far as I
> can tell. I have many times used gitk on bare repositories as an
> interactive replacement for git-log, so this is a unfortunate bit of
> fallout from that change. That's not to say that 2d92ab32fd should be
> reverted, though... perhaps gitk itself needs a bit of a fix.

Curious.

There is a "proc gitworktree" that does use --show-toplevel but it
is fairly conservative and assumes these calls can fail.

    ...
    if {[catch {set _gitworktree [exec git rev-parse --show-toplevel]}]} {
        if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
	    catch {set _gitworktree [exec git config --get core.worktree]}
	    if {$_gitworktree eq ""} {
		set _gitworktree [file normalize ./[exec git rev-parse --show-cdup]]
	    }

However, there is this call

    set worktree [exec git rev-parse --show-toplevel]

at the top-level of the code.  I wonder if the obvious and minimum
fix would be sufficient, i.e.

    -set worktree [exec git rev-parse --show-toplevel]
    +set worktree [gitworktree]

around l.12546
