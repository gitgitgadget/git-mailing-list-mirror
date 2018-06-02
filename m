Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F46F1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbeFBEjJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:39:09 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38230 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeFBEjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:39:09 -0400
Received: by mail-ot0-f195.google.com with SMTP id n3-v6so31620843ota.5
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+BIP+m8PSJFv46kuVx5ZZNmaFgSwNbZncvumiGNU4JQ=;
        b=hVNdWqZLWfBpjWbKEGrTyU2wjryaWTwXN+v/vjZdZaprhrP3iN/HdQ8sUVLFGZHAlT
         CuIJc1ZCUxjs9+ZTxUbL6peunesShM2K+kN1p9loKBPb3GXVFNy1bD3tZCAKTNSCtq1+
         O+hAMPqOKLtRl+/BfpcmKev+PLguYjTSj0g9cGXo4J0mGGK2Bjw59LfuhfuujWsDdR29
         Evjq9JVvCLH1SVdQWd36lUGbe+THFPHk0x1egQBOpDQaGtp03Qt1vgDzlEeFMciRMvMJ
         I+QWgmq4yyJkguQcWUlsuUxZ2d3wR/xvPCcdDxbUS+ArXUnr9ZEuBbRwtIY16/T4NWM0
         TJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+BIP+m8PSJFv46kuVx5ZZNmaFgSwNbZncvumiGNU4JQ=;
        b=TJSYCTqETcis5ZE1s5+OG4puBqA+9ODS6Tdz4nVSlOLUl2vlwiN2FldWJ89KCjUEBw
         M0qVBey5RWBtdp6znTAL4Qm+T4E6AYyTpgWPmHoXoVWEWQrgBa2ZkLzsoCq91jj9ifF/
         jCLY91mHrFwaYWVEQB1vnQ/XsYB1/8uHPRJueqshO5TqQ1HsIJybFeXIGdEHz8+aIF6z
         cZJNtApyxox9w49pMUD+lhrZ9L91dVcItp/1QvpKF3DohEgPJIRGcdO5HTxG00SqWaCo
         k9A9vTQ0EqX1aYKLo9ALPx2b1KJLJu2d31k0LvkpjWyhQQ5OpkjS7MWOrUOnD/nvCR9T
         z3sg==
X-Gm-Message-State: APt69E3Ni9pyo5jrgejTq+gttuBUsCHO3y1+M944YIiXx4mXAS94/PAe
        yAPnB926Wn2IeF0vbMkD4OZ5hqMLPXOqbdHhjF0=
X-Google-Smtp-Source: ADUXVKJjMNiR//EXonThN97TIlMTnPipoRz6D3TfzPlu2C4+t4UfS5NfvyXKTv2aXTJIpakph4hl/QFm1t7iYjztLHk=
X-Received: by 2002:a9d:124:: with SMTP id 33-v6mr4012488otu.65.1527914348565;
 Fri, 01 Jun 2018 21:39:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 21:38:38 -0700 (PDT)
In-Reply-To: <20180524162504.158394-10-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com> <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-10-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Jun 2018 06:38:38 +0200
Message-ID: <CACsJy8A8NofWCo0MbMxCe=xKTrnAqmM5D+FHSJXC-wO-DPnXwg@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] commit-graph: verify corrupt OID fanout and lookup
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 6:25 PM, Derrick Stolee <dstolee@microsoft.com> wrote:
> +               if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
> +                       graph_report("commit-graph has incorrect OID order: %s then %s",
> +                                    oid_to_hex(&prev_oid),
> +                                    oid_to_hex(&cur_oid));

Should these strings be marked for translation with _()?
-- 
Duy
