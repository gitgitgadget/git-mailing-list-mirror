Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EC2C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3466506E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 14:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhCPOVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:21:34 -0400
Received: from out2.migadu.com ([188.165.223.204]:50932 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236185AbhCPOVV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 10:21:21 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1615904474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMVjvY58pHI+g+kZ3jBquPi727Mo247uTplvjDdR2p0=;
        b=BA10lej7/m2/SawMFsnpG6LEETV8c7Bkse8MfTQFm06bsAuN4BFqUbO/otXaF5DvXpO+cM
        672/MroQhmX1L0rHflvCdgmkepaR+p96hWWKyNWlYiq2oXIUjx9jCcrHbAoL0aqe+hYRWw
        VT7XqYjol5QB8DzjnteRZZUUlxwya8OvoHj6sue005qHcOPM9qp/qsAT7t4HJmYsV6pUnr
        ILUg8/u6Flm4Fl/frnMhFw4MaM+1/pZIceX3xV9nBmQelXqPNNEiyFrUMRwnVj44NyBxt2
        NZwBUt4NJzI9IkYAD35+5kt/od2OQW91H4IFN0Q4ONQsGsCaI5XML0LlteezAA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 16 Mar 2021 10:21:13 -0400
Message-Id: <C9YUBUYH7PWU.3PHDZR2YCUEOX@taiga>
Cc:     "Jonathan Nieder" <jrnieder@gmail.com>, <git@vger.kernel.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eli Schwartz" <eschwartz@archlinux.org>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
 <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
In-Reply-To: <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue Mar 16, 2021 at 7:54 AM EDT, brian m. carlson wrote:
> I believe this construct is nonstandard. It is better to use standard
> URL syntax when possible because it makes it much, much easier for
> people to use standard tooling to parse and handle URLs. Such tooling
> may have special cases for the HTTP syntax that it doesn't use in MAILTO
> syntax, so it's important to pick something that works automatically.

It is standard - RFC 3986 section 3.1 permits the + character in
URI schemes. The use of protocol "composition", e.g. git+https, is a
convention, but not a standard.
>
> So I'm very much opposed to adding, expanding, or giving any sort of
> official blessing to this syntax, especially when there are perfectly
> valid and equivalent schemes that are already blessed and registered
> with IANA.

This convention is blessed by the IANA, given that they have
accepted protocol registrations which use this convention:

https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml

> It's difficult enough to handle parsing of SSH specifications and
> distinguish them uniformly from Windows paths (think of an alias named
> "c"), so I'd prefer we didn't add additional complexity to handle this
> case.

There's no additional complexity here: git remotes are URIs, and any
implementation which parses them as such already deals with this case
correctly. Any implementation which doesn't may face all kinds of
problems as a consequence: SSH without a user specified, HTTPS with
Basic auth in the URI username/password fields (or just the password,
which is also allowed), and so on. Any sane and correct implementation
is pulling in a URI parser here, and if not, I don't think it's fair for
git to constrain itself in order to work around some other project's
bugs.

> Lest you think that only Git has to handle parsing these

I don't, given that my argument stems from making it easier for
third-party applications to deal with git URIs :)

> Despite the fact that ssh+git is specified as deprecated, we had
> people expect it to magically work and had to support it in Git LFS.

Aye, people do expect it to work. The problem is not going to go away.
