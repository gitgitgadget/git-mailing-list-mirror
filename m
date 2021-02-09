Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C6C433E6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1314164DF5
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhBIWz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:55:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56455 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbhBIWR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:17:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B74FF9976D;
        Tue,  9 Feb 2021 17:16:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3HEImZ2MiiJS+5bBTyc4bzMkZFE=; b=Lyf91B
        7WmJVIsTYEoIZ8sfSSn+g6CHnviJOi2mca69x4mSpknXD0lCoQPCUCVwJQdHdvj/
        M5kQBMM2OBNuABkYDE9E8SImkg/ogpRkM9fVIRGyJvXFC0n5SMyCI1Bzn6BrQa1D
        DnKN1AAsBOqNKPpAsiFKDj7caeRLBCx2wpcBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MoPwXacQDv+VgX0HFiiZwThEHTUctZ+K
        bAx9ubsKMcKkPqxHoV+yjXVFy9HzpdVLyzKFtolMatfhgPuG/kd7ybwqGaJf7g/n
        3S/tfcEt/LpH5sguOgh48GrCsHGeDx+KO9t12/jmOcB7ABeFBRBuelluutV7dbZ3
        CwW8OlBHdpg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE72C9976C;
        Tue,  9 Feb 2021 17:16:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3981D9976B;
        Tue,  9 Feb 2021 17:16:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        SURA <surak8806@gmail.com>, Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] mailmap: only look for .mailmap in work tree
References: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
        <YB148VZJqKIPC8P2@coredump.intra.peff.net>
        <CAGyf7-EB=J1j1LOUiUBHE+g-hA1WXUNy3F4y84rCRwzGc2zo_A@mail.gmail.com>
        <YCLGgpfkJzg5nP7v@coredump.intra.peff.net>
        <CAPig+cSdTCYV=2OMEZTqahrfBypaHeD40ToMFJ1zbRNpkiPbYw@mail.gmail.com>
Date:   Tue, 09 Feb 2021 14:16:40 -0800
In-Reply-To: <CAPig+cSdTCYV=2OMEZTqahrfBypaHeD40ToMFJ1zbRNpkiPbYw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 9 Feb 2021 14:00:37 -0500")
Message-ID: <xmqq5z30zy2f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C403370-6B24-11EB-AC71-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Feb 9, 2021 at 12:31 PM Jeff King <peff@peff.net> wrote:
>> Subject: [PATCH] mailmap: only look for .mailmap in work tree
>> [...]
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
>> @@ -113,6 +113,10 @@ MAPPING AUTHORS
>> +Note that if `git shortlog` is run outside of a repository (to process
>> +log contents on stdin), it will look for a `.mailmap` file in the
>> +current directory.
>
> Elsewhere in this same document, techy-jargon "stdin" is spelled out
> fully as "standard input".

Good point.
