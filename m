Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20873C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A0F20728
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yJMxhzRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCCWWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:22:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51430 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCWWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 17:22:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0BABC77E1;
        Tue,  3 Mar 2020 17:22:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y3/rilfLF10JehWreQXCOIyH1RM=; b=yJMxhz
        RszgHlIV00oPHg4FxhdLDlvEdepy4zCYfxt3aJFDd5hjQO1U+OFBWuPwr+Zyf+4v
        6bLaD80YB2MR3POGogWFf5wBg4g1/L7LgKdaf8S/JCHmx6gR1zkW6BlUhNqYyHMx
        Ac49dBIWIeUSZ02qnPeijoMw+IfLzR9OCBXkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Va5bnBtcV5K4tMXJ0n0epNRBstzpD47F
        GCfXccruTJ1WUwvkyG8WE1Bl/3057XXVESeZ9ykkMJeEp+prFRv64xRghEeln9yF
        VdxJ2JaambNcyqRIocxwBpppAbPiJFY0dXClQ172W+Ik+DQZBERUR9/ImcgNG6mQ
        HrOXgqRGhFc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C885FC77E0;
        Tue,  3 Mar 2020 17:22:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F24B0C77DF;
        Tue,  3 Mar 2020 17:22:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v2 1/2] remote: drop "explicit" parameter from remote_ref_for_branch()
References: <20200302133217.GA1176622@coredump.intra.peff.net>
        <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
        <20200303161223.1870298-2-damien.olivier.robert+git@gmail.com>
        <xmqqzhcx8gz8.fsf@gitster-ct.c.googlers.com>
        <20200303211142.GA36275@coredump.intra.peff.net>
Date:   Tue, 03 Mar 2020 14:22:26 -0800
In-Reply-To: <20200303211142.GA36275@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 3 Mar 2020 13:11:42 -0800")
Message-ID: <xmqqeeu96pul.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77D7BDB6-5D9D-11EA-B35C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Mar 03, 2020 at 09:51:07AM -0800, Junio C Hamano wrote:
>
>> > But unlike remote names, there's no default case for the remote branch
>> > name.
>> 
>> Up to this point, it is well written and easy to read.  I think
>> "there is no case where a default name for the remoate branch is
>> used" would be even more easy to read.
>> 
>> In any case, if there is no case that default name, I understand
>> that explicit is always set to 1?
>> 
>> > In any case where we don't set "explicit", we'd just an empty
>> > string anyway.
>> 
>> Sorry, but I cannot parse this.  But earlier, you established that
>> there is no case that a default is used, so is there any case where
>> we don't set "explicit"?  I don't get it.
>
> Maybe more clear:
> ...
> Yes, that looks fine to me.

Thanks for a clarification.
