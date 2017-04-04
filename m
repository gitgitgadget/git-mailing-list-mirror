Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A109020966
	for <e@80x24.org>; Tue,  4 Apr 2017 09:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbdDDJRF (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 05:17:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35485 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752765AbdDDJRE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Apr 2017 05:17:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5232420789;
        Tue,  4 Apr 2017 05:17:03 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 04 Apr 2017 05:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=V+4LUiAX2Ex/ZbVSFA
        IC4FHz5H0eTrf2lT3z2xPfuCc=; b=l3JcpaG6DWhs1TNJxE5C9mcklRrrZ8PZwl
        I1MPiMGtfBgo0TNEc8w4b5dJ+INKmRTs5PezH52kII1S4E9tJuuxo2yzTCF80yDA
        f4kuXLkTsD05dWz0/OsYxPe6nXvkB7WJFdQYJKuoASWjUAjWSv+21YNVhs2sRQv1
        FzBm1xAH2PPqJY0+ahk3GtVTWDEg4KICAbk1YqBnAvGTIO5WCGpBz9ILpzPCbyc/
        fkQCSlEyaQ/B7L1W3qQ7F5aE/EZdMMUbI59XqsYAjXoez9j/VKwzvj6p25Qw+dkA
        /yLEKEQEsxpTcZB6PTRS+2XhLn5Og5yjzlwCsm0+WrZ5FpbF2oAg==
X-ME-Sender: <xms:j2TjWEMvcxdyBXDFxO2_-nMN9QLNfc8s1zsNoczeecqyQ9CLCJ31_w>
X-Sasl-enc: eLcaOotcRuVVYVcC9xn6w5brCCBOlbsmUhmC9CiT6cTt 1491297422
Received: from localhost (unknown [46.189.27.162])
        by mail.messagingengine.com (Postfix) with ESMTPA id E28C67E712;
        Tue,  4 Apr 2017 05:17:02 -0400 (EDT)
Date:   Tue, 4 Apr 2017 11:17:57 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pathspec: always honor `PATHSPEC_PREFIX_ORIGIN` flag
Message-ID: <20170404091757.GA4584@pks-xps>
References: <1556910880cfce391bdca2d8f0cbcb8c71371691.1491206540.git.ps@pks.im>
 <20170403162648.GA166794@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20170403162648.GA166794@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 09:26:48AM -0700, Brandon Williams wrote:
> On 04/03, Patrick Steinhardt wrote:
> > Previous to commit 5d8f084a5 (pathspec: simpler logic to prefix original
> > pathspec elements, 2017-01-04), we were always using the computed
> > `match` variable to perform pathspec matching whenever
> > `PATHSPEC_PREFIX_ORIGIN` is set. This is for example useful when passing
> > the parsed pathspecs to other commands, as the computed `match` may
> > contain a pathspec relative to the repository root. The commit changed
> > this logic to only do so when we do have an actual prefix and when
> > literal pathspecs are deactivated.
> >=20
> > But this change may actually break some commands which expect passed
> > pathspecs to be relative to the repository root. One such case is `git
> > add --patch`, which now fails when using relative paths from a
> > subdirectory. For example if executing "git add -p ../foo.c" in a
> > subdirectory, the `git-add--interactive` command will directly pass
> > "../foo.c" to `git-ls-files`. As ls-files is executed at the
> > repository's root, the command will notice that "../foo.c" is outside
> > the repository and fail.
> >=20
> > Fix the issue by again using the computed `match` variable whenever
> > `PATHSPEC_PREFIX_ORIGIN` is set. This restores behavior previous to
> > 5d8f084a5 and fixes interactive add.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  pathspec.c                 |  6 +++---
> >  t/t3701-add-interactive.sh | 20 ++++++++++++++++++++
> >  2 files changed, 23 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/pathspec.c b/pathspec.c
> > index 303efda83..3193e45a6 100644
> > --- a/pathspec.c
> > +++ b/pathspec.c
> > @@ -504,12 +504,12 @@ static void init_pathspec_item(struct pathspec_it=
em *item, unsigned flags,
> >  	 * Prefix the pathspec (keep all magic) and assign to
> >  	 * original. Useful for passing to another command.
> >  	 */
> > -	if ((flags & PATHSPEC_PREFIX_ORIGIN) &&
> > -	    prefixlen && !get_literal_global()) {
> > +	if (flags & PATHSPEC_PREFIX_ORIGIN) {
> >  		struct strbuf sb =3D STRBUF_INIT;
> > =20
> >  		/* Preserve the actual prefix length of each pattern */
> > -		prefix_magic(&sb, prefixlen, element_magic);
> > +		if (prefixlen && !get_literal_global())
> > +			prefix_magic(&sb, prefixlen, element_magic);
> > =20
> >  		strbuf_addstr(&sb, match);
> >  		item->original =3D strbuf_detach(&sb, NULL);
>=20
> Would it just make sense to drop the requirement that prefixlen be
> non-zero?  My problem with this change currently is the ability to get
> an original string with is empty (ie "\0") which would cause git to
> throw some warnings about not allowing empty strings as pathspecs if
> they were then passed on to other processes.

You're right. My patch results in:

$ git init repo
$ cd repo
$ touch file
$ git add file
$ git commit -mfile
$ echo foo>file
$ mkdir subdir
$ cd subdir
$ git add -p ..
warning: empty strings as pathspecs will be made invalid...
warning: empty strings as pathspecs will be made invalid...

Dropping only the `prefixlen` condition and then unconditionally
calling `prefix_magic` suffices to fix the actual bug. I've
improved the test to use a pathspec which resolves to "" and
check stderr.

Thanks for catching this!

Regards
Patrick

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAljjZMUACgkQEXxntp6r
8SzTWg//QZi8kVfOB13E7Mt2bFKOjv3ofo2vNTBqBfjDk1Gn1dS1fN5ZCNS8Q7Xz
1r/0gAnJSG2eONT7ppmf+vPL7fJPntXpgeYaarTI780Fn/28XUkkYvUxj4zVgCC6
kI2P51u0QsuvXoRwlgyY0FuGpvNIOzpf2wX2FVrdN5CXKx4jxxBP/vgwdxYF7AzV
CCU4OMANylnoobn0WAttEKrSesno/tEOW3b/5i0kb+QPdnhrOU4Cz4KTobTa7qRP
Px0xgRmx6C2Is3AnyySmr6z1lZnM6Ln6Sg/UkB6c8cMO2TDG+Rg3nzIUsc2162NT
/4xoXuuJPvZfoUQyY7aC/RTOeMrrqnLfc3bZFx84YnWlbbrPq0nMoqQjNQIWMzTO
N1WnGXX5Akie+p6R/DE/arzzRjJ3tYoA876sCR+VmBbZj70EG1URMV3sw8kZkTeD
yDLfciEA6+Gk4+36EKv/ygfMXzfDx7YZQzeye43ECqoPcX8XNKptbpF2rF9OZUM3
6eLsnEwy8rAKEEM0mcOfm2ZyoiAaVW2oeDSFNUAssDxAjiB5Q7GjNdItqDXl8TKs
vKEgDsOMp3I8eJgy333WafDD3JTOWi7uk1Y6uXJKjv6kH/0zHzZ+EjvPXyIWs7lu
xDS9F0EwQsDFrKRiCNHDGVoKCErc5P5g/bBLlCdHUrNcYhXOmKw=
=0eB0
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
