Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34665C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 19:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF152074D
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 19:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiEHPHf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgCXTUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:20:43 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36644 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCXTUm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 15:20:42 -0400
Received: by mail-wr1-f45.google.com with SMTP id 31so16981726wrs.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=ruMvJUIPS25OK+KiAhcBnElqsLIHqHNE3tuJWhsuVDA=;
        b=uiEHPHf+1Bk3+KbWapunY8sv5y3XduH0IhMpJjPVi6Udm/tEsQF3UFVn2W+7zeZsO2
         lkw7JVSDF50gCEhN92CsgPu4UNBB3LntAeMp1fT5mQVS6VO79QhaO1VnmsYXwrTarNeQ
         BP9LJj3AtAxUg7t46pRbThVMXjoNmh2ykkjaDd4vdUMHNITzRSLbZyKz072y4BlbeS0i
         1L1akTDVWZfiIaeWiFjuWcwRFGaRzDoIIb8Rr9ZHTtlcs4VYs32KBIVLOaugCTo5oIR6
         RztR5rX6M6Akx+6B9NcwmLIXToUY84gz+rY+NwCJbzG8ZULBI+/53G8woGUnLB2S+EiS
         WH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=ruMvJUIPS25OK+KiAhcBnElqsLIHqHNE3tuJWhsuVDA=;
        b=N3I88nCSz5jHrzYYBEAsGHAxW8mgYCtxFCm6onrD/q88pWlZELkZZKZ6t+ibBsBUMB
         5ybqAdwvEzHuvRZVJnIFIvshNgHn59tdWcyNyppxIxg0FQU6B5Cv5MuA5Zy1HNvTTHYS
         fkDthaGiaGQwZeq8Ofo84T0OD7/595tsEn4gD3uCkYBwEsBuSCGQpuAsijttG0YRpXTw
         d0Dv8mcTRlptAkpOFCm8QPa2ljPD/g8CURgU30rhfZOPRzFrvRRzm/f/z5FlmHCDfNA3
         ImtjCzMRTp6caUnkyFNmgFuymu1pKQY7tJ2DpFw0Ou5S/mtwC7AhRx39e3tbF/vSOQQy
         DB4Q==
X-Gm-Message-State: ANhLgQ3jrd8zlzpSrZY/Jj3nd3H4jwROMlE8PdMMC35VPVZeasqNjrTO
        ojYrwzdSHWesARpwVrY8O4gwZ/xOYlc=
X-Google-Smtp-Source: ADFU+vt0UI4ZiDpQPZFx4d3rMUHXSsOPx8bP5tRqbbBWWHrn5RXnTC0snNGO5eBZ0p7bUE8a9zWKDw==
X-Received: by 2002:a05:6000:1109:: with SMTP id z9mr9876745wrw.237.1585077640789;
        Tue, 24 Mar 2020 12:20:40 -0700 (PDT)
Received: from ?IPv6:2a02:a451:bb78:1:1507:b7b7:10cb:873f? ([2a02:a451:bb78:1:1507:b7b7:10cb:873f])
        by smtp.gmail.com with ESMTPSA id z12sm31421762wrt.27.2020.03.24.12.20.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 12:20:39 -0700 (PDT)
From:   Anton Mladenov <anton.g.mladenov@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Wrong Version On The Website ?
Message-Id: <D6C222C5-3949-43F3-A63C-24D58EAB6675@gmail.com>
Date:   Tue, 24 Mar 2020 20:20:38 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git team,

First of all, much respect for everything you do.

Second, hope you are safe and healthy.

Third, I think the version on your website is wrong.=20
The version number atop the Release Notes link (where I found your =
email) is newer than the one on the desktop screen below.
I checked your Github and saw the latest is 2.26 but the link from the =
screen image points to some other version. At least for Mac.

Hope you can check that.

Kind Regards,
Anton=
