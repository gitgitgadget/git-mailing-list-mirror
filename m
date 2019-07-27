Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6561F462
	for <e@80x24.org>; Sat, 27 Jul 2019 20:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbfG0U52 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 16:57:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60699 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388064AbfG0U51 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 16:57:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6509170CE7;
        Sat, 27 Jul 2019 16:57:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6El/TGTR/aZd
        rc88RxY5Qjl2iB8=; b=rxhiq5I9hmzQGhcUq0y6A16UT6DgmcizOy3FWDk2SVrN
        rVmptqDFF7RXTK+x9to9bqKIZPV7wgQq2I7apEAergalzyZlU3qk4XOhVU31P3QB
        vLKNaqkfDYXtLMWT+MMf1j9YtWI70J2H00pR4bMusRWXnzicoNj7UOqM3mx1jXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SPEvJU
        vcq1k0tHGodHYJamT04n7DDsoW73Z6NIceXIC+w8UTZkS2Zhe8oQl8Qx5QKWNKgp
        a21JXDW6IkmIwpO9ZVb9BhV/WQJxYKIQ3pooyBnYVvSEzwGMubrfeEjglxU8RrC2
        7lI4w0zXAUSI/ZFnQeKq+iqoHwr2TAXpy6ci0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC266170CE6;
        Sat, 27 Jul 2019 16:57:20 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDC6A170CE5;
        Sat, 27 Jul 2019 16:57:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christopher Head <bugs@chead.ca>
Cc:     git@vger.kernel.org
Subject: Re: Push force-with-lease with multi-URL remote
References: <20190727095440.1aac3b3c@amdahl.home.chead.ca>
        <xmqqzhkzl69o.fsf@gitster-ct.c.googlers.com>
        <0DC4FE1B-90A9-414B-AFAC-E328608C4F98@chead.ca>
Date:   Sat, 27 Jul 2019 13:57:18 -0700
In-Reply-To: <0DC4FE1B-90A9-414B-AFAC-E328608C4F98@chead.ca> (Christopher
        Head's message of "Sat, 27 Jul 2019 11:15:37 -0700")
Message-ID: <xmqqv9vnkxg1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1FC03DF4-B0B1-11E9-9232-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christopher Head <bugs@chead.ca> writes:

> On July 27, 2019 10:46:43 AM PDT, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>Christopher Head <bugs@chead.ca> writes:
>>
>>Quite honestly, the true culprit of the above story is that you are
>>letting multiple logically different remote repositories [*1*] use
>>the same single remote-tracking refes/remotes/myremote/ hierarchy.
>
> They weren=E2=80=99t supposed to be logically different (if I understan=
d
> what you mean by that phrase). My intention was for the different
> URLs to be mirrors of each other,...

What I would call "logically the same" is the set of repositories
that are synchronized at the server side, which may or may not have
multiple URLs to reach it, but behave as if it is just a single one
without your doing anything special.  Your wanting to actively make
them in sync by the above definition makes them logically different
set of repositories.  But the phrasing does not matter much.

One repository at a hosting service (which may iternally be
replicated, but that is not even observable from outside) may be
reached over https:// or ssh://, and the result of pushing to either
one of the URLs would be observable by immediately fetching back
from either one.  Having both URLs and trying to use either one that
works may help under flaky proxy situation, for example.

In the reverse direction, I think "git fetch" supports the notion of
<group> of repositories, so that fetch from multiple remotes can be
initiated with a single command, but I am not sure if we added the
same <group> concept to the pushing side.  I personally want to have
finer control, so when I push my work to multiple repositories, each
of them are treated as totally different push targets, and a script
controls multiple "git push" processes to each of them in parallel,
with retries and all.  I think having multiple pushURL and pushing
to them is sort-of OK, but what is broken in your configuration is
that you have a single remote-tracking branch hierarchy---if you get
rid of it, so that refs/remotes/myremote/ does not exist and does
not get updated, I think things would work fine.






