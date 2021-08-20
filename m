Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1581EC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB644610CC
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbhHTVK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 17:10:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54304 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhHTVK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 17:10:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 781E0D0683;
        Fri, 20 Aug 2021 17:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=uVtx6EyYcfdfBjZbkOzTCe866Os0QO6HVXw9KABbWMI=; b=KpPg
        YCQREuzADKIboLrdV1CZvaQtvsqJ3SLOhAy8HJGgrdMdc4nZ3pFXrKHVD4soZRjc
        MTh+zzTUfcjQMaX6HrcY17W6SwQH25eIWkD0k+AIsgnMlxNyD/0oExVce7SoplWJ
        vLOjQNc6aMZIKD3RxTT3tN3zM2KuZaE6WKFzo7Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EFBDD0682;
        Fri, 20 Aug 2021 17:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EAA45D067E;
        Fri, 20 Aug 2021 17:09:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     Adam Williamson <awilliam@redhat.com>, git@vger.kernel.org
Subject: Re: git format-patch produces invalid patch if the commit adds an
 empty file?
References: <02be6a48411fa100e7d1292fc312f7fcf571f334.camel@redhat.com>
        <xmqq5yw1ywdk.fsf@gitster.g> <YR9Iaj/FqAyCMade@tilde.club>
Date:   Fri, 20 Aug 2021 14:09:46 -0700
Message-ID: <xmqqbl5ru8kl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2DF19F2-01FA-11EC-A3EB-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gwyneth Morgan <gwymor@tilde.club> writes:

> GNU patch chokes in this case with an unquoted filename with spaces.

When we settled what bytes (not characters) in a pathname will cause
it to be quoted and how the quoting is done between us and GNU diff
and patch maintainer back in Oct 2005, I thought that we excluded
whitespace from the bytes that need quoting [*].  And I do not
recall us changing the rule for pathname quoting since then (other
than introduction of core.quotepath to disable quoting bytes with
the 8th bit set).

It may be a "recent" change on the GNU patch side, and I do not
think we mind tweaking our diff output to be more accomodating iff
that observation is true.  I however understand that spaces in
pathnames are not so uncommon especially among non-programmers and
they may feel irritating having to see any pathname with spaces
quoted.


[Reference]

* https://lore.kernel.org/git/Pine.LNX.4.64.0510111121030.14597@g5.osdl.org/
