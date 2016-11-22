Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B72E51FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 19:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbcKVTQP (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 14:16:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65275 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756291AbcKVTQN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 14:16:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FF085175B;
        Tue, 22 Nov 2016 14:16:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gPnE43rrhGj/rvt654XVIG6UIFM=; b=bTmLet
        AjtzEo/+De7KIRT8TY0+ixL3Fjn9x/5a90ncklX6DVbbRKGTmJROt2TlsQIlvgew
        wYTcPvKLEhcAwBEGt8ZVQm/GrGBhJSROmR88o6TLTC1xWZy4j1Z7jwR454SITvKK
        X17X1qhnhGR16t1BlGeqtJ8PlOqJgovTtf6bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CtWjQYyRYlVGPeXAkU4u0+gCbG2el+1k
        Qi1FNnp0Ejlb+hQKPot9dGYpJ4dV5hS48MqMxL5bW5b2c04wEKN3EGgt6l1kEw9h
        i7IybMQiYz3FaC+FDfs2jY1gd5KzSqXt6sRhxftuVmt827waO1C/zllStkK05qwK
        pA4xQTpRYbo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 777135175A;
        Tue, 22 Nov 2016 14:16:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF40A51759;
        Tue, 22 Nov 2016 14:16:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Pat Thoyts <patthoyts@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: pass the branch name to git merge
References: <6a6dd0b9-436d-327f-c33d-e5cce078b3a0@kdbg.org>
Date:   Tue, 22 Nov 2016 11:16:10 -0800
In-Reply-To: <6a6dd0b9-436d-327f-c33d-e5cce078b3a0@kdbg.org> (Johannes Sixt's
        message of "Tue, 22 Nov 2016 18:52:52 +0100")
Message-ID: <xmqqvavfpbph.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 215BD3A6-B0E8-11E6-ABBF-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> The recent rewrite of the 'git merge' invocation in b5f325cb
> (git-gui: stop using deprecated merge syntax) replaced the
> subsidiary call of 'git fmt-merge-msg' to take advantage of
> the capability of 'git merge' that can construct a merge log
> message when the rev being merged is FETCH_HEAD.
>
> A disadvantage of this method is, though, that the conflict
> markers are augmented with a raw SHA1 instead of a symbolic
> branch name.

Can't this be handled on the "git merge FETCH_HEAD" codepath
instead?  The codepath already does enough "magic" things to
FETCH_HEAD like skipping 'not-for-merge' entries and also knows
about the original refnames the commits to be merged came from.
