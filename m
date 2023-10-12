Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03051CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 05:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376867AbjJLFaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 01:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjJLFav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 01:30:51 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAC590
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 22:30:50 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697088648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrx5tH1KlYUHJk8VHqfvldbSLh454DztyrQv3pVpa9A=;
        b=LNpnYZmsdjW/SdA0AAm0WzfrhWacbgB6k1rgyXv4J4/rOkmu3SyI7NpO77/eD+okEp2Elb
        fNlvfzhGWkhlpsJFCzFtDMSkT62qyMgfVg1i8q6E2j9AWn5uLLrECtVAx0mPAbTY76K7rM
        WgG+TxNHSXyV7MaiAXAgOpU3xwCY4xId2loDmjWjG0hYg/uoU5IQNS04oPr42t5P6nb7IY
        LJH2aWFryLWjuPx1Clc389gItGsh5oAJtpU//yCIT0vd9xHl0dHKXfIjvPc+7ANpJvvvBG
        l2JhgcsrEdAklRuX5kvJetlgIzauyjuOGYBpwp+lk/wXBgI5O4Ndcg2HEH1Lwg==
Date:   Thu, 12 Oct 2023 07:30:47 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Christoph Anton Mitterer <calestyo@scientia.org>,
        git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <xmqqh6mwipqi.fsf@gitster.g>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g>
Message-ID: <3946c06e90604a92ad0dddf787729668@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-12 03:39, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> ... Digging into the history and
>> the changelog, this note is in "changes between less versions 487 and
>> 530":
>> 
>>   Don't output terminal init sequence if using -F and file fits on one
>>   screen.
> 
> ;-)
> 
> That is really a good one to dig out.  So in short, X was needed
> because we wanted to use F, and we could drop it if everybody is
> using recent versions of less, but the default to use FX at the same
> time gives us the same behaviour between both newer and older
> versions of less.

Please note that dropping "-X" and leaving "-F" would actually introduce 
the inconsistency that I already mentioned.  To reiterate, short outputs 
would then remain displayed on screen, while long outputs would 
disappear after exiting less(1).  I don't think that's the desired 
behavior.

>> ... And as you say, if there are people who really
>> care about their LESS options, it is easy for them to override it.
> 
> Yup.  I really like the discovery of that changelog entry.
> 
> Thanks.
