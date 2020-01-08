Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05D9C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C68720705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL45vnA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgAHKbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:31:41 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:45221 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgAHKbl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 05:31:41 -0500
Received: by mail-wr1-f45.google.com with SMTP id j42so2719057wrj.12
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 02:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wPs+aadeH8WRX9xuM2w4tno2PVl7doYuiyctPnXelY=;
        b=PL45vnA2ZTqHe7njc0DyEI1Xw1HUGHK7smlXjMVtOzj94WYk65zw9RKqntmjqCeCCa
         qvjD99Jr1no5oc4QdpqkUEB3blQiWf2NZQXKJtNVtzQmOEGTSC4vYiDqFRZehR7aEpBc
         iPjjwN+K+JahyhjIM8SYzo/tuM1O4iHLLTWQbUAb6b4SI/eSV1kT09oWJT/StwioTZm0
         gl+pav+o47AkcClpc7H58frctJ+o4SmdoquV4xzFWHf/DOsCVrb3MTY67LFew+HGIDZd
         xfOwcVwU03W47kuUBVDLavyYXoIIDmlrK75rQggTsNyRh+9JMV8TgSK7kzVBIntam4bG
         +MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9wPs+aadeH8WRX9xuM2w4tno2PVl7doYuiyctPnXelY=;
        b=Pd5kFTqdZIh5hIh7J0B6P8eyJHwEK6Hm2gxBby+dBB7+2D5AqINUpLQdnsESVh55db
         bux+eLqRm5UNRdg8clLgAEU527C9Cj0ehIt3p7OVvCdjK3X+x26I8iBa666JmQu6svek
         4miP/a4Uyz0Ii/anT7Y0lbP0wbNw8oj7KI8OBiwrqm4dbGOflB+nXW+jHo7Ly+s5CN3V
         OurPQgAHLW+4nemKvabXaGAlyZd4j2+TXI5Y2B88Jn+BtiWULE2D0DBbnk3aMckIwXNw
         x/HbPPhHt7pSZuNFIRyFXydj5fBHHkPC1awksmhE0tUPmecox0Dze6V41cM9/T0AB8gp
         Z5mw==
X-Gm-Message-State: APjAAAUvyONUv/r4PcajZWfx3VDd+HzU/BfMx0+ftXGT5JVEMK+WEEtN
        O9B9JM78EI4i+4lB/5L7omUwNKoNXBo=
X-Google-Smtp-Source: APXvYqz/K1e6O5k2k4WZbokxOKlU5LjDREQjRmI1Li/cUbHmvBnGZ3DhzpnzWyhpns0hwImynACNbQ==
X-Received: by 2002:a5d:6089:: with SMTP id w9mr3694525wrt.228.1578479498971;
        Wed, 08 Jan 2020 02:31:38 -0800 (PST)
Received: from torstenknbl.mgm-edv.de ([185.40.248.10])
        by smtp.googlemail.com with ESMTPSA id y20sm3150674wmi.25.2020.01.08.02.31.37
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 02:31:38 -0800 (PST)
Message-ID: <63f412b2b88c5b26fe6c7e515c18f9de802603bf.camel@gmail.com>
Subject: Re: Broken branch after git commit - tracked files in staging area
 can't be removed with restore --staged, or commit or stash
From:   Torsten Krah <krah.tm@gmail.com>
Reply-To: krah.tm@gmail.com
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Wed, 08 Jan 2020 11:31:37 +0100
In-Reply-To: <2423f8c0b91578c0faf7527b7d97b0e1e9666261.camel@gmail.com>
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
         <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
         <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
         <20200108091119.GB87523@coredump.intra.peff.net>
         <2423f8c0b91578c0faf7527b7d97b0e1e9666261.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Mittwoch, den 08.01.2020, 11:02 +0100 schrieb Torsten Krah:
> cd testrepo

git init

of cause after this one ;)



