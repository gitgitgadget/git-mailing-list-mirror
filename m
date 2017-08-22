Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB4E1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 19:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbdHVTeu (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 15:34:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64396 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752393AbdHVTes (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 15:34:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC2BD8D0CA;
        Tue, 22 Aug 2017 15:34:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=endFLE5dBtx9kWCZHYpt7yNT8Ag=; b=wfU4iR
        v2ebqoOSEs9gVZfmL+iFZfmyA7x1n85frcSm775Jqh468avbCbYGe7bvYggN8TtF
        odFdLhlO7CvvIYykQLs/vyRMRCkryHEBvw7wKclYzoRFQMjuiahRloFHiqySJfmd
        L0saoNpioAA9Wb37246AAfObKdvsMls0c7ZjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KpbN26StxF0ge9YHst/JQ3ZMZreBP8XN
        SeFpjVzsIomRcT4brWZ6bHBdKMpGLKzFuOSsgyTDHSgo972MzvmnDQmNF2tMxXsc
        mPAP7zlUvG1W+qmdY0q7N+NxOJ1zfP9ishuXLNwMiZNCUud2ZSpp+Cs6l6jVfOg0
        5pSBmcR4dCM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D383C8D0C9;
        Tue, 22 Aug 2017 15:34:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4825E8D0C8;
        Tue, 22 Aug 2017 15:34:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Best way to check whether working tree matches a commit's tree
References: <onhres$g9$1@blaine.gmane.org>
Date:   Tue, 22 Aug 2017 12:34:46 -0700
In-Reply-To: <onhres$g9$1@blaine.gmane.org> (Sebastian Schuberth's message of
        "Tue, 22 Aug 2017 20:00:01 +0200")
Message-ID: <xmqqfucj2y7d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4E94ED8-8770-11E7-BE62-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Hi,
>
> I'd like to check whether my working tree exactly matches the tree of a given commit. That is, there should not be any untracked, staged or modified files (including ignored files).
>
> Currently, I'm doing this in two steps:
>
> - check for success and empty output of "git status --ignored --porcelain"
> - check that the output of "git rev-parse HEAD" matches the given commit
>
> While this works, it feels sub-optimal. Is there a better / smarter way?

I do not think so; you want three things to match and you have a way
to compare two things at a time.

By the way, I think your second check should compare

	rev-parse HEAD^{tree} $that_commit^{tree}

as you are checking if the tree exactly matches.
