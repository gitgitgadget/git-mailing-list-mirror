Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BB9C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F06611BF
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhDOSCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 14:02:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56495 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbhDOSCf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 14:02:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9E4E122730;
        Thu, 15 Apr 2021 14:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=srMBbavpgtdbwQmbqKAdFWjB9Sc=; b=Ipa/D1
        /w854/3uconHq38zcsbDHiFnOnfhxTAP+R7J0khtygSbUhnfbQL3f5eFYAnP3RrY
        R3Qr0sIEr6R8IUqefcdXe0YtxECf2Rhj0UBq8X31kjf8FD/SnCX9ZKSIF4u5SWIu
        3QgyWt1wcGOtXmwNKVr64Ylx0Ep0IAmeggNDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vUuXHQw88Tl487JYJLl5/SlJr6dFK734
        lu43jZRSnAPaisNZDP6OYA/A0mgRc8vJpRAhxZCV84VhYFwSWVvCwiOB9vuD6DdX
        2d+2A9qxlxTF0CFXsHS7Qtsms72kf1rkPhdiFnVvNumVdesMJNzzOaAe58+4nnB+
        f7BUWA37Rrk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D447812272E;
        Thu, 15 Apr 2021 14:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26A4C12272D;
        Thu, 15 Apr 2021 14:02:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: What's cooking (draft for #4's issue this month)
References: <xmqqmtu1zn3o.fsf@gitster.g> <YHa5NE3tj/R5kF8N@ncase>
        <xmqqeefcy35i.fsf@gitster.g> <xmqqv98own1s.fsf@gitster.g>
        <YHgJdtF4X2LQCuZ0@coredump.intra.peff.net>
Date:   Thu, 15 Apr 2021 11:02:07 -0700
In-Reply-To: <YHgJdtF4X2LQCuZ0@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 15 Apr 2021 05:37:58 -0400")
Message-ID: <xmqq4kg7s9y8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B23C4270-9E14-11EB-9B20-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Heh. I wonder if I was too optimistic in my review at:
>
>   https://lore.kernel.org/git/YHCYfeRsHU34ZF%2Fl@coredump.intra.peff.net/

Yes, merging is hard.  When merging a topic X into 'seen', I can
review "log -p ..MERGE_HEAD" and keep the core changes the topic
wants to do in my head while reviewing the conflicting parts, but
this is the other "log -p MERGE_HEAD.." direction where all the
little cuts _other_ topics inflicted on the codebase before an
attempted merge, and something seemingly benign and well intended
change like "well nobody passes -1 to ask us to count _now_, so
let's drop the feature without even bothering to check nobody does
so in the future" can easily be missed.
