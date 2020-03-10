Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0491FC18E5A
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E1820675
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbcRrhp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCJRik (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:38:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46137 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgCJRij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 13:38:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so16950718wrw.13
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XPJw4xWckeaPKqBLaaOzSV60ydahNXYmjV35x+hsCmo=;
        b=MbcRrhp37KQ46XYAWyUuBfRnd4dLKEgqhUaB788fwHucMa5I8iNNwXlTPj2sJ3O5lf
         Bm8oZg9nqv5Kz72O0WlanfAIGoDq0BXdYD24+wewqgiGXrL633q4R6s8ZPN9A4CQq2KN
         2RStXZPSTOWA7psYFP6myaMzQ1QBpRjemxb/vx/vSNME9WH8M2VF+gQvScHGWT4CTyy1
         eKBED/AXAZHkqCA10X5MNNfJXcgN+kT1E0Irb+Y782/6ls2EOWBC+P0nkIriLX/F2ior
         r3OfJJQljXe518e2s6K3nK0JZZsGNC5teYXWBQsgaQOpuZpu/1gBsP36idnYzgPamwBO
         1Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XPJw4xWckeaPKqBLaaOzSV60ydahNXYmjV35x+hsCmo=;
        b=B2dlW4mSG2DJFJjr3CW3wX8VMVuG+qOhFdHpozURp3vCNJlvFKzQupilT0VjXVwEae
         YpPDswRGZbtv3asmgzZRsyDZc50lwk6aTC7lsXRvFyyKyLvVBcJ9dsWk35EVXwYJvFwa
         UF1xd+26sBFmdIINmKY8zanyaGS/YdKNMYCNfsXRHSX+OueL2xAvgaC/q7ok/AQCzqej
         LWneYFkO03MdOpDNpivx5pna2RWV9pjLpfN0v8HYr74vWGNaexIi8w5lo61xvvqoi8Qn
         V7Mv+2VzDQ8DVYtmw+83imWdgcd0a6wg1ErewsW49FXj/dkDov0pOKXIxoerAwAlKveg
         h0gQ==
X-Gm-Message-State: ANhLgQ1a+XqDdjI6kDW/7+3QldqKBB7JnNg63heBpZ1qkmToLYcNkRXV
        OcrqkDemIUo+b1R0dKsdaZQ=
X-Google-Smtp-Source: ADFU+vv2I0QnEwMMn1/YA0OUaiVWPxNB0xeQsaHxP84E4pk2nAmw9sM4Wh86l3VzoA6J6nlcH7mQoQ==
X-Received: by 2002:a5d:6985:: with SMTP id g5mr23780268wru.392.1583861917473;
        Tue, 10 Mar 2020 10:38:37 -0700 (PDT)
Received: from szeder.dev (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id 12sm4966148wmo.30.2020.03.10.10.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 10:38:36 -0700 (PDT)
Date:   Tue, 10 Mar 2020 18:38:35 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: yz/p4-py3, was Re: What's cooking in git.git (Feb 2020, #03;
 Wed, 12)
Message-ID: <20200310173835.GC3122@szeder.dev>
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2002131401130.46@tvgsbejvaqbjf.bet>
 <xmqq7e0qtqsm.fsf@gitster-ct.c.googlers.com>
 <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 01:18:52PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > OK, any one of you wants to do the honors of wrapping up the
> > proposed patch with a log message to replace the tip commit to allow
> > us to move forward?
> 
> 
> So the diff was taken from <20200123175645.GF6837@szeder.dev>; with
> Szeder's SoB (and possibly wordsmithing the log message) let's tie
> this loose end.

Here is the SoB and the wordsmithed commit message.

> Thanks.
> 
> -- >8 --
> 
> From: SZEDER Gábor <szeder.dev@gmail.com>
> Date: Thu, 23 Jan 2020 18:56:45 +0100
> Subject: [PATCH] ci: use python3 in linux-gcc and osx-gcc and python2 elsewhere
> 
> Python2 reached end of life, and we have been preparing git-p4
> (which is the sole in-tree user of Python) to work with Python3
> but we haven't told our CI jobs to use Python3 anywhere yet.
> 
> Pick two jobs and use Python3 there, while leaving other jobs
> to still stick to Python2 for now.

  --- >8 ---

Subject: [PATCH] ci: use python3 in linux-gcc and osx-gcc and python2 elsewhere

Python2 reached end of life, and we have been preparing our Python
scripts to work with Python3.  'git p4', the main in-tree user of
Python, has just received a number of compatibility updates.  Our
other notable Python script 'contrib/svn-fe/svnrdump_sim.py' is only
used in 't9020-remote-svn.sh', and is apparently already compatible
with both Python2 and 3.

Our CI jobs currently only use Python2.  We want to make sure that
these Python scripts do indeed work with Python3, and we also want to
make sure that these scripts keep working with Python2 as well, for
the sake of some older LTS/Enterprise setups.

Therefore, pick two jobs and use Python3 there, while leaving other
jobs to still stick to Python2 for now.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

  --- >8 ---


> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  ci/lib.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index a90d0dc0fd..c3a8cd2104 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -162,6 +162,9 @@ linux-clang|linux-gcc)
>  	if [ "$jobname" = linux-gcc ]
>  	then
>  		export CC=gcc-8
> +		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
> +	else
> +		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
>  	fi
>  
>  	export GIT_TEST_HTTPD=true
> @@ -182,6 +185,9 @@ osx-clang|osx-gcc)
>  	if [ "$jobname" = osx-gcc ]
>  	then
>  		export CC=gcc-9
> +		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
> +	else
> +		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
>  	fi
>  
>  	# t9810 occasionally fails on Travis CI OS X
> -- 
> 2.25.0-462-gba6e6679b4
> 
