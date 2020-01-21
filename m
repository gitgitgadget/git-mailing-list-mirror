Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282DDC33CAA
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A5C24125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mail-harpercollege-edu.20150623.gappssmtp.com header.i=@mail-harpercollege-edu.20150623.gappssmtp.com header.b="OFsCmiV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgAUSCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:02:51 -0500
Received: from mail-yw1-f48.google.com ([209.85.161.48]:34707 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgAUSCu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 13:02:50 -0500
Received: by mail-yw1-f48.google.com with SMTP id b186so1879912ywc.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 10:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail-harpercollege-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=/GbFFE6t05Y/fa542NWrptLC4HYpFwc/G+S58+d5Vkk=;
        b=OFsCmiV/TJVfveoloN0NDYnbJ56Ip4ZF5AfJuSRAW3vBZrJSVrJfMfqcVBtJ3ikWmw
         KJQFGlJGkNVX4/14jMqwPJHQRrv7km153RXAJlIN7b6OiedV6QJNl33BGIpsVTA3BjPD
         M9UEk3bUbckSKaAbbVmCEOx/PntiKg1Rko2jTr9+4k2pbdBJctUflyrQHpk+CKRH4Zbz
         YrMSLbGGZN94wt48ekCj7HFz3iDVQo5/hTdRsEFc/pHTuAc3vaPCZKlHvBiAOgztB7IQ
         3nN9/JTob1DLrj5aO+jnFz0tj0AQVnKNGe3IEnP3LDgg+JemSV0H2+FExaXisVNkqJXL
         oivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=/GbFFE6t05Y/fa542NWrptLC4HYpFwc/G+S58+d5Vkk=;
        b=PbkZAPVTz2PBl6bGf8AES286F5wJ2LUdLssN1AvQ2/o701J6u/vTRWBwbNux15RziG
         wfHMd3FB5VShcg5PMAP8umnmg0yiM+GaNmZ5eVIw/zic/9N9H1pLfXAVQ2NSJTD4s1OV
         f+JBZhJ8TKfETBCH8/okzv4LWK7zmke1X2Y8sTfRj2BELe5wkb47sBP8A5x4fR21jfQ/
         Hx/VakzGetJIvEJL07eP+IKEz+zjPvcCtYx9nELuwcCmIUzh3jrt+ZQjcNZItiH7VqQN
         IFKFLzYFjG+yDREY1iHC5Fo0rqwxscqyW0xlWMqASLrhmzowKOKufr4EraT6zHIWP55k
         m6IQ==
X-Gm-Message-State: APjAAAXI6GOU0+iEDVdimpDAvp5orAXg14VzrTaKsOspBcygB0fz8NWA
        r3HqI6+MYV5P2FxsGpzXYbCoruCmyV0=
X-Google-Smtp-Source: APXvYqzShvmmXDUSYLwFOpW5F6tHTcoIA9ZQV4R4rXwkySBqSgksI5+2/jmrXPggchYh0wghtd9Hwg==
X-Received: by 2002:a81:415:: with SMTP id 21mr4309766ywe.432.1579629769375;
        Tue, 21 Jan 2020 10:02:49 -0800 (PST)
Received: from ?IPv6:2601:248:101:3490:72:8211:1b73:4c33? ([2601:248:101:3490:72:8211:1b73:4c33])
        by smtp.gmail.com with ESMTPSA id e187sm16973906ywd.7.2020.01.21.10.02.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 10:02:48 -0800 (PST)
From:   Ravi Patel <r_patel445@mail.harpercollege.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Issue with installed Git OSX 
Message-Id: <2F620D91-F038-4512-A4CD-E706E6163A19@mail.harpercollege.edu>
Date:   Tue, 21 Jan 2020 12:02:29 -0600
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3594.4.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,=20
 I recently downloaded and installed Git on my Mac. I do not know but =
after installing I am not able to get Git Bash. I can see in terminal =
command line the version is downloaded as 2.23.0. But I am not able to =
connected it with any new projects or the existing projects. =20
So can someone please direct me as to how to get this working properly.

Thank You,=20
Ravi Patel=
