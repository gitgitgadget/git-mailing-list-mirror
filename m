Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BF5C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE48C2395C
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 17:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LQ1SiT+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgIXRTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 13:19:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62761 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbgIXRTq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 13:19:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 709EE8DE52;
        Thu, 24 Sep 2020 13:19:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y5mfVqjK5jVmH5MXUW7l8IKQu5Q=; b=LQ1SiT
        +ykcdUfkCDNSQ1ocG85Zdk8nexiUSBrk780+9wjUvmGKx7AeutYAq/x7OISSeIow
        MzFsoO7NiRR/3/DsrD4oPjhFYDotqahMghuMwE7CMdKNCNt968G0BunDj+uCdm8B
        SHh+msU2BPH6A6OC8HVdUiD8S132iARAtcEIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L7cdyadSpfgakn5LYeM9XKZp/blejzSk
        nnAtY37hybWy5l0JU9Eogh55ZdG6axJ+MSlXjqVDRCZ+t/kBW8PAna62zU8FrriA
        nrTrMd93L5VD+QqcuZ8rAY46m+FiEoOdzzfhBJZxxuO+vL88bJ2L8zH0D3Wo3/46
        RCfiHb8dV8k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 653CA8DE51;
        Thu, 24 Sep 2020 13:19:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DFC7F8DE50;
        Thu, 24 Sep 2020 13:19:43 -0400 (EDT)
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
Date:   Thu, 24 Sep 2020 10:19:43 -0700
In-Reply-To: <34484667-1085-c60b-9438-591faed41ddc@gmail.com> (Thomas Guyot's
        message of "Thu, 24 Sep 2020 03:13:53 -0400")
Message-ID: <xmqq7dsjgki8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 234BFDA0-FE8A-11EA-B8F3-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Guyot <tguyot@gmail.com> writes:

> Hi Junio,
>
> On 2020-09-24 02:40, Junio C Hamano wrote:
>> Thomas Guyot <tguyot@gmail.com> writes:
>> 
>> It is not "both ways", I think.  The idea is that when this variable
>> is true, we know with certainty that these two are the same, but
>> even when the variable is false, they still can be the same.  So
>> true does mean there will not be diff.  False indeed is fuzzy.
>
> I meant to say the old behavior "lied" in both directions.

It depends on the perspective ;-)

The old one didn't expect/realize fill_oid_info() can leave the oid
field to "unknown".  It was OK because is_stdin happens to be the
only such case [*1*] and we never saw both one->oid and two->oid
being the null_oid at the same time, so it wasn't an issue that
their validity weren't checked there.  As long as one side was
valid, when the comparison said they were equal, they indeed were
equal.  So in that sense, the true side did not lie.

If you add new case where the oid of both sides can legitimately be
null_oid, that will of course break the code.  I think that is the
reason why we are having this discussion to prepare for such a
future (that happens in 2/2???).


[Footnote]

*1* The missing side of addition and deletion will also get null_oid,
but we don't compare that with stdin in such a case.
