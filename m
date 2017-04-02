Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AABE20966
	for <e@80x24.org>; Sun,  2 Apr 2017 16:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdDBQoS (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 12:44:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57734 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751028AbdDBQoS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 12:44:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5340476A0F;
        Sun,  2 Apr 2017 12:44:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Exu96ybokIqKVLbRzhaWIGnS6LM=; b=FT6TVj
        J7Zu9EIDkp4CfcWMU1dBENcqI+iXs32YoYRs8JtP+34qXMtWp1lyX1zlgO9UR4oU
        5IE5zkFIU+O3dE7+Fak+IocVnXblDOJ46IUaR2pD4hhfJs1YCAyp3LFMK47WGg4I
        s6lX9ePkTG5D/Sw9VJ9sRx/nrjt5Xuna+petw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aOE0hkA16z7tmQFzNlC/lWYpSo9DWChc
        oBs4s4czE9tjjYaMeQA8z2vxJehVzIiw7Lo6IIVBB5Qgu25QUfxTmZxvsJ6ukYAV
        hLN0M+qDhs8Q5ERz+nWgjx4oqcflDpih5rYzQhTVxQMeF0XS88YJYBZ10dGtrhX8
        XTnjcNvzSBs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4965676A0E;
        Sun,  2 Apr 2017 12:44:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72E5A76A0D;
        Sun,  2 Apr 2017 12:44:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/20] Separate `ref_cache` into a separate module
References: <cover.1490966385.git.mhagger@alum.mit.edu>
        <xmqq1std1lmb.fsf@gitster.mtv.corp.google.com>
        <9b9a6cc2-a7d4-a7b8-0483-5aefdf926ca7@ramsayjones.plus.com>
        <xmqqh927tr6p.fsf@gitster.mtv.corp.google.com>
        <fe8f84d7-7bcc-f872-4bad-32e5b957bf17@ramsayjones.plus.com>
Date:   Sun, 02 Apr 2017 09:44:13 -0700
In-Reply-To: <fe8f84d7-7bcc-f872-4bad-32e5b957bf17@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 2 Apr 2017 15:48:40 +0100")
Message-ID: <xmqq4ly6u5cy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BAEE71E-17C3-11E7-9AB6-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> In that sense, Michael's series and Duy's later two series are
>> "tangled" (i.e. shares some common commits that are still not in
>> 'master').  If nd/files-backend-git-dir that is shared among them is
>> ever rebased, all of them need to be rebased on top of it
>> consistently.
>> 
>> But if either of nd/prune-in-worktree and nd/worktree-kill-parse-ref
>> needs to be rerolled, that can be done independently from Michael's
>> series, as long as nd/files-backend-git-dir is solid and unchanging.
>
> I suspected as much (hence the 'maybe not now' comment), but I noticed
> that all four branches were merged into 'jch'. So, it seemed possible
> to me that they were all being considered for merging into next.

Yes they were (and still are, but I do not expect they will be
moving to 'next' while I am offline ;-).  What you can do to help is
to review and say things like "nd/files-backend-git-dir and
Michael's one on top of it looked good, no opinion on others",
"the others have this and that issues that need a reroll", etc.

Thanks.

