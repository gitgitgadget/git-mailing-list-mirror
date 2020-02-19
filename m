Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2115DC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF6B2176D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cBVdFFDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSUJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:09:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61418 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUJE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 15:09:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 816C348214;
        Wed, 19 Feb 2020 15:09:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NOtSnpczFnY7jvfhNCrm98TNi7E=; b=cBVdFF
        DFWRSkZ/0Sw0aSjZC2aPgIpaPDbQlO/VX9DyMRxOud6+ob5psppUZ5Laz5PmbIkB
        QgP+0Mzd4mkBDK0QLzPH/Mcu8Zazd4DRKpSra1QwofOgYiAj9dKTEwaXzZwnHCTs
        hmaQreAkHZHxhJU21nrEN6qxXw2xsgkWp8RR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R00RnzRhnCJbc2zElPZrjc9353PIr/X+
        Zl9lldDc/b1BxbcbjV+6GGq/hoQvGoBsB6/ZzL7iIZ8cVMw2SBjDOTnwmBDIQTbZ
        r3GSTd/V8nzwqs7UaZqrX/wodRril0hakw0+XNGtSfCAakUtF+IrLv4OzO0JnNHZ
        yHaIi2+3/6M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78CB248213;
        Wed, 19 Feb 2020 15:09:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBF9E48212;
        Wed, 19 Feb 2020 15:09:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwenn@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Reftable support git-core
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
        <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <xmqqy2szip35.fsf@gitster-ct.c.googlers.com>
        <CAOw_e7abpAwTkb6qKZjbxxw7XrAWdhcANbjAWvRxi1_fT5vSDA@mail.gmail.com>
        <xmqq36b6h5o2.fsf@gitster-ct.c.googlers.com>
        <CAOw_e7ZztSCzpmaCYg2c1iaZLWSsYz4dYegT0V0dHVaDy8A_uQ@mail.gmail.com>
        <xmqq8skyfnxm.fsf@gitster-ct.c.googlers.com>
        <CAOw_e7YPzLb-zR+NVCR=-cNJg_43Q0E758RBJubqDdgYR=tNww@mail.gmail.com>
Date:   Wed, 19 Feb 2020 12:09:00 -0800
In-Reply-To: <CAOw_e7YPzLb-zR+NVCR=-cNJg_43Q0E758RBJubqDdgYR=tNww@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 19 Feb 2020 20:14:35 +0100")
Message-ID: <xmqqr1yqe3vn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABDF6806-5353-11EA-B740-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwenn@gmail.com> writes:

> On Wed, Feb 19, 2020 at 7:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>> It is OK (and indeed you're right that you cannot avoid it) to ship
>> a reasonably new snapshot as a fallback in such a case, but it still
>> is far more preferrable to avoid linking with the fallback snapshot
>> copy when a working one is available on the system, especially for a
>> widely used and established library like zlib, because we have one
>> less thing to keep up-to-date with the security patches made to the
>> upstream.
>
> what is the procedure for doing this? Do I need to write autoconf
> macros (oh no!) ?

We treat the Makefile macros listed at the top of the file as
authoritative set of knobs, so 

    # Define ZLIB_LACKS_UNCOMPRESS2 if your zlib is so old to lack the
    # function uncompress2().

with conditional compilation/linkage based on the macro would be
minimally sufficient.  Setting it automatically in ./configure is
nice-to-have but is optional.
