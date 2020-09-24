Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480EFC2D0E2
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 17:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086EE23899
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 17:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SNLVHc9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgIXRjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 13:39:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60922 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXRjB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 13:39:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2D30E8C31;
        Thu, 24 Sep 2020 13:38:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UL1yxuqIpm8MBvh9SDysfwMaEPg=; b=SNLVHc
        9zfPKF84onwNS8UHz0UD6RQnLTIBXEbhRvajZr+REM+ImWzMkIdRTM6NL9roA4J9
        6LoIOjegnrDXHzccXeqypYt+QcpfwdRQ+QsUz6ZMjVWScoojyBLkYtzdSldw5y06
        z74Gq8444DVf1wwTforbOdccvOsclB+lG2LjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J/YUxzedemUMK6wIsVKtANSTQTNMn4jQ
        jCnpF4tfwpz4W05AVqeaRfbyIJ20HLXV71Gjjyo2kyZbZLjpcxO41tsA+wAv+Hm0
        p1SeLlgboIfHIwl/1grJhbYfV9ygE8YU6NSxzGG60YRvofVFyAruFEqNlkSpONxI
        LJhIgZU56gE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB088E8C30;
        Thu, 24 Sep 2020 13:38:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15210E8C2E;
        Thu, 24 Sep 2020 13:38:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Guyot <tguyot@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
References: <20200918113256.8699-1-tguyot@gmail.com>
        <20200918113256.8699-2-tguyot@gmail.com>
        <20200918172747.GD183026@coredump.intra.peff.net>
        <CALqVohcZrBcjmonw-peVxUNM1kgEheCr3nAk9ZvajGpbpXsNaQ@mail.gmail.com>
        <xmqq363fm02a.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009231709340.5061@tvgsbejvaqbjf.bet>
        <xmqqk0wki9fh.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009232244000.5061@tvgsbejvaqbjf.bet>
        <1d0a60c3-d15e-bcbb-f042-2f8ae06f0de1@gmail.com>
        <xmqq4knnisn9.fsf@gitster.c.googlers.com>
        <34484667-1085-c60b-9438-591faed41ddc@gmail.com>
        <xmqq7dsjgki8.fsf@gitster.c.googlers.com>
Date:   Thu, 24 Sep 2020 10:38:55 -0700
In-Reply-To: <xmqq7dsjgki8.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 24 Sep 2020 10:19:43 -0700")
Message-ID: <xmqqy2kzf51s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2A419FC-FE8C-11EA-9016-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If you add new case where the oid of both sides can legitimately be
> null_oid, that will of course break the code.

Ahh, I forgot that we already had such an iffy caller that broke the
code.  I should have re-read the test part of the patch.

Thanks.
