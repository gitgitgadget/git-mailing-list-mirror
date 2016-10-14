Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08ECF1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbcJNOoN (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:44:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752356AbcJNOoL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 10:44:11 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B3AF9E60A;
        Fri, 14 Oct 2016 14:44:06 +0000 (UTC)
Received: from [10.36.4.60] (vpn1-4-60.ams2.redhat.com [10.36.4.60])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u9EEi3nC002487
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 14 Oct 2016 10:44:05 -0400
Subject: Re: [PATCH 0/2] infinite loop in "git ls-tree" for broken symlink
To:     Jeff King <peff@peff.net>
References: <1476451012-9925-1-git-send-email-pstodulk@redhat.com>
 <20161014134214.z3jzlx36y57cdqhu@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Petr Stodulka <pstodulk@redhat.com>
Message-ID: <9b77d6b5-79cb-e4ab-9fb9-17b66801c999@redhat.com>
Date:   Fri, 14 Oct 2016 16:43:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161014134214.z3jzlx36y57cdqhu@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DiDkeAAHOKBljjJbbN79PAVCqJH4SvNip"
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 14 Oct 2016 14:44:06 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DiDkeAAHOKBljjJbbN79PAVCqJH4SvNip
Content-Type: multipart/mixed; boundary="RORa6mXahqBUoTDkFlGdWlHehsK2EuVRH";
 protected-headers="v1"
From: Petr Stodulka <pstodulk@redhat.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Message-ID: <9b77d6b5-79cb-e4ab-9fb9-17b66801c999@redhat.com>
Subject: Re: [PATCH 0/2] infinite loop in "git ls-tree" for broken symlink
References: <1476451012-9925-1-git-send-email-pstodulk@redhat.com>
 <20161014134214.z3jzlx36y57cdqhu@sigill.intra.peff.net>
In-Reply-To: <20161014134214.z3jzlx36y57cdqhu@sigill.intra.peff.net>

--RORa6mXahqBUoTDkFlGdWlHehsK2EuVRH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you for info, I totally missed that. Yes, this fixes the issue
perfectly.

Petr

On 14.10.2016 15:42, Jeff King wrote:
> On Fri, Oct 14, 2016 at 03:16:50PM +0200, Petr Stodulka wrote:
>=20
>> I have realized that this wasn't fixed after all when refs.c
>> was "rewritten". Issue is caused by broken symlink under refs/heads,
>> which causes infinite loop for "git ls-tree" command. It was replied
>> earlier [0] and Michael previously fixed that in better way probably,
>> then my proposed patch 2/2, but it contains more changes and I have no=
t
>> enough time to study changes in refs* code, so I propose now just my
>> little patch, which was previously modified by Michael.
>>
>> If you prefer different solution, I am ok with this. It is really
>> just quick proposal. Patch 1/2 contains test for this issue. If you
>> will prefer different solution with different exit code, test should
>> be corrected. Basic idea is, that timeout should'n expire with
>> exit code 124.
>>
>> [0] http://marc.info/?l=3Dgit&m=3D142712669103790&w=3D2
>> [1] https://github.com/mhagger/git, branch "ref-broken-symlinks"
>=20
> I think I fixed this semi-independently last week; see the thread at:
>=20
>   http://public-inbox.org/git/20161006164723.ocg2nbgtulpjcksp@sigill.in=
tra.peff.net/
>=20
> I say semi-independently because I didn't actually know about your
> previous report, but saw it in the wild myself. But I did talk with
> Michael off-list, and he suggested the belt-and-suspenders retry counte=
r
> in my second patch.
>=20
> The fix is at e8c42cb in Junio's tree, and it's currently merged to
> 'next'.
>=20
> -Peff
>=20


--RORa6mXahqBUoTDkFlGdWlHehsK2EuVRH--

--DiDkeAAHOKBljjJbbN79PAVCqJH4SvNip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYAO8uAAoJEPiGu5hNgNqPGAAP/jGbz62LDmDhZsKx+IcO1Evd
Rsc5kJrjG8p1vfVkhJn0jL3xIv94ZSg/FetkImWMo5SvEeZx8Z5WAQuL29EaWr/M
l8tDLCt3C36cgNhRXmN9BPAScs7HIx7rWdTZlWE6cwXlcQEW/5jiPNUuYiLVOF/c
/75JPlU5aBzniqAELEzAQBv5LBaBllR9rJrHA01Jcgs8QECQLAISeNjMUx766dzS
OenRDmlvPIOcIZUGYsWGdZL+KTUCXLPciZkF2YBwMmPz2nl0cKtALkERKko5UTcV
GU0WxP3zH8beR81sej0MK4S/qqsdht0RVDn0wbD4HEtm20VKkxbMkjvR/agd6prm
yvZExdPs6qUROV1R+4g0LO965z9uvhPZDkELMnL7NpcDZyRuakf0PaB8ZvVbzdxd
O9jMXhxYyBAHuPm5plKLPkkueXd8O62HqxN6cDcVTcXeJhdzaVTyk9KFfggJruK2
z1X1c6BCAj86kyPJiAZus94mJcpN2DEXkHpZacfCjbrnh08KfkQHy4yCMq5QcA66
GX4MYlyFGo0rMUuF4310zILqA2vLqYa1WqXtnOTN98RFOzIZCx3C5G3J3F9YWhrH
yipksxiEPzTrRJsrTRdttGy2eDMvzYypfqrTtwhhudIuI/z4ACmhf4ElPQ9Gk4cI
63E0OGw5LMjeXtw7QAwa
=djff
-----END PGP SIGNATURE-----

--DiDkeAAHOKBljjJbbN79PAVCqJH4SvNip--
