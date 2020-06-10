Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57527C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222162070B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rams-colostate-edu.20150623.gappssmtp.com header.i=@rams-colostate-edu.20150623.gappssmtp.com header.b="odHzM44J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgFJSBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgFJSBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 14:01:39 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F77FC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 11:01:39 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id 9so2808758ilg.12
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rams-colostate-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=1jwRNlYFSUXLlFNCRORJW3WUN2miNEckjigNReitixk=;
        b=odHzM44JtXPvX9CM8Qis8vSWCxdueyAG91NPOSz+/gYZWgZIh9s1pgFWlVZ4dY45Pq
         pTv0OWu64pJh+Ym7uqCOhc+K7qv1MOOw6gaj1MGEjGNN8sJSnyFj9Tr/66quR+jaKb+Y
         tcxgTsA0DulCBvLKXJOt9hjv1VNrlpymdGRME+4FRo03LO64Am/N919F7rpxuz5qtCxn
         9eTmVt5yh9cB6uSHthvXQH71lscxdDFgk1FhFJz5lCYhikWs5TY79KLoLVP6/w2JILQY
         BCRVS0xmuy+yKklL6dgM8XUZcTTVVaLf15MtrYq4wRdpRmmEoSSKETlS4/4e2pqVbLWB
         y6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=1jwRNlYFSUXLlFNCRORJW3WUN2miNEckjigNReitixk=;
        b=b9sPyvH90+4ZXvPM3WCZsh+/P+yvWyinsH3iH0/7ZmEgLxPpJuDkxVYt+XzL4h52GD
         fnSbHdOhnkPLfIHGF17a3qk54SeY5rsP2xSty+QbJpc+ME98kICHkVyq0NVHQ/PirnKA
         ha4gWeNku3MAYnXpRU1PfPhmfJaNd+BUgCWnpzaLpVb/WwEDr32nrrsEXXAeeQhd8WYb
         TaVs5hO7rSpO7MDYt11kB3Z1eHC6YIkWkhuZU8UL+av3ezROb5QvEqAcZ/Nyhnp1hDoO
         JQUIznJy+goWj8u2knZOum9kRzVknQ2YY5j0hXCE1p2vezO4/jKLkmLHP4zfkIHQ7LYK
         g1MA==
X-Gm-Message-State: AOAM530KJstri9gmn3m2NaB/LaDfLAVL6OUTafZWXWZ1c1WCJ5PzYjUC
        oEHVmeykaqzAIPs55jFN1ek6DPyL2hw=
X-Google-Smtp-Source: ABdhPJylTGlfD/nQna7B0X9QNHTPipEwpyl1a0j0JKZqE9sJ7swpYUzM79DwXKuIb+RQDsH/gpA54w==
X-Received: by 2002:a92:c0c8:: with SMTP id t8mr4393987ilf.176.1591812097650;
        Wed, 10 Jun 2020 11:01:37 -0700 (PDT)
Received: from [10.180.91.128] (host-110-24.cofcdis.ftcollins.co.us.clients.pavlovmedia.net. [68.180.110.24])
        by smtp.gmail.com with ESMTPSA id t26sm287161ild.86.2020.06.10.11.01.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 11:01:37 -0700 (PDT)
From:   Jimit Bhalavat <jimit@rams.colostate.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: GPG Commit Signing Project
Message-Id: <5C35F542-3410-462B-848D-7F3C8A9FC9AD@rams.colostate.edu>
Date:   Wed, 10 Jun 2020 11:57:56 -0600
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=20

Hope you are doing good. Which branches are for refactoring/new features =
in the GPG Commit Signing Project?

Thank you so much.=20

Best,
Jimit Bhalavat.=
