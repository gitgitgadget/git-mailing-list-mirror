Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCAFC2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6C2206CB
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hv6icTzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLXTZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:25:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64222 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLXTZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:25:28 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6508398CA4;
        Tue, 24 Dec 2019 14:25:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v6rsd5tI5YhvKTEOAN1B+iEaBMA=; b=Hv6icT
        zcP+AE2pk6F8xDmVwL5OT10uYqZ/49/HkftxXn3nS/Drb4lB3bbaCWXF9zTfrjuu
        fQL4UA5YJi4ZNaMq6m/4spayQHTRMi/bwi6HSv+VL+YnVCDJ3OtZIJ79JET6M2C3
        yEEUod2IoYLh2nvgnE1TwCTgLZkXN26APEw8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OBPEjJs/7UO4cBnrtfxi5VWlXByM2s4E
        EG02sf8DFoEaYAyrCg+HOSPHzz6TMZo4tz/5K1ApsM/+m3a6JDQCALZhR+19KZLB
        hghiH3a4JuwJGsaZ3shEDa0uAJhScXZ7RA/61haTPzEhwl0z1x+leuLLg5b7/joH
        gfkKYmQJ4NM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4593198CA3;
        Tue, 24 Dec 2019 14:25:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B93698CA2;
        Tue, 24 Dec 2019 14:25:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] format-patch: make format.outputDirectory relative to worktree
References: <9422e4225143b2b908bd1fed9a510b9333bf34a2.1577191015.git.liu.denton@gmail.com>
Date:   Tue, 24 Dec 2019 11:25:18 -0800
In-Reply-To: <9422e4225143b2b908bd1fed9a510b9333bf34a2.1577191015.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 24 Dec 2019 07:37:50 -0500")
Message-ID: <xmqq36d95xwh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FC6AE9E-2683-11EA-BFA6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Currently, when format-patch outputs patches to the path specified by
> the `format.outputDirectory` configuration variable, it is relative to
> the current working directory. However, it would make more sense for the
> path to be relative to the worktree if it exists so that patches will be
> placed in one location even if a user were to change directories.

Would it make more sense?  If a user is deep in the hierarchy, after
running

	$ git format-patch master..

the next thing the user would want to do is to go to the directory
and give them final review and edit the patches before sending out.
That would involve going up some levels depending on where s/he is,
in other words, the location the patches are found would be different
and this change makes it a lot more cumbersome to go there with a
relative path.  The only people who benefit from the change is those
who have their working trees at very shallow hierarchy so that it is
not cumbersome for them to give the full path to the top of them.

So I think this cuts both ways, and "it would make more sense" is
overselling.  Besides, those who can easily give the full path to
the top of the working tree (because they are short) can spell that
short path to outputDirectory configuration variable just once and
be done with it, no?

> Rewrite the output directory logic for format-patch so that it will be
> relative to the worktree of the directory. An escape hatch is provided
> for if the previous behaviour is desired by prepending "./" to the
> variable.

Anything that forces existing users to change their existing
settings is not an escape hatch.  It merely is a regression with a
possible workaround.

So I dunno.  I probably would have accepted a patch that *adds*
outputDirectory configuration that behaves the way you are proposing
in this patch if we did not have the variable yet in the system
(i.e. three or four years ago), but I am not sure if it is a good
idea to change it after these years.
