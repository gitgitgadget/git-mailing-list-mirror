Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436941FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 01:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753615AbdC1BFs (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 21:05:48 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35345 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753565AbdC1BFr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 21:05:47 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so17037407pge.2
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 18:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bxa2/UUlIo4DdNYwvGOumiNnqXcCQuwhA/e/hWCRd8w=;
        b=EEudaF7U3HE01hMq+cYr1lFCWSB+98vJBwvXB8ho6QuPyNqLtzo+eyJG3IYv/idvah
         2UWkFom1sv6Vq9pMux7F4JQ2Y19ZSG8hp/OTMKVIKQLlkkVJnPVcqBwBGL/BMMI29o+i
         hyqHz18Uxij8sh+hLLDOwYevU2wG787eQmE+fXad0sWMKx8RyWaFGIzUPKlftSh4ieQi
         HglQq4CaMxlYIFk5L5pEs67wWPbDv8M+f8MNNdAXNxgwmQaC0A1whIldbEK39r+fFpw+
         SmHsyuIhkVikABK6VaMoFcjyDXaLnJo3o+rv3fBo+GmLtilmHco5zLfK6eTe/spQRDGq
         jlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bxa2/UUlIo4DdNYwvGOumiNnqXcCQuwhA/e/hWCRd8w=;
        b=Eha0NdKDHaTZ7q5cZ1XqTNmVybyN8alaitnoJJ8G5CjfRqfkVHPaHuHe94F2QgQ9Ol
         gTJNa14eIZAe+/O7lp94ZHbXq98owiwIcSrXkeatKrVGshnZfRaP4Qbj/8l0357odPVx
         v08uObDz+BWfVSiz+go36RvpE+vyA7KJWkDw8U/LPJDNbeX/7/uhJg9OrqjKw5I/svNL
         QsPtTK7bn/ZsfJ0FCwd7S5hWXMLOfO6rtM8W+ZpQAfJcRP1rvBa7WD4JeR337KBZoQxr
         YWSY+9wigcUaZMDnyeNm8o8G1Kcqw2fdhsLmdLKfqNRaBNXcFH1U/fnr2uB8ndEzRxFM
         l01g==
X-Gm-Message-State: AFeK/H0SezXz/rxui9Kahbm0sD1/Zc2au2BK8XsdDpbwzAEAcMmSVv8TZNfgdhUjmF3xlA==
X-Received: by 10.84.131.79 with SMTP id 73mr31974867pld.45.1490663136157;
        Mon, 27 Mar 2017 18:05:36 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:c051:ab1a:5a93:a0ac])
        by smtp.gmail.com with ESMTPSA id r17sm3402332pfa.13.2017.03.27.18.05.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Mar 2017 18:05:35 -0700 (PDT)
Date:   Mon, 27 Mar 2017 18:05:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] submodule.c: correctly handle nested submodules in
 is_submodule_modified
Message-ID: <20170328010533.GQ31294@aiede.mtv.corp.google.com>
References: <20170324182902.19280-1-sbeller@google.com>
 <20170325003610.15282-1-sbeller@google.com>
 <20170325003610.15282-8-sbeller@google.com>
 <xmqqpoh2z93q.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpoh2z93q.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Shouldn't this done as part of 4/7 where is_submodule_modified()
> starts reading from the porcelain v2 output?  4/7 does adjust for
> the change from double question mark (porcelain v1) to a single one
> for untracked, but at the same time it needs to prepare for these
> 'u' (unmerged), '1' (normal modification) and '2' (mods with rename)
> to appear in the output, no?
>
> IOW, with 4/7 and 7/7 done as separate steps, isn't the system
> broken between these steps?

No.  Both before and after patch 4, this code has to determine two
details from a submodule:

 1. Does it have untracked files?
 2. Does it have any modifications to tracked files (including
    submodules)?

Using porcelain v1 format, (1) is represented by a "??" line and (2)
is represented by any other line. Using porcelain v2 format, (1) is
represented by a "u" line and (2) is represented by any other line.

So patch 4 does not intend to change behavior.

This patch 7 is trying to do something more subtle.  Suppose I have a
superproject 'parent', with a submodule 'parent/sub', which itself
contains a submodule 'parent/sub/subsub'.  Now suppose I run, from
within 'parent':

	echo hi >sub/subsub/stray-file

Both before and after patch 4, if I run "git status" from 'parent'
then I will learn that "sub" was modified.  "git status" within 'sub'
would tell me that "subsub" has an untracked file.

But from the end user's point of view, even when running in "parent",
what I want to know is that there is an untracked file.  Treating it
as a modification instead of untracked file is confusing and does
not answer the user's actual question.  That is what patch 7 tries to
fix.

In other words, patch 7 is about changing that list of two questions
from before.  Something like

 1. Does it or any submodule contained within it have untracked files,
    that I could add with "git add -N --recurse-submodules"?

 2. Does it or any submodule contained within it have modified files,
    that I could add with "git add -u --recurse-submodules"?

 3. Does it or any submodule contained within it have a changed HEAD,
    that I could also add with "git add -u --recurse-submodules"?

Question (3) didn't come up before because when there are no nested
submodules, the diff machinery answers it (saving us from getting the
answer from the status --porcelain we recurse to).

Thanks and hope that helps,
Jonathan
