Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BD7C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8432420706
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uyw3SlQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgHXTwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:52:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56714 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHXTwE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:52:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5871677772;
        Mon, 24 Aug 2020 15:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cLUUCigT/9MKZgIJSlwU6SNaIJA=; b=uyw3Sl
        QshnzXpcSfqIuHWyC/XbSvUqiLpbHls2KA6Aal/OTy5z3EQCttj9ZHa8zLjdwH7l
        wZt3OOK9SF3QAK8oWnkTpjxDtUH/Zs1i3uACAZj0sYaDFa+oZoRbq98LPZNk1tLV
        jFVuaMV0LQRrpOo0jGbW1AgzL0Om0Dj+LebXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iZA0L0UA/MKBgP+VHY4VI9vXX9zLdxlc
        CvhS7MGp/L3CsIqa08j7oPJDH+oG3hB6qnyIvNrEqQEdZop27wtCnF2blgvpDHC3
        Bq5v6GoeP2s+MNsTaHJLmhEiLKp1ZHmcfiVQ3q31y7djwHEuDy2Ihh1Q0GDRo8u9
        PDX2dCKvePQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F8D177771;
        Mon, 24 Aug 2020 15:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 152827776F;
        Mon, 24 Aug 2020 15:52:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Optionally skip linking/copying the built-ins
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <xmqqr1rv50x1.fsf@gitster.c.googlers.com>
        <20200824190348.GA677706@coredump.intra.peff.net>
Date:   Mon, 24 Aug 2020 12:51:59 -0700
In-Reply-To: <20200824190348.GA677706@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 24 Aug 2020 15:03:48 -0400")
Message-ID: <xmqqeenv4yao.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46AB69B6-E643-11EA-A666-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> However, I don't mind re-rolling without touching the pdb list at all if
> you prefer. It makes the state after my series a little more broken,
> but it seems that nobody cares that much, and if we're pretty sure
> Dscho's patch will graduate, then it will be moot anyway.

Yeah, that was what I was somehow expecting ;-) 

Other than the .pdb thing, I think the rest of the topic was good to
go already.

Thanks.
