Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B8C20960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755381AbdDMTFf (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:05:35 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33231 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdDMTFd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:05:33 -0400
Received: by mail-pg0-f46.google.com with SMTP id x125so34549295pgb.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cH1kZOzSPEhpybcs9dInT9Rxdmu6iKMqX3h0YLuUWuM=;
        b=Wc9dZalvTYWSPVRaevUBvlLrIhEyxHYdqOYK5CRmMptR8yPx8Ue09AlS18YrT3jqxX
         GMf9fxpEWLAvf4EQFmD3CmFvL/r97eMCwON9TL09BJ6XMjvRQ2JHXBKaCt02ZbjXKYMO
         uSVffM8A9du3nsZa7njvOTEMjhZe3gTxF57JOkDt/DjQqYdATkfcYocZRknl5P7sPKiI
         A7Y9t05orfHxRpmQN/5wcoz10rpJuSO1apVE0zFkZfXf+Zcb1Fc2/kibvtlEoJ/J5l5P
         pNIkJzf9p2d1KX/W1MQH+BQdxD4Sbv4jrt/sEmrxU7E15U7dqp69lIIt+f05HH8YCxaH
         HxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cH1kZOzSPEhpybcs9dInT9Rxdmu6iKMqX3h0YLuUWuM=;
        b=QuckPsgMqEPC9mKITcWo8lXt0vIaa4e0CY/DE3zBV6jPLeW9Oo5sTQ9Q9KvylCGPGY
         xKBEETpAq0+NEFuyjagexGy9H649D7yds/GPkswSnrlEkAM2PycjUCJ6ZsyYHLM7Isar
         f6P36//STfSvTsEz2LaBDlok6sB8gM2PtG3KsBX/8GIVklcmp5pn3+Np7LILObtbdjnO
         xAVVcRGoLDdgnmTQpJBMGG974V90gNdhJ/K1ZCn76EZpMGb3z7SH8DNGwvGmZ+Ervcqr
         dR255D0+wogFuGWxMYtDT3jgPGoXTBv9bsB1yvqciVbWNiWjgLjSI1c116lfozTqTcLH
         kggQ==
X-Gm-Message-State: AN3rC/6lGwNuwiBBIsNllw38i1Tg55QEVqdeax1xRx0wqVcuCDDA/dDE
        CnI07IrLQe4Jw1viiyVB9cNbrCqEfpiR
X-Received: by 10.99.247.69 with SMTP id f5mr4393506pgk.63.1492110333089; Thu,
 13 Apr 2017 12:05:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Thu, 13 Apr 2017 12:05:32 -0700 (PDT)
In-Reply-To: <20170413185707.97746-1-bmwill@google.com>
References: <20170413171224.3537-1-jacob.e.keller@intel.com> <20170413185707.97746-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Apr 2017 12:05:32 -0700
Message-ID: <CAGZ79kZ8KV+c2StKR8tp=s_E1+uEaSezgsmUfyyO9HUrmzdT+g@mail.gmail.com>
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 11:57 AM, Brandon Williams <bmwill@google.com> wrote:
> Add in a check to see if a submodule is active before attempting to
> recurse.  This prevents 'ls-files' from trying to operate on a submodule
> which may not exist in the working directory.

What would currently happen on recursing into non-active submodules?
Can we have a test for this?

Thanks,
Stefan
