Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3767C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C79D2465D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DoR8/VYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgBSSKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:10:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53142 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSSKe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 13:10:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AE8C47466;
        Wed, 19 Feb 2020 13:10:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oaqs58TwltRNPcYaPY8SLOcnMec=; b=DoR8/V
        Yb2vxJbwE2luA45EeXAyUEiYsGBqvZXLcRtbfSvhYadyeONgz+zI/VWcpxyS/kPk
        1qXitIEJSI3RRN03s6nKh2+YNMZ8uqW2kKGpMLBClM8MnRaNTk09JIsGP7QXBg/j
        qXofiIBDSknECFAsV9rzyn0PWdMnenJyPUoGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DhKR7aOAz5sDrj0bdDwAn2UI2cRquAkh
        G7tBcRSui9KFNmeZY5IpL+BdSpJgn0P18VDexhPyHEC8Lbh/GrfgB2DmzwG8mYiW
        WtNQvVVq7QgE57Kl0SOw9Usq7J/ZAnNl1CLvAMZDheOhkyKW9yNxJ7GbZMi5OMuu
        cuRQLeYc7x4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3005147465;
        Wed, 19 Feb 2020 13:10:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FE0D47464;
        Wed, 19 Feb 2020 13:10:31 -0500 (EST)
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
Date:   Wed, 19 Feb 2020 10:10:29 -0800
In-Reply-To: <CAOw_e7ZztSCzpmaCYg2c1iaZLWSsYz4dYegT0V0dHVaDy8A_uQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 19 Feb 2020 18:21:03 +0100")
Message-ID: <xmqq8skyfnxm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D9A3A36-5343-11EA-A573-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwenn@gmail.com> writes:

> On Wed, Feb 19, 2020 at 6:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> > your checker is tripping over code imported from zlib. I added a /*
>> > clang-format off */ comment to avoid reformatting this code. What do
>> > you suggest?
>>
>> Use zlib from the system instead?
>
> uncompress2 is a 2016 addition to zlib. It doesn't pass on
> gitgitgadget's CI, because it is using an older version of zlib.

Ahh.

It is OK (and indeed you're right that you cannot avoid it) to ship
a reasonably new snapshot as a fallback in such a case, but it still
is far more preferrable to avoid linking with the fallback snapshot
copy when a working one is available on the system, especially for a
widely used and established library like zlib, because we have one
less thing to keep up-to-date with the security patches made to the
upstream.

In any case, if we cannot avoid shipping a borrowed code that we'd
rather not touch or fix-up, covering them with local .gitattributes
file, disabling selected whitespace checks, may be one way out.
IIUC, our default settings for the whitespace check is in the
top-level .gitattributes file

    * whitespace=!indent,trail,space
    *.[ch] whitespace=indent,trail,space diff=cpp
    *.sh whitespace=indent,trail,space eol=lf

A new local .gitattrubutes file in retable/ directory to loosen the
set of checks.  The borrowed code triggers indent-with-non-tab and
trailing-space at least, which needs to be disabled locally, I
think.

Thanks.

 reftable/.gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/.gitattributes b/reftable/.gitattributes
new file mode 100644
index 0000000000..f44451a379
--- /dev/null
+++ b/reftable/.gitattributes
@@ -0,0 +1 @@
+/zlib-compat.c	whitespace=-indent-with-non-tab,-trailing-space
