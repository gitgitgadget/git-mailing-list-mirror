Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09E8C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77305206B8
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgLCZEKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgEEWxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 18:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728076AbgEEWxy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 18:53:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4C2C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 15:53:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 7so1704986pjo.0
        for <git@vger.kernel.org>; Tue, 05 May 2020 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9X1A4huO8iOeEfZNc1gpisj8eAJlQJL75zULtl+pRg8=;
        b=fgLCZEKu4y5cMoYoMxbxRqHBt6vqVx0ZDBBUX0+vDzTaqFQMPFKFp4R6d2U3gBaXMc
         +4GzUWrgJCH7hXkZjmPYPzBE4HAosR15Fo2w8xRDVGH1fGOO3ODdwVRP8ze6RvVulO4b
         KaGwd4J8C55O57UzAWOt7LW9w9MqxXc1CwUfqPz5BkV9VP5ReXCXGlNd64nQDxUtV7fg
         1Ymhzat5E4uMpbqsxof0mKnKGrJgkQgfIEjMhJpeBLCgQaPz4bugHh0FbYAH5YqThOO4
         sjidlAV4QtoyUu293wVyUkweXEPP5oYzagmzHZuYRKrFtCmL7giu9eJv5dBiZPsjEsdB
         jKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9X1A4huO8iOeEfZNc1gpisj8eAJlQJL75zULtl+pRg8=;
        b=CU66MZ+Ub0zFZHiXe6GzABFfzjWCzCOjKgMjuDFgI0+ILNG+WW4bOrAD4HmGlHP077
         Rkv9fcnFG8WE7p/tQ6Ko999kvnVswAjjCaIe8TQLbmgdhgarxADr5wPIO+I3Q9aZu7Y6
         bn99QkRckoWpqefK5CR4z/IMGOkWtMIkHDF0jWQySn5BkceW2Hq9ygnSFYo1afZYzsFr
         3RfpsiWzWSRLaAjRRqMK+QvxaY0pGj2MickSpXlGrg1OR0+aNvE4DOeE3vPE46DjwlLO
         CQ35fIvKbEdFs8ujeAyA2fViII57eT08LiwmvDa8XpTSf7iBRdaGmCJpfWcMrl+HzO5v
         VrNQ==
X-Gm-Message-State: AGi0PuZO2YA6wTjRt2wFEyrIwQWS1Yi9ChSH6UaAC6JabY+1p02Z5wKW
        AtXloJ8AmXNCIip3iZ7Je58=
X-Google-Smtp-Source: APiQypKkB3CMU5WtSAzRbvJvvpdBdomZB3NOKygtRA3IIzIJo8AncC5rs1SATA9Ayh/aJmfys9tO8w==
X-Received: by 2002:a17:90a:6c96:: with SMTP id y22mr5723501pjj.74.1588719233535;
        Tue, 05 May 2020 15:53:53 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id x4sm140918pgc.74.2020.05.05.15.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 15:53:53 -0700 (PDT)
Date:   Tue, 5 May 2020 15:53:51 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2020, #02; Tue, 5)
Message-ID: <20200505225351.GA49541@Carlos-MBP>
References: <xmqq8si69fda.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8si69fda.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 03:38:41PM -0700, Junio C Hamano wrote:
> * cb/credential-store-ignore-bogus-lines (2020-05-02) 2 commits
>   (merged to 'next' on 2020-05-05 at 5b919ec5d6)
>  + credential-store: ignore bogus lines from store file
>  + credential-store: document the file format a bit more
> 
>  With the recent tightening of the code that is used to parse
>  various parts of a URL for use in the credential subsystem, a
>  hand-edited credential-store file causes the credential helper to
>  die, which is a bit too harsh to the users.  Demote the error
>  behaviour to only warn and keep using well-formed lines instead.

this blurb needs updating, as this version doesn't warn as reflected
by the branch name.

Carlo
