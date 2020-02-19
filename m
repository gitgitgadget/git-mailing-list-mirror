Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C327C34031
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 00:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1714208E4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 00:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDywCmf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBSAAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:00:40 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:35173 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgBSAAj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 19:00:39 -0500
Received: by mail-pf1-f173.google.com with SMTP id i19so226264pfa.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 16:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJaJINAj2e6twFFDPbMPdm1vDSD8f2NqO1AkV6ZQXa8=;
        b=fDywCmf1Iw6cbcnXouTyeLw3llMfkX+Vp92x7OqRuckTLqZtCcHHagrqpUYqnAFcXY
         zP69mBGDxv5Srv9faT2MXqUbRV7rqbwX6fKvF9640qspmfkorypvp+rYp1KAa0bKCyhg
         pcH6c7fpyf7eRJxKvckV3BQNBGzG0l7Qs5b1jouZDTpfnEmUe5m+tj87rbj1mbBtlXrZ
         Sszaj19RQSzRjBdDv7dPND9aBXGySiGJZpofrw/Cow+FW8JSScV0/pgqgzdoDPyJ4DZ+
         tStWH6snTELdzvP0lcJxyoBbMdhGzSJw6p6u2+oPYAAmuEY2ULHqgdVREsKM1BGdilBv
         9Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=QJaJINAj2e6twFFDPbMPdm1vDSD8f2NqO1AkV6ZQXa8=;
        b=IbXisJUkviYvna6nytCsB3JsAuKAL/Ov5k29UK7t6QZuwukJzHGoyh8hQyeUqRFNVP
         DqtvMzUSJX8qoqInx0j+s2M0I1M48RIdTriehA4n3n1Pd3aqcKuowQeFNf9xy7W2VWRt
         6seLA3C2l+uu3fWI97KhChn2HKlYaC+TkA3wtT+EkfRFfsVMK10hcokbOvqqv5rWp6SM
         gsHlEpzWQ1ehTTNJw+wZPf7JHgLpc/MJgu5T2SCE/EO1qdHY7+fBrW3L1uC2HbUWFSFc
         1xCz/njF0xJ/omite6KE4CNubCsg+a3eh2dGKWPi2+AgWPG67iU5BQ3i4cH+0sbKEw3P
         27Ww==
X-Gm-Message-State: APjAAAV9SgjSUsanoV6F8NP7SPEQDHlLYs/3RmXUgGCnxRVxKC8zX+3c
        6AWXDMqAD/ibMA0lYfJ0cPg6Kg==
X-Google-Smtp-Source: APXvYqwbSK9fpt+gNeIzlr3w3AJCHySDw6PqCRK10I9j5/qL4KewLSV0QJY62cu6mxgv1TiYg1gMLA==
X-Received: by 2002:a62:fc11:: with SMTP id e17mr7287893pfh.207.1582070438929;
        Tue, 18 Feb 2020 16:00:38 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id z30sm125143pff.131.2020.02.18.16.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 16:00:37 -0800 (PST)
Date:   Tue, 18 Feb 2020 16:00:33 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Torsten Krah <krah.tm@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Eric Raymond <esr@thyrsus.com>
Subject: Re: Draft of Git Rev News edition 60
Message-ID: <20200219000033.GA12115@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Torsten Krah <krah.tm@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Eric Raymond <esr@thyrsus.com>
References: <CAP8UFD3fE-JHFweU+VM5xwEph7d6eUEFS23TLVsOrW6F+68QDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD3fE-JHFweU+VM5xwEph7d6eUEFS23TLVsOrW6F+68QDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.02.17 16:50, Christian Couder wrote:
> Hi everyone!
> 
> A draft of a new Git Rev News edition is available here:
> 
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-60.md
> 
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
> 
>   https://github.com/git/git.github.io/issues/410
> 
> You can also reply to this email.
> 
> In general all kinds of contribution, for example proofreading,
> suggestions for articles or links, help on the issues in GitHub, and
> so on, are very much appreciated.
> 
> I tried to cc everyone who appears in this edition, but maybe I missed
> some people, sorry about that.
> 
> Jakub, Markus, Kaartic and me plan to publish this edition on Wednesday
> February 19th in the afternoon.
> 
> Thanks,
> Christian.

A couple of typos and an IMO awkward phrasing, all in the "Git tools and
sites" section:

* In the "Github and Government" entry: s/Ggather/gather/
* In the "Shell Git" entry: s/that a practical/than a practical/
* In the "git-tfs" entry: s/no more actively/not actively/
