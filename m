Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAABCC388F9
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF052222C
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603736190;
	bh=qfM6M5E0r273ys/q4OnNHW7L0BNXFbLeOFcMNTIc8OE=;
	h=Date:From:To:Subject:List-ID:From;
	b=cU6qkpH6TIEQ5Yoh1H/BxtBRW3wBK64XvH/hzaYrN7K6onYc2M0diyY7VxxCUFPWr
	 hzyWwRSFC9luDnEc2A/7BOk56xSD2IBNENVKbJ1BplFLcneCvekoR/gBiNyHsJCmgW
	 oG3v3CZLJN2UFJ9xFz+tf4di9kPbpyzlmgTI9Y2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789475AbgJZSQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 14:16:29 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:43532 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789472AbgJZSQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 14:16:29 -0400
Received: by mail-qk1-f177.google.com with SMTP id q199so9257003qke.10
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=5AR6GEnXLBpG43hAtbEpQBS8XwUl2rwfzRWPOyYs4L8=;
        b=FCfYM/BVzSULIGMImT1vPoNgvbdEzAhMCIo0yN0GjFhq+0vNi3+mVjZLesUCh1eoFy
         OQqGWC+CfCyN3aixkIBcxlyLarPa7e1TCBHrfEND9td5kPAMdXY+knWXvJjckJNX9xnN
         a/8sEmuUTLQ7a6Z8QcK9Y7lJREp1HB9ZkgZZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=5AR6GEnXLBpG43hAtbEpQBS8XwUl2rwfzRWPOyYs4L8=;
        b=sZ0h1SgQ8c3E2u1X+mS4wsCSETe3sOaR2X7Lw/yVRlDfgbXX0IZiZQTNYq/Hvirg7v
         b2lfMI9oJ4NCNAMHTgJQuGIfhh0g7HkBwugnmgNc1JI/aSq49O7xsiIILpmFoboK0F/0
         2r8r30KggZ6rWO+aX8qN0+BluPS4CNf57pIk75R7KMgLuyeGZ9aFeBeWVo2yv9eFvh2y
         GauLdYeCsF/Wt5ZykZTDJG238DMfHhfcTcf8Puc7+Z87IgAlAYqm1AhPkJp9pezguMEN
         KUqvGbGF+b3Yfh7qCygjC6/MrbI/FfSmAGLqc/QjtoBWqN2+dRYK++tESX88HPHaZ/mQ
         1mDw==
X-Gm-Message-State: AOAM530kjAstZs5+67irPC7F909Y9SPXwJhi92N7dFcAlTPpQeiysMvw
        icruYeim6uVZhgZHnvH1emgEdR6mBO566dBm
X-Google-Smtp-Source: ABdhPJxOF8XlCJlkZ7YBY/l6+ars2LO4G3tSAVN0kyOd3qc0P0zZj5KTPnApKxVh+d5ieRji0tdI7Q==
X-Received: by 2002:a37:ac12:: with SMTP id e18mr2189112qkm.306.1603736187651;
        Mon, 26 Oct 2020 11:16:27 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id k4sm6946445qkj.46.2020.10.26.11.16.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:16:27 -0700 (PDT)
Date:   Mon, 26 Oct 2020 14:16:25 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: git-receive-pack doesn't seem to respect gpg.program config
Message-ID: <20201026181625.c6f5y44ydndkniul@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:

While trying to configure signed pushes, I found out that no mater where 
I set gpg.program=/opt/gnupg22/bin/gpg (in-repo config, ~/.gitconfig, 
/etc/gitconfig), git-receive-pack didn't appear to be paying any 
attention to that setting and always used the "gpg" command in the PATH.

Not sure if that's intentional or not, but seems like it should be 
paying attention at least to /etc/gitconfig.

-K
