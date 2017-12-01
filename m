Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1109B20954
	for <e@80x24.org>; Fri,  1 Dec 2017 18:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbdLAStJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 13:49:09 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35286 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbdLAStA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 13:49:00 -0500
Received: by mail-wm0-f44.google.com with SMTP id f9so5038056wmh.0
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 10:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6VcxfHLhIOFJTh+Hf7qbpO8R4hpXsHojFXst0vrC3eQ=;
        b=gsMaGnhqaLLZnAlX0uMqxMBMCmwt40YAqGk66Su6jcSIopf7MZqpQ/TnzuRfTut+Fv
         HtLscJ36uTQBqUiROLx9OhSlFocriU3ZRLZC4DSqdXuAlsP0OYWxXSS0PXp7tlgF2X0u
         kdhyAojM/BwftJTfL347gcFxxamq/9x/5HyfyhwitubLj4Fuis8tqGU8N1Al+d5HhLTJ
         KoRT4hax/AJrZ6Ts+wW9YPxahtGp9BelN+8bZUNDdPZ0kpemKgTzUAap6EdcJLIXRJ8e
         rxws7xITikBUdI0PhrF69uNR5vvQJCLPeiq/HwrnO7000FNeeo3vQwHxF+Adc71rpL1u
         0qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6VcxfHLhIOFJTh+Hf7qbpO8R4hpXsHojFXst0vrC3eQ=;
        b=P7NssoUG9LynVwOrkg0jQJbDRZRA600m0hACRRVKpv69ETCXeedSZpaS/XywPZ8Knl
         hk5szn9pSu1Hpt4oSHOVUVnZTmJxPB6X5Z6d0veR/NNeCLh1YftPkuqOOUxKSpHzg2AS
         jjayafZX1Yw8siwn0Lg0XB0x7dLjp8rGLQhjdKiFAbKHrFodH/+tE16KtjRluZAIy+TS
         15Jw4lyQWHv1Hsdlz6p8WaIgjTUKzxlAYbvQboaoFK2rNUv6EwO3vVZWPXOwQng8FNdF
         P4ekFGQgz/XFc6axew29uGkxPlfJy+02RYn4O/i8eZD59BC4ypeNjaEFl9bEjK29ZSFf
         Mzkw==
X-Gm-Message-State: AJaThX7lZDmykoVIQv8G6C2dp2ZI4Vjx8RqjIhtigKcWHk9jAL1u5sgh
        OUrfE/HdGS7I66kFCcJQDOQDFFx2aJlNHItXBXFHCw==
X-Google-Smtp-Source: AGs4zMad9xFUTt5ss+yc29poNr60pE9zU350WRz/HV4DaYiFffaKMp/6OfPcWa1TA/O6PYJTkqahgcCk0TL4HlEyzh8=
X-Received: by 10.80.129.135 with SMTP id 7mr19516580ede.101.1512154138905;
 Fri, 01 Dec 2017 10:48:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.185.101 with HTTP; Fri, 1 Dec 2017 10:48:58 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Fri, 1 Dec 2017 19:48:58 +0100
Message-ID: <CAN0XMOJnQX-gSnpHaiJUYr4X4-WT91oT3Xv3gDtKYjX7J3ObVw@mail.gmail.com>
Subject: git-clone ignores submodule.recurse configuration
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Today I played around a bit with git submodules and noticed
that the very handy configuration "submodule.recurse" is not
working for the git-clone command.

"git help config" tells me that submodule.recurse affects
all commands that have a --recurse-submodules option.
git-clone seems to be an exception which is also mentioned in
a workflow example in Documentation/gitsubmodules.txt that
says:

  # Unlike the other commands below clone still needs
  # its own recurse flag:
  git clone --recurse <URL> <directory>
  cd <directory>

So this seems to be a known issue. Is someone already
working on this or has a plan to do it? Or is there a reason
not doing this for git-clone but for git-pull?
