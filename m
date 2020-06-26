Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCD2C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 07:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B302420768
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 07:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDcBrKJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgFZHIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFZHIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 03:08:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0615BC08C5C1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 00:08:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f9so4281087pfn.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 00:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FuGH/PApW5ByAFijjF8n45gQ3OlG9tfnEUvryiPmdB4=;
        b=GDcBrKJpHNh38i7qUc0PbrIsZjKk4rZI2ppmw/hTVAfoZcCKGbiIYfTtrthHVBJal+
         gyd8veS4F+Z7hTT/Ee5BlEnSNYZ8dXXjKWoit8Pw5Ec+hRIVZeoVkOaZogtnLfAMXC/n
         S22FIIH3KGKb9/E7zTWbgLl58JHETOduU553+qX2omApUISl1+yazwHE3WsG2uEkvn58
         +RYJLnILjyJY1/ePWVQkssu4IXtEZ6cuYul0Ti6RbxyvjGHB6+OuImbB4i7c1EckO9qz
         ktqtQ9hURs1eL54oZEyFJgIr33eqLrc3qiakSUYPvK2fON6HEVPx45jpOBcPoyUimrHt
         ofHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FuGH/PApW5ByAFijjF8n45gQ3OlG9tfnEUvryiPmdB4=;
        b=LajfgK4VB1RpSH/8yz5MHLO1zJTBg7I62AMLQcQZFaJ2xksXGy/k/bob9NdDXUSMSJ
         V6q/dV39/37mSzPXrJHqRrTLcv1CFNcv1RMcvjxB9pPzoWpDrA9ByPbsCt9GaPK/qTfr
         7eNU1ToFSghDGTuGDI3GVPSHdEK0YtxAhXn+N2GQAETc3rvdZ2WusrrtTm6pww9PFrmD
         YfYMEut73Xb3hHrPkToYlEPJRwfrTXGrRd57QDK3a48ENuXTABfIm6XtxkOqW6Gnf/Dn
         f5mUmwsaDxKlETPZ+8E6Jxd+10X2ZFiZvdgk9oVVu/4tqxWqCGbJmyymxqu5ciKuWCJC
         UrAA==
X-Gm-Message-State: AOAM533U+qqRZPWKySJb5BFysxBwJon8VCea/q93BWqtSuow202zc2xd
        neLGVriVOVbR1qTb9WEJxoo=
X-Google-Smtp-Source: ABdhPJxbuSjbKZsOdtatkDRMCZliu8ZTLKFmsxZfyC5bqcCXLTrki/jcw63pReskyRU1Tyey8tKerA==
X-Received: by 2002:a62:7e90:: with SMTP id z138mr264487pfc.292.1593155289316;
        Fri, 26 Jun 2020 00:08:09 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 4sm24597699pfn.205.2020.06.26.00.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:08:08 -0700 (PDT)
Date:   Fri, 26 Jun 2020 00:08:07 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #05; Thu, 25)
Message-ID: <20200626070807.GA84491@Carlos-MBP>
References: <xmqq1rm24ol3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rm24ol3.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 25, 2020 at 06:12:40PM -0700, Junio C Hamano wrote:
> 
> * cb/is-descendant-of (2020-06-23) 1 commit
>   (merged to 'next' on 2020-06-25 at ca0eaddf5e)
>  + commit-reach: avoid is_descendant_of() shim
> 
>  Code clean-up.
> 
>  Will merge to 'master'.

apologize for the most likely unnecessary clarification (probably implied
by the merged comment indicating ca0eaddf5e), but this branch uses both
rs/pull-leakfix and rs/commit-reach-leakfix, that are currently merged
earlier into next and also scheduled for master.

> * jk/fast-export-anonym (2020-06-22) 4 commits
>   (merged to 'next' on 2020-06-22 at b517b2f707)
>  + fast-export: allow dumping the path mapping
>  + fast-export: refactor path printing to not rely on stdout
>  + fast-export: anonymize "master" refname
>  + fast-export: allow dumping the refname mapping
> 
>  The way refnames are anonymized has been updated and a way to help
>  debugging using the anonymized output hsa been added.

s/hsa/has

Carlo
