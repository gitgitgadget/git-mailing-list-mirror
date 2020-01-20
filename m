Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96315C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 19:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE96217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 19:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H71ZMwIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgATTiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:38:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:49531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgATTiy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 14:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579549133;
        bh=a59AmPNvYiyfik1vvJe900sPdUylR/MR84uZB5nhdh8=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=H71ZMwIXKP0+mGpbf6WW/iLw8ZRMJkMyRkoRbAuAQMIA5wConIXUq66Fo6tn1tQcB
         o8sy9cBMEkj4Er4XsHhIk2mSlHDVyOb5ItMTcuQ2twwxWu1IdTlx9NBglDudOU9bra
         gEm6MBtJ0FnML5+DiepXSrWUuWZzJc6kQi5u51g8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1jGH8k3o6w-00Pz6Y for
 <git@vger.kernel.org>; Mon, 20 Jan 2020 20:38:53 +0100
Date:   Mon, 20 Jan 2020 20:38:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Y2038 vs struct cache_time/time_t
Message-ID: <nycvar.QRO.7.76.6.2001201555220.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ESYTf0OV47xBla3rdGwcRmcpDjbecTmz29rajW376pYYeNmC1EJ
 zNfVPqYhh1ZfGXSnaKyDXzFdcHAoI7SJRpnh3QuE92HpfIbmhsj2vlORPoVShVoOt87aPoW
 UdavlRoD26E8bHZTds78t/q4qI77duHo7QrKVXn8LCAFoi3gwwlPGRqe0XmI4xCjddrmdSC
 8KGAW7MwhMvst6x98fuFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h47R2k34F20=:6GleBG0jB8e2H77gxio7+A
 G+2JtfuB1fUiNetJ7J1G6VrAgjnzL2HBHKTkhlX29nNELYIIblrKV8vefHHr0lIT6m0SNJJr4
 Eaa1W3BILrRyYyuMv77DoU3Uv+mcktVb6rHafcd+i7/KKUEfh5KL3LspsP/d5pTSsfQv/iCDI
 YUihqS4sGQS78rjJyXLYyd6oD1OMewOsTbqI8cxtZhF/e6+RDhGkJ61w9VYWkCPtGsoPI6LRB
 NRae5YEgeP1F863m8QQ9h2NkyDacRnal/ViM5zfQ5aRZJcvo27a/421RaI/7wpdTmDG//JqxO
 zVj8d+jWlbeGYZVMpjVgayXqfRWc1FD+srJSyNZzS/5nq8gNIZalel6uyM3xZB2SBHPCc22mD
 KCYOQY+uClYIQiGc+/EIsN+O4tC1xdgU3nUExn9ZSKd6780N4iyuk29lAP4WMSdOv+CtMAQKA
 mCGUay4s4kXGjy8+DC+/PXlHgI/Tobj3btytTFBCssN9BhKNeJfgOk6vkyqTEXLM95wFURXji
 fYrVAYp1cKOIKB/BfmMsMJFwrVP3FylbRAhJv6qcLvAonlqmb2VmXXGn9yubAUxU+RsHunrTW
 jeKgGTKXt/LOZWxju3CN3eK5/gKGIbFW09SdeQysUAYql9tPZGO+metQ6mbOtQdSZvW4Fhisp
 S6M/MYqCPFvDtfAeN8Z1NN4uqHt3IpVoelEYBDThVUacKyURwPuP58JrfeVyuhI3GziDue98L
 wfK/NZf6zLDz5ZWjkutQ4Rl78vVlFfLUEG59P34LPGOPpw7m88bjJWF835z8a1vEXM0M6iknF
 rRUru6hiucAJ3I1K+BqBA+n6pk6VIEjzjfWcxz+vRcd+BJ5b1Bcv32MxvOjSBAfNHQv/Ss//u
 Z8Gzgyocf5QYkLuIm7prlOlAzpoq4+JW+F1LqFM24gBUEsA9r9nqCpmFZQEMeUXgMvNAlwVBF
 q1zyg/HGvDeN7YQpie2yYHWatx+BlqS14dWvuqVEWYLAyYmuWQ+GL945+LeTS+GmcQ+bR4Sd8
 f15IzboMNsSKJqY2PcAVUVJnS9y39lNFlUWj4LVLcGttH5IWPwZs2jZpA59sSEI8Ds2n2ckk9
 5CtFIaSD0jwH0KqhzzA3xc4p/3qI91FKE85zhyrsii3a3z7fNIVr5c6TRtQXz6AvOmky31Wmn
 DRUEHkOtZ79AYPyBjzk6HwiJBGwuQEV9F5QtNU15hmrjLisXSObRMY5wVNUg4bmMSh9os9rym
 qMs3quvyJso6mHzTgATvibR2l0+HH2TS/EIj9DC0gGMjkIJqz4UxYna92NbM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

today, in quite an entertaining thread on Twitter
(https://twitter.com/jxxf/status/1219009308438024200) I read about yet
another account how the Year 2038 problem already bites people. And costs
real amounts of money.

And after I stopped shaking my head in disbelief, I had a quick look, and
it seems that we're safe at least until February 7th, 2106. That's not
great, but I plan on not being around at that date anymore, so there. That
date is when the unsigned 32-bit Unix epoch will roll over and play
dead^W^Wwreak havoc (iff the human species manages to actually turn around
and reverse the climate catastrophe it caused, and that's a big iff):
https://en.wikipedia.org/wiki/Time_formatting_and_storage_bugs#Year_2106

Concretely, it looks as if we store our own timestamps on disk (in the
index file) as uint32_t:

	/*
	 * The "cache_time" is just the low 32 bits of the
	 * time. It doesn't matter if it overflows - we only
	 * check it for equality in the 32 bits we save.
	 */
	struct cache_time {
		uint32_t sec;
		uint32_t nsec;
	};

The comment seems to indicate that we are still safe even if 2106 comes
around, but I am not _quite_ that sure, as I expect us to have "greater
than" checks, not only equality checks.

But wait, we're still not quite safe. If I remember correctly, 32-bit
Linux still uses _signed_ 32-bit integers as `time_t`, so when we render
dates, for example, and use system-provided functions, on 32-bit Linux we
will at least show the wrong dates starting 2038.

This got me thinking, and I put on my QA hat. Kids, try this at home:

	$ git log --until=1.january.1960

	$ git log --since=1.january.2200

Git does not really do what you expected, eh?

Maybe we want to do something about that, and while at it also fix the
overflow problems, probably requiring a new index format?

Ciao,
Johannes
