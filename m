Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB3AC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D17E208B3
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ClEjNzsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgKKT1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:27:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62596 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgKKT1e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:27:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D626810E8CA;
        Wed, 11 Nov 2020 14:27:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jq1vHTnGlOKyorGQBZX/15S4Ti4=; b=ClEjNz
        swj0sel73sTZ+N1DipeJEPCiwK0UXzbt3X2G6lMGQ97nV+RhOpyI0w8x/uz4bMG0
        CFSonbi0K/a9KT6NmM/l+pWtTLJIc+ROydXJL511dvwkEy2MFm/ajlozShQywgFU
        wGXK7DZnZFqqDemIuN8xmTH+pBVVn17SF3DuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bJNRtmJOQqI7Dum6um0So+xUh3HocYWx
        5aHniM+RfecdhsnT4YJCMDZezpSi1zU3PYbDq5enlCt8XbphVWXv0LjSuglV2ti+
        cG9w1AAmIgk6od/PFuuHgzTdNTOD9vy4WNOswkh7u7kWwMIUG/hwH6uGPduTR5cq
        3TBS6I9XT4Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D010E10E8C9;
        Wed, 11 Nov 2020 14:27:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 259BB10E8C8;
        Wed, 11 Nov 2020 14:27:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC 1/2] submodules: test for fetch of non-init subsub-repo
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
        <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com>
        <1604910829-49109-2-git-send-email-peter.kaestle@nokia.com>
        <xmqqk0uuct94.fsf@gitster.c.googlers.com>
        <37DD13D4-FBE4-4DB7-85F5-824E850BA9AE@gmail.com>
Date:   Wed, 11 Nov 2020 11:27:27 -0800
In-Reply-To: <37DD13D4-FBE4-4DB7-85F5-824E850BA9AE@gmail.com> (Philippe
        Blain's message of "Wed, 11 Nov 2020 12:35:53 -0500")
Message-ID: <xmqqft5f4rts.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F08EAAF8-2453-11EB-9840-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Thanks for spelling it out; I think a quick paragraph about this somewhere
> in SubmittingPatches would be a good addition for new contributors.

Patches welcome ;-)
