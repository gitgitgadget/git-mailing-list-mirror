Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E3C2D0CE
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 01:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BC124656
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 01:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djM4YZGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgAVBT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:19:27 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:33433 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgAVBT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 20:19:26 -0500
Received: by mail-yb1-f169.google.com with SMTP id n66so2388321ybg.0
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 17:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hDOYeRH0mOe/L2LtvqyOklji7yTkRU2Rs2Ru98CxEDM=;
        b=djM4YZGb/Yip74RKAfF5rvP4KFtX9Ofm/NGDdCNwQDgYUVDJJAmL49buB46giWwqa6
         N03Y7XObrd0aKQJRFgqOf2pht6jOO6GSsbYyGasSeTzSJ/ROKkJZXeL8pWrIPiOlidKg
         gr6vnpNntWRiQfMTta/jtoQEU4Eew1UzgfDCiHzhJ1YHvtfx+n8nBFFI1m+4fg+y5Wy5
         rHGsH46+V7bXncO8cGCabGAsKP65hQgfP0E8BFFxCTHTbq6S0Lc5C0fOLfL4xOM8we6A
         XfagrA5tVXDv9j7yX9F2r2bW7RK8hiMLIDe3XPVDN6RLV9c8nGawns4KKv1OfJxDCi1M
         c2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hDOYeRH0mOe/L2LtvqyOklji7yTkRU2Rs2Ru98CxEDM=;
        b=Y6mmlGaL9rzK9d4UcHlxHq498L3zE31rPSqPj+gw+YONxEBTjGwHK78wq/NZaMXSvX
         yd1BwR3OFwGVIGGkdl2hz15eQX/D7V6FqhNhLjfLTA5uayRoEiWTNIFacoIqzN3njhaH
         zCjYqnmP4aheZlIUwS6ZYC63EkvveC6JnlGPUj873GT87Sj0C6UnRErORZlBSw0DcnPy
         A1U/wrwO+uTbkhLnhxMkV2bEq0SW/cOuXRPz2gGGGX1tig0SOUSTndlclC7x94UTGmbo
         K9LYn/bd3q3mdFy2dSIH7ZSgKizJ9LBGvgRmvM3V9x61QlpJremLjs9LXp8YXDXmEozh
         hGUg==
X-Gm-Message-State: APjAAAVJkSEQzlD2VoaxBOwhjuWPdNNQERX+xLxEjh2xARD1eFqV2Fjs
        EGU5Kp08b16VxWjcYE4CI7FHOGEYwYU=
X-Google-Smtp-Source: APXvYqxF7EyGF3k8fis3aB1Co6vPcpYfSMywVDOCfiG3syW/0QeRgYGau9S4S4TRloOJbTcyqmF6KA==
X-Received: by 2002:a25:8749:: with SMTP id e9mr3746058ybn.147.1579655965040;
        Tue, 21 Jan 2020 17:19:25 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k6sm18173079ywh.56.2020.01.21.17.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 17:19:24 -0800 (PST)
Subject: Re: Sparse Checkout Trouble (2.5.0)
To:     JunkYardMail1 <JunkYardMail1@Frontier.com>, git@vger.kernel.org
References: <062301d5d0bc$c3e17760$4ba46620$@Frontier.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d4056731-c13b-c89d-dfd2-e6235e29fed6@gmail.com>
Date:   Tue, 21 Jan 2020 20:19:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <062301d5d0bc$c3e17760$4ba46620$@Frontier.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/21/2020 7:42 PM, JunkYardMail1 wrote:
> I have a shallow repository clone and using sparse-checkout of just a
> handful of directories.  When I upgraded from git version 2.24.1 to 2.25.0
> some files not in the sparse-checkout were staged to be deleted.  The
> directory path of these files contain the Windows reserved name of "prn".
> Ex: "japanese/prn/. . ."  Unable to un-stage these files and reset the
> changes.

Are you using Git for Windows? I'm not sure why the "prn" would be important
otherwise.

> !/*/
> /*/directory-*/

I don't see anything complicated with these patterns, although they seem
a bit strange. Why would you not want anything in a directory except one
named "<something>/directory-<anotherthing>/"? Is this actually the exact
pattern set?
 
> Reverting back to the previous version (2.24.1) allowed to un-stage the
> files and reset the changes.

This is definitely pointing to a regression, and the feature did get a
bit of an overhaul. The goal was to not change how existing users
interacted with it, though, so this is a bit alarming.

I did find a behavior change related to these paths in Git for Windows
2.25.0 versus 2.24.1:

  $ git clone https://github.com/derrickstolee/git-sparse-checkout-test
  Cloning into 'git-sparse-checkout-test'...
  remote: Enumerating objects: 6, done.
  remote: Counting objects: 100% (6/6), done.
  remote: Compressing objects: 100% (4/4), done.
  remote: Total 6 (delta 0), reused 6 (delta 0), pack-reused 0
  Receiving objects: 100% (6/6), done.
  error: invalid path 'directory-1/prn/a'
  fatal: unable to checkout working tree
  warning: Clone succeeded, but checkout failed.
  You can inspect what was checked out with 'git status'
  and retry with 'git restore --source=HEAD :/'
  
The checkout here is _expected_ to fail, due to the protected
filenames. What is troublesome is the following sparse-checkout
commands fail, and the read-tree command fails in a way that
2.24.1 does not:
 
  $ git sparse-checkout init
  error: invalid path 'directory-1/prn/a'
  error: invalid path 'directory-1/prn/a'
  
  $ git sparse-checkout set "/*" "\!/*/"
  error: invalid path 'directory-1/prn/a'
  error: invalid path 'directory-1/prn/a'
  
  $ git read-tree -mu HEAD
  error: invalid path 'directory-1/prn/a'

The double error messages are due to the "try with an in-memory
pattern set, then roll back if there is a failure." The patterns
we are trying to create do not include the directory that is failing.

I'll keep looking into this.

Thanks,
-Stolee
