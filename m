Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8669BC43217
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 06:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiDYGHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 02:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbiDYGGT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 02:06:19 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF2565FB
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 23:03:14 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id kk26so3110209qvb.6
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 23:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FoplfoD5hEp69VYnu/e8E+V3JeyImgVO5QDpZBRrcBE=;
        b=pDRtASXBiJNZV2A002mUTV/kaHtDmErka+t2x1zNuLyD8WZAHFR8sJk+gYA6ttvVOl
         frtpxgmMi7XSup8fUYil5cIO0c/J01hMkpE8QxZwx0Y8+6bR+JSze1yXOLnHuuBysbY7
         iU3RCwvUGE0XPXsiF9hg4U+cP70FFfIpK8hlNheIwhCkEHpRHHMED3OuDQ1goVFQHe9+
         pPyPjOT3qla2R6Zj68Lj0i4INkO3optM7iQET6HCTfKZu50gcDHyNeNHOorDmwOJdZEP
         KrsP/gskcw++pwwRpfEkz0cH0OubGZuGepOPAHO0bsnpVKIZZndJe1W0NEx4Fqk5W065
         lvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FoplfoD5hEp69VYnu/e8E+V3JeyImgVO5QDpZBRrcBE=;
        b=nSsA9X8vLHUSOEBdrpeWLV/WzAN7fpaEAmcn/4rcdwLn73o8B9Bq71LfHx0OCwNDUR
         VgigtukWTHSIU6RUhW6yAp57pRbaEc2wMgo6ak5G6xxWn5pB+GYyEBMckhy5MWUDGPqp
         4W9961DWf8UEi4HxmS7vyV82ji69/zWF/grTs+JGyuppKzGFZ6XLSKbJv6itNRV50e3q
         AuwkuNettKtvdFR0lO5ng9GLmbqjWn0jG1jivb9LmvCdrMmhj6wkIt4Yt3ddatjXJrU5
         VpAUDy69gxEjzxuzv6ePLVBScUW2vPGkztGs/pPIcT29YLeLbk7nFWkpzG+qw7qUsSK1
         Svlg==
X-Gm-Message-State: AOAM533qxvZL+96JLLcwpYsAkfOIfccSLcvxVnylY/1xM8q3E2jbra74
        iZCWc3ld3rclb+XLAnucUfM=
X-Google-Smtp-Source: ABdhPJyDd5b6VqxFPIJrE7Mhsc8WYa6yUS3FuZOH9OOUa/qfpLnDBXAze24JEFbS6hE4bjkwaOOGdg==
X-Received: by 2002:a05:6214:2a4c:b0:446:738c:f733 with SMTP id jf12-20020a0562142a4c00b00446738cf733mr11269741qvb.121.1650866593274;
        Sun, 24 Apr 2022 23:03:13 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05622a1ba500b002f1f9a0d79asm5549544qtb.11.2022.04.24.23.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 23:03:12 -0700 (PDT)
Date:   Sun, 24 Apr 2022 23:03:10 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
Message-ID: <20220425060310.57tzqjopniul7h5p@carlos-mbp.lan>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
 <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
 <xmqqczh73hns.fsf@gitster.g>
 <xmqqk0bf1i12.fsf@gitster.g>
 <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan>
 <20220425050549.GA3280@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425050549.GA3280@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 25, 2022 at 07:05:49AM +0200, SZEDER Gábor wrote:
> On Sun, Apr 24, 2022 at 07:01:08PM -0700, Carlo Marcelo Arenas Belón wrote:
> > On Sat, Apr 23, 2022 at 04:44:57PM -0700, Junio C Hamano wrote:
> > > 
> > > Actually, not quite.  when "git" runs in "sudo git", the real
> > > identity has long lost
> > 
> > Right, but in this specific case, the terminal is still a good indication
> > of who the user is, so the following would work.
> > 
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 58fd813bd01..5d5d91688ee 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -442,6 +442,11 @@ static inline int is_path_owned_by_current_uid(const char *path)
> >  	struct stat st;
> >  	if (lstat(path, &st))
> >  		return 0;
> > +	if (isatty(1)) {
> > +		struct stat ttyst;
> > +		if (!stat(ttyname(1), &ttyst))
> > +			return st.st_uid == ttyst.st_uid;
> > +	}
> >  	return st.st_uid == geteuid();
> >  }
> 
> Our 'GIT-VERSION-GEN' runs 'var=$(git describe ...)', so standard
> output is not a terminal during 'sudo make install'

didn't realize the orginal report was coming from `sudo make install`
in git's own repository, but even that worked for me.

when I meant the original case I went with an artificial test where
I run :

  $ mkdir -p r/t
  $ sudo chown root r
  $ cd r/t
  $ git init
  $ sudo git status

and I get no error, unlike the original version of the code.

of course, part of the "extra work needed" is to figure out if stdout
is the best place to look at, I chose it just because that is the
unoficial way to signal in our code that we are running interactively.

note that usually unless a pipe is involved or nohup is used, the tty
is still attached to your process.

Carlo
