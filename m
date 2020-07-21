Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D6DC433E1
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA5520658
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 22:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dmtvaQFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgGUWUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:20:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbgGUWUl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Jul 2020 18:20:41 -0400
Received: from crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D88CC6044F;
        Tue, 21 Jul 2020 22:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595370010;
        bh=CnLaKGjpQy4yZCZ/yP+/qT/ha/CAm0yVwveXsChaYMM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dmtvaQFYCariOWO+tdxxokxm0BXQH05xr88ZM8dwQpDhmh4Udd8AnjPHVVzF9Dg/9
         Ci8KFaYEyM5Z+Pw2iOCJ5aW6EbhHbsPVR0KU2uoN4RIsL1w1Wk9cqjuzhgfH3U8EBA
         B1i8NtzH2aXcvhSq7+ROLvIU6ugt/tH7DnDTN0kwZ1SYYU9CPXlRP1NrI+85lQF5hu
         Kp3Tcjj5P/f7E46EmqTYV52JUK3j6slCcWHhG5Zfdq0G0gOyefLK1ByIzyNw674ELu
         /+4oF5H33k7Owhjmc3dPTDo4AOk9KcnZpooXTsF2hvabQ+nMn4tK2cL82Z+otL6bGk
         HEcv62HxeEma/JmxcZ8v7rp6TV+dBJ4zwYUee+ByXeyc7uZL0mK1W7e4dW066gHz+7
         djnifxQPTeQ8drFjcjYdzTch8z8fFF3fqLCphUiwwB8MZvPjIKX/d9iV4J8TjLYJKF
         nWdGS3LLWLCb/C517IruolXTWJ8shPlw6XsJQ4RqYUK2NQsrIuY
Date:   Tue, 21 Jul 2020 22:20:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] [RFC] travis-ci: remove bogus 'pyenv' in the Linux jobs
Message-ID: <20200721222004.GA1667453@crustytoothpaste.net>
References: <20200721161225.6769-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200721161225.6769-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-21 at 16:12:25, SZEDER G=C3=A1bor wrote:
> In our test suite, when 'git p4' invokes a Git command as a
> subprocesses, then it should run the 'git' binary we are testing.
> Unfortunately, this is not the case in the 'linux-clang' and
> 'linux-gcc' jobs on Travis CI, where 'git p4' runs the system
> '/usr/bin/git' instead.
>=20
> Travis CI's default Linux image includes 'pyenv', and all Python
> invocations that involve PATH lookup go through 'pyenv', e.g. our
> 'PYTHON_PATH=3D$(which python3)' sets '/opt/pyenv/shims/python3' as
> PYTHON_PATH, which in turn will invoke '/usr/bin/python3'.  Alas, the
> 'pyenv' version included in this image is buggy, and prepends the
> directory containing the Python binary to PATH even if that is a
> system directory already in PATH near the end.  Consequently, 'git p4'
> in those jobs ends up with its PATH starting with '/usr/bin', and then
> runs '/usr/bin/git'.

Ouch.  So we're testing git-p4, but not the git binary underlying it.
Fixing this definitely seems like a good idea.
--=20
brian m. carlson: Houston, Texas, US
