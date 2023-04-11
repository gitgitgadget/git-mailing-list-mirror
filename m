Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFD4C77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 16:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDKQcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 12:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDKQcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 12:32:09 -0400
X-Greylist: delayed 1600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Apr 2023 09:32:05 PDT
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED440FC
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 09:32:05 -0700 (PDT)
Received: (qmail 31708 invoked by uid 989); 11 Apr 2023 16:05:23 -0000
Authentication-Results: cressida.uberspace.de;
        auth=pass (plain)
From:   Matthias Beyer <mail@beyermatthias.de>
To:     git@vger.kernel.org
Subject: Bug with git-config includeIf
Date:   Tue, 11 Apr 2023 18:05:18 +0200
Message-ID: <3352350.44csPzL39Z@takeshi>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8326540.T7Z3S40VBb"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Rspamd-Bar: -
X-Rspamd-Report: MIME_GOOD(-0.2) SIGNED_PGP(-2) MID_RHS_NOT_FQDN(0.5) BAYES_HAM(-0.120411)
X-Rspamd-Score: -1.820411
Received: from unknown (HELO unkown) (::1)
        by cressida.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 11 Apr 2023 18:05:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=beyermatthias.de; s=uberspace;
        h=from;
        bh=WQkqmtFwHaNvPVn+X56WyPvO2Zhii2Bfs8y2ZYACK5Q=;
        b=l4v+lIEK7WfWBqvrTInPQui42hLDgVXqGK4INSANz6nzhPMB5LRC4o+iL4wXnc48+gdkeaKOcI
        5j8zIqdzvetdglNJeTCvLIN6jaQU3CIXQFebiUlKc2ndH72JP6/eHMAWMlGHzYuN2IJUB+Mopnsy
        z7jaU02X82KStN0veTjZWZRgjdyxESwKMtwY5msVHI4Osz5vBPd8UAiA/OUptoFb2I1yX9abVk1J
        S72QCUER1N4TcWumRJGk5rE7Bd/wGoprbIJrT9yguWBzS+ilVc79z12uXEyJRRDnzDeH6fgIqIcK
        e6FOVmbp+zGbr62jdzHvbJcoa0qhC2sCKpwNjctfqnXIP9MywmCBkVvB3/DS/tDivjwBUIDOdzdZ
        Wuspkl3yQTsEVtE9FluRRYOwenATJwZeoww4Mmnhz6rPJH+PZ0C07GRCEKbAg480ZfTAJ1XpU8Eg
        DXt7XvuplBq18MZaf27hnmuFnY6/E0QS1XQ4vL0psqpLaceFy7aJCQHMtMQB68+967a1HMu9Go40
        /1q5KirWqwaH2ECZMufaUTBe4Kl2M5hHnmiohGoPlpJxtEzZC5Y2jA/X97OtHMvpKbDyFtZLZJRd
        aV6W8zTInohp9qNgmdzQImKovPNAPCzjv6K20sF0ieDcss/ZlXTxdXWS6i6sxc+ACWwHLA2YNaXC
        M=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart8326540.T7Z3S40VBb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Matthias Beyer <mail@beyermatthias.de>
To: git@vger.kernel.org
Subject: Bug with git-config includeIf
Date: Tue, 11 Apr 2023 18:05:18 +0200
Message-ID: <3352350.44csPzL39Z@takeshi>
MIME-Version: 1.0

Hi,

please keep me in CC when replying, I am not subscribed.

I experience the following (seemingly) bug in my git setup:

I have three files for my git configuration:

* ~/.gitconfig -> ~/config/git/gitconfig
* ~/config/git/gitconfig_private
* ~/config/git/gitconfig_work

The gitconfig_private sets my email address to this very email address, the 
gitconfig_work sets it to me work email address.

The gitconfig file has a `includeIf` directive:

```
[include]
    path = ~/config/git/gitconfig_private                                                                                                                                                                                                                                                                                    

[includeIf "gitdir:~/dev/work/"]
    path = ~/config/git/gitconfig_work   
```

That means, from my understanding, that all git repositories in ~/dev/work 
should now have the work-related email address set.

If I go to ~/dev/work/somerepo and `git config --get user.email` it indeed 
shows the expected email address.

But if I go to a subdirectory in that repository, the very same command shows 
the private email address, and commits get written with that private email 
address.

Did I miss something obvious or did I discover a bug?

git: 2.38.4

Best,
Matthias
--nextPart8326540.T7Z3S40VBb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEUJGUus1GMTrRclzcEKWX9Kitz80FAmQ1hT4ACgkQEKWX9Kit
z83Dlg/8Dzd+qX1OcKZ+mCpmTjg0DNJq7RI5lfriMBWv6AMNI7riwQFl4/8Hs2jd
DHBz/j3hD6U5CUmI2qOXYmLAc8BgkFWorxlPPRhhXh9Jkvzv2COZ5SquEaAvYhOT
VCONh57u5/fe9XOHo7jSjKywUzAkWqjuctgigTuo98QzttLFx+OZ3TYDBWtJNZ1L
WGOw/jK/b+db2QIAJhceAPmry6ZjUQhTHfAiF5mgQ9eBfioWC6K4ifQrjYptWpXX
vEox8BmbR8q3VpXZ36NBuOoLr4Ok0ia4YhgpkKIWO3qalKNnFKED0u4M6Oj0lNss
n5DgmPF1Mqlo70/+f3MHNu6Be8VatHFwuC0TsobMbQ3U2vWjQXgvAZ0Fa9nnI7sV
pgSckqAjLrvFFz3n/pOV/svi3fmo58cGGRmZgGl7KxD1mUPvWgncF3u5Brtliu38
M/9DY3wf1wP4vDlXW1SToHU1R8TRceSoJwYAh/vSSwI64f2GPwm9zy1cu3+G7imj
Qt8/V+6ypK+x99a7+fRpkPoem9jMDVlp8q+H+y6jCsFMVPy04Kt/c05DTcXDilRs
Hkr3VKmkP6b+w+5FReN83PJC4/csRirhRsDuJj8Szg4+iwYNBJkJaRQRRiGToe5j
1c6LNFOMj1/cWTQuS1ayd5le2zVXPZ1SVDOY/IkG0pzckkm9yhQ=
=VqeX
-----END PGP SIGNATURE-----

--nextPart8326540.T7Z3S40VBb--



