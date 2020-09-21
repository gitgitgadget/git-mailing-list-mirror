Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F24C43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 16:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073A3206E5
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 16:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HxQWfT+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgIUQFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 12:05:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52083 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgIUQFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 12:05:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39AC78D345;
        Mon, 21 Sep 2020 12:05:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x1JfzyBzxr02wNw1RoT/CAlRO/Q=; b=HxQWfT
        +gmMH/16kNXcPQU7nuZkdGlhKYypgo7nnmfjgW4kNS2osovZTjqivkHltHblG1GW
        28BakB2fA2Svj0suNz18sxchEx+Y0brISX2zLSHMeUH+9w6HqoH/qp7g1s2HBkRF
        aWJardXQWkjOsg3FVhI1EisjTXDNus/om1pSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ygd+VGY6N3Tk42XrNP9LVflMoDiJ4888
        jCpdFSNaT2uAZ+4a3H44nGBg63K9VD5I2l20QjCI8+f46I0ghhhaHY4tsmJHLSce
        3zkZRvCjXd6uw49AB+S/ZdWc8QBk7bfKE3o2ssZr9EWMna5UH01nblytvw/lODPJ
        /QuckAdZW+c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 306D38D342;
        Mon, 21 Sep 2020 12:05:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 922B48D341;
        Mon, 21 Sep 2020 12:05:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
References: <cover.1599723087.git.liu.denton@gmail.com>
        <cover.1600328335.git.liu.denton@gmail.com>
        <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
        <xmqq363gs1mt.fsf@gitster.c.googlers.com>
        <20200918104833.GB1874074@generichostname>
        <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
        <20200920110148.GA227771@generichostname>
Date:   Mon, 21 Sep 2020 09:05:26 -0700
In-Reply-To: <20200920110148.GA227771@generichostname> (Denton Liu's message
        of "Sun, 20 Sep 2020 04:01:48 -0700")
Message-ID: <xmqqzh5jf73t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43E270E8-FC24-11EA-ADC0-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Junio,
>
> On Fri, Sep 18, 2020 at 09:52:39AM -0700, Junio C Hamano wrote:
>> I wonder if turning the builtin/diff-tree.c to match that structure
>> make the result easier to understand (and I'll be perfectly happy if
>> the answer to this question turns out to be "no, the result of the
>> posted patch is the easiest to follow").
>
> git diff-tree does not even recognise ranges so as a result, the else
> case does not even need to exist there, unlike in git diff.

(caution: before morning caffeine so what I say may be totally off)

Do you mean "git diff-tree HEAD^..HEAD" would fail, or something
else?

Thanks.
