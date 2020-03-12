Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D33C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 10:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D952071C
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 10:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orangeguava-com.20150623.gappssmtp.com header.i=@orangeguava-com.20150623.gappssmtp.com header.b="NbvN+Ewe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCLKnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:43:16 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:42184 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLKnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 06:43:15 -0400
Received: by mail-pf1-f182.google.com with SMTP id x2so2704186pfn.9
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orangeguava-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=uhrMoUcLFTCQsXKjnYOjNQfqzTrEKeXZEaLIfdva20s=;
        b=NbvN+Eweu/iaK38cCZqI27lusF5TKMyVKnB79SCCXT6qWtp4KaeZEiyD1vVDHykeIg
         2iDDbRjYs6Na4Z3as/sJ/F4d4C0YiPDMikqhU6fYgcIENLmK7upeCZ8GrhWEOfMbtB4N
         5OfpbXHrpe2BqPAtSVhZH38Y+/f4DXmuyd2BqWQKfqQ25nGL5FLDJx6QVpFko/j6nQEl
         Bh/H9efQ+hrHpuyLZtnD95WBVR7W0ZmPptp7MTioyDQHPsEsR4FUP6ZfBzXSekcmI6ES
         ciBM4EhocpFFKbzidGGWKQjZ7PPiVo9jPMBVbtq1sTOa82418AEj8HQotE36y4KOP0Jp
         VEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=uhrMoUcLFTCQsXKjnYOjNQfqzTrEKeXZEaLIfdva20s=;
        b=TLl2T6dZY+aUGZXtCPR8BrLyMPb3JBHsEtGFd7OPM2jnqeRwv79kDK0YKLRI9M8xh9
         91YpK1kWtjtL/QiBg3N5qSmbd9Yfaj41ixKnHKs2Spixm8Mp4vobN6V2eVjj+EE0aW3O
         8r/ctiqY6SLOxNbk/UEGcf+cvSPaut03ar37DGC0YztwLwtHfly+XJYejrt3eV7F0jRR
         W/wCL2DK34ZcaWspYJ3+7U0gkMfxMzJgvhtWfsTBl95dKHbNK8+pGjfR0dNIYLN0T3kN
         XSoZSc9nfebNmcxNqX5qg/HKSyXKg+ZSSm71IbEMc9MkTjY3xaUCCWB2ir2tV/Lu0YKH
         kX9w==
X-Gm-Message-State: ANhLgQ05DiefdecksfAo0NXmZUINBFjO6rFbOCNFvSbuXxWojcUNBbPX
        fs/kEeXDlY8pOcnyp/5FZgXOgQ==
X-Google-Smtp-Source: ADFU+vtUgCgAsfW+K13/ZLvwLjQtTdf+LUkcEIJmE1OfXBn1HwCrfrefd3o1TUVBMigPWOnsrs6IwQ==
X-Received: by 2002:a63:4555:: with SMTP id u21mr7193401pgk.66.1584009793336;
        Thu, 12 Mar 2020 03:43:13 -0700 (PDT)
Received: from ?IPv6:2405:6e00:48b:675c:c5b5:3ae4:2a49:575f? ([2405:6e00:48b:675c:c5b5:3ae4:2a49:575f])
        by smtp.gmail.com with ESMTPSA id l67sm2198541pjb.23.2020.03.12.03.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 03:43:12 -0700 (PDT)
From:   Tom Clarkson <tom@orangeguava.com>
X-Google-Original-From: Tom Clarkson <tqclarkson@icloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after 315a84f9aa0e2e629b0680068646b0032518ebed
Date:   Thu, 12 Mar 2020 21:43:08 +1100
Message-Id: <65C25466-895B-4EEE-87BF-C8823AB953FE@icloud.com>
References: <3E84DE22-9614-4E1B-9717-69F6777DD219@msys.ch>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Strain, Roger L." <roger.strain@swri.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
In-Reply-To: <3E84DE22-9614-4E1B-9717-69F6777DD219@msys.ch>
To:     Marc Balmer <marc@msys.ch>
X-Mailer: iPad Mail (17D50)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Deleting the subtree-cache directory should be safe enough, it only holds a r=
ecord of previously created commit mappings, and deleting it just makes subs=
equent runs slower.

The data that actually determines whether you have a regular merge or a subt=
ree merge is part of the commit message, and everything else is derived from=
 that.

> On 12 Mar 2020, at 9:33 pm, Marc Balmer <marc@msys.ch> wrote:
>=20
> G'day
>=20
> Due to some issue in git subtree, a subtree push pushed all commits (over 8=
000) ever done to the main repository.  So the history of the subtree'ed rep=
ository not only showed commits done to the particular subtree, but all comm=
its in the whole project (see E-mail exchange below).
>=20
> Today we decided to no longer use subtrees, but to use two independend rep=
ository and managing merges manually.
>=20
> How can we get rid of a subtree cache data?  Is it enough to remove the .g=
it/subtree-cache directory?  Or is that dangerous?  Does git-subtree store a=
ny data anywhere else?
>=20
> Thanks and regards,
> Marc
