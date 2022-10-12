Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F7C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJLVf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJLVe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:34:58 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD205356ED
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:34:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10DE11562E4;
        Wed, 12 Oct 2022 17:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9F08g8OqYb7vQAbBrH1KK8vr14lQJ6Vz/l0HTk
        PwGbs=; b=yCuMwDkW/EyV78CZ1DWUyeeq5bLA9c0z4Qs4AbmzgqkGW1IJwjDZ5H
        nwGIGbyxOpEeOfVrmVNzNwNkwqKVsEVDyI+8XKr4BaKZQUdjGGJTMrlA3+KkUUNA
        PQw2VKiYpVwYvNRPrBm/efTGNOosCP//taTO0IMa6NNxmSkLa8d+U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 091971562E3;
        Wed, 12 Oct 2022 17:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FACB1562E2;
        Wed, 12 Oct 2022 17:34:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
Subject: Re: About git reporting missing newline for symlinks
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
        <Y0cyX8Ggp+dkgAjX@tapette.crustytoothpaste.net>
Date:   Wed, 12 Oct 2022 14:34:55 -0700
In-Reply-To: <Y0cyX8Ggp+dkgAjX@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 12 Oct 2022 21:32:15 +0000")
Message-ID: <xmqq35bsk9og.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B744C882-4A75-11ED-97DA-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-10-12 at 21:17:04, Ignacio Taranto wrote:
>> So, both git diff and git show display "\ No newline at end of file"
>> for symlinks.
>> 
>> I think this is related to how Git renders diffs, IMO it shouldn't
>> display a warning about
>> newlines for symlinks.
>> 
>> Am I making any sense here?
>
> What Git shows for a symlink is the destination of the symlink.  On
> Unix systems other than macOS, path names may contain any byte other
> than NUL, including a newline.
>
> While it obviously is not a good practice to include newlines in your
> paths, it is possible, and Git would not be able to round-trip symlinks
> where the final character of the destination is a newline if we didn't
> handle trailing newlines properly.  As a result, we're not likely to
> change things here because it's required for correctness.

Just a fun thought experiment, but I wonder what would happen if a
user chooses to add .clean and .smudge filter that adds and strips
a LF at the end ;-)
