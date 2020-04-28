Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3577EC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFEA2137B
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cDftlsrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgD1U5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:57:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58202 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgD1U5V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 16:57:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71310CFF3B;
        Tue, 28 Apr 2020 16:57:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TRWCaTz424MUcZydLYOcgqdE5n4=; b=cDftls
        rZpHoYBWlK5EcjsOAwH3zYKNvkXAvBrNm4IU8sECJN1PBnXlL7BEw+NAlsQ3pkTW
        IdHwe/xsnzXMsKeBvcSsja6QCoizQGd/+B7wimjtPVesy0xfwS7gjqUfEZVtwgB/
        rbikTZ8uQUAU4bJXKyPVptrrZmQl43Gb1vKYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Clzb+89ITm8L/AY1oDa0J9XslFulU/av
        eTJoIGOFbs5e/n7Ic/3fTCGLGtXAulxIjIcM31scHLcSL+6TtSm0a9iWlQm4TJNa
        jC6knnhAk1A05+5Yqy3uWgcWGmh0X+LDFME1kum2RD1KP4sRrBPGrE/a7zF9GBXf
        8ISATJIeneQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68416CFF3A;
        Tue, 28 Apr 2020 16:57:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B35E6CFF39;
        Tue, 28 Apr 2020 16:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/11] completion: add test showing subpar completion for git switch --orphan
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
        <20200425022045.1089291-6-jacob.e.keller@intel.com>
        <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
        <CA+P7+xpEMb-A1cOkOxdWf0pM=5o8Cyn9=5HLZPtFNMcLUaypsg@mail.gmail.com>
        <xmqqo8rb4lyj.fsf@gitster.c.googlers.com>
        <CA+P7+xoBnS8huHiU+QM8x6LRiSDRYVVS2pduv6i_qrwb1ZS7fg@mail.gmail.com>
        <xmqqsggn32i7.fsf@gitster.c.googlers.com>
        <CA+P7+xoSdDjbSAKeCsPz97Rc=ykpuTb2pNKazsCNcau2SBquMA@mail.gmail.com>
        <xmqq8sif2zfr.fsf@gitster.c.googlers.com>
        <CA+P7+xpD7LaYMnoi6L-Z7e9w0j0+ppDCw6fGBzSMfxerw0HrUA@mail.gmail.com>
Date:   Tue, 28 Apr 2020 13:57:17 -0700
In-Reply-To: <CA+P7+xpD7LaYMnoi6L-Z7e9w0j0+ppDCw6fGBzSMfxerw0HrUA@mail.gmail.com>
        (Jacob Keller's message of "Tue, 28 Apr 2020 13:41:44 -0700")
Message-ID: <xmqqlfmf1g7m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9060090-8992-11EA-85E7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I assumed completion would be most useful to complete the start-point,
> and so I opted to lean towards fixing completion for -c/-C to complete
> all references. However, I don't think the branch name should
> necessarily complete from all references and it would make sense to
> complete that portion only by local branch names.
>
> I'm just not sure how best to implement that in our completion logic,
> and I would rather ensure that start-point completes properly, if we
> have to choose.

Sure.  What I was saying that if it is easier to implement by
completing both new branch name and starting point from the same
set, you could choose to include both branches and tags, and your
"excuse" for choosing that design could be that a user who wants to
fix something in 2.26 release may want the completion and typing
progression go like so:

	$ git switch -c v2.2<TAB>
	... offers v2.20, v2.21, ..., v2.26 as candidates
	... complete to v2.26 and type "-frotz-fix"
	$ git switch -c v2.26-frotz-fix
	$ git switch -c v2.26-frotz-fix v2.2<TAB>
	... again offers v2.20, v2.21, ..., v2.26

;-)
