Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9644AC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 00:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58106212CC
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 00:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAYpEUTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIOAOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 20:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIOANo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 20:13:44 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A347C061788
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 17:13:43 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id o14so442383ual.11
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dXXOY3fDFP778EZejGfdO08kM1ij19l7uPbw0Tgsiys=;
        b=FAYpEUTEBQlG2+V4WlsRYXQ9+o3cgvi3mXMuLW+FbOkrxs6S7wkUFMczuB6cIDHjEs
         oVERmnPQYSh1hXY5cAITSlQuNngHSD0U2j1PYf6mKa1xOCGYR5but+J0HFEUMgheOr4G
         4gQQYgG/Ukvp3eY/nn0Qpz2og+bVl40zjb1UpMYWphWxWF+fxPLZmuRCZUT6rtDKEzgy
         IfxUAWTk8Gq69gcPKIxusB+J3rJQOMGSP49T8y9v04hBG8kNk+G6O9GAt17EQf3IPFeg
         iNEwYpEnBq+cNQKd2Wp5vuQIMClpAhFeviHBlkOZ7UME3xThyLWgCOIwnPy76w5IwW+w
         Lbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dXXOY3fDFP778EZejGfdO08kM1ij19l7uPbw0Tgsiys=;
        b=cxSvUsDemqJ7D7FBJbLZTFTogI7fV6aU0OPr5a3lozV/knkDvYSD8YY02jfDXdu87E
         4ArdFM7c7K8kG5EEP+AFjnwDuRYEMsopdzZUMZoQ+BgEFLuo6gqG1n/xwNXTyKQhPh1Q
         Xxv1YYyGPlp2RlQR4efsmbY3KKX7D6n4oDSsn5pGInCrJWcaGlqaTcMOOiMlpXId7ftc
         iZ6kCRImq6YiRRWuYVpOu3mTBLUsCKdbQArwhh45za2iPnilvv9abMQJSa1Aa6TOR6vl
         Ad9DNU8QO6GvWT5ysOovV7d9tOxQOd1vO3YeCAkqnV3IEZ88yyCK4LC8n3r7KYQmyVdo
         P8dw==
X-Gm-Message-State: AOAM531KtZAuMUe9jVRjCd2hYt7tkCiTZ5xuO76zr+3A3Ts4rCDuqTvm
        Vx7Jh2ZaOYtRjKg3VaUbDwja3nLhHw365lqQQS6HT9dkK9n9mw==
X-Google-Smtp-Source: ABdhPJzXq/T90SEY3mndP4atw5on4xwr754YG0yaFMZT/4Ns0a+mq1Qaz7jNvRIuA90Pjl9RkJqZ8GYAhrw45xGoMvw=
X-Received: by 2002:ab0:1450:: with SMTP id c16mr8147444uae.27.1600128820631;
 Mon, 14 Sep 2020 17:13:40 -0700 (PDT)
MIME-Version: 1.0
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 14 Sep 2020 17:13:29 -0700
Message-ID: <CA+P7+xpjSxEmB0qpWkhkd=yeA9xF-ssVdW1J5NyJdkqfza=GPg@mail.gmail.com>
Subject: git format-patch with useAutoBase = true
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just ran into a surprising and unexpected issue with git format-patch.

$  git format-patch -1 f7529b4ba3c98470b0e367ba447ad0da84dc308
fatal: base commit shouldn't be in revision list

It took me about 15 minutes to figure out this was referring to the
fact that I have "useAutoBase" set to true in the git config, so that
I get --base=auto by default.

It turns out, that if you, while this config is active, try to format
an ancient patch that is historical, you will get this failure.
Because --base wasn't specified on the command line, this made it very
unintuitive what was going wrong.

(I started to try a git bisect thinking it was a some bug in my
current version of git from the repo, which still failed..)

The failure occurs because the "automatic" base is newer than the
requested commit. I am wondering if it would make sense to relax this
restriction and make the format-patch automatically disable
useAutoBase if it would conflict like this?

At the very least it would be helpful if the error message was more
intuitive and potentially explained what was going on a bit better...
:)

Thanks,
Jake
