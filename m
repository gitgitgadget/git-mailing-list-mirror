Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1CF1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 20:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbcK1UUK (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 15:20:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55823 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751654AbcK1UUI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 15:20:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B39453543;
        Mon, 28 Nov 2016 15:20:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+G9LqnIjoIBAM6VwFZHFkqBNiMw=; b=P+WfAV
        cNyLAJcZ+mRvQH5lcfNuAjqSYtEcTr49zljTdVSgRtMoqQpyjvzXC3ihWj4VinWO
        1PGO2X4V+I5t9rRrYPxgHnGZw+lSG1Jgjr/RdxmBYn7JfP7j4RTBH9O88HrwA/2Q
        hVhfHd/WsULhsSlzyINyhYo92lV/gp5zST67s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i+tfgYO5RkNK6juYVehg15aqO1j+Trbm
        g3lzItbhSlQ5ckMmUtGXs7JrHja+CaZ9dRDfBvWOL5jYu/Q/FOgbQ0hxOkhADHq0
        XynuEN9RuQQ7xHI3SRbEbG9LWcYmfHVyAPddxU3T6E/5UBHaMHjfygRrBfFGHNT4
        Gj4zjaf9GxQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 458EE53542;
        Mon, 28 Nov 2016 15:20:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9FFB953541;
        Mon, 28 Nov 2016 15:20:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 00/11] git worktree (re)move
References: <20161112022337.13317-1-pclouds@gmail.com>
        <20161128094319.16176-1-pclouds@gmail.com>
        <xmqqwpfnidxm.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 28 Nov 2016 12:20:05 -0800
In-Reply-To: <xmqqwpfnidxm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 28 Nov 2016 11:48:05 -0800")
Message-ID: <xmqqshqbicga.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D7BFF04-B5A8-11E6-94BE-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Does this round address the issue raised in 
>
>   http://public-inbox.org/git/alpine.DEB.2.20.1611161041040.3746@virtualbox
>
> by Dscho?
>
> Even if you are not tracking a fifo, for example, your working tree
> may have one created in t/trash* directory during testing, and
> letting platform "cp -r" taking care of it (if that is possible---I
> didn't look at the code that calls busybox copy to see if you are
> doing something exotic or just blindly copying everything in the
> directory) may turn out to be a more portable way to do this, and I
> suspect that the cost of copying one whole-tree would dominate the
> run_command() overhead.

Please do not take the above as me saying "you must spawn the
platform cp -r".  

A more traditional alternative solution seen on this list is to work
together, leveraging expertise of each participant.  From the build
log Dscho gave us, it seems that his Windows port lack at least
POSIX emulation for lchown, mknod, utimes and chown.  It is hard to
decide without involving Windows expert what the best way to deal
with it in the code (e.g. To stub or #ifdef out these calls?
Provide suitable emulation in compat/?  Something else?), and what
things other than these four are still missing.

