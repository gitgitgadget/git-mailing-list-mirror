Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48C7520960
	for <e@80x24.org>; Thu, 13 Apr 2017 22:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbdDMWBd (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 18:01:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34670 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbdDMWBc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 18:01:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id o126so12922746pfb.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MBsTo4cYZ2hppQREPNfIbxHzA7hP0yru00nE4iu6g4w=;
        b=ZgpwtepiAHk8eXF+K4hWBl2Ptfo924UCL/BMkk9b8Z0LE7HOScLHczOYlng5lw3ws+
         zjnVteI3d7Bwaw+tL395D/thOHVPr+zwu+qWSjSyhbSXRPW3qb+eaFmNMhgsadQc6Cmq
         Mz85tjZT1sc2em4IUpWFXQPTjXTSOD0oBS51FIT6ns5P+KknVRjaiKaLVoXHxTItiCcj
         bv4fvYw9hd6PlDdh9LtfXHRUx9gf01dqxbsz3WbwrY48CKUjpA9JKHeamWTR2PmWRGEH
         cdPLwNMB6bGYROAcoOeQs9oWHd6YoikOGGqsKeJmRIpTM3se1f4JLWOELN28l7VcUKJS
         40fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MBsTo4cYZ2hppQREPNfIbxHzA7hP0yru00nE4iu6g4w=;
        b=TxqnSJsllzFwyo9kZUFfEEmnEWnS+/awxAhaOnsN1VJA7TIBT7fCLSLSDp2Y6pk769
         ws0SGLtYBoO7bW5H9tRNnaW80U2QjFR5WnBhU/CJho67zkVtufCUkrVvR76O5YtardjY
         7aAmm+2T7H2Z+UrgrDaW48o3IuVvP73IbKG9m7CuF9bCySP5tdAKyMa28Z1lj71VuE22
         b4xVV/8Qmb7LHxLgWVhktrcYpRHUFxrb2yphtgBQ+xui/QegmHs1x3lW3vDeSMscT++o
         e03/es/mUYfC8XGHXinI2aIGqWXH5D0C5w4Cw64nUVCgkkHBaMbvN4wKrMV+TK7xjXme
         Oh4Q==
X-Gm-Message-State: AN3rC/7h+h7TwQGzjaOyMayYSlOUBsbVoUaQwUiIKxh+WPwDQUz+ZeUr
        S06pKyL13ti8FhVRpmo=
X-Received: by 10.84.231.9 with SMTP id f9mr5321786plk.191.1492120891529;
        Thu, 13 Apr 2017 15:01:31 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:40ae:ac27:c1a2:6a87])
        by smtp.gmail.com with ESMTPSA id p11sm26700pfl.4.2017.04.13.15.01.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 15:01:30 -0700 (PDT)
Date:   Thu, 13 Apr 2017 15:01:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gergely Nagy <ngg@tresorit.com>,
        Aaron Teague <ateague@apple.com>, jeremyhu@apple.com
Subject: Re: [PATCH 1/1] difftool: fix use-after-free
Message-ID: <20170413220128.GD10084@aiede.mtv.corp.google.com>
References: <cover.1492111288.git.johannes.schindelin@gmx.de>
 <c8a5e41b77f132272eb9a1dc4142279499a54641.1492111288.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a5e41b77f132272eb9a1dc4142279499a54641.1492111288.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/difftool.c  |  7 +++++--
>  t/t7800-difftool.sh | 19 +++++++++++++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thank you.
