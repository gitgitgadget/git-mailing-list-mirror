Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78745C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A332158C
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 17:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TPK9Z9Gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgI1Rbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 13:31:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56528 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1Rbk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 13:31:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6414EE9DA;
        Mon, 28 Sep 2020 13:31:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4c1J8Cl9BYqeXKH/YpgYZraHZsc=; b=TPK9Z9
        Gf94StW+aCcNvwqilLdR2qh/eVfO3GWQLeJXGYdeppHxdBb54RnlKzqnIoY/GmnZ
        lQXj/HBNPEbjCCC9yd6R2fbsjLuHtVeg4pQhm+OvuPBP3ZWoMkAV4uwFLU0ec8+E
        Nzn+tCZAGj2VZG2e9nOWkurmQKb6hS86tAltU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=StTZf0hSjEv25WAJMAoRk6QOhOEtbeNw
        14KebRXbfDOlwgHNPckOk4YhdIcanbqr/VnuzWopI8cNokqIdaSVtKn5GhXo2HRA
        7HLIsUczZcTVeVdWqRaAc94UWI+qhzVc/ytHS2YDQ43TWZFZcLBu99ljNSULhDDG
        pZ3DSR7i4P4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEE18EE9D8;
        Mon, 28 Sep 2020 13:31:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F31EDEE9CD;
        Mon, 28 Sep 2020 13:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 0/3] push: add "--[no-]force-if-includes"
References: <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
        <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
Date:   Mon, 28 Sep 2020 10:31:34 -0700
In-Reply-To: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Sun, 27 Sep 2020 19:47:44 +0530")
Message-ID: <xmqqtuvhn6yx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7560F356-01B0-11EB-B3F8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Add a new option: "--force-if-includes" to "git-push" where forced
> updates are allowed only if the tip of the remote-tracking ref has
> been integrated locally, by verifying if the tip of the remote-tracking
> ref -- on which a local branch has based on -- is reachable from at
> least one of the "reflog" entries of the branch about to be updated
> by force on the remote.

https://travis-ci.org/github/git/git/jobs/730962458 is a build of
'seen' with this topic, and the same 'seen' without this topic is
https://travis-ci.org/github/git/git/builds/730857608 that passes
all the jobs.  It is curious why one particular job fails while
others in the same build is OK.  I've seen this pattern for this
topic in the past few days.

The failure in t5533-push-cas.sh is sort-of understandable as the
topic directly touches the area of the code the failing test
exercises, but the failure in t3701 is totally unexpected.

You can go down to the bottom of the page and click on the
ci/print-test-failures.sh line to see which test piece fails.

Anything rings a bell?

Thanks.


