Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2A9C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0952073C
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSqUz2dO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfLDWDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:03:10 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:38706 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDWDK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:03:10 -0500
Received: by mail-pg1-f173.google.com with SMTP id a33so307837pgm.5
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6bdSUq/+VBNXucuUysK7c/b3K34tEkWvFPKSr+4JXk0=;
        b=RSqUz2dOXlUSlA01BHURNTWOr9dRjGfpEv5B3n9HbhmYfrAl7bcYxgxjXzSIzYQ+S1
         xn+9xDIUEoiwcALpVv0VsgFfMammfNzVKo+wWBtCj8kYtqZoSv/GbtbKMLLFWGIFKXlh
         Qb/USlMjCeclG7Wq15mLHRGZeX5k3SSzc79NhHPi9KuOMMrrZCGCMd0xRMR+jrPueaBt
         GJEcmjTFpE1KLJtQL5PwExHojKXR+RPkSirzRpUickE7u5pag9Gx45pN1o3fNflJDIpI
         ikOdykTIqfQI9kZCguRSUBE8ny3h0DwxgxQhyPKXZktYvsrKzPOpQWC3f/HjlA4E6/KR
         DC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6bdSUq/+VBNXucuUysK7c/b3K34tEkWvFPKSr+4JXk0=;
        b=OlQC+JNEpS0vP+BAhVcAneXLCs1BUz+aH/lmofFd1+CNWHpPpQDCUAoLNtVo3tTjNL
         sfRo6j7SvD6GLd/8QCeSJL4byD/pnOkdj39UJGxpNya77hLbmKE+pbRXcyZCou52Hf7K
         zemUmMUIF0mdx30xJdG8/X+HVdTvMYOpME3xNh3ba83Mg9qgViM5JX74fmu7fkRytUhj
         MH7I4V9fJUR4iqb3wam9Ga8vASCXw01XE+Usj0LKRUmZvLyvvMEWTsuoH8JuuhUQJrmb
         OwC2ycNPEiVVI1fYEdXhCXqhi/XFAoatayuhUzqJbXDlbDKgLl595QtX1dKAPmA4FQPk
         xg1g==
X-Gm-Message-State: APjAAAUyqsIwIVPt8Mk0ebXIdVLwnhCV04XkKAivFrGQfbAvj78Deh5i
        Viw1NzxwstP9/+bgXbBhR+x0oosp
X-Google-Smtp-Source: APXvYqyCyf7aBUthx7YjZSse50JtIvzf8zCdXVkRjWrwZtBh9vkgTT3jNNgad4xI0EVh5vzqwATrPA==
X-Received: by 2002:aa7:8dd0:: with SMTP id j16mr5550395pfr.58.1575496989293;
        Wed, 04 Dec 2019 14:03:09 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id h9sm7313941pjh.8.2019.12.04.14.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:03:08 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:03:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 0/5] t: test cleanup stemming from experimentally enabling
 pipefail
Message-ID: <cover.1575496683.git.liu.denton@gmail.com>
References: <xmqq1rtk557e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rtk557e.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Sorry for the confusion. Looking it over, I see that the sed expression
you proposed indeed makes the intent a lot clearer. Here's a replacement
series for the last five commits of the branch.

I would've opted to send out a single replacement patch but this change
causes some minor textual conflicts in 4/5 so this should make your life
a little easier ;)

Denton Liu (5):
  t7700: consolidate code into test_no_missing_in_packs()
  t7700: consolidate code into test_has_duplicate_object()
  t7700: replace egrep with grep
  t7700: make references to SHA-1 generic
  t7700: stop losing return codes of git commands

 t/t7700-repack.sh | 165 ++++++++++++++++------------------------------
 1 file changed, 57 insertions(+), 108 deletions(-)

Range-diff against v5:
1:  a99a45cb6f ! 1:  3008ce8deb t7700: consolidate code into test_no_missing_in_packs()
    @@ Commit message
         Refactor the resulting extraction so that if any git commands fail,
         their return codes are not silently lost.
     
    -    We were using sed to filter lines. Although not incorrect, this is
    -    exactly what grep is built for. Replace this invocation of sed with grep
    -    so that we use the correct tool for the job.
    -
         Instead of verifying each file of `alt_objects/pack/*.idx` individually
         in a for-loop, batch them together into one verification step.
     
         The original testing construct was O(n^2): it used a grep in a loop to
         test whether any objects were missing in the packfile. Rewrite this to
    -    sort the files then use `comm -23` so that finding missing lines from
    -    the original file is done more efficiently.
    +    extract the hash using sed or cut, sort the files, then use `comm -23`
    +    so that finding missing lines from the original file is done more
    +    efficiently.
     
         While we're at it, add a space to `commit_and_pack ()` for style.
     
    @@ t/t7700-repack.sh: test_description='git repack works correctly'
     +	myidx=$(ls -1 .git/objects/pack/*.idx) &&
     +	test_path_is_file "$myidx" &&
     +	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
    -+	grep "^[0-9a-f]\{40\}" orig.raw | cut -d" " -f1 | sort >orig &&
    ++	sed -n -e "s/^\([0-9a-f]\{40\}\).*/\1/p" orig.raw | sort >orig &&
     +	git verify-pack -v $myidx >dest.raw &&
     +	cut -d" " -f1 dest.raw | sort >dest &&
     +	comm -23 orig dest >missing &&
2:  f79240e937 = 2:  f3a0470edc t7700: consolidate code into test_has_duplicate_object()
3:  632a62f6e9 = 3:  c34477a5a9 t7700: replace egrep with grep
4:  bf70cc5a0d ! 4:  113f375192 t7700: make references to SHA-1 generic
    @@ t/t7700-repack.sh: test_description='git repack works correctly'
      	myidx=$(ls -1 .git/objects/pack/*.idx) &&
      	test_path_is_file "$myidx" &&
      	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
    --	grep "^[0-9a-f]\{40\}" orig.raw | cut -d" " -f1 | sort >orig &&
    -+	grep "^$OID_REGEX" orig.raw | cut -d" " -f1 | sort >orig &&
    +-	sed -n -e "s/^\([0-9a-f]\{40\}\).*/\1/p" orig.raw | sort >orig &&
    ++	sed -n -e "s/^\($OID_REGEX\).*/\1/p" orig.raw | sort >orig &&
      	git verify-pack -v $myidx >dest.raw &&
      	cut -d" " -f1 dest.raw | sort >dest &&
      	comm -23 orig dest >missing &&
5:  1f6d9a80ad = 5:  ab653bd76f t7700: stop losing return codes of git commands
-- 
2.24.0.578.g4820254054

