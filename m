Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA5C433E1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B7D20775
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pfM4tc1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgG1VQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:16:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53971 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgG1VQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 17:16:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 786187870D;
        Tue, 28 Jul 2020 17:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SdoNfwW6OL/sDyudeiiVc1jKEm8=; b=pfM4tc
        1odJDO5IvY0I+zmY1yhfMBfgP4vutBQ//GRxkRNSD+IQWn6wGPrkilpjiOI0OYAE
        jJ3BWyDFYICL0nHofIC8MauW/BgmdlkvgUpgwC6af2+AvwsquY/ZzBiQmu/XhVls
        YqaTZc7bf1JFgiSEy79o4CCZcjuq8W7yaNGNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ll6xunPQwRm5qfoEGnQPlMGfyg6g2L/Y
        iHMUJWupL4gquEr5aV1ckRRTTSukVXtj02eR7KmBd1/+ziQL6wMqOO/LXO2NYUBC
        vc+cZn+nS1RUS4r48McR41DNw/pW+1jHDF0SSx4I21q1VCmxkM9C7ne6zhAMaZoZ
        MIAeIxFf6Yc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E6507870C;
        Tue, 28 Jul 2020 17:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBCE27870B;
        Tue, 28 Jul 2020 17:16:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 11/11] strvec: rename struct fields
References: <20200728202124.GA1021264@coredump.intra.peff.net>
        <20200728202823.GK1021513@coredump.intra.peff.net>
Date:   Tue, 28 Jul 2020 14:16:24 -0700
In-Reply-To: <20200728202823.GK1021513@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Jul 2020 16:28:23 -0400")
Message-ID: <xmqqr1svcpcn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97D211A0-D117-11EA-9D30-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The "argc" and "argv" names made sense when the struct was argv_array,
> but now they're just confusing. Let's rename them to our usual "nr" and
> "items" (which we use for string_list, as well as many ALLOC_GROW()
> arrays).
>
> Note that we have to update all of the callers immediately. Playing
> tricks with the preprocessor is hard here, because we wouldn't want to
> rewrite unrelated tokens.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm actually not that fond of "items". I almost went with just:
>
>   const char **v;
>
> as the variable name which contains it usually provides sufficient
> context. But I worried that people would consider that too inscrutable.

I'd agree that v[] is a good name.  If it is too short, I can live
with item[], but not with items[].  Clearly we are mostly accessing
one element at a time much more often than treating the set as a
whole, so signaling "there are multiple things in the set" with
a plural name is much less important than being able to say item[4]
to name the 4th item in the collection.


