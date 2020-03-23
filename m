Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BCC4332E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7283B20637
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7hQQeyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgCWSwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:52:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40710 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgCWSwM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:52:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so6290480plk.7
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ucp7IiouhInoRCE5AswS2Unkkitb2c7F8fTADCTVXDE=;
        b=C7hQQeyCSJGxSGExGrZVp8cBQeduPhSwYkEegjkrnzPSB7YGGwf6Q1fc9KsJGVnPfo
         blbIA9P0EpQwpQTsMzcWvpaWpeiQY26NHeJb81witsdoC/1RKlYOCQISt6OmJjpLb4tP
         HYD5OApKnAjPc5o6Nz9poSukgJx8FnjdoJDzOMz9QqSIAZGf7ZoQ8kB8EhGRrxRK4T/g
         jsHjcayfRoTNCHKo1mFekPqKnahqUr+ckLtKmn6LSygnMTUqxDtQAZBSw3nHvrJWQK3H
         UZJiy42mQ8laAgsRS9j7hzoXjZLBkH3AAZGuv9PNj1eqEUe5WdvYe8KbQaN8bEOyzh/R
         XIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucp7IiouhInoRCE5AswS2Unkkitb2c7F8fTADCTVXDE=;
        b=JsaB+tyKQ8Fx/7688yHrzS2kfj5rkqgXq9cPGyfTRAUBf5Zq/2AHQHGEUYAKSl+8to
         2kfu0R/bHXhsbcT5jslo71QNk8Rd2mZkfWN9bNY31/NgNhsovf86G6Ge2bNdhjsGu0Nf
         mF4Hom4BA2lnRkkUBrHcwn1MjgrupGp9FCSVEdB5gavc0qlb7IsRZIcj5QsxQVXkL66Q
         z6pmkSvZtWEIHJgjm9q9XBeljcqpR9M+XEmEH9tKy1r0ZHZi4YU923U23vjMJzk8K2dq
         vVHEARGNbmns6DW18+AByyfbxFJk5BQFekPaPonOg8TGerGY3++z3Qg19Uo9hFk2QLMY
         kENg==
X-Gm-Message-State: ANhLgQ3OGapXjh32nkYUnqwPyNX+PeVhnFsRqRLUlSHEy+Lgmf2OGB+Y
        G2ZgsWl4iz95Iw5wfPaszOQDXw==
X-Google-Smtp-Source: ADFU+vt3VO1SN3YxrCn1jAwmsqT4w+EUmCrMJMtBn8GRzChJhpdI2FEmMt+Y3MzHycGRmDF0L1XBvw==
X-Received: by 2002:a17:902:9348:: with SMTP id g8mr23320283plp.112.1584989530918;
        Mon, 23 Mar 2020 11:52:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id j14sm1921424pgk.74.2020.03.23.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 11:52:08 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:52:03 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
Message-ID: <20200323185203.GD45325@google.com>
References: <20200302230400.107428-1-emilyshaffer@google.com>
 <20200302230400.107428-3-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
 <20200319213902.GB45325@google.com>
 <xmqqd097dg4k.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2003201633560.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003201633560.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 04:35:45PM +0100, Johannes Schindelin wrote:
> On Thu, 19 Mar 2020, Junio C Hamano wrote:
> 
> > In any case, I think we've wasted enough time on this.  Let's see a
> > minimum working version that won't break/affect the rest of Git and
> > ship it standalone.
> 
> I still disagree with that, but it seems that no amount of arguments will
> convince Junio, and he's dead set on the standalone version.

In this case, I'll leave the build settings alone and focus on other
comments on this patch. Will try to work on it today.

 - Emily
