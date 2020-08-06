Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF98C433FB
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5C222D6F
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGFxHnX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgHFIuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbgHFIuv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 04:50:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8B7C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 01:50:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y206so14260356pfb.10
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WKFKbleIsBnS0KKqm5zJQuSZnMAuW6sTZ9cMNbVSrG0=;
        b=UGFxHnX2V+ZCegVe58Z4qOlPVctX1ID1tLjdlx+N4vKBmKSOaHl3yDvMTINKGFCkjf
         mypP4KsM80+9xqK3Gy/lTgBQuVO38zufBwL9vqIGPnS9bejLNUBqOvVxtm0vQaSDPnoS
         bgacXXmX90nGLjlhR1fJj0aO8qOPF2/Osnmx9/ER0fl9EekxdzQ1FIROJkNXYIyAdBwy
         ZbpcjA44yXf3ZANyn2I651nKTQF7C6qW5QZeptY1NEftKO0811mRNjSfPsE1niVLsY9X
         W1BDQ4fM6hcGtiQZsm+NVqLa9ldUMuNQMO3pq2yMeaRXSoInm1FhA12UDAyO/TRRYV+n
         ST7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WKFKbleIsBnS0KKqm5zJQuSZnMAuW6sTZ9cMNbVSrG0=;
        b=KHeCvhUgLvPk/p9JM/MLovnP0yisFcIuhALVvv0Qs/9h5bKFEH1ahfM2jqjhaM6MZv
         1Z6r+ns7in7TNJlSKkFqHyZRvbILHd47rkBLrxUxvbvlMTyTd2bOe5seozBXLRXJL05X
         8ct5RzzbQTW33QbE8J9RGgeNJzASeWZqoBRXZWBkuu0uKg2giZE6++kp+lazEVUildWo
         7g3oiV9jHIQbe5kOU9o3ivtpfDtbiDUAO0Vl8uEWTEiYW8FF8SQPWlVX15GAd7xjOFai
         SRxxWWVMysPqAbIOC2k2gIji3RgdkWsYd4AZHIHAKz7Dgwtuls5KB4MMozMF06bntgM6
         CPTw==
X-Gm-Message-State: AOAM532y11roA8MxFSRgXQ5ZKC/inNPtjw8QaeHnh4qBnFRa2lFiI2Pe
        3e2G6DNGBkqt8J1ktXGk6k7F6kfG9T8=
X-Google-Smtp-Source: ABdhPJwUaAQcaGhI1SDEbZOOQOQGKQ5OkpWgNAr9Pi0FkbDTzYSKefHmNodt6K4ZiMv3Q4sIjp/vmw==
X-Received: by 2002:aa7:91d3:: with SMTP id z19mr7035014pfa.119.1596703849880;
        Thu, 06 Aug 2020 01:50:49 -0700 (PDT)
Received: from konoha ([45.127.46.60])
        by smtp.gmail.com with ESMTPSA id v77sm7710930pfc.137.2020.08.06.01.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 01:50:49 -0700 (PDT)
Date:   Thu, 6 Aug 2020 14:20:43 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        chriscool@tuxfamily.org, liu.denton@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH 3/4] t7401: ensure uniformity in the '--for-status' test
Message-ID: <20200806085043.GB13942@konoha>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200805174921.16000-4-shouryashukla.oo@gmail.com>
 <xmqq3650ok53.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3650ok53.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/08 02:30, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > The '--for-status' test got its expected output from stdin. This is
> > inconsistent with the other tests in the test script which get their
> > expected output from a file named 'expected'.
> >
> > So, change the syntax of the '--for-status' test for uniformity.
> 
> There are a handful examples in t5401 and another one in t3700 that
> give the "golden master" from the standard input.  When the expected
> output is used only once, I do not think it is particularlly bad to
> have it this way.  So,... meh?

I realised what you were trying to say after checking out t5400 and
t3700. I understand that this change may not be immediately needed but I
think it does make reading the diff a bit easier since having a '-' as a
file name does get a bit confusing when reading the output. If a
separeate commit just for this change is a problem then I can squash
this with the previous commit? What do you think?

> Unless there is a compelling reason to insist both are files
> (that may make it easier to enhance test_cmp in a certain way
> you plan to, for example), that is.
> 
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> > ---
> >  t/t7401-submodule-summary.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> > index 18fefdb0ba..145914cd5a 100755
> > --- a/t/t7401-submodule-summary.sh
> > +++ b/t/t7401-submodule-summary.sh
> > @@ -285,13 +285,14 @@ EOF
> >  
> >  test_expect_success '--for-status' "
> >  	git submodule summary --for-status HEAD^ >actual &&
> > -	test_i18ncmp actual - <<EOF
> > +	cat >expected <<-EOF &&
> >  * sm1 $head6...0000000:
> >  
> >  * sm2 0000000...$head7 (2):
> >    > Add foo9
> >  
> >  EOF
> > +	test_i18ncmp expected actual
> >  "
> >  
> >  test_expect_success 'fail when using --files together with --cached' "
