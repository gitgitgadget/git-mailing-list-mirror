Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0F1C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 19:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDNTmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 15:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNTmH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 15:42:07 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D57F49EA
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 12:42:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 312D8202737;
        Fri, 14 Apr 2023 15:42:03 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=suFao5kdWxpXJ7MBNeODIhZ2v87Kbkza3eg5cN8
        CoNo=; b=g2xQ1g6qA0XzuLBpIu5K5djSX9BNor1r3rIo6PM4y8rinI6fx6q8EVF
        3iJsUBn6FzsvazYF/44lD0Xz07LTc/F2tzO9UnrFVd+ijFEADEwYpTzqmTv8nQsc
        lnwlrtcdVLL+2HTSjGHDfxxRrkWng0IN73FYy1en5k4KSqpZdXFc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A836202736;
        Fri, 14 Apr 2023 15:42:03 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D3334202732;
        Fri, 14 Apr 2023 15:41:58 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 14 Apr 2023 15:41:55 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/18] version-gen: remove redundant check
Message-ID: <ZDmsg0njhtv_qM9a@pobox.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
 <20230414121841.373980-7-felipe.contreras@gmail.com>
 <ZDltLSTxBCWRoMjK@pobox.com>
 <643991c58aef_5ecfe29433@chronos.notmuch>
 <ZDmjIqNwVMESgHnn@pobox.com>
 <6439aa5b2c776_6058729489@chronos.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6439aa5b2c776_6058729489@chronos.notmuch>
X-Pobox-Relay-ID: 6BB0D0E2-DAFC-11ED-B774-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Todd Zullinger wrote:
>> If I have a git repo, say ~/fedora/git which contains the
>> fedora packaging (spec file, etc.) and extract a git archive
>> in this directory, the describe will now pick up the data
>> from the parent git directory, won't it?
>> 
>>     $ git -C ~/fedora clone https://src.fedoraproject.org/rpms/git.git
>>     $ cd ~/fedora/git
>>     $ git -C ~/upstream/git archive --format=tar --prefix=git/ HEAD | tar xf -
>>     $ cd git
>>     $ make GIT-VERSION-GEN
>>     $ cat GIT-VERSION-FILE 
>>     GIT_VERSION = 
> 
> I don't think this is a realistic use-case, but supposing it is, what would be
> the desired outcome in this case?
> 
>  GIT_VERSION = 2.40.GIT
> 
> ?

That's what we get before this change.  I don't have an
opinion on whether that could/should change, but if it does,
it should be deliberate I think.

>> The version file in the tarballs prevents this from
>> happening in the most common case, but it still feels like
>> this is loosening things a little more than it should.
> 
> If we care about this, the same behavior can be achieved with GIT_CEILING_DIRECTORIES:
> 
>  GIT_CEILING_DIRECTORIES=$(cd .. && pwd) git describe ...

I only mention it because it seemed like a change in
behavior when the series aimed to not change any behavior.
I'm sure there are plenty of things which could be changed
while making imrpveoments here.  I think we'll be better off
if those changes are all noted and deliberate.

Thanks for working on this stuff, it is good to see
improvements to this sort of plumbing.

-- 
Todd
