Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B603DC3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FD82074D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1yi0NL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgCWPLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:11:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44043 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgCWPLx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 11:11:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so6015806plr.11
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 08:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o84wRh3lWTQDQqpw7ipGBMVVjgWgA5R2BY3uniB6+uw=;
        b=Z1yi0NL7xt4plSVYG6F0ck7+NzUH49q1UkpMYvXhsMQr+2breCy3LaWXv2CiUw+nOB
         tCw8PCwL7n1mAYSfPYka1lhu8lwojxu8CCcjllNoib+8KxoEzEdQf7x5KaehE5nHtG/a
         JOza+kMj1dFPxit70P603ihMFLNdfPHXjxsrbzH7AhY51i6uxV+3PvrIlg/ZPiOBbg2r
         WeKHpmBzRsF3JPxL0rrvjm+py1yzfct5J2IjTcsf9ElAEmVuBK/JezVomiHl3aOMO8cx
         E6HoSNxcz9vLokXxDmmuYTFZFlg08/lTQ60dWylOa+jSeMQwzGhrl32a0XV1OEFebviu
         8b1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o84wRh3lWTQDQqpw7ipGBMVVjgWgA5R2BY3uniB6+uw=;
        b=umaOIQED14ezBUom1fR+oQjio76+H4qaTorgyv5WmIwxIRWZpyfNtzqnQGLzUNwqnN
         aIMIgR6mooSNvju+z9AbcSnNpDtcoiYvxAOO8wUxxPqT/4zPycD7ShXvQLHwlJBBD7aI
         jq2bej15AXWL3F84O3LJEz2F9XnX5TI5QQLGYoRPFMOSwL2TmJ8suWkLg8TaVwBlriMH
         9S8qtVB3waZfghLPCAx6Ee40WZdfFSXR9xBqX+cmS/Lwb20nZWzJl7fcO3pQTZxYJTtZ
         NRmbn3EVj8sPOPeb25PREa9vQcpug3TvCtvWKR/R0sqpkCA9qL7nBNAYCTSW5q62sVg6
         us/w==
X-Gm-Message-State: ANhLgQ06pyAIBtd+l2arWr9TgEt1nmWrqkKhkZb9LMDU4zk1Z5WfyciH
        +HBq6FP2JpoKlMXxTowFGKU=
X-Google-Smtp-Source: ADFU+vvot6scN3xBmaN8zlJAunfcQHu5DSXm9qeUzYJyq0oM9kmwWCsatG0JcOL5TFT5kjPBcIwLng==
X-Received: by 2002:a17:90a:aa0c:: with SMTP id k12mr26534213pjq.193.1584976312176;
        Mon, 23 Mar 2020 08:11:52 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id u3sm13797625pfb.36.2020.03.23.08.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:11:51 -0700 (PDT)
Date:   Mon, 23 Mar 2020 22:11:49 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 6/8] t7063: drop non-POSIX argument "-ls" from find(1)
Message-ID: <20200323151149.GD11801@danh.dev>
References: <cover.1584838148.git.congdanhqx@gmail.com>
 <59e3f73784b2a3bd9ccec87412e6178411c3708e.1584838148.git.congdanhqx@gmail.com>
 <nycvar.QRO.7.76.6.2003231509150.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2003231509150.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-23 15:11:50+0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Sun, 22 Mar 2020, Đoàn Trần Công Danh wrote:
> 
> > Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
> > update feature, 2016-08-03), we started to use ls as a trick to update
> > directory's mtime.
> >
> > However, `-ls` flag isn't required by POSIX's find(1), and
> > busybox(1) doesn't implement it.
> >
> > >From the original conversation, it seems like find(1) with "-type d"
> > could trigger enough "lstat(2)" to ask FreeBSD update mtime.
> 
> This rationale  makes me uneasy: why did Duy add _both_ `-type d` *and*
> `-ls` if the former would have been enough?
> 
> > Use only filter "-type d" for now.
> >
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >  t/t7063-status-untracked-cache.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> > index 190ae149cf..6791c6b95a 100755
> > --- a/t/t7063-status-untracked-cache.sh
> > +++ b/t/t7063-status-untracked-cache.sh
> > @@ -18,7 +18,7 @@ GIT_FORCE_UNTRACKED_CACHE=true
> >  export GIT_FORCE_UNTRACKED_CACHE
> >
> >  sync_mtime () {
> > -	find . -type d -ls >/dev/null
> > +	find . -type d >/dev/null
> 
> A more conservative patch would be the following:
> 
> -- snip --
> commit 1680a64fae24b1073dbf1b844889a9953823b7a2
> Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date:   Wed Jul 19 22:13:16 2017 +0200
> 
>     t7063: when running under BusyBox, avoid unsupported find option
> 
>     BusyBox' find implementation does not understand the -ls option, so
>     let's not use it when we're running inside BusyBox.

Yes, this patch is a conservative patch.
In v1, I went with "-exec ls -dils {} +".

And, Jeff worries about a lot of flags passed to ls may run into
compatibility issue.

> 
>     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> diff --git a/t/t7063-status-untracked-cache.sh
> b/t/t7063-status-untracked-cache.sh
> index 190ae149cf3c..ab7e8b5fea01 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -18,7 +18,12 @@ GIT_FORCE_UNTRACKED_CACHE=true
>  export GIT_FORCE_UNTRACKED_CACHE
> 
>  sync_mtime () {
> -       find . -type d -ls >/dev/null
> +       if test_have_prereq BUSYBOX
> +       then
> +               find . -type d -print0 | xargs -0r ls -ld >/dev/null

Can we just change back to what Duy proposed time ago:

	find . -type d -exec ls -ld {} \;

> +       else
> +               find . -type d -ls >/dev/null
> +       fi
>  }
> 
>  avoid_racy() {
> -- snap --
> 
> I have this in Git for Windows' fork, although I have to admit that there
> is no CI set up to verify that this is all working as I expect it to.

I'd find some time (later) to setup a Travis build with Alpine and VoidLinux,
mainly for musl check.

-- 
Danh
