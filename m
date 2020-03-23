Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DEDC10F26
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 07:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63FF20732
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 07:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv1DXVnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgCWHYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:24:03 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:41040 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgCWHYD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 03:24:03 -0400
Received: by mail-lj1-f170.google.com with SMTP id n17so2993526lji.8
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 00:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7EwBb03Xke4PEIqwWUMJIHbEjQyP4quZu6+kgRaXSjE=;
        b=kv1DXVnBFLJj4WylkRHkSmeJ0TnqWF8D3tGIwIhMtSXph/fHopVwo8S6Q3j85hp4ND
         5ID49bJj0jJuWaYicaqLnFVs1VoQFY6y1U+DD032n4PkX2BwtLoTYcnM76/4a+hubNdc
         9Whfj6l/ch3pSIy8gInZKRt+YWEj6rDGZgVzmiEwJGpYDzwJ0MA2AzcA2aLzImmWJlC9
         61WOeuehucIHYRe1mTV77c9nrPCiLCYJCOafs/Zk9R3utC3HahI0r4GsqSDb3M0EaYGe
         hADsjfNQFb/grsD1Wrn7SxmG/i+b6S3wA79YO4X7j9Hv0zIoWbCaUupInLpjiCk9I6ct
         DEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7EwBb03Xke4PEIqwWUMJIHbEjQyP4quZu6+kgRaXSjE=;
        b=KSWnfjbATsaEL/2Hv4A4oEGAQd9dc/1X1LxMayj0CNsZ60PjSGDy3aex20o7Y26tK7
         VqbIiNj1rVv4Px3M3bfWfVO8TNtiDyEtoFLwlM4ycI77SR3JqC+bv5o93XE69ITJD+2m
         DtWVaoEEPYJHtIzqYt0ncSmdiM3/wXdR0qKq1k7wHVtGM841iJ46+RsGAAxnBRqHdOgu
         F0RgAq98KptXKUNdz3cJk4AUMKO4WS3tec6BIdK4aLd0ZMPMtEmDD465V+xqqKezscmK
         kJPy1EmKV3lQCQMvPC97c29bkel8hBGLKIk1k9ce90jpuo8+RpfNdR+iEovcm7rDiGNj
         jJrg==
X-Gm-Message-State: ANhLgQ1drp+TK2P3we8mACPh20DBV7Xn6eRt6cCkZ1Cv8HZdSUI2ou+r
        gG52VIvrOHpfUFABpZseFRa6fHn6vzo5xOtHhPCr8HFzaX4=
X-Google-Smtp-Source: ADFU+vvhcHrSp21xE+E3lU7mU8J/eZEZWT16PIPDCXKZY/1wpePpRgaqNIKS8NQ3/2gVJajVqb0+nTlcD5MWxVTCT44=
X-Received: by 2002:a2e:b792:: with SMTP id n18mr13253454ljo.268.1584948240445;
 Mon, 23 Mar 2020 00:24:00 -0700 (PDT)
MIME-Version: 1.0
From:   Harshit Jain <harshitjain1371999@gmail.com>
Date:   Mon, 23 Mar 2020 12:53:48 +0530
Message-ID: <CACuU+s80UPZnwQfd1rXBVyMaE0FmpYNgf+wPLjOo0M7kYNWx1g@mail.gmail.com>
Subject: [GSoC][RFC][Proposal v1] Unify ref-filter formats with other --pretty formats
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings!
I would like to request all of you to please review and give suggestions
for my GSoC proposal. I have already submitted the draft on the GSoC
official website and have mentioned the link here as well.

Link: https://docs.google.com/document/d/1pNDKC-ZVTdo-B9xUtB1LuVkQXpYBsB5dEEtRbHuzWtE/edit?usp=sharing

Thanks,
Harshit Jain
