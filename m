Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7CCC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 10:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FA220776
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 10:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1Yq4nSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgJLKLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 06:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgJLKLs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 06:11:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8925DC0613CE
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 03:11:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t18so8312164plo.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q8ELDBYIxXF0BjIEaoZyj1K2rYy5PSlbaI0HRELM6vY=;
        b=k1Yq4nSeR3/bVUV4pF/MHnzCd2L3tv6Ec69LUA01nfNWRK8AFST34/jf7FDtG4P99n
         AVTVpnilgcan2xW9M+FZWZ2NBEdhHk7bFMVWjPft4a3nbh9si+yBNaosCNskgAZ+NBLc
         /TRGro9id6C5EFpNgVNbAZvVUWZrneTWbGfWChja+odtCyv//v1f8ZlGhM+UwzxC0Y2Q
         hR5ZPAJ7H9jQ8m32JoE4hwD3FLwudhBSopXQSc7QFdW8s/42mRsCzpmHRJVkjPEuT45u
         VG5kCWUgm1Kz/tUJEz0rGNHLdvOxDvjLPjsJsra3wAGkNXgeS2xfsmX6SKPozj7QMpcb
         dWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q8ELDBYIxXF0BjIEaoZyj1K2rYy5PSlbaI0HRELM6vY=;
        b=mZsXzNlqw0jetiFYjzYiBohNK6iQD+WT3t5MRluMtGwoof68SWpMqsWnlIg2AdbL3u
         3bg4UCPEIT48RCDgcc43x328F5asiBsX/saP3tBNvQBADgCAvWgESfzmje1aPXFJMBHu
         82ht14Yq9GIOv0vWCk3iwtR2qQPpo5sGr9BhRsBuIAjAWVLSh5Szzm0Ul+R28lYC2vaJ
         c2amdIDoHL5WTf7nLAsnZ+4aAj+Eo0VrGQ3wAV1KwoHtB25VAWtODCfZz+18CVYM54R1
         XHtRCgk0iOoiviECBX79fVMKO8gba7+3ZSKWFQZuxUKzq5AM0zyKxDveMLXFTGlr91AQ
         KMOw==
X-Gm-Message-State: AOAM532GCPETT9xoiWzv5WgYm/6+h6dYrkxu5j3OaXrAwnp6aSfXpzZo
        b/CGMIfDMMIePy/IG6o2Xko=
X-Google-Smtp-Source: ABdhPJw5+uarJ74qfOHiA/ZBsuNktjz13GtUULH59kGFyyx6E/ujC/xc95b435hcUrYgcFGQblFV2A==
X-Received: by 2002:a17:902:465:b029:d0:89f1:9e2a with SMTP id 92-20020a1709020465b02900d089f19e2amr22665921ple.6.1602497507867;
        Mon, 12 Oct 2020 03:11:47 -0700 (PDT)
Received: from konoha ([45.127.46.169])
        by smtp.gmail.com with ESMTPSA id l14sm18422796pfc.170.2020.10.12.03.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 03:11:47 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:41:40 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com
Subject: Re: [PATCH v2 1/3] dir: change the scope of function
 'directory_exists_in_index()'
Message-ID: <20201012101140.GA12637@konoha>
References: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
 <20201007074538.25891-2-shouryashukla.oo@gmail.com>
 <xmqq8sch3o8v.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sch3o8v.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10 11:05, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > diff --git a/dir.h b/dir.h
> > index a3c40dec51..e46f240528 100644
> > --- a/dir.h
> > +++ b/dir.h
> > @@ -370,6 +370,15 @@ int read_directory(struct dir_struct *, struct index_state *istate,
> >  		   const char *path, int len,
> >  		   const struct pathspec *pathspec);
> >  
> > +enum exist_status {
> > +	index_nonexistent = 0,
> > +	index_directory,
> > +	index_gitdir
> > +};
> 
> These were adequate as private names used within the wall of dir.c,
> but I doubt that they are named specific enough to stand out as
> public symbols.
> 
> Unlike say "index_state" (the name of a struct type), whose nature
> is quite global to any code that wants to access the in-core index,
> "index_directory" is *NOT* such a name.  It is only of interest to
> those who want to see "I have a directory name---does it appear as a
> directory in the index?".  It is not even interesting to those who
> want to ask similar and related questions like "I have this
> pathname---does it appear as anything in the index, and if so what
> type of entry is it?".  A worse part of this is that even if such a
> helper function file_exists_in_index() were to be written, the
> "exist_status" enum won't be usable to return the answer that
> question, but yet the enum squats on a perfectly good name to
> express "status" for the whole class that it does not represent.
> 
> So, NAK.  We need to come up with a better name for these symbols if
> we were to expose them to the outside world.  The only good name
> this patch makes public is "directory_exists_in_index()", which is
> specific enough.

Understandable. So, how would it be if the function I wrote in
'submodule--helper.c' could instead be written here (in dir.c) and
would help to check if the path is there in the index or not. It could be anything
ranging from a filename to a SM. Since the return type will be an
integer, this PATCH 1/3 can be eliminated and we won't need to change
the scope of the 'directory_exists_in_index()' function and the enum can
stay visible only in dir.c

What are your thoughts on this?

