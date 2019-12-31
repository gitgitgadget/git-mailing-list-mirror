Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C52C2D0C3
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 00:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F0620722
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 00:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpvA3VmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfLaA0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:26:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43554 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfLaA0K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 19:26:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id k197so18782663pga.10
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 16:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aWZw1yJiNWGUrhYseyrZ2+kVX0pFw9qZPeTp2bAT3RI=;
        b=mpvA3VmPE9oM8TR8aXOFlw9ieWnCd2BdtCE576P5Fr06X1piuVX7tnVt9yjYARJMEw
         iITjjNoXfcNsn8OfazJIRyYYdB526c0EaggE7AC/diM91CtXapAALmtY3xfVMxsrz08m
         B78c8w1KQxHBxXUN5dfXZRn2eEC+E1hijmY9LEfRdBo59U/+n9asDcfsTI3k7+GPA9hS
         OGJ9GQvkMbnLdyttxZB+0GUtar1zkekIuABEYQgu2mfGyo/a15YBMxQiEGz1zEMHmtAC
         xQlyUppO5KHmtYeth53VtZJR928nzumTWV66ra0EsBdlJNJ+uq0xnf0FRwunhnkBQrBn
         9l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aWZw1yJiNWGUrhYseyrZ2+kVX0pFw9qZPeTp2bAT3RI=;
        b=rcDzm0u5jr2E90rwZ0iNB4xAs9cOuPJHhaiYN7YB9sAKxyxV0wV5B9wyyVpLbb/Qo1
         viiCbECmHZN4zGRoVFzQUtZ9Oi4CoxLF/o/ziAeBXy1SIrBfg7xoJ4sKTSNLj/YaGaVz
         iJFYk8PP3Lx3qOJVaGcUWmwf1gd9WLR1rIbc3EcOl91HtlFILvXfs7SzKxd1qpkhqR83
         5ebV9FmYYtmioyupL7h/w6JIJGCq2JsFc9n+IGSj9ngPari+NW5bxcWDRrFu/Ve+V8EQ
         0mrNmENFfzck2PWSvw6Vdxf3HKGeu7i9wrWy5V2ZqKeo1q5UdVTe/FncZAWlAYP7+DtF
         JTUw==
X-Gm-Message-State: APjAAAXUXTr5n+qaRJ9eXOtiCqfUVp4QVksgMvpsCcXJiHzdqC6wODY0
        3u13P7wfZ2gExirvtCay9nk=
X-Google-Smtp-Source: APXvYqxvcXE2oHP6csX27DTfw0ZMhPzSGcnPK54pRykiktFxfXmETYZ8dF8kDfiTDnlW67Tj0IC91w==
X-Received: by 2002:aa7:946c:: with SMTP id t12mr65354862pfq.137.1577751970206;
        Mon, 30 Dec 2019 16:26:10 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id y14sm34127949pfe.147.2019.12.30.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 16:26:09 -0800 (PST)
Date:   Mon, 30 Dec 2019 16:26:07 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] t: fix quotes tests for --pathspec-from-file
Message-ID: <20191231002607.GC13606@google.com>
References: <pull.503.git.1577727747.gitgitgadget@gmail.com>
 <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
 <6193dc7396b9cc6cb78f382c1b1679d6bb455fe4.1577733329.git.gitgitgadget@gmail.com>
 <CAPig+cSSqAxuHYg9DxuJzC7m2HAt8F2YPNxT0x5+SksCGic4MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSSqAxuHYg9DxuJzC7m2HAt8F2YPNxT0x5+SksCGic4MA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:

> But is the "no newline" bit indeed intentional? If not, then a simple
> echo would be even easier (though with a bit more escaping):
>
>     echo "\"file\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&

For portability, that would be

	printf "%s\n" "\"file\101.t\"" | ...

because some implementations of echo interpret escapes by default.

Thanks,
Jonathan
