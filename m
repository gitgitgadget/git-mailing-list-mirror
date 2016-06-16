Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0631FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 10:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbcFPKOV (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 06:14:21 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33616 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbcFPKOU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 06:14:20 -0400
Received: by mail-lf0-f53.google.com with SMTP id f6so37341099lfg.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 03:14:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to;
        bh=OLm3rnLBEfWxTI0gDuK3P8VjPzD2iAAQq1pVOQRoN2M=;
        b=gQpPUurMv/iye5F79/SrzuIu4z2c6ss7eAkwPKSS/PZOkEC1TBYj51n/DABA3Em1yP
         7dcAbQ7SZoNRTuHe5dkqZbQPEAi33lWPbD4dVICN4N72WMkERezO+UdqbMqRwELwnny3
         J/ZS04z6CGOmhpJVvrrghWFLOlHCX24xyd4lcKPz6HxElyqb2wEiUM3DX+m280nJfpqv
         KmqIfURsMCVudcbrOGb3/HU1wRzNtTCoLhu9pNIRu1d1IBJ095PyBlj/7X4Ml849iKr+
         z+KNdUS7Yp4gxZnew2Vk0NQlXfJdT+0yv7M5xHVKO7CU3taKJMYKptXtuVSwJWIEsgle
         F23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OLm3rnLBEfWxTI0gDuK3P8VjPzD2iAAQq1pVOQRoN2M=;
        b=LiW7KIOGq8mp+6pBqit5t7U9adYfvleYkb1Bx+S2idnJ75klyksb41RMKgVAqPtLRh
         Vj+OQVle3adEEoSyBrEs1CveMD7jkKixgvKAepZLc+uGykeAukPsclkVZA5hSJkFoI7Z
         xDOSmOAqS6GGes0s2zxNY0/x164ycDBZfH8AnJ3XniIXHiRjO1eyHsacyGnWg2rxHTLS
         cXJ0TiyrGQG5iRIAk78cGStIZAu9s6108pcDwDPJExCpNz89Zc+HtpfUm8Zx2Bf9VOpR
         fkBSWPfnAyJZiQrZtSvGx+aOEpMmAJKcrmy2DhXEAM6zJrKtlVYCwtHL7lMQfAfrRYNi
         WWzg==
X-Gm-Message-State: ALyK8tLecq3ERIEdAyLdZ9zyPXBQmTvph4RHZIWKIFdR44nXdO7koFnUs2D88uTrEyotULRVK0qhYkPIE/mGbjsJ
MIME-Version: 1.0
X-Received: by 10.25.161.142 with SMTP id k136mr35021lfe.0.1466072057781; Thu,
 16 Jun 2016 03:14:17 -0700 (PDT)
Received: by 10.25.156.78 with HTTP; Thu, 16 Jun 2016 03:14:17 -0700 (PDT)
Date:	Thu, 16 Jun 2016 15:44:17 +0530
Message-ID: <CABYP2JZU5wqxCK1B7b_fDB0Lqz4-7a_Erb5dHKReZHQecxC8QQ@mail.gmail.com>
Subject: URL rewrite in local config unable to override global config rule
From:	Saksham Saxena <saksham.saxena.1994@ieee.org>
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello everyone

I came across an anomaly in git recently, and would like to share it
here. Please suggest if this is a bug, or if my approach is wrong.

Summary : Added a new rule to the local config of a git repo by
issuing ' git config --local url."https://".insteadOf git:// ', but it
wasn't observed by git as it kept using "git://".

Details : I had set my global config to use "git://" instead of
"https://", as I prefer working with SSH. Recently, I began writing a
'GitHub Wiki' of one of my GitHub projects, and, apparently, those
Wikis are normal git repositories, and can be cloned and edited
locally. However, the clone url available is served over HTTPS only,
and doesn't support any other protocol. Naturally, I had to change my
config to change the behavior of git while connecting to the remote. I
thus proceeded to update the local config of the repo to use
"https://" instead of "git://". However, my remote urls weren't
updated. I manually then removed these remote urls and added new HTTPS
ones. Yet, the remote urls showed "git://" protocol in them.
Screenshot of the terminal window can be found here
(http://i.stack.imgur.com/y7GMP.png).

I tried to add the "pushInsteadOf" rule as well, but again, it didn't
take effect. This is particularly disappointing, because the local
config have the highest priority, and yet it isn't effective at all.
Because of the limitation of my remote, I cannot even push my changes.
True, that I can dig up some dirty workarounds, but I do not
understand why this behavior is seen.

I have also asked this on the popular Stack Overflow forum
(http://stackoverflow.com/questions/37844460/git-remote-url-is-not-updating).
If any of the moderators here do not find this issue as a bug, then
they may help me out on the forum itself (if you happen to be on it)
to reduce the noise on this thread.

I hope I described my problem clearly. Awaiting response.

Regards
Saksham Saxena
