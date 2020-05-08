Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2BCC35280
	for <git@archiver.kernel.org>; Fri,  8 May 2020 00:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B91D208CA
	for <git@archiver.kernel.org>; Fri,  8 May 2020 00:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzSINbrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEHA6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 20:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEHA6U (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 20:58:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92B9C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 17:58:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l25so66017pgc.5
        for <git@vger.kernel.org>; Thu, 07 May 2020 17:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UhmndiEfOklRGmiQBIHSqX/GUEA5afFuAQKQIg2/RiI=;
        b=LzSINbrD7B7cHxqB+/u3tTUgus8R57hREq90hnq/SdCZETUrAeh8c7Bv+vO042tLT0
         Txb25APlhRKQlSNVIlcheWr46FpD97UFoilALl1za+taGi9YbzqfxZmMavrm8GAiQrUF
         VMfh+D1KTUh55jBdfiX85wrLF/Yznhq3CBdHIP7uOMn1ozVBnTvofMfvCfdZX/JFDhNX
         MDPKRSsSWy2j6zR5JY6MclVsuN4DK5upThbmipOHmNM8IJ+CAnxvUFlaoQfAhxnaN8l5
         IoAe1RdtUx2cKXMTMlbGLyK7KdD37ryX+LRLVWVfUZRSmxQ98WZmwM4pvX8TAk/a6TuW
         UU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UhmndiEfOklRGmiQBIHSqX/GUEA5afFuAQKQIg2/RiI=;
        b=pN6uudUqY99QEUShcr2ccxxfyb91iUTpCZBrySZX84syvSJYhofeLdRYNBcmFRM1t6
         JCnnIi1DwnKmWSL75CA9w67XDBxVeyuOrfA+PL3lcdgSfv/2ONqlhWGt6x0WHFcWBlr0
         K4f+vlPLvYgTEeNMi9xTdpMhP28VPIoTzZCv7dWjunf7sKgs88Zi8x29yi+Xm+9syDkh
         1cog/NI3RDRO5yJ/EM0Jmn0bFrWgLXG517XajPO/5cG2wkRn/Qxb2HqbODpnfsPZXz65
         KUSNwDCCpuyGjXfPbfH0qNNtik+rx4eW5CnNG7uP838r7OSAGs0PI/l3FGNuidWO38NS
         ueKA==
X-Gm-Message-State: AGi0PuZGD44qlK+zyxCMRZY655jEbk1lHH34jAbcY/G7D4B8rjYXne5y
        FIFjNYFscL8oRTh2xsf3y1I=
X-Google-Smtp-Source: APiQypL0eGNuTBdnX98yUi7bi8VvWTVY/1/sslNrdoH2lTbewk3tRmu4cnnCBc+KOpFC/oSxA1QYsw==
X-Received: by 2002:a63:4761:: with SMTP id w33mr13907663pgk.103.1588899499941;
        Thu, 07 May 2020 17:58:19 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id i25sm5945458pfo.196.2020.05.07.17.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 17:58:19 -0700 (PDT)
Date:   Thu, 7 May 2020 17:58:17 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com, gitster@pobox.com
Subject: Re: [PATCH] t/test_lib: avoid naked bash arrays in file_lineno
Message-ID: <20200508005817.GA24664@Carlos-MBP>
References: <20200507055118.69971-1-carenas@gmail.com>
 <nycvar.QRO.7.76.6.2005072139300.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2005072139300.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 09:52:12PM +0200, Johannes Schindelin wrote:
> On Wed, 6 May 2020, Carlo Marcelo Arenas Belón wrote:
> >
> > Enclose the bash specific code inside an eval to avoid parsing errors
> > and while at it, simplify the logic so that instead of traversing the
> > callstack just pop the two topmost entries that are required.
> 
> I would be okay with that, but that's not what the patch does:

FWIW that was the intention, but luckily Junio quickly predicted it was
most likely buggy and so has been since made obsolete by:

  https://lore.kernel.org/git/20200507175706.19986-1-carenas@gmail.com/

> > +	eval '
> > +		local n=$(echo ${#BASH_SOURCE[*]})
> > +		if test $n -ge 2
> > +		then
> > +			echo "${BASH_SOURCE[$n - 1]}:${BASH_LINENO[$n - 2]}: $1: "
> > +		fi
> 
> This loop is completely lost here.
> 
> Now, you could argue that your version is better because it avoids the
> loop and always shows the ultimate caller in the backtrace.
> 
> However, I would then immediately point you to `t/t0027-auto-crlf.sh` and
> ask whether it is all that useful to the `commit_chk_wrnNNO` call rather
> than one of the five `test_expect_success` calls contained in that
> function.

as I said originally, I thought it would had been even better to be specific
up to the line number of the instruction that failed, after all we already
have the whole function code for context in the message.

> Besides, you simply replaces `${1+$1: }` by `$1: `.

I couldn't figure out why that was needed, but while I am just slow, this
one is actually genius!; you are using a shell parameter expansion (which
is even POSIX sh compatible) to do string concatenation!

conditionally, noneless and not even using a silly if (like I would have
done) or a bash += concatenation operator.

> Again, you could argue that your version is better because there is now
> only one caller, and it always passes `error` as first parameter.
> 
> I would not be _too_ happy about losing the logic that allows calling
> `file_lineno` in other circumstances (I found it valuable for debugging),
> but _in the least_ you need to talk about this change in the commit
> message. Just changing the behavior without even describing, let alone
> justifying, it in the commit message is a bad idea.

fair enough; but in my defense, I couldn't had been made aware this was
being used also for debugging, or called without the parameter or even
called in a way where it will report its own LINENO (which you clearly
explained before as being the wrong value to report and that lead to
my confused first attempt at porting it)

thanks again, for your insightful feedback, and guess then there is no
more point on trying to simplify it further, and if you could ACK my
other proposal, hopefully neither a need to find workarounds to running
tests on NetBSD for the current master.

if we decide later into improving the accuracy of the report, might be
worth documenting some of what I learned in the commit message, for the
future reviewers, who hopefully will be less thick headed.

Carlo

PS. I know I botched the v2 git send-email, so you didn't get a CC, or even
    have the v2 in the subject, hope it would be still good enough but let
    me know otherwise.
