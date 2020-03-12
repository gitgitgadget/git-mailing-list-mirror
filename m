Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A3EC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7DD20724
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XuwSTua6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCLSKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:10:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63553 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCLSKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 14:10:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0431A4FEFE;
        Thu, 12 Mar 2020 14:10:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0PHAdcE+fww8Vl9N6Y2y8FP/dLM=; b=XuwSTu
        a6hRZ7s6oTYaoSF+JoJ34yU0F0zaYj4Fld0YqhZL8osq+BW4VBXWMFel2823hIcz
        f4gV93K0Ys8hIRQN2SGVSA7GStu8/3nZz0I9328+JjTkzODg3VNqzU1Py8QHBM+6
        rpwDz1HcFN0QLMFDNQlKS7zi4sDV+lyoyehac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LEJulZjtskCEl7jihBRZGOE0TCwSWyg+
        r7xMO/d6gP6sT+U3tC1pHaxlWbgevavQt5MgfB+ZJTomM3SoDkX1kDCs2CBLAnfu
        Yd3UhIsgt9muMd9E7X1qfgcaEqRKmW8CMc8ucTkwq8baEuI7CUKacsRDh39ilng2
        1bqPRa+1TdY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F03284FEFD;
        Thu, 12 Mar 2020 14:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7987C4FEFC;
        Thu, 12 Mar 2020 14:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        git@vger.kernel.org, me@ttaylorr.com, christian.couder@gmail.com
Subject: Re: [Question] Is extensions.partialClone defunct?
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
        <20200312170714.180996-1-jonathantanmy@google.com>
        <20200312175151.GB120942@google.com>
Date:   Thu, 12 Mar 2020 11:10:12 -0700
In-Reply-To: <20200312175151.GB120942@google.com> (Jonathan Nieder's message
        of "Thu, 12 Mar 2020 10:51:51 -0700")
Message-ID: <xmqqsgidfnqz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B81A61EE-648C-11EA-8E59-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Hmm...besides giving the name of the promisor remote, the
>> extensions.partialClone setting is there to prevent old versions of Git
>> (that do not know this extension) from manipulating the repo.
>
> Yes, so the lack of setting is a bug.
>
> Christian, what would your prefered way be to fix this?  Should
> extensions.partialclone specify a particular "default" promisor
> remote, or should we use a new repository extension for multiple
> promisors?

It would depend on how well versions of Git that supported one
promisor with extensions.partialClone works with a repository
initialized with Christian's multi promisors when the extension
points at only a single promisor.  Is having other/secondary
promisors meant merely to be performance thing, or would the
repository be broken if these promisors are down because some
objects are never available from the "origin" or the primary
promisor remote?  If the former, using a "default" promisor with
extensions.partialClone would be sufficient and be preferred as we
do not end up wasting a new extension, but if the latter, we would
need to prevent Git that is capable of single-promisor from touching
the multi-promisor repository with a new extension.
