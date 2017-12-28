Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0841F404
	for <e@80x24.org>; Thu, 28 Dec 2017 02:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbdL1CO5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 21:14:57 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:40959 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752757AbdL1CO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 21:14:56 -0500
Received: by mail-wr0-f169.google.com with SMTP id p17so14370737wre.7
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 18:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CD+zgXhKFqT3rDFfvSplVQLefiY4Hr6eHggw6WqhwWA=;
        b=B/pEe/Pt7HC+I0/ZGMdhvCDcc2W814fAEMYfcLd6YOLzhtAgB+s9PL+czDoXhLzEvO
         CtovDHQsIp4IB+LcTvw5P92U3L5NUmplgtbXem2VIdicZKZzfDdHtGPw+Ytd55jXBOBI
         6VLyqvhucX6FnC3mZY7r7JBZachUu+BMfPh4fUqIQvCc2hJ/fXhAiZzHeJQwsDprtYm6
         5YFGjvG6PhUFQV4m0OOlHyzN6lvLvcvqSPHmv2/cgNJSb6fcCB3irXImfcOPkDQFDLFp
         oJLzJefIRopclXBYXZaGRBFVjLLXP/FMaoqTQ7uusg6JtAS6hDoJ1+w8QUeRXqa3hT2P
         sjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CD+zgXhKFqT3rDFfvSplVQLefiY4Hr6eHggw6WqhwWA=;
        b=ZBPdLfKrplE1rUR943HWUq2bnzD2lLnhZMNOzoYkrjnxwSSkVzM4cPnKr3VaS69Ydm
         i9yEZLICnKxy+jJ6jatoBEPWJs2IxxAWt8Qqys2/nENmr/85PCFWVCSHT9dxuJ0PqWqA
         wUAPhrbCvILLHyrE2bjx21DNr4HuOiMrecLYOOguph/TSSXMcXL6izLe7GUX/yUdYsak
         APdUfCCviJmhu5NlT7y5a7q1ulK/WtcO5wOsmckxXlF+e4bz6fy9lcPeUshahXBwCLYG
         CScx0lwIsLONJCcbqmJLe6I+5Clw0ycTW4ugLtU66Lu/HyFQTkj0A9YWMXK8vWxK4Yob
         lNcQ==
X-Gm-Message-State: AKGB3mK3ksCH8lGsN+A5yw5QAf1HsRSMXJsPrvZrfEQ7E06Jw2RJSg7Q
        us+qz83+V9Dyw4UO8Ozw7Gk=
X-Google-Smtp-Source: ACJfBovyPxF9Dum16Ve/TKfLcszMV22ltnZWN0nnNJGeftLe/4cl/ij1xUCNMiGRJGnEec6dzVzn2w==
X-Received: by 10.223.142.202 with SMTP id q68mr7974690wrb.262.1514427295763;
        Wed, 27 Dec 2017 18:14:55 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id p13sm33344774wrc.61.2017.12.27.18.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 18:14:54 -0800 (PST)
Subject: Re: [PATCH v2 6/7] wt-status.c: handle worktree renames
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>, Alex Vandiver <alexmv@dropbox.com>
References: <20171225103718.24443-1-pclouds@gmail.com>
 <20171226091012.24315-1-pclouds@gmail.com>
 <20171226091012.24315-7-pclouds@gmail.com>
 <d0f2055c-e0c4-32af-6371-53d0e9a5fbc5@gmail.com>
 <CACsJy8Dn_XKA8=iLRZpj2EKYOSZqHT0jw9o_HzPH_vncGGeCCQ@mail.gmail.com>
 <fb29d5bf-daae-fa8b-b787-e536cd5f98c8@gmail.com>
Message-ID: <1e89cabf-c6ca-de43-fac0-399da9a9776d@gmail.com>
Date:   Thu, 28 Dec 2017 03:14:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <fb29d5bf-daae-fa8b-b787-e536cd5f98c8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

p.s. An extra note for the casual reader, just in case:

On 28/12/2017 01:50, Igor Djordjevic wrote:
> 
> ... it totally slipped me that documentation is/was pretty strict 
> about <origPath> being HEAD path (exclusively), where I was still 
> expecting it to show renamed working tree "from" value as <origPath> 
> in case of working tree (double) rename, too - where that exact 
> (already renamed in index) path wasn`t to be found inside HEAD at 
> all, so the working tree rename couldn`t really be shown as "source" 
> and "target" rename pair, strictly following the "porcelain v2" 
> specification... :/
> 
> ...
> 
> I repeat that this looks like the correct approach, making fully 
> described working tree rename detection possible in porcelain in the 
> first place, but also aligning output of "status" --porcelain 
> variants with its default (--long) form.

Wherever "working tree rename detection" is discussed above, it`s all 
still about renamed file `git add -N` case only (where old name, 
appearing "deleted" from HEAD/index, is not staged yet), not some new 
functionality where renamed file inside working tree is instantly / 
magically recognized without being staged in the first place.
