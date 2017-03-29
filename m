Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D79420958
	for <e@80x24.org>; Wed, 29 Mar 2017 22:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbdC2W25 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 18:28:57 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58902 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752944AbdC2W25 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Mar 2017 18:28:57 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1E0BA280AD;
        Wed, 29 Mar 2017 22:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490826535;
        bh=b/cexqxo6NSf015NwGM0uvQqMz5ywR4edOPmLXfs8zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+LPBK63XGctPoWkknL08KoMZkwohRCEnK6ssNB6a1Lgvthmg3fNhpeEIgWFYez8g
         LY2SCKG1jQPKv5waCTx7qYBIyoVNnVj797ktz3bR0qTpd1OH+drSdckk4cf4uBQQPr
         C+j7/ONSocYi1RWm+NOdjT1HLndgUObvGbNQDMhE+U8rzdbGV6HuxhOL0kArxxOzoi
         ALdAFP4PWZEUIsElAK0zpazXqzQN413VKL8pIlj9s0XkFZcuzZk5AIVgJ01yuqkDze
         lSkgpI4hIMjnw/MMXTYzGjuejBsWtqttEGpcVLX+ymFelLR9Fvwfaw559ZJpjbkgJR
         iEOqqamf0nwzY7hqoLUd57vuiDwIISI+6IqOMbxXMPjGu6/VCYYLyuw/YxVxRctDSC
         8SirIUwzzuEEluv5mPxWV4qXbc6vgoKgyTT6KdYx4A5JuDKHdKiLMzHubWkB3DPe40
         0geq0AgTRxipIKOjwGQARL6CXjur+jO/Xl1XsGIknyap9qSRfoy
Date:   Wed, 29 Mar 2017 22:28:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 16/21] Make sha1_array_append take a struct object_id *
Message-ID: <20170329222851.zjdr5hoxjr5wjs7k@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
 <20170326160143.769630-17-sandals@crustytoothpaste.net>
 <xmqq7f39e2gi.fsf@gitster.mtv.corp.google.com>
 <20170329000648.vb2hdqfizjqjyryr@genre.crustytoothpaste.net>
 <xmqqvaqsazec.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rl4rjao7u7fth7jp"
Content-Disposition: inline
In-Reply-To: <xmqqvaqsazec.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rl4rjao7u7fth7jp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 08:14:19AM -0700, Junio C Hamano wrote:
> This change is about dropping the need for ".hash", and I think a
> faithful, boring and mechanical conversion that tries to preserve
> the intent of the original author would be more appropriate.  It is
> entirely possible that some places where the original said E2[E3]
> were easier to understand if it were *(E2 + E3), thus we may want to
> further rewrite such a place to (E2 + E3) instead of &E2[E3] after
> the mechanical conversion.

You've convinced me that &E2[E3] is a better choice in this situation,
so I'll reroll and fix the other issues mentioned.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--rl4rjao7u7fth7jp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljcNSMACgkQv1NdgR9S
9ov0bxAAnnZpBQ9C+xW4ZueqTBEGK5IvdHLdzfpuOHLXBoklb3cf72x0b7OeJGhF
UQXEAQ+3ooc8g3EJ/t5NPPV7rx2nHv/67BNVDhl/0BIKHzvaz1Y6UTuk9ze5yTbE
gOSuvqD01Q25KBIhpwsTGo69zjkolDBF6hwsb38oYHKXOnOhQgj0VpG9z7gfo8t7
uKc14up1sdhKyN1fFlE2XG2Ga+GAltwgtNA+D3PHvGXAbOPiFra5K6Cx9oc62KqH
lL34M3dm66yTerWMVErUHksPyCMGV5xFVvwZadO4QMk+5+d2sSmjnTkaHKUcBKYb
EKLXtkYEyzDA31jttko0dobHey5/+UvDlGVXFQUtt0dMStHBe+jdGbMzNHQM4rDe
eiJoB/J3IsQOFEB8nfRFaXoYHZR0NXNXEncI+Bv+t49jqmkPIKYLUKxX9lriGZiV
Sjq/auH6zqjlnjjVAbzCg5YSHTjj3OkUzHVM586KUuQdPWOKa6Px978/YVVtJzjg
G4xw4Ri/lJnlq5++fbjO7lRrPi1XVvLq+oQ2IEzuG/Frm0dQluLoXHXd7ohk71wm
CdvsRgjWKlshk6tq8f5bXv4lWYgvRQzK2lWXiegTNcdIVbDDapiovm5C5nsW7OA9
NKlInFgc4mdKmGqAwsgh12iRG2PGuPaGv0oUrOBwWZ04dXopcQg=
=ZFA4
-----END PGP SIGNATURE-----

--rl4rjao7u7fth7jp--
