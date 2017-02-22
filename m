Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D85E201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 21:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934800AbdBVVQi (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 16:16:38 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35701 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933679AbdBVVQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 16:16:36 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so1917456pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 13:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rIKX9/NwjJnI8U0/rO5meOpUWAyGOwiF6OUBfbw7SiQ=;
        b=pq/1J4CxdR+eeCkNAHb7EVIezR1EOqvuZwiME0MLVQBFt9RNzg4+bRDLWxdSNLGiSe
         D/5FvkL4sB5CWEd4OfjsOw9j+veXxTZ9DxqEZ+NZBHoioMkwDAHPSR3W6d8nzLAuSdkm
         ENaf+mfZirfQhyUQpeP31HIuaq9EJ8wuynRVo4T/BQC2PiX/yELs6l/qcq5aZS00DpAC
         k0TYVQxpy0NPdJTO+ucM2iSIrotYor5LhylyoXvEp2Bir1RKbIWhV5tJ6PmXuDbBL0FQ
         d9qVjk7iBhycB2Xf5fX8ATFzpnTzj3pLgexst52x+YKMFnQbD06QaRQq1q1MT7a1BIj9
         SECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rIKX9/NwjJnI8U0/rO5meOpUWAyGOwiF6OUBfbw7SiQ=;
        b=ZBcmGYK/mmjAFSWt82J8420nMkEk+IcR5oCRItrarL8HOuCc1WQhZtSMIGM9SJUtUF
         ACoq58LwySYvgM39Ly7/5Voyre5bKX+5TC6WX+3b7E6Ek9j8/ZPhC0XsFIkvFVJ1RHRQ
         GNMWz/jsxifLlmce/QvDKnwpgtFzV7YN3/NuTDq8sfmtmchTZySxl+lF9m7unJCvis9t
         QAi+2ix6a5FXdpLB7mCukazvVfOVT9v6apeDdKgyyzAt35Og2uIZwPS1wodgtBiL9ksm
         cGhNHc3jmKXBChRmqPfa98L3pbvasEKB5avdSMnLv3h/lABOUz2GKEkombUGS3Q9eYk/
         3ZfA==
X-Gm-Message-State: AMke39kcu9a/hsd8BZD1ze81dNBkLe+/cyPenjZE6XQ7koz1I2mOMi5a/XTq3KT+FM3KkA==
X-Received: by 10.84.254.66 with SMTP id a2mr49963928pln.57.1487798195364;
        Wed, 22 Feb 2017 13:16:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id s20sm5394306pfg.11.2017.02.22.13.16.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 13:16:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sandals\@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
References: <20170222173936.25016-1-dturner@twosigma.com>
        <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
        <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
Date:   Wed, 22 Feb 2017 13:16:33 -0800
In-Reply-To: <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
        (David Turner's message of "Wed, 22 Feb 2017 21:04:14 +0000")
Message-ID: <xmqq8toyapu6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <David.Turner@twosigma.com> writes:

> Always, no.  For failed authentication (or authorization), apparently, yes.  
> I tested this by  setting the variable to false and then true, and trying to 
> Push to a github repository which I didn't have write access to, with 
> both an empty username (https://@:github.com/...) and no username 
> (http://github.com/...).   I ran this under GIT_CURL_VERBOSE=1 and
> I saw two 401 responses in the "http.emptyauth=true" case and one
> in the false case.  I also tried with a repo that I did have access to (first
> configuring the necessary tokens for HTTPS push access), and saw two
> 401 responses in *both* cases.  

Thanks; that matches my observation.  I do not think we care about
an extra roundtrip for the failure case, but as long as we do not
increase the number of roundtrip in the normal case, we can declare
that this is an improvement.  I am not quite sure where that extra
401 comes from in the normal case, and that might be an indication
that we already are doing something wrong, though.



