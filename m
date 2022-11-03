Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7860BC43217
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 00:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKCAjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 20:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKCAjb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 20:39:31 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32414120AA
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 17:39:30 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-37063f855e5so2129257b3.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 17:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/zW54+Y5QPgc2H2cvvdD33FNpfJH5OD2BjRP/I5LBII=;
        b=IbpcP+nQMVF6geQz7T4dslsD78NzJxQYCndji8GGxQENVY5jFV7pzMZtX1w4leukp6
         KAkaJ2+sjNbZPR9+TkPT+wFtGhy372k/L0+HtbvBDDEYUZyNooreBh7s3xKbCfhJi6Av
         kfYV/FeIKmVi/C3zl1S+XS4//LG2yyaKbW6q2wRRsNktxfcLHfse6K0Iq5Gj6NqFm3bJ
         VCKgM6orTlcxLb4LOXshdyaHO/6uvTR4e6sSFc0BtiSLvaMPx4or3WfViVQGUpvgE+j1
         HR2QeOlBukizS+hc4xGt+mAVQEAeRqp+L9XQNKHW8NOLRT5k7TBvKHphR4oX1eKstqsk
         Pahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zW54+Y5QPgc2H2cvvdD33FNpfJH5OD2BjRP/I5LBII=;
        b=bFbfs3LQ0SHtrFJL55DTbaVqPJ2kHBLvWJnjSMGep+myMrfkb15vGjgmVU1SdWcB77
         r+NFXql2ndB4tzhnvSfyIEDk2zPc1M95j28EShIG92kUMP35voHJUZfS2AsB8ODIGz2D
         35evCWsoU0j5h2aIXQPRaJ898t9KU56WCzw7XqGO8ZTdIsN6mm1C+FKPUrR1iR3WpZYD
         0zpQZHbrgZO2o95ATxSVqnNw2PZ3Oh9gFwHDHDTV5Fii8nbAWBhGS3iFRPM4tyrYkWA0
         QgLQPgfeqIKchouvXUYfHSbSdl9fpAYafHx2Uw+AnospKuIr4Tx8I5OjaZ76t5DQt+7O
         g+tQ==
X-Gm-Message-State: ACrzQf1EF9xglVcmWOH9JEBpk5uqWpkmdxRCqJCib32vGV4WtK9SSQt1
        QP0gJXgPbVhQay3H0nHb6YKelW3uwE1tZJuVK8A09ekShdHbAg==
X-Google-Smtp-Source: AMsMyM7P+wGwzMP4dUOsyye1NQl5X77ou3uqtM0Rd6z36e1VB+rvq5/dHKoaBcKIzqAN6BpV3EmD+GjzjhqWXU/8xh8=
X-Received: by 2002:a81:704a:0:b0:370:3daf:4e89 with SMTP id
 l71-20020a81704a000000b003703daf4e89mr23739641ywc.268.1667435969393; Wed, 02
 Nov 2022 17:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJyRyRo7oVAfLx8MONO=Y8KhLvL+tJgDTbCUezR1AFa73R5pbw@mail.gmail.com>
 <Y2LgzmTvElmRTsoe@tapette.crustytoothpaste.net> <CAJyRyRqMPX93-Oa5XMvZtDTRxh0SisUhOFAWhv-6hXR5sEkQpA@mail.gmail.com>
 <Y2MHNeSrhxfH1Ayf@nand.local>
In-Reply-To: <Y2MHNeSrhxfH1Ayf@nand.local>
From:   John Soo <johh.soo@arista.com>
Date:   Wed, 2 Nov 2022 17:39:18 -0700
Message-ID: <CAJyRyRphLTHZ6pUqsq0F+X_9=ejcTByr5KvRSuMBn2DA5d2EMw@mail.gmail.com>
Subject: Re: safe.directory and ACLs
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <dscho@github.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you!

Got it!

Kindly,

John
