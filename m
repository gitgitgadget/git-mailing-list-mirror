Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B577201A7
	for <e@80x24.org>; Tue, 16 May 2017 00:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbdEPAWV (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 20:22:21 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40370 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751577AbdEPAWU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 May 2017 20:22:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7FFAC280AD;
        Tue, 16 May 2017 00:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494894139;
        bh=35NV5uE4fLrzbDSof7pcATEqN6z4TNJvNnnmvmhdCMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pqjog3VaNFjFionFhv19rYVBSINWq1Ici+8WG///Xt/gJQkkB1JPbAGKnsc9yybYG
         J+55vBUzrn01YbIghk1HFVkr9so0+tmBb5HwhcOzvBWAzqKWmakZSi4yHTmp/Qc9Ut
         9VSJ6FR4nKLbVb731DHwTJ1ghXK5sBJWOGVDIGo9xfIhXKCzLVYWtVhEpN+bLGA8IZ
         uVQcKUtwEkgPYlz9txoptn74AnFJE/NNJA4ZzmEELmyZXvJlYplomF5uGE1o8kZKuN
         SdVtoy44Tpk40JQsFsmJK89mhQKg9Fne4z2VFUBRI7S4il22zbx0wmDXPExyHaqvMp
         aeIiTiAB1uar5vP7Gnwcdtp2A0LYzEDs3DY44DmGckNUnpdsGMe7lCp6YYDtBi/Wg6
         tLezVDHYKWfwFeGWAWWZh2Gdi+FLLUPl7+K1eWDCY/nVubusgAjVZvthWsYe2JeA1v
         oIJKJfXAep4kbCod8NL1b0BGdhMy6MlU7ciSuefMBCHsft7gOlj
Date:   Tue, 16 May 2017 00:22:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        pclouds@gmail.com, johannes.schindelin@gmx.de,
        David.Turner@twosigma.com, peff@peff.net
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
Message-ID: <20170516002214.tlqkk4zrwdzcdjha@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="srlhvjls6tgvdw3v"
Content-Disposition: inline
In-Reply-To: <20170515191347.1892-3-benpeart@microsoft.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--srlhvjls6tgvdw3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 03:13:44PM -0400, Ben Peart wrote:
> +	istate->last_update =3D (time_t)ntohll(*(uint64_t *)index);
> +	index +=3D sizeof(uint64_t);
> +
> +	ewah_size =3D ntohl(*(uint32_t *)index);
> +	index +=3D sizeof(uint32_t);

To answer the question you asked in your cover letter, you cannot write
this unless you can guarantee (((uintptr_t)index & 7) =3D=3D 0) is true.
Otherwise, this will produce a SIGBUS on SPARC, Alpha, MIPS, and some
ARM systems, and it will perform poorly on PowerPC and other ARM
systems[0].

If you got that pointer from malloc and have only indexed multiples of 8
on it, you're good.  But if you're not sure, you probably want to use
memcpy.  If the compiler can determine that it's not necessary, it will
omit the copy and perform a direct load.

[0] To be technically correct, all of those systems except SPARC can
have unaligned access fixed up automatically, depending on the kernel
settings.  But such a fixup involves taking a trap into the kernel,
performing two aligned loads and bit shifting, and returning to
userspace, which performs about as well as you'd expect.  For that
reason, Debian build machines have such fixups turned off and will just
SIGBUS.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--srlhvjls6tgvdw3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.20 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkaRjYACgkQv1NdgR9S
9otyrRAAnQ5wqx3L3lzJUIYOUYB5bA5QI9A3exPFuVvM4zh7ranvLLR5ix3sAKIb
8vFD020Sk5AFIB9IDgkABSNhiqmGSSVBMk3MkDLMu7Rro4W2x+bnZ6X1SgV/huKR
S9Dl3+GM79NSHVun5ySbUt/oAkbzTDPT/Yqb0M8qXjxWNBtHsbibgVf+4EkSIwmX
tCba+JGlQiFYFuAINIAOaqRlQmGfE2OiyQC8AUmnIzLOQhBoq0113IBQZJ4iwNms
HInvrZkZdeuhZFhqSbiMBORnIXooyaG/+bZi+PojT3R1S1GrosOqTvORT5HOO4Ef
52iFXv/+JhU/dkd6l3Vpj4dxcQli6yDtLQaeUGN9UwK1FBi45W2kOXCrMs2yB5Ic
EQXTokmrXnsj3trvpnQ2MWIFJCTwKP+8iNzLvl40bqSfuAnwus6gsjQVLCC14+/+
EsMZdVFGLLI7BW2asRzfUNVaYCaM8nfZDqofBLmr4LRLHYCl9/5y/BPLYHwoD6aO
OLI4UqTtVUzXdYGZ9zT+IxtZnaw7sW9mtMQb3ad2S3Q3ZOwkttgfR85NwObwnhAk
mA1a1kViobtrqMPHasmFyxaZoIe5JylFZ/jnAs8eVV/JvK9o0uq+Y8XsDO5YdLWi
J3XkTtvyurOGghv4/ta5I0/pd0AtEmtfDr+dTb62VPj+jrhgSmA=
=hWsf
-----END PGP SIGNATURE-----

--srlhvjls6tgvdw3v--
