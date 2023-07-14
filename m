Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAAEEB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 16:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbjGNQv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjGNQvz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 12:51:55 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F356F1FC8
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 09:51:54 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA52724CE6;
        Fri, 14 Jul 2023 12:51:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Fm4DlczVa7yrWqY8OcdyqVvhPkFbahQcC29Jl
        bhaFg=; b=sz8WyM/aNHS5CH7GNgAF3ZVLeNvRnI9fgy6bEX1WGTQKMaZMXmEblh
        KZ850I+H6TSHrom7mO9z0rmVC91I4BKl0MpwCdGf1ZuXQUOxWEhGrb2tbEQkunpk
        VYrO+Xkz/3iwFABWq6ZvdgxWsB6oHRbFyjg8FXtH6Sei1fNSgdtP8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2CD724CE5;
        Fri, 14 Jul 2023 12:51:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3183A24CE4;
        Fri, 14 Jul 2023 12:51:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/6] rebase -i: remove patch file after conflict
 resolution
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <227aea031b588977f22f3f97faee981d79ade05c.1682089074.git.gitgitgadget@gmail.com>
        <kl6lsfakr2sr.fsf@chooglen-macbookpro.roam.corp.google.com>
        <55dd6194-25e5-1a66-9c39-27cb19bfbb3c@gmail.com>
Date:   Fri, 14 Jul 2023 09:51:50 -0700
In-Reply-To: <55dd6194-25e5-1a66-9c39-27cb19bfbb3c@gmail.com> (Phillip Wood's
        message of "Fri, 14 Jul 2023 11:08:26 +0100")
Message-ID: <xmqq4jm6qvvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BADE5840-2266-11EE-AED2-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 21/06/2023 21:14, Glen Choo wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> @@ -3490,7 +3495,6 @@ static int make_patch(struct repository *r,
>>>   		return -1;
>>>   	res |= write_rebase_head(&commit->object.oid);
>>>   -	strbuf_addf(&buf, "%s/patch", get_dir(opts));
>>>   	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
>>>   	repo_init_revisions(r, &log_tree_opt, NULL);
>>>   	log_tree_opt.abbrev = 0;
>> I was checking to see if we could remove buf or whether we are
>> reusing
>> it for unrelated reasons (which is a common Git-ism). We can't remove it
>> because we reuse it, however...
>
> I had a look at that and we're using it to construct a path that we
> should obtain by calling rebase_path_message() - I'll add a fix when I
> re-roll.

Wow, a patch from April commented in June and responded in July ;-).

I'll salvage the topic from the "will discard" bin and mark it again
as "Expecting a reroll" in my draft of the next "What's cooking"
report.

Thanks.
