Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F521F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 18:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeKPEhY (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 23:37:24 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:37594 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKPEhY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 23:37:24 -0500
Received: by mail-pf1-f177.google.com with SMTP id u3-v6so7411011pfm.4
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=E2zN5qA/gbYerWNWINmIobxQHoBc10/BtDks+i9Q0GQ=;
        b=A7v58Bo63r4Pb5BeAVtrB4Q3c542uATYICu+l6nLcgmTB2LcDJ7nQlEwLN5iB0dD6+
         lxn9AD7k0vw0tLQCLDIAPZ+1ZXDIZUxgCdXQQb1hNFL4iZ6UNhjz4ITPvJymswV6Tukp
         ZNK8mi9sOY4AkMZX9nnxxqrk0Ydo/yRxGjTCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=E2zN5qA/gbYerWNWINmIobxQHoBc10/BtDks+i9Q0GQ=;
        b=LIDQDj6yOHcoZORupTE4fxuuKzOQEm1ewygBwT/CJW66ciRNHnOvmRPn8daBGqmos9
         I6mXs5N0E/CcziEVp/oxHyYllkqtew2w/vEg/ZwkTyb1b8Tl3oBw/f7vYjloLtEAt0+f
         bovJ05cx0CHINMLCGo46TKwxZC6bM4PQtDS58d3d6F7myStKotZ01hwllEFbqgN8OokL
         jzphitK0jpb+A8Rxycf1j/dpyomiAZsNz8bd2BqiJSJ26KKjMyhwJGlopQyAg6o0eLL2
         fd3d7D5Ml9kgXgFJs6Fife2K85yxVrfEWR6SPiicmlTH2IGEKdL39j2Zj5WwV716S6yH
         KLUw==
X-Gm-Message-State: AGRZ1gJlBFBndqpbYSGLupaguJvBIYIn1g6Vm1HeA786xU9fN59a8wB/
        VS+CS4xoB3ixSY8CN5Og2kxjYXgcK/BUYQ==
X-Google-Smtp-Source: AJdET5dPOq3sqCEr+ljhPkj3VlkuUcvWtluE1kft0N/LxbzVdrX3qCS/TNo4bO/QRWCdxCh2n2FA6g==
X-Received: by 2002:a63:2586:: with SMTP id l128mr6952749pgl.104.1542306509681;
        Thu, 15 Nov 2018 10:28:29 -0800 (PST)
Received: from pure.paranoia.local ([172.83.40.72])
        by smtp.gmail.com with ESMTPSA id b2sm25024790pfm.3.2018.11.15.10.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 10:28:28 -0800 (PST)
Date:   Thu, 15 Nov 2018 13:28:26 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>
Subject: insteadOf and git-request-pull output
Message-ID: <20181115182826.GB25806@pure.paranoia.local>
Mail-Followup-To: git@vger.kernel.org, Borislav Petkov <bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:

Looks like setting url.insteadOf rules alters the output of
git-request-pull. I'm not sure that's the intended use of insteadOf,
which is supposed to replace URLs for local use, not to expose them
publicly (but I may be wrong). E.g.:

$ git request-pull HEAD^ git://foo.example.com/example | grep example
  git://foo.example.com/example

$ git config url.ssh://bar.insteadOf git://foo

$ git request-pull HEAD^ git://foo.example.com/example | grep example
  ssh://bar.example.com/example

I think that if we use the "principle of least surprise," insteadOf
rules shouldn't be applied for git-request-pull URLs.

Best,
-K
