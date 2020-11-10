Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5246C4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 13:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565E0207BB
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 13:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=digitalsocialweb.com header.i=@digitalsocialweb.com header.b="BWlISS+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgKJNRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJNRN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 08:17:13 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C96C0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 05:17:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p22so2957411wmg.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 05:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalsocialweb.com; s=google;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=slNq8NBPxHFbXe9fNvn+Ir6OSSMGYHeGF/+6wx7b56Q=;
        b=BWlISS+P++mxTM7QVRVFPmLhL2LvBJUIlVqF1GqKavPX7GlK7h6JjQeypO6B5zLutp
         noBDuZwR9uWv1cBuknu1V7c9L2E63i9QcvlTb3iOa+eTlkt0R0d0ZIJBzzs6ryfIlCyH
         +RWSnwumdw7e0gblF34E9oyBZj8hrOoXHvbzfn7mEn9yaHCDYRK0420q9kqYY9OpGPTv
         6z5JimqUKOf5nNsf0+zE7lW06i/kiGp2jrpIXhxaXmtUqxRKcWUV0fgcu4109BSkGy4s
         ZFV+i1o+tljreiYQELxd6qgx7XQLqXKYSidwVjJIhN8zElkf7TxloMiF17/lDxCVCX+O
         a1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=slNq8NBPxHFbXe9fNvn+Ir6OSSMGYHeGF/+6wx7b56Q=;
        b=uRLQcHiflLfgmOW1P1j3XsF30Pe9K4n5IY6z8Mqko3+Kb6n/rMP8zQBdR9v9SrJUdW
         iNRVYT53tJjxVssFT1u4kbDm19MfHSiG2cWDxF9qL1KxsE9h0QrPhA1GWHT0zzs5FUzL
         RDmnbTe8Su0AmJa478yE/QkY7w9X5coJzAOLMDzY/t2REBZVlHDCQfiwFv4fsuhKbBZo
         VP2hJtpcym8g6zwuEwgZfw+o1QZjNaKPr1afpk9V+pAh1YTmj61FtNyGLOXI5uRoQke/
         QEnI5zu9ZNvym63pmVJh6VjWkr32PRtF+o9Y+SikxcQ2t+n6TkmDK54orYNmIwIzLXMp
         MB6A==
X-Gm-Message-State: AOAM532tDVkG0LrktwQHS7RQZNrltT/iM1uZBpaAIA2Kbey8W3v9ER/d
        2PEy6bZ29ubybhnaYc9Ta1WQEUaRrEacW7Cq
X-Google-Smtp-Source: ABdhPJwtB4w4ESLTwbV7gv9wwJIUPllS40ZsgXnStUvLmYjAFai6q2OB2tLpvvgQJfD+i6Y3TJWqMg==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr4657719wmc.173.1605014231092;
        Tue, 10 Nov 2020 05:17:11 -0800 (PST)
Received: from 72.255.54.232 ([72.255.54.232])
        by smtp.gmail.com with ESMTPSA id g11sm8165132wrq.7.2020.11.10.05.17.09
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Nov 2020 05:17:10 -0800 (PST)
MIME-Version: 1.0
From:   "Jason Dunlap" <jason@digitalsocialweb.com>
Reply-To: jason@digitalsocialweb.com
To:     git@vger.kernel.org
Subject: Paid Gust posting
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Tue, 10 Nov 2020 18:09:12 +0500
Message-ID: <10980385454712157481936@DESKTOP-L09MN1Q>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

We are a professional Outreach company looking for blogs for blog posting. =
I came across your blog on Google, and I=92m writing to express my interest=
 in posting content on your site.=20

We also have a writing agency, where all our writers are native speakers an=
d will ensure that whatever that is posted on your site will be of high qua=
lity and relevant to your site.

All payments will be made via PayPal or Pioneer. Whichever method you prefe=
r for the do =96 follow backlinks. Please notify me of the price per post.

I look forward to hearing from you,

Best Regards,
