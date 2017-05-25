Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E4F20209
	for <e@80x24.org>; Thu, 25 May 2017 04:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941897AbdEYE7Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 00:59:25 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35514 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941894AbdEYE7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 00:59:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so36698284pfd.2
        for <git@vger.kernel.org>; Wed, 24 May 2017 21:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=asjf63jsNM3ZRY8sTiN0HcwC2ACOm2FK0d+iPM61Hk4=;
        b=CV7PQSs3+ubyOKMLdXoKxx+AwBQWaUmJJn/NeswtB9DYG+ZSz8ojpHEF7Eb0i50tTP
         G/Fm3zENel/xvnMmlltbVxRgZAa5CGMp9FWc+NKrQyQQWIhSCYrv8nc/T/w5fMllU9P7
         sdDKpFFERcO2wOm2/aRFo30x6hdrr/hvQ6QfotwrWeCUjls4n6Vc4HcDNc+lbgcgmn5M
         eF+wYth7qUotTVPjtkYXlcY+m1Xm+dV3biyWxIr6vS3pC+13xEj9QoNGlinyIXZ1wJVK
         U2GCTmgtvbfYqT4a243Vyc1QFKl92bcABNiMK2asODPnRsChalk2t3vxD8R6ltamIY1m
         cxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=asjf63jsNM3ZRY8sTiN0HcwC2ACOm2FK0d+iPM61Hk4=;
        b=PrMCZpjOYD5XOinD/7jwlldK6PRUz7jNBo1W2VSPW+t7VZwESJwStEZkPXrN2maXBz
         G06cDWKZdySHQx3OUXHAG/v7myC35EUlbjJdBEdODnGgdyTX8a15+E0CqwIhz6I3kmST
         R42pNtZZQGS8xWSBes6HIA0wOwh5E/zQ2pZtFp0cNVzl45TV4fAEZ3XbMW3hn7+17RLD
         XhqT5G2moB/XngrUD9D+tu+WAlH+3L+OHgD4zz93FR1AiGpzTkTeNB3O321fsoNAetCn
         pMtxNnih2HRxCyWr7PEr4lSuza5rhrWpfH42kQAUvqfmlcEuV3+D/Y0rdDVKPhlk8Wc/
         S5IA==
X-Gm-Message-State: AODbwcC+FgkaL0CFAsSygoGuCKcqtT4TeJKkDY6/K0PiqFdnELvxk9ct
        hgExEP7Qr2t1lQ==
X-Received: by 10.84.129.99 with SMTP id 90mr46841983plb.134.1495688363680;
        Wed, 24 May 2017 21:59:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id q27sm11456868pfk.4.2017.05.24.21.59.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 21:59:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 20/29] blame: rework methods that determine 'final' commit
References: <20170524051537.29978-1-whydoubt@gmail.com>
        <20170524051537.29978-21-whydoubt@gmail.com>
Date:   Thu, 25 May 2017 13:59:22 +0900
In-Reply-To: <20170524051537.29978-21-whydoubt@gmail.com> (Jeff Smith's
        message of "Wed, 24 May 2017 00:15:28 -0500")
Message-ID: <xmqqwp95edlh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> Either prepare_initial or prepare_final is used to determine which
> commit is marked as 'final'. Call the underlying methods directly to
> make this more clear.
>
> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
> ---
>  builtin/blame.c | 49 +++++++++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 26 deletions(-)

I do not necessarily agree with the log message in that this change
makes the contrast between prepare_{initial,final} more clear, but I
like it nevertheless because it makes the interface into the helpers
that prepare "initial" and "final" very similar.

The lifetime rule of final_commit_name used to be that these helpers
make a copy to be owned by the caller, and it seems that this change
makes all codepaths borrow it from entries in the revs.pending list.
I think that conversion is also done correctly in this patch.

So far, nicely done.
