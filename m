Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249651F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 09:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbcH2JkR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 05:40:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35844 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756515AbcH2JkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 05:40:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so8674476wmf.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dE7CzD2S8yHZX7D9lnm6j3rf/Dxf+cZyi/jbx+pDCok=;
        b=knzGLwd+Z2fIwthgtHrGw4Csk8V0gqGvraTzHPxUhrz7G1LpOxwgsmlj9TB1O3Ga0H
         EHwJH3voGWU/WWfAgPbqjLN17I4HHNBc0XiKRJ46VqaBq7y+vkuzeO3PlDHzNgspR5Yh
         bbozlh3KekpRI87TMyLJuqiEJRcG39cvc08TxRlj/Mr8uLXPLJP9qJTOAzsVFNKhCzRW
         8FkbAUz82PJoa+MJmFWWrTFsB7NzLO65wTfq5lHJpiip7HtNM051dAfqP00P0BJ50Beu
         sVS8/aeb1qqmUG2jplPPf5T6c+6KOyROludVkA6Dt0GgHOtBH9HA8TFnrO4edjTB3pkg
         OvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dE7CzD2S8yHZX7D9lnm6j3rf/Dxf+cZyi/jbx+pDCok=;
        b=EomXphmaMSLzlwAlgLlQqvRAxtC/ljrwIVQvOh1UnJ+0Q94/ByyYL9wLvCOW2EzIT8
         JP8KS62ZRXkvkd2d6hOuJIou/yeoxMLyiVP1XNB/NIJe6Ub9IuNLDOqANibBOYwdR4zY
         KWc67uhSUfK/6wRBdnQ1Hnt5NPlN7+fbHt59Lk7/XHbNA+38ftnz4BQ4/g/ZmoTgnpid
         y5+gLN4cI18ng4A9lHxkko/0Odx0eaLpCCnonQwr3TkXYiHTqqot+U7Vf6fmgj6wBbAb
         o5WmtsqzLSKOjSNe+TlHMz43fhkNUSMLdWVZD28TE1OK0H1YbQpoPxGF0E7t1tPgWfxh
         0tYw==
X-Gm-Message-State: AE9vXwNuRe2goV8NfcrRIGoaumtMcKTD203Yc+W0LWnG2oAgouXFKCMj6+SQDcUQv3JlQg==
X-Received: by 10.194.110.229 with SMTP id id5mr14490904wjb.23.1472463572299;
        Mon, 29 Aug 2016 02:39:32 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id q139sm12599268wmb.18.2016.08.29.02.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 02:39:31 -0700 (PDT)
Message-ID: <1472463570.4265.24.camel@kaarsemaker.net>
Subject: Re: [PATCH 12/22] sequencer: refactor the code to obtain a short
 commit name
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Mon, 29 Aug 2016 11:39:30 +0200
In-Reply-To: <4b99922194d97f012459a473da48ec31d18c687f.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
         <4b99922194d97f012459a473da48ec31d18c687f.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On ma, 2016-08-29 at 10:05 +0200, Johannes Schindelin wrote:

<snip actual commit>

I fail to see the point of this patch, would you mind enlightening me?

D.
