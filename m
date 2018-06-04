Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F20A1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 22:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeFDWdn (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 18:33:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33136 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751209AbeFDWdm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 18:33:42 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AA78960732;
        Mon,  4 Jun 2018 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528151621;
        bh=yRND2uvwzbVBqZkVRbY/bYr/aqbPEVTPs3hyBsS0jE4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Jk1QKzvbbC+jvPpYMal45p+OQI4fM3gXl7LsDZdszPDu4Rc6tguh1+69/xX/eLEDw
         PysytC3TPbFRcRwpldxFSBgYdS1JsEXtouVmRqLSSUiJ7BpkH+0A+h9H8Rp+9Geq8C
         fFqL/ab6Fyfdbe0jDUT5pc6GurTq+a66Z87OEJdoNe/Mb0VtI4widfDYQ9tB32OSGW
         UfhmgzJjPTvGqH+laBUpMSA3yWfH0Dcn21Ph6kHvLq96eS70kk32GSR0PkAbkOsYmg
         OJ2IVQ0CR3ANb39jMw7+X1yl0+j1gqGjGWOJBDSzq3O2WZj+XaYZTmnWlkM4r0X/yf
         6n1K4fOOfLqi3T7ddFYmLarPjL4xyPyPb99pOnEyvZnLH+xa8cfP2opgufQNfF2IE0
         /OUnzAnElRUcQMCQOezhlnxUhQS9TdAa1nqCo0u5H3G9+62PpsCIOcWCOlDIk2SsgR
         Vz1A/FTuEeHVeyDXvjMZYM8QpJBPMrRYMh+4TKefv1cqgt09LFn
Date:   Mon, 4 Jun 2018 22:33:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] tests: make forging GPG signed commits and tags more
 robust
Message-ID: <20180604223335.GC288937@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180604133926.16558-1-szeder.dev@gmail.com>
 <20180604133926.16558-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <20180604133926.16558-2-szeder.dev@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 03:39:26PM +0200, SZEDER G=C3=A1bor wrote:
> On rare occasions the given pattern occurs not only in the commit
> message but in the GPG signature as well, and after it's replaced in
> the signature the resulting signature becomes invalid, GPG will report
> CRC error and that it couldn't find any signature, which will then
> ultimately cause the test failure.

Ooh, I hadn't seen these failures, but thanks for tracking this down.

> Since in all three cases the pattern to be replaced during the forgery
> is the first word of the commit message's subject line, and since the
> GPG signature in the commit object is indented by a space, let's just
> anchor those patterns to the beginning of the line to prevent this
> issue.
>=20
> The test script 't7030-verify-tag.sh' creates a forged signed tag
> object in a similar way by replacing the pattern "seventh", but the
> GPG signature in tag objects is not indented by a space, so the above
> solution is not applicable in this case.  However, in the tag object
> in question the pattern "seventh" occurs not only in the tag message
> but in the 'tag' header as well.  To create a forged tag object it's
> sufficient to replace only one of the two occurences, so modify the
> sed script to limit the pattern to the 'tag' header (i.e. a line
> beginning with "tag ", which, because of the space character, can
> never occur in the base64-encoded GPG signature).
>=20
> Note that the forgery in 't7004-tag.sh' is not affected by this issue:
> while 't7004' does create a forged signed tag kind of the same way,
> it replaces "signed-tag" in the tag object, which, because of the '-'
> character, can never occur in the base64-encoded GPG signarute.

This seems sane and obviously correct, and the other patch looked good,
too.  Thanks.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.7 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsVvj8ACgkQv1NdgR9S
9ovPVhAApk7YF8Ozqa6rqttbpe6yMd0je0hgjJzpr9ebCIRD+7BcpFuxM4NHit2V
U6WpCYAhgU4iH5gxDLdNVfOqY+DmKVY5KvqiKHJyLsUzfw6ZBdOwuhH8ktPBvSR+
l/j2iWjl1mgq9u7WLa1yJC4tZtLSH3ZZJdSWUiqosesTJ7lh0iJc+g7hFi/d6NTB
YxctGd6RzirSoq7vfNTNJ+JCXVwES1oYCtKAjzLrdctpzrRnwuM3BKad0oN05JSz
bKLhLCtgOTu8LvooWS5n80fzB7r8SovA/cfqIpVhYi4iqyM25RmJQ8+aa0QlPyo4
pbhCHfMeRiaW8f16BC7GEVXmv7m2M81s8e8BBXAM46LnGaZbi9fHx4JO7GPI2ykE
KbWHBaaxm2zmsjLhQ8/6RqlBnPsooVIRJvfrf/rAt/9At4r+MRdNGNIawRUwOOBt
FmomNsw1tcUag75Sx9N+owtiYd1xwHl/8rIXnsCe+3cMASDHgtg1/wUWO4QVU3ee
KcsZrlZQTMh77HgAsVqeIVQPMCpLtZHSY8YUYJSrXfuljHcOvg/Uv+NRALvLcdWn
3HhkYwcKSDjr5cUJCmtgBtFpR+w255FW8zn9DPfFdF16JgUiippIb1r/mA2n9VJM
/gqFPOqTxUl5fm6pQYYV4052gcjTz3LcugMXX7aU153wycoMQ9k=
=kccf
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
