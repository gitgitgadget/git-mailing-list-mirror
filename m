Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0493C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 04:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9709520737
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 04:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cs0mxeS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGWEPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:15:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61770 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWEPn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 00:15:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03AE1D6ADE;
        Thu, 23 Jul 2020 00:15:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mol0dvC0fewHfCYlEam0OKOJACI=; b=Cs0mxe
        S+BGNJuR5auHAyMSlPmWy4Ghxjykk/hzibvGeUPsiMqOq/UOXH2NOJIBau6AUyWt
        An1z0LhjmMa3Sah17az7XUxqP4BHCWA7YapTWmN3JICCGMVs2QsLT30b921akA3O
        HdAyrIv1Pt8msEwkzBI0u6pRR7SMJFtzXgxTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ya8Vn4ZEjpyW2Dvdew4SQUzwLJnXYazo
        /DzvIgd3q1+xl67kBVww6Q7qhhxBkhycnqasicCSyP+RkZteADJvkL3Eq1t4/wxg
        1g3UMFxqMUuorLPffJycvq3a1BcypJQpMu88KyGHmbDzxwmLKd1wq29umWsHthBz
        fRNQNl8qA2E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E58F3D6ADD;
        Thu, 23 Jul 2020 00:15:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2B53AD6ADC;
        Thu, 23 Jul 2020 00:15:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 32/39] setup: add support for reading extensions.objectformat
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
        <20200723010943.2329634-33-sandals@crustytoothpaste.net>
        <xmqqblk73s1n.fsf@gitster.c.googlers.com>
        <20200723023900.GA1758454@crustytoothpaste.net>
Date:   Wed, 22 Jul 2020 21:15:37 -0700
In-Reply-To: <20200723023900.GA1758454@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 23 Jul 2020 02:39:00 +0000")
Message-ID: <xmqq4kpy50k6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A6BE9B8-CC9B-11EA-962D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> By declaring that the repository is invalid if its version is less
>> than 1 and objectFormat extension defined, we prevent unwanted
>> upgrading from happening by mistake.
>
> Yes, and more specifically:
>
> * If the repository is v0 and has an objectFormat set, we fail in newer
>   versions of Git (i.e., after this series).  Older versions which do
>   not support the extension will see breakage (because unknown
>   extensions are not fatal in v0), but we hope by adding this check that
>   nobody will ever configure a repo this way, since it will be totally
>   nonfunctional in this state, regardless of version.
> * If the repository is v1 and has an objectFormat set, we work with
>   newer Git and everything is great.  Older Git versions fail hard here,
>   and the user gets a moderately helpful error message.
>
> v2 of the series just ignored the setting in v0, which would make it
> equally broken in older and newer versions, but would provide a less
> useful error message (probably about a corrupt index).

Peff's 'jk/reject-newer-extensions-in-v0' uses a bit refactored code
to make it easier to add only-v1-and-later extensions while rejecting
them, even if the code knows about them, in v0 repository.  Even
though the mechanism is a bit different, the spirit is quite the
same as this step.

Please double check origin/seen:setup.c to see if I resolved textual
conflicts in a sensible way.

Thanks.
