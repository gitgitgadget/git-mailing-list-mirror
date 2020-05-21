Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B65AC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9B820826
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkQYYFq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgEUQ5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 12:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbgEUQ5N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 12:57:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3BDC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 09:57:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u22so3045723plq.12
        for <git@vger.kernel.org>; Thu, 21 May 2020 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=njJ9RbFvqb5eSv70/qsjEHK5D5rNAYXft2nhFHzoKNI=;
        b=tkQYYFq9LdemTaV5JH4JEbXv+eP0HD7AorY5jqtv9RcqecTevKyxJeX1u2BVdLfP31
         khrSWt/bB4U4QGh95Sp9Qmz5kRwm8FzXypuKddbcV15YpzR0f00S8Q0dJ8bwy+JuKyC1
         b4WpOUP7depbHPzFrRol+Fpe6uEourhYoeAjek6rrMZgOhll3Z5yYJL+aJUK1u8nOvp+
         1wrKYttEESFAYOp71glhNs9hscfdm5axbRrA0dzOyoxmMMNau/sYxMPfoviK7HY/20/v
         vqEgdtaUpRITtdbnw8epBDzpSU7cvheG4Yl6ZQDLZFO7JI5PAvJhLbynhBJP/izdDirD
         zNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=njJ9RbFvqb5eSv70/qsjEHK5D5rNAYXft2nhFHzoKNI=;
        b=qYjU/EouFysrMDnbfY/DXLvlmgYF1OFfaAYH3Qj81q9gvvC1y2jA/jbi+vgtGL3SSE
         zR2tJLRHjl3tLB/Vznz7xGcXVgnynUjLgPOWEbz6m6bARfWqFBwq8Lo0fNjYwvPh0jhA
         BMB8pmcog1IKgzecZMQya4szKxQhh9Iki6w+1ASdXq9gSd3+s6aYyeMSXAM4WAyrLOXs
         Im72cLnS9+vqYCPTLUSNVcGZI8Q5eYiIapJihQW31LFRcmz9AJsXHuicNAwso2EZO6UP
         JOYOc4qM2klms9+MDbWsLEAp6ABDl0swCXZ3PYAFg/sAIG2yCihfWgGc/8eswATlhXpq
         pfMw==
X-Gm-Message-State: AOAM532kqfgJABC8XgJNYix2iKqpp1Gu0vFHYsE8SNPNCdV2sqbUurZp
        sOMnq9NFhoaYH93O4JPGIqPeTlQK
X-Google-Smtp-Source: ABdhPJwfkf93ZAn+Rzzixil3Z0hYl3RZsSAtF4GA+bAWQ8La8BX3zbqMYKiddHiBPSkc6/cr7pXQsg==
X-Received: by 2002:a17:902:a60e:: with SMTP id u14mr10272627plq.176.1590080232268;
        Thu, 21 May 2020 09:57:12 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e16sm4335802pgg.8.2020.05.21.09.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 09:57:11 -0700 (PDT)
Date:   Thu, 21 May 2020 09:57:08 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     mirucam@gmail.com
Subject: Re: [PATCH] git-bisect: remove no longer needed variables
Message-ID: <20200521165708.GG20332@Carlos-MBP>
References: <20200521163449.36108-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200521163449.36108-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 09:34:49AM -0700, Carlo Marcelo Arenas Belón wrote:
> With the original functionality moved to bisect--helper there is no need
> for them in git-bisect.sh anymore.

them, really only being _x40, which was retired with 06f5608c14
(bisect--helper: `bisect_start` shell function partially in C, 2019-01-02)

with the rest obviously still in use for `git bisect help` to anyone that
would bother trying to run the script before hitting `git send-email`; sorry
for the noise

Carlo
