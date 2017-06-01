Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A191420D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbdFAVUi (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:20:38 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35985 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdFAVUh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:20:37 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so37789017pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lEsC1MqeezxQfCuZe3Vf9X5jCoiso3pOHopTjnHS08k=;
        b=Ry7mEZPPj76wevzEFESrL6zugU4M5LF3TAfvMfnqjfUeVsVmLzaN/4vCV8Ywa6qj3R
         O6O+8cSjRIW2+giqzbS65T9g68o/p18v9DaE6FihVcp7sXuha4xgdkX2Of246UnKdag6
         lMyFIilgMeHSFauP65zTfwY2y51YbvyyDWHCYwPLc7cC+Gi5JXXrBz7bmcf48g3z9Zdd
         s5+wIuk4WjG03AGiV9SB5eVT7sovwSAspi9Dc2EGuVySF/kxiGAU1rubX2O5VzQ2qqFL
         aZImQipNhCMcSCmCEHmvlx5pANENgBsGK5+yusQISAQVjpyvX9u6/4oAdMCoA6pxg5bH
         okHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lEsC1MqeezxQfCuZe3Vf9X5jCoiso3pOHopTjnHS08k=;
        b=fLZPG/rU19j20jqB0Nt+4bdblLjk/KKAdYtIySeynfDvz3mroilGn/TXNuH9Mp5nrS
         U7llB0x7yxqdt/Q6hgjZmG044iGUx00fvI5wutam3gTLkvumtF/OJikOPYZFbFvPjtYe
         vc0IAnenKcmyZqnEsAnvWnJbYc5DfeNszxosLGdl3ALIy6mIngJMQwgohcCLFF05hKJJ
         uVqCWalGHkfi+TOwFlkgS+V6Sz5qxsQVa618EDkhCXVJ4QCPWSxxXdYNUel6kqy6/SEO
         fVEfg+o8Ek5JhYDhKyJiRirRjLiNuFCEJiLTJwgNTOkQCG6/p0K8RFghbRXeivyHFQmb
         STiA==
X-Gm-Message-State: AODbwcBsXWI9Iy2U+uIzK8Ry9u6K3x1NpDQwFglavfH0RhwxakbZ19g9
        hTzeT+kIyU7eCwYApYMoxYQngdpWBp+kFGJF1w==
X-Received: by 10.84.231.206 with SMTP id g14mr96481023pln.12.1496352036877;
 Thu, 01 Jun 2017 14:20:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 14:20:36 -0700 (PDT)
In-Reply-To: <20170601182056.31142-3-avarab@gmail.com>
References: <20170601182056.31142-1-avarab@gmail.com> <20170601182056.31142-3-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 14:20:36 -0700
Message-ID: <CAGZ79kb6O7hraY4caY8tdFn1d0Fi+LRr9cHk2UuXf79LbnPdhw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] grep: skip pthreads overhead when using one thread
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 11:20 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> +       if (num_threads =3D=3D 1)
> +               num_threads =3D 0;

I would think that it is easier to maintain the code when keep the 1
hard coded, and apply the following diff instead. If we encounter
a 0 later on, it is not clear what the original user input was.
(Did the user ask for 0 as a proxy for GREP_NUM_THREADS_DEFAULT ?
do they care about the number of threads?)
It is less complexity in the decision logic here.

--8<-- (white space broken)
diff --git a/builtin/grep.c b/builtin/grep.c
index c6c26e9b9e..6ad9b3da20 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1231,7 +1231,7 @@ int cmd_grep(int argc, const char **argv, const
char *prefix)
 #endif

 #ifndef NO_PTHREADS
-       if (num_threads) {
+       if (num_threads > 1) {
                if (!(opt.name_only || opt.unmatch_name_only || opt.count)
                    && (opt.pre_context || opt.post_context ||
                        opt.file_break || opt.funcbody))
@@ -1295,7 +1295,7 @@ int cmd_grep(int argc, const char **argv, const
char *prefix)
                hit =3D grep_objects(&opt, &pathspec, &list);
        }

-       if (num_threads)
+       if (num_threads > 1)
                hit |=3D wait_all();
        if (hit && show_in_pager)
                run_pager(&opt, prefix);
--8<--
