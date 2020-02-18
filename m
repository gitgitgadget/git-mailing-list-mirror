Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B5CC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 09:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E153206E2
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 09:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ5JreWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgBRJhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:37:19 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:39464 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgBRJhT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 04:37:19 -0500
Received: by mail-ua1-f45.google.com with SMTP id 73so7205592uac.6
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 01:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gx1hnraUOGdgBzliR37IOCr/ZJydVas1wZfu/mkB+FM=;
        b=hJ5JreWO5ihQJl21K2cCOfjsqtmYSQNnZXKzxI5WH+6/8/BkILpLOTMFpzcVQv3qLi
         fr0p5DE3/NsbaJZAX4fvbLuscR3Sc3i7qVXx2LEy3dvktp6VXLSBgUFCbYPmwf7GaZap
         +mTiu8TigoNgM1q2uuHJWyIYgaVUx4APnYBPCiLWr+enldK8v1uPN7KDaq6ZdvwaDHhh
         y22kblK89ttYC5ac1cC0rDu3ifTAx3hDKuPL/7x+XoZC7nM+iC32Dgekl6phf/7NFvWs
         yY0v+j729EE/hSgkt1hUwsv9bGaqlvgjfgpubo8CergZutgEdOQj4OrJYA1PCNItmusJ
         Mbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gx1hnraUOGdgBzliR37IOCr/ZJydVas1wZfu/mkB+FM=;
        b=g3YNuSXY9CBwnbuab4GuZKZV/kVmeD1thWNajx3bRWucqotMk2j1suGjqUrA0UCVx9
         AQ/23T60sQpkYcfGoyi8wFZTlPJfJ2IaTiWkC0cfUjEBK9iKPyI08mOQgrIZvF7x7kGf
         gU+34cB9oIkIgUSjAMhWkcSPO+vVnD4igtkn/7HgNv4Ay2cML5yqyhX6YRIU5viqPN8l
         3Zx7ERKZO6KkQIJGXSfbNO1zQj0+zEAeBY85OJYMU4hLmIV/xxDmOcPxa+i6NRfxfmJb
         R9L+5AJcogCk85bLjtnUfmBCOg2G22Bww5ZBwfGOn1wmR/ebfltJmS1/LsYp/Jyxi5s0
         k7RA==
X-Gm-Message-State: APjAAAWfwO3EHJZkrGVuFGx2kpIW8dypeZvcRO+NzUiVr9rdsqsBP8nY
        4cem4qGGNSJy5DLqKSFWR4HcVq37+vmn68CkSvTwdtdU9n8=
X-Google-Smtp-Source: APXvYqzdNjAJC9iBjRmbrKiU//2OFlfveQAGLFWAvgxSSovFGRg15noJcq21niwxAmBUKDIW6LMoXmjoMuJhut0hoo4=
X-Received: by 2002:ab0:55d7:: with SMTP id w23mr10240550uaa.113.1582018637977;
 Tue, 18 Feb 2020 01:37:17 -0800 (PST)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 18 Feb 2020 17:37:06 +0800
Message-ID: <CAGP6POJf4YX_ZdfMNBY_ktWCB7Y2vLHSoiq+Ai1ZvQMZ6yc6gQ@mail.gmail.com>
Subject: use libcurl to obtain the real-time speed of git clone.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The git is based on libcurl.  I want to know whether can I  use
libcurl to obtain the real-time speed of git clone.

Regards
-- 
Hongsheng Zhao <hongyi.zhao@gmail.com>
Institute of Semiconductors, Chinese Academy of Sciences
GnuPG DSA: 0xD108493
