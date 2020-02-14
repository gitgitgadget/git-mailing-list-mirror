Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8DFC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 19:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A07206CC
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 19:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TPLiS9rO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbgBNTD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:03:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62627 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgBNTD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 14:03:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA0963D25D;
        Fri, 14 Feb 2020 14:03:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YlL8oCWdhrVtZAOKkZcd5wqHzRk=; b=TPLiS9
        rO2olHh38i5Ljb0RpPAqOFXk8LLwWwnp/lCvoawy9ap1aKIiwTEKeefPHpGF46BT
        ro+y4NUjxOxw9fcMQyYuyhlgHdwzZcJ5Xv+FxyrMQ+MHrNWLMo442nB1kVpJmpmJ
        qOy6lC5z9CCQkJ1dsd8B+fLThcHVKLSneSv+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uYPbcanLQ50itfZ/Of4IIArdIxGjFrrd
        l2cbe3zAl+mhUvZJ3Tkk9u1Bj04WsAtWbztRyth4OmF/GM/kZqk8Qt0jeybYsMvz
        yPAw7ewQhux2cbmkVHCvR9sW9AsneDryCGh3bKDXvhjbCeZ5p+kjiTM9Z98z9z9G
        I06C1cv9u1g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC1F43D25C;
        Fri, 14 Feb 2020 14:03:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5216C3D25B;
        Fri, 14 Feb 2020 14:03:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 04/15] pack-bitmap: refuse to do a bitmap traversal with pathspecs
References: <20200214182147.GA654525@coredump.intra.peff.net>
        <20200214182216.GD150965@coredump.intra.peff.net>
Date:   Fri, 14 Feb 2020 11:03:26 -0800
In-Reply-To: <20200214182216.GD150965@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 14 Feb 2020 13:22:16 -0500")
Message-ID: <xmqqeeuxng8x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE9F64F6-4F5C-11EA-AC55-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It would also prepare us for a day where this case _is_ handled, but
> that's pretty unlikely. E.g., we could use bitmaps to generate the set
> of commits, and then diff each commit to see if it matches the pathspec.

Would the gs/commit-graph-path-filter topic possibly help in this regard?
I was wondering how it would fit within the framework this series sets
up to teach object-filtering and reachability-bitmap codepaths to
work well together.

