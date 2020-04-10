Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C491C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11EB207FF
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ESnxYlcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDJWaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:30:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56093 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJWaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 18:30:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 340104A6FC;
        Fri, 10 Apr 2020 18:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=beR6deWRgzilxsuoiJqInSGpYeI=; b=ESnxYl
        cX0HmzCKf/CA2ojzy2hEd6ifEHXMfnL94SjmhI0sCP08qq3jxbMliPuqEmcGJCAk
        y5TGK/sUbUpIP4aepothysFr8HnYSqZjU1HJz1OxsHQk7psDogTKqWIc8nNcyele
        TKCP1xAMKNRKxfuyE5NWp31Jer/EtKFMO8Zmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S9QwvMiGs/9P+2cHN/84UK6jBqYfUjFt
        2pIFLVuDhgo/HBl1Tx4t2Ey3q4a5NVu5haA4Jc7JItqZ+M5+L/70ZmPomeg4Fn39
        R0/y8qqc5Cfh4CcMxPHkTPtEaCEnVV6P2OzjNw4Z6SsdV1t9kGrf/FtlSYhBC3/j
        8B9vCyIdsZY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C8534A6F9;
        Fri, 10 Apr 2020 18:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACE394A6F8;
        Fri, 10 Apr 2020 18:30:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bryan Turner <bturner@atlassian.com>,
        Sami Boukortt <sami@boukortt.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 0/3] rebase -i: mark commits that begin empty in todo editor
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
        <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
        <xmqqpncfhy3g.fsf@gitster.c.googlers.com>
        <xmqqd08fhvx5.fsf@gitster.c.googlers.com>
        <CABPp-BEQdK8PagqCrKCvkzaWvSQVfW9g9_RbFCNP3r3qeChbzQ@mail.gmail.com>
Date:   Fri, 10 Apr 2020 15:30:13 -0700
In-Reply-To: <CABPp-BEQdK8PagqCrKCvkzaWvSQVfW9g9_RbFCNP3r3qeChbzQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 10 Apr 2020 15:13:13 -0700")
Message-ID: <xmqqv9m7geiy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D888C600-7B7A-11EA-A903-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Apr 10, 2020 at 2:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > So I am OK to rebase the other topic to v2.26.0; would that help?  I
>> > already saw there was some entanglement with the other topic in one
>> > of the patches in this series, so...
> ...
> Thanks, but wouldn't I want to base his patch on top of mine rather
> than vice versa?  (Since mine might be labelled bugfix, and his is a
> new feature?)

If you are willing to rebase the --[no-]keep-empty so that it does
not depend on v2.26, that may give us a better result.  I just got
an impression that you somehow wanted to base your changes on the
newer codebase, but if you want to base both on the older codebase,
that is fine by me, too.


