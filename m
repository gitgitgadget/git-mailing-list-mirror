Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AFFC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 00:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282512074A
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 00:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyl7gwjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgD2AX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgD2AX1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 20:23:27 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27EC03C1AC
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 17:23:27 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o19so331152qkk.5
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 17:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VG2zIMzShQ9d5h+sV7LNxjI60XyuuetuoZJVCgU9LSs=;
        b=Qyl7gwjmeROI3Ffoc7XwYXFOxhOFB+eol7mhhwvRZlIEqVi0yvoqcKDC48GXLVNQaO
         blfRTTby7sN4/Dovv3hsjHhloEQ4QZmCr1Wy2EN79cSODJDUCofUSgGcA9m50Rxl1Nw0
         8t6ru7AB4CM9jUwJjTjRiVmdWNftNHfBgHzaBHNLugEkZJC5rHARTSqhivReg20Sv8hL
         wArDEiqHsdWMVrYYK77h6X8QX1bU7s3vTtQqtfdBqytNGBzvJ3zUNolJJT1CPscTa0j9
         RINvCuUi9HqSeJPgqOExSdIMFMQidDXGdOhGHropi9bFQqsl+ha3lDQZBDHBmd6c4BwG
         iXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VG2zIMzShQ9d5h+sV7LNxjI60XyuuetuoZJVCgU9LSs=;
        b=fWLL0REbYoIh1csK5umeiPN4ummqorJAxvmFu19ZJIjl8rK0LbCVnGs4BnYKipTbC8
         ugDKK1QFN4M2gV5PdhB0mYi8U19Q53RxV0NqxDAJXqBWNiL/hXejVuqfR5y/uCAl9AHQ
         WQ2toifkE4bgQf8caNH4v7z1UECrzZzvxpAiHqIAwvPyU3iwPjlmwJjtHl2Hp2kInFIu
         h8jyUpudUA6YxqvPv7+aRewvQUJM3uJMkeywvcLT8R0BQO32Rcp3gwjm3CRE0qlC+3uZ
         uWoD7qJM5eLjIfnZqGUnhlCkEkKgApocc9OGM5sngel9gbcCW/aVpOwIX5dzv97uFR9B
         pIqw==
X-Gm-Message-State: AGi0Pubto4JkTQFgVNLEQgncchIaWWzhiIrtvB+b1WMacp7mfHNC5TP9
        3crwDzrguSZJqP4CmLh2pORlukLa
X-Google-Smtp-Source: APiQypKVjDPelu5kYk3oSFc4+Kojet4YXfX8mjbRndJpmChw63JQ/UG5XB7UAIzhDRfkviu0Vp1Bqw==
X-Received: by 2002:a37:387:: with SMTP id 129mr30388787qkd.147.1588119806440;
        Tue, 28 Apr 2020 17:23:26 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id s50sm15214004qtj.1.2020.04.28.17.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 17:23:25 -0700 (PDT)
Date:   Tue, 28 Apr 2020 20:23:23 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] rebase: save autostash entry into stash reflog on --quit
Message-ID: <20200429002323.GB2570028@generichostname>
References: <353a67567a90aea8a90bce1de05d005c61b3b670.1588066252.git.liu.denton@gmail.com>
 <xmqqv9lj1k0c.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9lj1k0c.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Apr 28, 2020 at 12:35:15PM -0700, Junio C Hamano wrote:
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index f7a6033607..7d0c89a184 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -256,7 +256,8 @@ See also INCOMPATIBLE OPTIONS below.
> >  --quit::
> >  	Abort the rebase operation but HEAD is not reset back to the
> >  	original branch. The index and working tree are also left
> > -	unchanged as a result.
> > +	unchanged as a result. If a temporary stash entry was created
> > +	using --autostash, it will be saved to the stash reflog.
> 
> ... let's not do so for end-user facing documentation.  "..., it
> will be stashed away".  Or we may not even want to say anything; any
> "--autostash" user would expect that the changes that were stashed
> before "rebase" started would not be discarded, and this change may
> just be a bugfix.

Hmm, in this case, git-merge.txt may need an update as well. From
'dl/merge-autostash', 

	'git merge --abort' is equivalent to 'git reset --merge' when
	`MERGE_HEAD` is present unless `MERGE_AUTOSTASH` is also present in
	which case 'git merge --abort' applies the stash entry to the worktree
	whereas 'git reset --merge' will save the stashed changes in the stash
	reflog.

and

	--quit::
		Forget about the current merge in progress. Leave the index
		and the working tree as-is. If `MERGE_AUTOSTASH` is present, the
		stash entry will be saved to the stash reflog.

both need to be amended to remove the reference to the "stash reflog".

When I was writing this documentation, I wanted to distinguish between
the temporary autostash entry and the actual stash since the autostash
entry isn't pushed to the stash unless there are conflicts or it's
explicitly saved. I'm not sure that something like "If a temporary stash
entry was created using --autostash, it will be stashed away" works very
well since the word "stash" is overloaded here to mean "a random stash
commit" and "stashed away in _the_ stash". Unfortunately, I'm also
having trouble coming up with a suitable phrasing of my own.

I dunno, perhaps I'm overthinking this too and your suggested rewording
sounds good and I'm just being too picky.

Thanks,

Denton
