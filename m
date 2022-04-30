Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9645BC4332F
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 06:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiD3GnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 02:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiD3GnR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 02:43:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315373632E
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 23:39:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0056120F41;
        Sat, 30 Apr 2022 02:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B7SZAF4MSaFb
        alSNqv+rhqY/axMacKkM7EDu7XnWfJk=; b=jZvD5OQ/k5fVleYo4clwexvM+EO+
        ixLtmSi+zS3mmdqoI3NARSk812Lb3LeMtsi4KeRkMzfNIS2LIlvmJa2cFOK8FWUO
        /UdzGQuxhq//yrYnka4ryf+Wo787PRMJqr6lrv4fO1dInJYJuvihI5AZ16DozTAQ
        Bstv9dZc1oHhM84=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A718D120F40;
        Sat, 30 Apr 2022 02:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A9C8120F3F;
        Sat, 30 Apr 2022 02:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Documentation: explain how safe.directory works
 when running under sudo
References: <20220428033544.68188-1-carenas@gmail.com>
        <20220428105852.94449-1-carenas@gmail.com>
        <20220428105852.94449-3-carenas@gmail.com>
        <YmzUirQlDR1942rH@debian.me>
Date:   Fri, 29 Apr 2022 23:39:51 -0700
In-Reply-To: <YmzUirQlDR1942rH@debian.me> (Bagas Sanjaya's message of "Sat, 30
        Apr 2022 13:17:46 +0700")
Message-ID: <xmqqbkwj847c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 576B735E-C850-11EC-90A0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Thu, Apr 28, 2022 at 03:58:51AM -0700, Carlo Marcelo Arenas Bel=C3=B3=
n wrote:
>> In a previous patch, the behavior of git was changed so it will be abl=
e
>> to find the "effective uid" that is required when git was invoked with
>> sudo to root, for example the internal calls made to git when calling
>> the following in git's own repository:
>>=20
>>   $ sudo make install
>>
>
> That is building Git, right?

Why do you want to know?  In other words, if Carlo answers "yes" (or
"no" for that matter), what are you going to do with that piece of
information?  E-mailed communications with people on other
continents are inherently high latency, so it is more efficient to
try reducing number of round trips.  One trick is to make sure that
other side does not have to wonder "what do you need to know it
for?" by telling them upfront why you want to know.  Then they can
guess better what kind of information to what detail you need, in
order to move forward.  If they agree where you want to go with the
information is a good thing, it may even give them an incentive to
give as high quality information as they can as quickly as they can
to you.

Having said all that.

If you re-read the sentence before that sample command line, it
would be clear that the answer is "yes, as that sentence said, it is
building and installing Git".  Especially "when calling the
following in Git's own repository".

But Git in that message is merely an example.  Any piece of software
that wants to run "git" as part of the "make install" procedure
(e.g. to compute the version number, it may run "git describe", when
it knows the build is being run in a Git managed repository, instead
of being in a tarball extract) is affected.
