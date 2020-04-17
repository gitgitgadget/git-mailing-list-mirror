Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77820C2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 22:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB4D20B1F
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 22:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOrnjh11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgDQWEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726638AbgDQWEu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Apr 2020 18:04:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B102BC061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 15:04:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x4so4391403wmj.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LUe/xa2VtkLWUJ9UJx9k+B6LYSxQRG0qu1wrNEg6E90=;
        b=EOrnjh11yPsfYNRWnrtrP2CNdi8QOOqkIWjbnFzUIAWA2qBINoDtiCgSiJdUzx1wSi
         ti1Vn3cV57PehB8npF2ZGgDDSrrRsRJQnUy7SwYsbcB12UylHxquH172tX/By7phcqt7
         0ztI5NUrW7/hV4UNnwC9XsQmZ/so4tPcOVjn2pIxaovdBxj36OjGBo7Zd/F+GlUB6XNi
         V8ZjiCc9j6qvywYDdVYUZvc0u5DCBI2BZb4XX/Pff07TRIAVjOd8/DFp3QPHNMz1fndJ
         RLrKM3J2hzmMqN6y1z0Ut4nnx8XFm0bs9sQZHeHfZUHp0DRkT8WPxMqSmyrgU4tkWnFg
         BKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LUe/xa2VtkLWUJ9UJx9k+B6LYSxQRG0qu1wrNEg6E90=;
        b=XrOwvq5+nz4sk5UwxK8cIkcAW7Z594BqVwVzoQ4vCdabnyQvrKo9QkFF4vZyo/kDPp
         4PD9gm9qINp/n08eGlDpmKeZpzy7TXTGSNpM1mZK21v1auPW6Om+sj+2/q/5U/TxQQ/I
         hlJdetxjcMcT2F5eQ5vPiqVz8SOdOnx2zNumGOpUlk2c9BwJ7i8H79W2m0va3DqvnET1
         ztLikzRqmpEX9lgKS1/FQagLIHIq2WUGZZTcHGlQzUY6DPiK2TcO/Cu+68AZReVPajoE
         kTwlSlG8CRWzeUgeX433iqmg/Rx1kD/Y3h4SgUJQvmG+mxO9I7cTxgDv62otS1H2jEiB
         c4ow==
X-Gm-Message-State: AGi0PuZeXdPsOwQvw1w9jozFru7kZq52UL+mnoSDgqAR3Zw1h7icdMyS
        uw8BBWzu43+6PEeVEX76HCw=
X-Google-Smtp-Source: APiQypIX0i2pJQAum631jyYC44PYkEWeJblMX9KOcHti0xu4eItAaGIPkrOv0Dp0d6HcuKAHdquUww==
X-Received: by 2002:a1c:ded4:: with SMTP id v203mr5427413wmg.106.1587161088360;
        Fri, 17 Apr 2020 15:04:48 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id c17sm33855631wrp.28.2020.04.17.15.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 15:04:47 -0700 (PDT)
Date:   Sat, 18 Apr 2020 00:04:45 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
Message-ID: <20200417220445.sasjy4rvzonoz7cn@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Fri, 17 Apr 2020 23:59:19 +0200
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
 <20200416211208.xqnnrkvcl2jw3ejr@doriath>
 <20200416213009.GA1721147@coredump.intra.peff.net>
 <xmqqh7xjxeew.fsf@gitster.c.googlers.com>
 <20200416224708.zr4dlrz4hpaqsz2s@doriath>
 <20200416230554.bhk2yfycjwjpxggy@doriath>
 <xmqq4ktjxawx.fsf@gitster.c.googlers.com>
 <20200417125415.6o5avmae3cyvq4fy@feanor>
 <xmqq1romvx2q.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1romvx2q.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a quick answeŗ, I'll give a more complete one afterwards.

From Junio C Hamano, Fri 17 Apr 2020 at 10:30:53 (-0700) :
> ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
> [branch "master"]
> 	pushremote = publish
> 
> [remote "publish"]
> 	url = .
> 
> [remote "origin"]
> 	url = ../somewhere-else
> ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 

If you remove the remote "origin", then
	struct remote *fetch_remote = remote_get(NULL);
used by pull.c will return NULL:

it fallbacks to 'origin' which does not exist, so remote_get_1 in
	if (!valid_remote(ret))
		return NULL;
returns NULL

But is_workflow_triangular in
	struct remote *fetch_remote = remote_get(remote_for_branch(branch, &explicit);
);
returns "origin"

The difference in remote_get_1 is that
	name_given = 1;
So
	if (name_given && !valid_remote(ret))
		add_url_alias(ret, name);
gets called.

But I think that means that my fixup is actually wrong when a pushRemote is
set without a remote while 'origin' do exist. I'll need to test. Grmpf!

Thanks a lot for the thorough review!

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
