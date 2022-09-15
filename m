Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA10C6FA89
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 16:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIOQPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 12:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIOQPj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 12:15:39 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9873E96FDC
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 09:15:38 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (104-8-158-41.lightspeed.cicril.sbcglobal.net [104.8.158.41])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 68B7B5A26C;
        Thu, 15 Sep 2022 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663258537;
        bh=zH86iHlTK5T7qU66cezOYyqfYgor6bZrjkTmMtyS+Mw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=FgAiyIZWdkICZDYMdT+Xaf2qrqA9PGLXQ659eGBu31kgTvLrzZkywSA9+WOOEsfgv
         ILTzrNoPhR4s3k8b3QKfXyIHt9sQwAgq+WSHnNtneCWbsBLlHIuJIZomQyOmxxyLQZ
         2QY+HdCtO3G2EDgljnmNerEDiaHVM2SS8DkJfo9E3Vf2wXh/xnQR//88c2kzSzMmu/
         epGuNBLWX3nsPKnqU8pClzfy3iY12Idz/Y2eHwhl69LZFg8jv8AZLRXqQtU9ifMOYY
         NTUMATPpp9RDyPf/0q4/VESVLmlPHQ8ExGUzSFGcJ8uM731U8mSL6YHHODCWAMu3lF
         8vInLB3ZJBYskKYmveT3tGk2w4Dt984dI0toQOyLYfairYBQSor1UNZN+Al6erjksv
         mOQKorUe9+UIl2vLHfS01vJ1P98SuY+MwUAIsFJy0oC95qnPVK61Zj4lROEHYfZWbw
         tI8VWoYgdhUMS5Y8DoYvj2P+YAeerfaCbKH6vpJhYmKfFWcrjMi
Date:   Thu, 15 Sep 2022 16:15:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brijesh Patel <bridgepatel@gmail.com>, git@vger.kernel.org
Subject: Re: BUG: Value for GIT_SSL_NO_VERIFY has no effect
Message-ID: <YyNPp3UMCii67ugC@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Brijesh Patel <bridgepatel@gmail.com>, git@vger.kernel.org
References: <CACs=J2MLnawNF5mp19sCJAZADPenHjWVZvKW5rM1fwELHjqqyg@mail.gmail.com>
 <YyMi76Cy7KnfZFU4@tapette.crustytoothpaste.net>
 <xmqq8rmkpsit.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Q9AxdTJ/jBn6fF+"
Content-Disposition: inline
In-Reply-To: <xmqq8rmkpsit.fsf@gitster.g>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3Q9AxdTJ/jBn6fF+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-15 at 15:27:22, Junio C Hamano wrote:
> I did a quick audit of the environment variables documented in
> git(1) and it is a bit messy.  Many environment variables use
> git_env_bool() to make themselves a proper Boolean environment
> variable, but some others that are described to take "1" to "enable"
> do not honor the usual "yes/true/on" convention.

Yeah.  I think we could well adjust this to accept "0" or "false" to
turn it off if we liked, but it doesn't right now.  I think that could
well be valuable if we wanted to make a change in the future.

I could submit a patch to do this over the next couple of days for this
variable and GIT_CURL_VERBOSE as well if we decide we want to do so.

> SSL_NO_VERIFY is worse, as it is not even described.  So we should
> add it to "git help git".

It is documented in git-config(1), but of course we should also document
in git(1) as suggested.  Do you want to turn this into a nice patch or
would you prefer that I turned it into one with your sign-off?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--3Q9AxdTJ/jBn6fF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYyNPpwAKCRB8DEliiIei
gS9SAP40zcmKVQqVMr+Kse5AiRKFrI7XQ6+rvieQHL6KHpU02QD9FVG7207guzzP
sg+7aDzm8Q+opHXlGGn6nFWFWq0mEw4=
=XVps
-----END PGP SIGNATURE-----

--3Q9AxdTJ/jBn6fF+--
