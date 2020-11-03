Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158B6C388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA49021556
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mS+mGnue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgKCVsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:48:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56817 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729495AbgKCVs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 16:48:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 818DEE578C;
        Tue,  3 Nov 2020 16:48:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xLIYB70O8NGYLDuGuBY0E/H7Hys=; b=mS+mGn
        ueTzfiYmZ1gQca4wyYj6A5LX55mabcJcXENwxM2YOahDJXoJiZe0lxSCRHKY+wAT
        3Htf0Fp2VuonkvY3fuwOZQGhWtq+CEP95zSmSyxfA2jI/egBJ43lS6NdUxlu+3f3
        fjECFbLQOZKPPvqn3e+uaKhPc26yralElD0pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VLXVze4/D5p+rruhnakuR8t/+c36tNKk
        1vY+mP89qrS3tmFpP6qh63U+BxGT8IQhmq+OnWV0MBIHFbgkehYFcaL6+4E0vRfq
        /3VYX3SC/nDmxY2W4564XgssmaslQhcIvQeccNAQwtts33wL2DWVPlUF2ied0cD1
        PqH9ZESDtM0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79FB5E578B;
        Tue,  3 Nov 2020 16:48:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BD826E578A;
        Tue,  3 Nov 2020 16:48:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 04/11] upload-pack: advertise trace2 SID in v0
 capabilities
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1604355792.git.steadmon@google.com>
        <4912af5f2b949b9944b37843a9ebabdd33e66215.1604355792.git.steadmon@google.com>
Date:   Tue, 03 Nov 2020 13:48:23 -0800
In-Reply-To: <4912af5f2b949b9944b37843a9ebabdd33e66215.1604355792.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 2 Nov 2020 14:31:02 -0800")
Message-ID: <xmqqwnz2p0wo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C99B5A4-1E1E-11EB-B576-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> When trace2 is enabled and trace2.advertiseSID is true, advertise
> upload-pack's trace2 session ID via the new trace2-sid capability.

I would have imagined when advertiseSID is enabled, trace2, at least
the part that allocates and assigns the session ID, ought to be
enabled automatically.

But the above goes in a different direction and requires both to be
enabled.  Any compelling reason behind the choice?

Does the documentation added by this series make it clear that
asking for advertiseSID does NOT automatically enable allocation of
session IDs (even if it does not explain why it does not happen)?

Thanks.


