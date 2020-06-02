Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F043AC433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 00:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D7D20734
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 00:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InRLgk1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgFBAtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 20:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFBAtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 20:49:01 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADBFC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 17:49:01 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b5so5092020iln.5
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 17:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=BxtBYcw7PMyM4OnZEsQWKCObY8j6Cr/n1eLoBgs7MnA=;
        b=InRLgk1Yb+OFUBRfTI9e3QCOiX+EONObxQliWuUdfZVIjDpS6YatcHxLMqdntFEdIe
         FuH7gaNDmblnSF6KbxUsjJfdGAY9KJYIYyBCCSGu8Pz5S1hn3RQ2+kSbyZ8u2IpgmKhT
         bJo+XG63VFrUPhahTMu5HQPdUlebSnWMQ/1Ub6igaE6wED0VYk5tbNbjqk/PgyGxt3r2
         J6TvmzEj6ruDoENkmoEn1pW+ChmSbRU1T9ufs07F+jSrmbER/YdzXCymFQbaXKocKkmc
         G63Oz8F0dla8C6pAetb+8i/cR9QR9n39JYHAUNOcwwPP6aT0b6DNAz3JqnzBiMcOuSf9
         i2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=BxtBYcw7PMyM4OnZEsQWKCObY8j6Cr/n1eLoBgs7MnA=;
        b=nA7NYoCaFDF7gQY5SELacE+f8daUr4Y1FaARVUrq1pgNMvf2oT6p0KObIP7ZeAt7M/
         rrqf3LAskd7+dSAyGMDv7Jyk4+0ik2EUewxVJKcMnfPIGDkzX1dML5PxIBEXG6sIzIia
         aZaGXu4LpA/9aVO3gKYg1SOvbn0bO2a+reZYChgZoXHELDtqB/Nu2Y71TNWYdUpYgDZn
         7eEnpkZdf6vV2xTe0fNO2NHBJn+QaoIKSWcUCYkWLQbHKZU1sWjuQGR5bWfiuAENV802
         j3MRceNk9tNtRp89jqYfqun+TtiC4/cqYR6rmNVRTnBBZPgR28sDkYYlQPXJzZMh9V5U
         e05Q==
X-Gm-Message-State: AOAM5309A7fBfX2LPb6Bil9/Ub4Nj8HDHXCZ+eomN9VdVrBRoLdm0DZM
        FBjb5hi0ZsTtEC2CsSfYsbMW7LY4Kfc=
X-Google-Smtp-Source: ABdhPJzOAm8t8N36RYI11OiUGoA2/m6O6zlZ7ygUYIWMZbGxAcNBkWtJb07Zkis5uao5m8OVzbfaFg==
X-Received: by 2002:a05:6e02:1181:: with SMTP id y1mr12315639ili.111.1591058940324;
        Mon, 01 Jun 2020 17:49:00 -0700 (PDT)
Received: from [10.180.91.251] (host-110-27.cofcdis.ftcollins.co.us.clients.pavlovmedia.net. [68.180.110.27])
        by smtp.gmail.com with ESMTPSA id d13sm582938ilo.40.2020.06.01.17.48.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 17:48:59 -0700 (PDT)
From:   jimit bhalavat <jimitbhalavat144@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Jimit Bhalavat [Hyperledger Git Commit Signing]
Message-Id: <6531E46A-321A-43CB-8471-8F1FF10373F3@gmail.com>
Date:   Mon, 1 Jun 2020 18:45:47 -0600
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
