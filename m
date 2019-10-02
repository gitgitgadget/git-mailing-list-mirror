Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26EB01F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 20:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfJBUDW (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 16:03:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59454 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfJBUDW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 16:03:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ECFB381FD0;
        Wed,  2 Oct 2019 16:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bAXWkXlujIURWcb/w7rMLUBEWtw=; b=PnR6mf
        pHgMSX9nd+lQ9ISGn08zw2Z5zHObRWy+HgjMCdFKMD/JfO9eR58rxnm7TAqrbtsv
        0XnSwmcKVWkpPM1Pnvy/1IXkH6lB8GJjalcKGat0izY8VZYMc97r0tba/H/O/9Ow
        SVehtAGeITU7rAwuOr6GtCms/4ExQaV2oCVt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fYnOgGHMeZ+D1cUambAWl1Wdk4/LcNPa
        S7MRRSjFW41uexkIwmHmgwhJGIeBabGmsahoZbsCoWUIulOy0nrT+wX6j7JJLtYz
        KhSw46fXYXrmUiGSKXt+0DCbqHF/EkC8aRRiY9nJNyyOzmk7CCKs28YBbJHmzmct
        AvO92WNUdyo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3D3281FCF;
        Wed,  2 Oct 2019 16:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1772181FCC;
        Wed,  2 Oct 2019 16:03:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [BUG] incorrect line numbers reported in git am
References: <20191002184546.GA22174@generichostname>
Date:   Thu, 03 Oct 2019 05:03:14 +0900
In-Reply-To: <20191002184546.GA22174@generichostname> (Denton Liu's message of
        "Wed, 2 Oct 2019 11:45:46 -0700")
Message-ID: <xmqq8sq2ewzh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC859DA6-E54F-11E9-882D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> which is in the middle of the log message. I expect the line to be
> reported as something in the range of 198-203,...

That comes from not knowing who is complaining and what it is
reading.  In this case, "git apply" issues a warning because it is
fed .git/rebase-apply/patch file, which is the output of mailinfo
that parses header & log message out, leaves the message in a
separate 'msg' file in the same directory and stores the rest in
that 'patch' file.  And it is line 87 that has problems.
