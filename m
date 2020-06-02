Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2546AC433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 00:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CC8207D5
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 00:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rams-colostate-edu.20150623.gappssmtp.com header.i=@rams-colostate-edu.20150623.gappssmtp.com header.b="YQmNbnoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgFBAqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 20:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFBAqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 20:46:03 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DA7C061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 17:46:01 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id c8so8996854iob.6
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 17:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rams-colostate-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=BxtBYcw7PMyM4OnZEsQWKCObY8j6Cr/n1eLoBgs7MnA=;
        b=YQmNbnoRVgHuR7MM2McK+heofpqc6vEC1d/g2soaK50392zJOiwoi2wvFueQLzBx7E
         wCf4TwOa6GW89V0rhsDHd0qCCwDIMnuPMchfbJOYmE23Q2O5ZoHq9o1in3tIbc9jNbYi
         GTIDKwAA0UvKwctfaEu2mXlm/B69uoJA1Ic37UXC2+ANMMYAiKgkE10cPCGohRBLo3bI
         493GSNDLMMETCrwAnARY9HPJ8hNTCI9iistqVm5xS8R3JPDOWocp98TJ0yI8muq9lkHK
         M+5JZkA7Igy/wn3LJ/Tmlm0RtD56lls8gqFEteJw/Yg5iHko0VHifayKm09zilMEWPzz
         Tcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=BxtBYcw7PMyM4OnZEsQWKCObY8j6Cr/n1eLoBgs7MnA=;
        b=exqbgXk/rVZFs1SW4uk/UHJCRskVsj9zolUw+OxpMYlTP1t4ebeUthEQFMyVWuGfuS
         kF70Brs7c1J228FJYLNvOaJ/fnHyJCVhrxDLRlUFwGjbTUPMXDEKjBjSB+1dhBedSVUg
         Tvezhchi9jMEaju2xaQH7qz08UwPDzF7Vn9yglCyx0Z860IYqEcLjRxlryD2JHOX3cjP
         VD2Jwhs4/wxiMfPsYui3AnGBB+TykwracbELzlXjGVvLMlkJt89j7k9PJDzz/KWuHP3l
         btgaDpG70jiSewRZZZSX6QBx07nLg8MFQQyzeOwSGsQ3KRsdekvAYa6xcCjACKueETbK
         YqRQ==
X-Gm-Message-State: AOAM531qGuTgHHrAkjTXdAWh9FRkkcIvIpqtFXuzb6BtYDcgSch0GEW2
        nru/4MhbWepujpWMOzo2WsiGF6+gDXE=
X-Google-Smtp-Source: ABdhPJxdERUSePjhAsptraqXGe9XklXOJWYjWYcOEjO+Qosr1roa73m1aSSHQ9OG6zIrE27OaOerQw==
X-Received: by 2002:a02:b88e:: with SMTP id p14mr22632822jam.36.1591058759798;
        Mon, 01 Jun 2020 17:45:59 -0700 (PDT)
Received: from [10.180.91.251] (host-110-27.cofcdis.ftcollins.co.us.clients.pavlovmedia.net. [68.180.110.27])
        by smtp.gmail.com with ESMTPSA id f26sm410031ion.23.2020.06.01.17.45.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 17:45:59 -0700 (PDT)
From:   Jimit Bhalavat <jimit@rams.colostate.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Jimit Bhalavat [Hyperledger Git Commit Signing]
Message-Id: <81807F23-6218-46C2-B8AF-C84375F267E8@rams.colostate.edu>
Date:   Mon, 1 Jun 2020 18:42:47 -0600
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good Evening,

I am Jimit Bhalavat, a junior at Colorado State University, majoring in =
Computer Science and minors in Mathematics and Statistics. I am going to =
continue working on Hyperledger Git Commit Signing project and carry on =
the work from Summer 2019.=20

Just wanted to introduce myself.

Thank you.

Best,
Jimit Bhalavat.=
