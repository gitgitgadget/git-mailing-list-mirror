Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0A9C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 19:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A63020672
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 19:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vMhdZkGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgDETVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:21:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59352 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgDETVs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 15:21:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E3E3C44AF;
        Sun,  5 Apr 2020 15:21:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dC5otRkvGlTv1u3hMgkVEiXN8L8=; b=vMhdZk
        Gcx907WyfnQHgsOXPS+5M416SKd3D6661Ci3JXHEFjo0OJzkoKvNn8krsr8XFtQE
        0Dy0j+eeO+By8KMeeO1gmCSamzLOYZGNQTnTpFEe+7cYWG9aoqmrjHcmchD6v5gC
        GpBY+v8ttIN7eSYJfdl6ECyikDwAxsXlP/gpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X8DJuX1PgERTLw8cVaJCA3MZl0DQwF0D
        7cbwvC/vjBM65wC1nmLq1uOg7mEO5rCbOZpu9LspVx/tNRaqP5A6J/x5YQI+xd1O
        XG3NhEO1Mv8Ix80M6ODX9CZ4l86qleHRHcz0dC1o9wG069zMMOLeLF4e0WOxtcQv
        AAMZ2C8iJUY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15EFAC44AE;
        Sun,  5 Apr 2020 15:21:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5F89BC44AD;
        Sun,  5 Apr 2020 15:21:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        stolee@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/15] run-job: create barebones builtin
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
        <665da239774419074a9bae49b9c92b340885bfa3.1585946894.git.gitgitgadget@gmail.com>
        <fc5e6823-ebb3-df58-d7fc-6fb2b58cffe8@gmail.com>
Date:   Sun, 05 Apr 2020 12:21:41 -0700
In-Reply-To: <fc5e6823-ebb3-df58-d7fc-6fb2b58cffe8@gmail.com> (Phillip Wood's
        message of "Sun, 5 Apr 2020 16:10:01 +0100")
Message-ID: <xmqqimidybzu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEFDFF64-7772-11EA-BA3A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Stolee
>
> On 03/04/2020 21:48, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The 'git run-job' command will be used to execute a short-lived set
>> of maintenance activities by a background job manager. The intention
>> is to perform small batches of work that reduce the foreground time
>> taken by repository maintenance such as 'git gc --auto'.
>>
>> This change does the absolute minimum to create the builtin and show
>> the usage output.
>>
>> Provide an explicit warning that this command is experimental. The
>> set of jobs may change, and each job could alter its behavior in
>> future versions.
>>
>> RFC QUESTION: This builtin is based on the background maintenance in
>> Scalar. Specifically, this builtin is based on the "scalar run <job>"
>> command [1] [2]. My default thought was to make this a "git run <job>"
>> command to maximize similarity. However, it seems like "git run" is
>> too generic. Or, am I being overly verbose for no reason?
>
> Having read through this series I wondered if we wanted a single git
> command such as 'git maintenance' (suggestions of better names
> welcome) and then 'git run-job' could become 'git maintenance run',
> 'git job-runner' would become another subcommand (run-jobs or
> schedule-jobs?) and the 'git please-run-maintenance-on-this-repo' you
> mentioned in you email to Junio could become 'git maintenance init'
> (or maybe setup)

I had a very similar impression.  In addition to what you already
said, a few more were:

 - Why the existing "git repack" isn't such "maintenance" command?
   IOW why do we even need [01/15]?  After all, "repack" may have
   started its life as a tool to reorganize the PACKFILES, but it is
   no longer limited to 'git/objects/pack/*.pack' files with its
   knowledge about the loose object files and the "--prune" option.
   Consolidating pieces of information spread across multiple .idx
   files, reachability bitmaps and commit graph files, into a newer
   and more performant forms can just be part of "packing the pieces
   of information in a repository for optimum performance", which is
   a better way to understand why "repack" has a word 'pack' in its
   name.

 - Many of the "maintenance" operations this series proposes do make
   sense, just like other "maintenance" operations we already have
   in "repack", "prune", "prune-packed" etc., which are welcome
   additions. 

 - Like the individual steps that appear in e.g. "repack", however,
   some of the individual steps in this series can be triggered by
   calling underlying tools directly, allowing scripted maintenance
   commands that suit individual needs better than the canned
   invocation of "run-job", but I didn't get the impression that the
   series strives to make sure that all knobs of these individual
   steps are available to scripters who want to deviate from what
   "run-job" prescribes.  If it is not doing so, we probably should.

 - Again, I do not think we want a reimplementation of cron, at or
   inetd that is not specific to "git" at all.

Thanks.
