Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE10C433E3
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E720207F5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AJyEGtu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgG1QsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:48:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56727 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731367AbgG1QsX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:48:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72AA880CE5;
        Tue, 28 Jul 2020 12:48:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XTUfZPLzg5WEypGhS1sy6aE71D4=; b=AJyEGt
        u8HWHCEiWSU1muc2EcBTmWJv7Zsb2TBSVJnV60FhqSDlPtRgaoKYPYnUVCNSsh6V
        ue+BNsMuUfnt0Li/y6H1N5DZO3yV43hqIHqr6YOOdZIxcSMuxtsF4ox9/xwaa7WP
        N4mAY8RyPo8RHatxyAG4PRDFAxG62VE4iL2Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ewm6nRbADsnFcI8PX/mNunvs0lVzG28Z
        FZIQ30jRPtP4RKP20dUTrLO29J+eGKMN3WVt5reF4Gbnr0YV1MP0LrxXKsPtZ9uC
        bKwhSrRZcuEANKCJ958DDgS8PVfCb47YBuS+CHlVxnamWthHTnLYvBgzl+7qL/cW
        onbB4vM6ieA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B24E80CE4;
        Tue, 28 Jul 2020 12:48:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED79A80CE3;
        Tue, 28 Jul 2020 12:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] making --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
Date:   Tue, 28 Jul 2020 09:48:20 -0700
In-Reply-To: <20200728163617.GA2649887@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Jul 2020 12:36:17 -0400")
Message-ID: <xmqqeeovegbv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2503792C-D0F2-11EA-AE36-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For some projects, it's useful to walk the first parent history, looking
> at each merge commit as a normal commit introducing all of the changes
> no its side branch. E.g.:
>
>   git log --first-parent -m -Sfoo -p
>
> might show you the topic or pull request that introduced code "foo". But
> I quite often forget to add "-m", and get confused that it doesn't
> return any results.

Yes.  I agree that --first-parent should imply -m when combined with
diff options like -p, --raw, etc.  I am not sure if -m should kick
in without any diff options, though.  Doesn't it have side effects?

Thanks.

