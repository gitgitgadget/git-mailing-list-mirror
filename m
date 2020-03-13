Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5532C4CECE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 09:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB7F20746
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 09:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvw7/d2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgCMJgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:36:43 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:45948 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgCMJgn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 05:36:43 -0400
Received: by mail-qk1-f170.google.com with SMTP id c145so11331503qke.12
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1pA1ALutWAn0zcnFxGEbsZ4F4BidIQhqk9CUUvyaSXY=;
        b=dvw7/d2MG7cw3mUK359qEtNIoqtHCpZCUT5cOp/bJnRbaXd44zPhc9QGpTzUuh9jSI
         5Oe1LX3Z6tuXACvA+2cYHqPRlaAeSERlBborHbYt3hpv7yiTOfkpe5qiyc19PY2Vvx/Q
         r5qa8VVjPbi2GqX7P/hvkKfEdnSe4gLcs04+DGz3iKltUF+f9RvkfU3oSdV6zrX6DUYM
         Ie0Kz0MLYCnAu10HhxdHnLfKDu8h4koUgrh3tFH58Ai0czun7Lv1+y5GEyxQQkTbgI/t
         UfyGnXfIpW1wJlWsJ5vTmZcM3PrMH78Mbooa+2kPSk1CTMZObiO2alemmbIOA/XBQhbt
         qhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=1pA1ALutWAn0zcnFxGEbsZ4F4BidIQhqk9CUUvyaSXY=;
        b=dXuApsAzZt0A2waki1Wew9Icb0aV8B2CRJT1nTmxcWU4kRsGQ4kCxZ2vvP1fP5Tm70
         mP4xM7uUwYaOUuLU9hRe3s0FnkKmGe2NCCviY+RGbon8gB8eCcM/PYBZ7yBPnExX3XmS
         91aE0DJjPeU2fuw2f30GRtRFGN8s5Avyl1lWcaEoq/7oNItTXC21IJRv0EvPzq/iiBOE
         etBAd0VPxZqvm4oo4mCCbyTGY6my86CGgTXyKPLoanPVJzq/hN/T+UcJhAuNBvLwuuuB
         WtD/hhcD+DnXx7L+Bz2sOx6hGYVlOb74MwP8jD+mjqWmYQ9e1CUpe6HqhRZo5fq0dwRR
         UJEw==
X-Gm-Message-State: ANhLgQ05Yg5iOgHVSoo5STZGztNkwdt1WLy2gLLLMaQ9VbWyq83gKBKN
        KNxWgKGpMWmZKc15kYe8si6yyu+8e9IFvv9aw4GhJssGQmI=
X-Google-Smtp-Source: ADFU+vu8VKTzG8v2PsPNTDe287jetcrlHh9NbuGAbAbDEEvRUHHfDVgSuETKRBpgMuEDoXcRxMlbeJZ650f7dTeBz28=
X-Received: by 2002:a37:5685:: with SMTP id k127mr11639754qkb.481.1584092201784;
 Fri, 13 Mar 2020 02:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <CACTq9vt0c+yX9hp5m84dQ7Y4qWk-RrP=zQ2s4PnNRC1ytGbOmw@mail.gmail.com>
 <CACTq9vuZO_wHhzBKsm=SOTcyXq3e=ur4NmNG9B-g=p5OXMuCNg@mail.gmail.com>
In-Reply-To: <CACTq9vuZO_wHhzBKsm=SOTcyXq3e=ur4NmNG9B-g=p5OXMuCNg@mail.gmail.com>
From:   =?UTF-8?B?SnVhbiBKb3PDqSBMw7NwZXogVmlsbGFy?= <jjoselvill@gmail.com>
Date:   Fri, 13 Mar 2020 10:36:30 +0100
Message-ID: <CACTq9vvv+_cEv3Epk3tku47qogH0b8oUtVWUEt=tX5UGzxQZ6g@mail.gmail.com>
Subject: Re: Feature Request: git config for stash -u
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

I was wondering if a git configuration could be made for including by
default untracked files to git stash, so every time it runs it is like
it had the -u flag appended. For example: stash.includeUntracked

Thanks for your attention!

Regards
Juan Jos=C3=A9 L=C3=B3pez Villar
