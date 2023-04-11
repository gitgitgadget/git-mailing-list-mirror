Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506EAC77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 16:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDKQri (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 12:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDKQrg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 12:47:36 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0482855B9
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 09:47:21 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 5A7CB40004;
        Tue, 11 Apr 2023 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1681231640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dz0dek0JkaE1DHjaaHF79fTEfnCE0HBh1Kur22HmWds=;
        b=UNf1qhN1jyslFpL9VH5m4tW9gLsDr2QTVnkn8MTEKJw5cvqhyTjw0RPfgxs2cMTQ0QPIG4
        edKwk0mVm32o5bLLmptm34MuwPYH8uVXD8Rtx/hs0eE4bzDnfuJ+epzv9qDF/U0myj+Ego
        vvIANriBmwNzguLcP/y8dINe0Nd8I2pWbmkVMT1EqEzU8epmyd054pv/OnwR0qcfxzQMK+
        T7blblCAxdCnXqhELWHHRnhtaU4TZ/a6xFATRTI7NTzmD6RwIqucSYym6U1Ojf+QITH6Ci
        +pETEXoNeKorbFzOSjQV9ozrkOcw4K+57N0+oHxQc9zkgq589U9Iu4LaRd1xsg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 11 Apr 2023 18:47:18 +0200
Message-Id: <CRU2VKKMECFZ.2GSICU4EKKBDR@ringo>
Cc:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Michael Strawbridge" <michael.strawbridge@amd.com>
Subject: Re: [PATCH] send-email: export patch counters in validate
 environment
From:   "Robin Jarry" <robin@jarry.cc>
To:     <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
X-Mailer: aerc/0.14.0-154-g68bc51d7fe3d
References: <20230411114723.89029-1-robin@jarry.cc>
 <79a7c59f-6644-1dad-3b85-fe0ca8beb968@gmail.com>
In-Reply-To: <79a7c59f-6644-1dad-3b85-fe0ca8beb968@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood, Apr 11, 2023 at 15:23:
> This is certainly less intrusive, if it does what you need and is=20
> efficient enough for your needs then I'd be inclined to go with this=20
> approach.

Yes, that is perfectly suitable to validate series. The missing pieces
of information (e.g. the place where all patches are spooled) can be
either hard coded or stored in git config entries.

> >   	foreach my $f (@files) {
> >   		unless (-p $f) {
> > +			$ENV{GIT_SENDEMAIL_PATCH_COUNTER} =3D "$num";
> > +			$ENV{GIT_SENDEMAIL_PATCH_TOTAL} =3D "$num_patches";
>
> We only need to set this once outside the loop
>
> >   			validate_patch($f, $target_xfer_encoding);
> > +			delete $ENV{GIT_SENDEMAIL_PATCH_COUNTER};
> > +			delete $ENV{GIT_SENDEMAIL_PATCH_TOTAL};
>
> Do we really need to clear these? Certainly not in each iteration of the=
=20
> loop I would think.

I wanted to keep everything collocated. The time spent setting/unsetting
these variables is completely negligible. I don't mind making this more
streamlined in a v2.

Thanks for the review :)
