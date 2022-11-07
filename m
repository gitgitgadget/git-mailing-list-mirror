Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D74C43217
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 00:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKGAl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 19:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKGAl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 19:41:57 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E590BCA1
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 16:41:56 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DC911BC3F3;
        Sun,  6 Nov 2022 19:41:53 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=FkHCWjYH2nNlw
        4qnRpofHTk+w1SpWFguTUlZESAX7yg=; b=roh+vXZi98pk28J89u8Xdv5ymTtYV
        HV22zZf4CmSOMoxTjGZp+8idq6Ymk9KxJXaEwm4MyBMQ5iczeFfr91LPlhrM8n0o
        8mXml2oOD88dfwkuYacRICnpqs092B4mlt5EUtWBt1fgN3VZuUxwAFDWkhfcyNuY
        TMf9sWSxmViMms=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 161C11BC3F2;
        Sun,  6 Nov 2022 19:41:53 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CAFB1BC3F1;
        Sun,  6 Nov 2022 19:41:48 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Sun, 6 Nov 2022 19:41:44 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>
Cc:     git@vger.kernel.org, andreas.stieger@gmx.de
Subject: Re: git can not be built for s390x since update to git-2.38.0
Message-ID: <Y2hUSDlW/mChgotU@pobox.com>
References: <64b10e7e-2807-8ae5-88c7-3df7f6f1f3bd@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <64b10e7e-2807-8ae5-88c7-3df7f6f1f3bd@opensuse.org>
X-Pobox-Relay-ID: F69F7AA4-5E34-11ED-977E-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sarah Julia Kriesch wrote:
> Thank you for the hint, that it is working for Fedora!
> I have compared your spec file with ours and found, that you have got a
> BuildRequires for jgit only for s390x.
>=20
> That has solved the problem. Is there any special reason, that s390x ne=
eds
> jgit for git builds?

It's the opposite -- but the rpm conditional is quite long
and ugly though, so it's not as clear it could be.  It
excludes jgit for the test suite entirely on Fedora 35 and
newer=B9.

On prior releases, it was excluded for x86 and s390x
architectures.  For s390x, the issue was that the jgit
daemon frequently hung on during builds and was painful to
try and debug without access to the architecture.  (For the
few tests which use jgit, it was simpler to just not test on
s390x).

=B9 Every few releases (it seems), some part of the java
  dependency chain gets close to being dropped from the
  distribution.  After disabling and enalbing jgit several
  times, I've left it disabled, even though jgit has managed
  to remain in Fedora.  As much as I'd like to run the
  compatibilty tests, I don't like the "OMG, git will be
  removed from Fedora because some dependency of jgit is
  going away!" every couple of releases. :)

--=20
Todd
