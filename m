Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52E0C433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 04:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJHEUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 00:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJHEUy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 00:20:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE4EAA35B
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 21:20:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59AFC149C73;
        Sat,  8 Oct 2022 00:20:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1eoS74ggWSUQOGbdaL3AVRaE2bEDYAjNPP8SLw
        piW/g=; b=lz/UM068mNVIleGW2Mz4MYzIino86ZtGMquH6qv/KQbxPgyQZGEdhR
        dpJLuyqbdDBpmxVdtVAqTwCUyxWZwV+/f9+w1LCZDixuzQF2HcSbNrgutxwYHhg/
        TaGfjmSKdqRRKCE7NmxawB/Znrvu12gUytYXGUiuWEmLzK4HCDFk8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 514E1149C72;
        Sat,  8 Oct 2022 00:20:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BACC5149C70;
        Sat,  8 Oct 2022 00:20:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] symbolic-ref: teach "--[no-]recurse" option
References: <xmqqleprcn08.fsf@gitster.g>
        <CAPig+cQZ_SehTLoFEtBf2Xv=8iw3-DkjQfP3R9J8kUm3DjkLBw@mail.gmail.com>
Date:   Fri, 07 Oct 2022 21:20:44 -0700
In-Reply-To: <CAPig+cQZ_SehTLoFEtBf2Xv=8iw3-DkjQfP3R9J8kUm3DjkLBw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 7 Oct 2022 23:35:39 -0400")
Message-ID: <xmqq4jwfc5er.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94859672-46C0-11ED-999B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Oct 7, 2022 at 6:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>> [...]
>> One thing that is slightly irritating, however, is that I do not
>> think there is a good way (other than "cat .git/HEAD") to learn that
>> you checked out 'maint' to get into that state.  Just like the output
>> of "git branch --show-current" shows above, "git symbolic-ref HEAD"
>> would report 'refs/heads/maint-2.38', bypassing the intermediate
>> symbolic ref at 'refs/heads/maint' that is pointed at by HEAD.
>>
>> The internal resolve_ref() API already has the necessary support for
>> stopping after resolving a single level of a symbolic-ref, and we
>> can expose it by adding a "--[no-]recurse" option to the command.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  builtin/symbolic-ref.c  | 16 ++++++++++------
>>  t/t1401-symbolic-ref.sh | 14 ++++++++++++++
>>  2 files changed, 24 insertions(+), 6 deletions(-)
>
> Should this be accompanied by a documentation update or is the patch
> intended as an RFC?

It started its life as an RFC but I had an actual need during
today's integration run ;-).  Will try to come up with a
documentation patch when I have time.

Thanks.
