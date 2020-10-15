Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF5C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2C622254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sebres.de header.i=@sebres.de header.b="mAlH3XBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbgJOSJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 14:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732646AbgJOSJz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 14:09:55 -0400
Received: from sebres.de (sebres.de [IPv6:2a03:4000:3f:185::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA8EC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 11:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sebres.de;
         s=dkim; h=Message-ID:References:In-Reply-To:Cc:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yCoZdUpnQeoXgLPt+Qt04gTn5rB2JqGhUiYIqERaLJU=; b=mAlH3XBrWUSe0LLil5hFGRPJIl
        /w5JOlt4eAs3cPJLQfW9MHB77puzHwfrVwNb9HhJ8p2vkT6RwO5o9rHtoLsRsvec1XGOmWdUHKrfo
        mE1K+3WDrz9ovhjAujxvdpaMofJUc6lXs0psNTyD6E7ivLTqGXm4/LIADuEC1EM1fswDA71dL1HVF
        zB4GOijQXIBsV6fXnsKfa0XjD6+ZhzMUR6+ayNQ3OeAjJ5YyN2WAFsyP/mUvKFatcwY6Wz65SoH8K
        ZpxZkaUk3Mk1Yk7DpWXw7CD2hTXTCot32CEVHQjYddv7fCGQHzQ00Yb8QCcP60IDgCiyv2G2Xs5H+
        kePy4CRQ==;
To:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Oct 2020 20:09:47 +0200
From:   "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
In-Reply-To: <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
 <20201015012636.GA387901@coredump.intra.peff.net>
 <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
 <20201015153849.GA551964@coredump.intra.peff.net>
 <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
 <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
Message-ID: <f3e4f7ccc36dc214201c1838acce4aff@sebres.de>
X-Sender: serg.brester@sebres.de
User-Agent: Webmail/1.0.3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nice.

Brian's patch looks indeed really similar.

May be this is a sign to introduce real issue tracker finally? :)
No offence, but I was always wondering how a team is able to hold all 
the issue related stuff in form
of a mailing list, without to experience such an "embarrassments".
Especially on such large projects and communities.

Regards,
Sergey

15.10.2020 19:34, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Why does this vaguely look familiar, I wonder. I can swear that we saw 
>> a breakage due to a similar pattern that attempts to convert a global 
>> to an arg that is passed down to the callchain but not doing so fully.
> 
> Are we revisiting this thread?
> 
> https://lore.kernel.org/git/xmqqtuzlld1d.fsf@gitster.c.googlers.com/ 
> [1]
> 
> I wonder what happend to the thread at the end ...
> 
>> Anyway, the diagnoses above look correct and cleanly described. Will 
>> queue. Thanks.


Links:
------
[1] https://lore.kernel.org/git/xmqqtuzlld1d.fsf@gitster.c.googlers.com/
