Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5974C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 00:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF372084E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 00:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKO3CVDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBDAx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:53:59 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51153 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBDAx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 19:53:59 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so569891pjb.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 16:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=myQ/QkDfWcfWHubX8I3SOXA/s3x3Bpa5itB2r7o84Iw=;
        b=SKO3CVDAbKeF9z7Ys4IOTp+YAfkvvc5/rzg//P3+TiiuOIDQgSqtID4Jy13v2x4ln1
         BR3tN57WK+c7rfe+HlkaIRoqQi0foUUFbqr3su1gXybcJraWZd4il5s81VAI6jXoLTyT
         zsN7VPNyHxveNUxwv5ERcvqNTxzC9IF2rLkGkLasI26mtsvm61IiYtrZFGhhYHDJKQ8O
         RqO2SORwvYLvYXkheXRjuoZpNrOMleTkJrrQTL0jgf/3bYL4p14avSDGg+KKHLDbONij
         UyfidU2yKvurhwLtY7E2Kg9L0tAWk7mk/HTquBxf9XTJp5s26Ebe63SO4xcDn+nCv5UE
         gofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=myQ/QkDfWcfWHubX8I3SOXA/s3x3Bpa5itB2r7o84Iw=;
        b=MOINovzepnAG0GYgErwKjczNkGxvwZBnLBSuxazN2aXDR4HIED76XinKzSMlhohlI0
         4SJMRe9Mn+QqN8obah9PMUfHSdEW2mZugB3zXyx3FQeViZmo5k8UVa3exIR+R713YGOT
         //NfNhFTyBRn/Chq4pJIYknzKMLWY0T2ko0KoLgpssjyw8hECKbSB7R2CTQFBz3c2RNl
         n06Hf0j1IkEHmWKWcQSOFbpKZT8fWKtJjsX8/j6yYDpRggWeadYqiRoX91pHxFCUft2C
         oOG2WCRxkq8ZE8xLxr1k7m2NDmoEPZcTK0Fx9V6uSE/V6oBmUMe3bUx4BrV+M/pPMIVV
         8DpQ==
X-Gm-Message-State: APjAAAV6XsszFpEK504XaCpIrJIBueH8CCXIFBlG4UT4+TO2BiBiKdkD
        CzPcRBEgXz2FJSvY1tP30BK683ymblI=
X-Google-Smtp-Source: APXvYqwGWwIWbz4UYRD0wUDkvKmPJqsDVa8vs7W0FIICqF1GVbPzvBpcsioaomkTX4AnT2oxbHtdxQ==
X-Received: by 2002:a17:902:8b85:: with SMTP id ay5mr24373547plb.253.1580777638738;
        Mon, 03 Feb 2020 16:53:58 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id gc1sm653338pjb.20.2020.02.03.16.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 16:53:58 -0800 (PST)
Date:   Mon, 3 Feb 2020 16:53:53 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 02/15] help: move list_config_help to builtin/help
Message-ID: <20200204005353.GB87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-3-emilyshaffer@google.com>
 <CAN0heSo6K42mmPkLE=QPo93OJmzbN0Xj-uYOE-wOT2N5ctda5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSo6K42mmPkLE=QPo93OJmzbN0Xj-uYOE-wOT2N5ctda5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 11:19:26PM +0100, Martin Ågren wrote:
> On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> > To make help.o usable by other commands again, move list_config_help()
> > into builtin/help.c (where it makes sense to assume other builtin libraries
> > are present).
> 
> Nit: I think this could be patch 01/15. It shuffles things around --
> *then*, starting with patch 02/15, we can add exciting stuff.

Sounds reasonable, here and 04/15. Will do.
