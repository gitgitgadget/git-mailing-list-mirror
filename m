Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 6927 invoked by uid 107); 24 Aug 2009 08:34:05 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 04:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbZHXIdp (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 04:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbZHXIdp
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 04:33:45 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:48327 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZHXIdp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 04:33:45 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1242652qwh.37
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 01:33:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2DX5s383rGN3asjA2ZscqHFnYAUDgSe39K0+Xpybazo=;
        b=w1Vde5gnPwohCd4Ts4a/JmZWrYmc5Rwq9T/wAM9GgmguHjfNa4xnuzJE1MX3/zJmaE
         9J33nFP/QhEkLWa8skaJMYTfBBe3XRus/Z+45OKdacTI8TfFHoGojOQKnq6PUpZ6Jrch
         WyA5M99Ixp3me/k9obJcYHvqqTaYeHjyraGvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O/W68CwBeSEgHd/xEj68kuJ2nCSxu+AceHCwPri/ZyPLiSvZwH+sW0FGUQzQVLuZmD
         1eqolWkehLgpCdcGdzBS7fMy4oQ8usmAZsWr+uU1chVsf318GcRFhHTtdGHVg303xilR
         JVxPhuF2Z/6MKS5OMeZ+MEbYeidZ0dg6QweA0=
MIME-Version: 1.0
Received: by 10.224.22.212 with SMTP id o20mr2495384qab.164.1251102826148; 
	Mon, 24 Aug 2009 01:33:46 -0700 (PDT)
In-Reply-To: <4A92476A.4060205@microchip.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
	 <20090824060710.6117@nanako3.lavabit.com>
	 <4A92318F.6050105@microchip.com> <200908240946.52813.kai@samba.org>
	 <4A92476A.4060205@microchip.com>
Date:	Mon, 24 Aug 2009 01:33:46 -0700
Message-ID: <2729632a0908240133t12eaafd5oe8d50af6d6eec566@mail.gmail.com>
Subject: Re: Pulling one commit at a time.
From:	skillzero@gmail.com
To:	Sanjiv Gupta <sanjiv.gupta@microchip.com>
Cc:	Kai Blin <kai@samba.org>, Nanako Shiraishi <nanako3@lavabit.com>,
	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 24, 2009 at 12:55 AM, Sanjiv
Gupta<sanjiv.gupta@microchip.com> wrote:

> What I would like is to "test *every* commit" available in the public
> master. There would be no local changes or commits that aren't pushed in the
> private copy.
> So I just want to clone one copy from the public master and then just keep
> pulling commits from the public master one by one and run regressions on
> each one.
>
> It's a damn simple thing in SVN world.
> $ svn info will give you the current version you are at, assume it is
> "cur_rev"
> $ svn update -r `expr $cur_rev + 1`
> $ build
> $ test

I'm not sure if this is the best way, but you can use git fetch to get
the latest stuff from the server without merging it then you can merge
from origin/master (i.e. the server) into your local master, one
commit at a time, and verify at each step:

$ git merge `git log --format=%h master..origin/master | sed '$!d'`
$ build
$ test
