Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6528FC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 18:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiGASlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGASlR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 14:41:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444D728723
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 11:41:17 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D454D1AE061;
        Fri,  1 Jul 2022 14:41:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zyfvvB/sswmzP47QEiuXtIJK5eM5GUoYZ6G6y7
        PUz7k=; b=JcKMxvOrZ8hFDiaRTOPVeOyH4SvF4kwn+5EJa3gC9DP19Omf4D5yFd
        5T6IUYg1c8U7tcU6eCI2fNKpHxgQmRnsBI+C2A+VA27FYDU9Gu3vQUuHWYAGloku
        kxPLzm5rJ4MzjxuYGn1+Dm2In4TFhRzDqJp4uuGccz2AdLYwwQm+w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE3561AE060;
        Fri,  1 Jul 2022 14:41:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5EE291AE05F;
        Fri,  1 Jul 2022 14:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Eric D <eric.decosta@gmail.com>, git@vger.kernel.org
Subject: Re: Option to allow fsmonitor to run against repos on network file
 systems
References: <CAMxJVdH+o+H56tJ4UmD8YcsNsLuutiUXpOP=euQbomBe1kLkMw@mail.gmail.com>
        <16832f8a-c582-23bb-dda9-b7b2597a42eb@jeffhostetler.com>
Date:   Fri, 01 Jul 2022 11:41:12 -0700
In-Reply-To: <16832f8a-c582-23bb-dda9-b7b2597a42eb@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 1 Jul 2022 09:32:37 -0400")
Message-ID: <xmqqmtds8ylz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6216B2F2-F96D-11EC-B961-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Having said all of that, I did do lots of testing and never had an
> issue with remote drives actually working correctly, so I think it'd
> be fine allow a config setting to optionally allow it.  I just didn't
> want to clutter up things in advance if no one actually wanted to
> use it on remote file systems.
>
> I think it would be fine to have a "fsmonitor.allowRemote" or
> "fsmonitor.allowWindowsRemote" config setting and default them to false
> for now.  Or until we learn which combinations of remote mounts are
> safe and/or problematic.

How about getting rid of "is this remote?" check altogether (which
presumably would simplify the logic) and make it totally up to the
user of the repository?  fsmonitor.disableInRepository that is set
in ~/.gitignore and lists the paths to the repositories (like
safe.directory does), for which fsmonitor gets disabled, may be a
handy mechanism to set up the default (and it can be re-enabled with
per-repository core.fsmonitor).


