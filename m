Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76C32021E
	for <e@80x24.org>; Tue, 15 Nov 2016 22:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934857AbcKOW2e (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 17:28:34 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32934 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbcKOW2d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 17:28:33 -0500
Received: by mail-qk0-f171.google.com with SMTP id x190so153922385qkb.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 14:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kgECIpCJ+VByhikyDGqhfRcMnv+aXX7EpQ1xWboDw20=;
        b=nwFmhBwp4JGtpzXl6PszQ7mLhuHuwhK52b0gZ7rk+hQEOJCIRnTLU+ZhGhxr5SHupe
         gxVAkEmvZzfRvp6qiuJS2F3VMVj7A8UTKFVUZm07UDykJWBNUx2J461LsQ+Mvgtf3i4a
         tro+Mg0zo2toXEo/Zrfcrcb2ne7cqW58kyA1HB0ZNSwVmvFShuwlB/F9EB/wc75RPHuo
         GtMM+lI41KNF75z5H9NbXw0mA6pm6YfeCW+3noh5yRe3CNHExn+9uSyJxlBCsSmOJ6m4
         AbS2RFXg9lmU0dD7dWJ7PDDaW3cCw1cAiRfSG2veJHInqckAlj/ODW0pdOntPMVTFgeI
         Zqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kgECIpCJ+VByhikyDGqhfRcMnv+aXX7EpQ1xWboDw20=;
        b=Ji6mS3ectDfLt2SuPcUPTLJDonm2XZ3y5xp8sWGQdChh/pOeK/jCL/S0VJQtn8FJOJ
         dJg9PIlGoctmsb1SZ5/AOI7IbKhdrBTYJLut7eQUGJioh0d9yAqke/XqiZI9jx4azDC1
         UyB/22QRIzFeUpk0yzi8Eaj5QC8JIEqOQvU6HR9e06e99rAz0VmCS94cCL9+RQzww4vJ
         5O1oMITvUzqdNjZFrGBgxYpWuN/uyoV8NicjlAvmJ8ZnUmxvfXNRSFATMOp0SCwJVwqd
         zk4Q53d/b96zu8uOfpd8a2wg6Cshzz5VOqyb/WA0f+wKrU2XpnnkaZQwZ1cDXb+9y24C
         fzNg==
X-Gm-Message-State: ABUngvdMojoRGOmQPTSOK6+xRxYkFwadFYwF5HtuEWjIwUib0NzAuG3ZKxzePVqMKDqIUmnJCrArAh+I9cwMua2h
X-Received: by 10.55.186.3 with SMTP id k3mr27634672qkf.47.1479248912227; Tue,
 15 Nov 2016 14:28:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 15 Nov 2016 14:28:31 -0800 (PST)
In-Reply-To: <0f1aaa07e151f6be87eb61b434f8c9448f8dad75.1479221071.git.hvoigt@hvoigt.net>
References: <cover.1479221071.git.hvoigt@hvoigt.net> <0f1aaa07e151f6be87eb61b434f8c9448f8dad75.1479221071.git.hvoigt@hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Nov 2016 14:28:31 -0800
Message-ID: <CAGZ79kZtQG5pE-6N-1yZKA95VRmrDRB3PnSd1gtqBM9fxD48Cg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] batch check whether submodule needs pushing into
 one call
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 6:56 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:

> -static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
> +static int check_has_commit(const unsigned char sha1[20], void *data)
>  {
> -       if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
> +       int *has_commit = (int *) data;

nit: just as prior patches ;) void* can be cast implicitly.
