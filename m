Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255092035F
	for <e@80x24.org>; Thu, 10 Nov 2016 11:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755437AbcKJLwl (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 06:52:41 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33077 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755424AbcKJLwk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 06:52:40 -0500
Received: by mail-wm0-f53.google.com with SMTP id c184so51938449wmd.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 03:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=qNZtPf8JudiTqqCuG/4ZrUbv4VuBKWU9Zbrt3d61KfY=;
        b=fsipzZCATbokvEJ/v2SkW/sdITgX1IP3Y4R1O+6jD/CcAhmwYWpJXoyOJq+PsCz4rv
         uDp+t8jeNx9yw/Y0XnKeIg1gvV+ab7FQkdWNjL00YJSMJ8D5dLEsSUvcsAkLQDrScIte
         kiG6ALwCFFOGnbdmY0Xnwh5MFCRHu8cyLb9rFtszLN8OKRJWfQ6H5Wo1pW0nKMVxpgT4
         /R+mNVY/1UXwjZXljcnCEar6QEl/WJlDdJr+MjW4HuCbgbdGjC8jX6CQAQ0UKqKN6uIV
         Acet4etuezQ59nXkyQbYHvSh2m0XTsyg0tXaFhrXrQHIhQImqdKOb0bUMY/L3jVsOh5O
         BmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=qNZtPf8JudiTqqCuG/4ZrUbv4VuBKWU9Zbrt3d61KfY=;
        b=WNM9oJIWWPc7PM8yNl3BIMDGzXmmdkZFQ3fiHQcoTEczdYTPIgAAuh7xAmJNmswbmB
         hkHxNQz0S16FDVpFHCENdQCVyBcTH4xFBJ4m43KXwXBzruBieXpF6xwyUTbg7h4Pvccp
         C/Ecpp+ROYCZruVJgF1MlImEEfp65JgQo6G0VSdz4pdBORQCmzrF7pn1RuqplGB2RXtf
         jKoOKO5noqpS5nYfInPAZ/MvmPFeqJGhYCA1DvBzEP6tUHEsvoXIVULShLBKyWJzurJl
         spQ3SV0E/y/ZkDBWcF2o7+Yq/pLL4OLtY/sK+wpczBYRMeYmSn9kgMn0f06b4Vh7HCZ6
         P0VQ==
X-Gm-Message-State: ABUngvdV2xU+yN5Y1ThXpORGF9gOn9ySxhd+5nhDLX65199VmZq+GZAD/P5H9UPeWKzCzw==
X-Received: by 10.28.66.26 with SMTP id p26mr24640026wma.120.1478778758563;
        Thu, 10 Nov 2016 03:52:38 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id n6sm5049965wjg.30.2016.11.10.03.52.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 03:52:37 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [RFC] Add way to make Git credentials accessible from clean/smudge filter
Date:   Thu, 10 Nov 2016 12:52:36 +0100
Message-Id: <4C8C5650-7221-4F62-A9CC-81AE01EF6DC7@gmail.com>
Cc:     Jeff King <peff@peff.net>, me@ttaylorr.com
To:     git <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

we just implemented the first "real-world" user of the new clean/smudge=20=

"filter protocol" interface (see "convert: add filter.<driver>.process =
option"
edcc858 for details) and the results are fantastic. Filtering 12,000 =
files in
my artificial test repo is more than 60x faster (depending on the =
platform).=20
On Windows that means the clean/smudge operations runs in 57 seconds =
instead=20
of 55 minutes [1]!

I have a number of ideas to improve the protocol even further and I am =
seeking
early feedback on the following - possibly most controversial - idea:

Some filters might want to perform additional network interactions and =
these
filters would like to use the Git credentials to perform these actions. =
If
such a filter is configured with "offerCredentials =3D true" then the =
filter=20
could request the current Git credentials via the "filter-protocol".

A configuration could look like this:
------------------------
[filter "myfilter"]
    process =3D my-filter-process
    required =3D true
    offerCredentials =3D true
------------------------

The default would, of course, be "offerCredentials =3D false".

I haven't looked at an implemenation approach at all. I wonder if this =
could
be OK from a conceptional point of view or if there are obvious security=20=

problems that I am missing.

Thanks,
Lars


[1] https://github.com/github/git-lfs/pull/1617#issuecomment-259411850=
