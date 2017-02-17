Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA3F201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964915AbdBQXmY (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:42:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53491 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964862AbdBQXmX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:42:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B8BA6A45C;
        Fri, 17 Feb 2017 18:42:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=WmVSBSH3wHg8/XJXU3xQbmr4qk8=; b=vkfvcs
        rITdaNORf8tJLfeLscmPvNiNicAJCyK8NFNca7zNC01InJSBWlnBTZzIoloDozBs
        PX/PC7Oa8Z6Ei6yALofzhwde9u/VfoGjHugYP97bhqTL8H6taFM2IqxOhRMkAwTV
        24TyF07KTRG3ppnFCm6W3sPl8hbxtvDVg74h0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3461B6A45A;
        Fri, 17 Feb 2017 18:42:22 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A21076A459;
        Fri, 17 Feb 2017 18:42:21 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] rename_ref: replace empty deletion message in HEAD's log
In-Reply-To: <20170217195549.z6uyy7hbbhj5avh7@sigill.intra.peff.net>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net> <20170217035800.13214-1-kyle@kyleam.com> <20170217035800.13214-4-kyle@kyleam.com> <20170217083112.vn7m4udsopmlvnn5@sigill.intra.peff.net> <xmqqk28ou2o1.fsf@gitster.mtv.corp.google.com> <20170217194350.prhp5joh33cbvwsd@sigill.intra.peff.net> <20170217195549.z6uyy7hbbhj5avh7@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 18:42:20 -0500
Message-ID: <87zihkpeoz.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9F86612-F56A-11E6-AF45-A7617B1B28F4-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=WmVSBSH3wHg8/XJXU3xQbmr4qk8=; b=NCg1wy3Abw3d6KF5a65W6/8kqUGI2U1U2FI2fW73IzMXPmlqj7RwI+MqBzGA5hxYeQH9jM4H09foJ6NbhCybtFwUuY3ay1F8nxeoICJfunnlINLJewsL71kS1h9qCKzTh0o1aU/Al4u3odbiNjxYksPg9KeMHbu0E6m9RDc0WB0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Feb 17, 2017 at 02:43:50PM -0500, Jeff King wrote:
>
>> Yes. I think the options are basically (in order of decreasing
>> preference in my opinion):
>> 
>>   1. Log a rename entry (same sha1, but note the rename in the free-form
>>      text).
>> 
>>   2. Log a delete (sha1 goes to null) followed by a creation (from null
>>      back to the original sha1).
>> 
>>   3. Log nothing at all for HEAD.
>> 
>> This does half of (2). If we do the second half, then I'd prefer it to
>> (3). But if we can do (1), that is better still (IMHO).

[...]

>> I'm actually confused about which bit of code is updating HEAD. I do not
>> see it either in files_rename_ref() or in the caller. Yet it clearly
>> happens. But that is the code that would know enough to do (1) or the
>> second half of (2) above.
>
> Ah, I found it. It's in replace_each_worktree_head_symref() these days,
> which does not bother to pass a log message.
> 
> So I think the second half of (2) is probably something like the patch
> below.
>
> Thinking on it more, we probably _do_ want two entries. Because the
> operations are not atomic, it's possible that we may end up in a
> half-way state after the first entry is written. And when debugging such
> a case, I'd much rather see the first half of the operation logged than
> nothing at all.

OK, I'll have a go at replacing patch 3 with this approach.

-- 
Kyle
