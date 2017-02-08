Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D121FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 23:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbdBHX1j (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 18:27:39 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33509 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdBHX1j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 18:27:39 -0500
Received: by mail-pg0-f66.google.com with SMTP id 194so16072713pgd.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 15:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=aJkMlmAOA8VSHwLylMX7t+5UfWGQUShItlKC4BAtM98=;
        b=Xc6SqWh2ycp3QEhVVpVn06+ZSEY4a4X6h/wLZLdLW2P5mxbLJE5BziL17JcYXx6oA2
         nqWnd8NYiBK2CDZSvhG8JiPeOg1Tb2VVjQFBvfk27TYOBaIT3pGPbwlOcIHuQV05jLJ1
         cIcfY/SBha6B5CxTXWWNoJpeu4Mta8rhWyOle3Omow+xL7dDeusT8186I+CH/qkFY0rx
         6zfuKrJi5vrgT6j+M3oFk3uwB2dQQ7vqLBFDMiTC6jAEm7ZvwYJwsQ3rwAGVTVgkp5MM
         9Sycili0Li5szSVqak2b2czYsOpWyVSXLYyvXNluVMOgUiwlOnoVVo7zfkUQjFjMqfL+
         a40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=aJkMlmAOA8VSHwLylMX7t+5UfWGQUShItlKC4BAtM98=;
        b=R3NrWweSM5Fgp2W74IaSyyIPhrWYJxcCyGAne0GPsL59vzmzwxLdRQCWSEWOeAgOX3
         yXf1qtio6YseNG9dEIxDcaLUkrPuLjxfkulYurPoz6XWBApeJ9ScsGWxsZkzVhuWEd9C
         yJsekqlGEKWFQba2bq8kJvWY4L7aZZOBy5zm0B3AFiS7WBIKN/5rjCXxN5neKADLLMwV
         Bm4lVEnPmoB3pfUhS9h7ERWe8TRDHFXZDlTVv0iVH8eDXxErSfmPXfbjkbbCP3NOOGZl
         53xUoHqb5MLz2xEZAO7GjgiNyoe2i3y81x/2E4xhbCv66HYzoXBT5Db2YFEaEWd18zIJ
         kxvA==
X-Gm-Message-State: AMke39ntCZTJTX3SwxqlAfGJv0JhmeyW3FFuxu4v4CHn2/q/P0CRtI1vusR8s2m/0D6LJw==
X-Received: by 10.99.54.196 with SMTP id d187mr92717pga.91.1486596360625;
        Wed, 08 Feb 2017 15:26:00 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id s26sm23051686pge.33.2017.02.08.15.25.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 15:25:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] worktree.c: use submodule interface to access refs from another worktree
References: <20170208113144.8201-1-pclouds@gmail.com>
        <20170208113144.8201-3-pclouds@gmail.com>
Date:   Wed, 08 Feb 2017 15:25:59 -0800
In-Reply-To: <20170208113144.8201-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 8 Feb 2017 18:31:44 +0700")
Message-ID: <xmqqr338tgc8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> As such, we can just linked worktree's path as a submodule. We just need

Lack of verb made me read this three times.  "We can just treat
linked worktree's path as if it were a submodule"?

I agree with you that the "submodule" in the name is misleading.  We
would want to be able to walk refs from other local repositories
(and repository-like entities, like the .git/ thing in a liked
worktree), like our own submodule, or the repository we borrow
objects from via the alternate mechanism.
