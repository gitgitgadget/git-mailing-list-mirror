Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD1A520357
	for <e@80x24.org>; Sun,  9 Jul 2017 10:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbdGIKZL (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 06:25:11 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34958 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdGIKZK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 06:25:10 -0400
Received: by mail-lf0-f54.google.com with SMTP id b207so44221535lfg.2
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kazlauskas-me.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=6j+Qf3NNNI0Z3jXCRYjdFJsUCer6ZEhLYW98wU5TE6c=;
        b=rT/Bla3l7elutM1K880BfWSm1jUaXA7wT25w1SILTnPYdLWpXMjkOdhzR3xuTRJJZb
         kq+Cr3Z/kkPI29ZH+7QiR1eHKVzg28d/5UdL9Txw4wDcxsH61Gn1ynyrFsER0K+KoAk+
         TqqYNaNVC9nwjjw7KhFeUa0zU8NJdWadn09Bqi0tVTFvl8hGlR79UFdJ9fOnaSiqohIO
         KSN9q0veQumsRPd7hGA88zde63oBrcIr5Nkjlh9JeTQmUcVXl12k51mPIBBU/KutzvG9
         z+/itJoRs/esrmm9q3E77weBMM4LzVOyxl4i2UL/yiZ8kV1C2U8tJeplkAnCAfePjFlD
         vDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=6j+Qf3NNNI0Z3jXCRYjdFJsUCer6ZEhLYW98wU5TE6c=;
        b=EL0ZmeEXK5KuSHnEflD4xR8AAbkhffhmSyntIbdnDcbwys8yYAvTPJvCS1+XdMA2nl
         dLqNeM2eBEl3nqdzpfc2o4q3F+vJqejsziDrhhw2+0r3PALP4C9u2DrZrOW2ytnCrW/y
         fHMfDj0LUXSXbysyCo0Mo6ptkXVx13+0iG4oZFZqOq6mlsnHZjufr6mmD1HmOZz9/O7K
         rqYaMwJh5a3VtFtzVcch3beXgjtWKY0FL6QDWxG47qrPpzJ3OqW4vfi73K8VW8CRzaZW
         isWtweuwV23wjaTYya/cMmCnB0JfDG2umWGzbDQBwYUaNED10dxN8E+540KkiL4ZwB9G
         OSUw==
X-Gm-Message-State: AKS2vOz0axyh43c+UqtHfCjHOhdv/OUiBx9CbPPgiEo0dwfGpKpoFc2s
        UIKPHJBmbdXTK5QU3uY=
X-Received: by 10.25.167.136 with SMTP id q130mr22703349lfe.162.1499595907904;
        Sun, 09 Jul 2017 03:25:07 -0700 (PDT)
Received: from kazlauskas.me (78-60-58-6.static.zebra.lt. [78.60.58.6])
        by smtp.gmail.com with ESMTPSA id h6sm1768955lji.59.2017.07.09.03.25.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jul 2017 03:25:07 -0700 (PDT)
From:   s@kazlauskas.me
Date:   Sun, 9 Jul 2017 13:25:06 +0300
To:     git@vger.kernel.org
Subject: Fetching new refs gets progressively slower
Message-ID: <20170709102506.GA32425@kumabox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a weird issue where fetching a large number of refs will start off with 
lines like these:

* [new ref]               refs/pull/10000/head -> origin/pr/10000
* [new ref]               refs/pull/10001/head -> origin/pr/10001

going fairly fast, and then progressively getting slower and slower. By the time 
git is working on 40 thousandth such ref, it seems like it is only handling 
about 3-5 such “new ref”s.

These are the steps I used to reproduce:

 $ git clone git@github.com:rust-lang/rust
 $ # edit .git/config to add 
 $ # `fetch = +refs/pull/*/head:refs/remotes/origin/pr/*` under origin remote
 $ git fetch

I tried this on three distinct file systems: zfs, ext4 and tmpfs, and on two 
distinct systems (both with different SSDs in it). Both exhibit the 
approximately the same behaviour. Both on a fairly recent version of Linux.

Here’s some timings:

System 1 (ext4) 97% (1047.74 real, 700.11 kernel, 319.89 user); 599476k resident
System 1 (tmpf) 97% (963.78 real, 647.51 kernel, 292.77 user); 600052k resident
System 1 (zfs) 98% (2116.66 real, 1715.86 kernel, 370.32 user); 531232k resident
System 2 (ext4) 97% (1036.56 real, 710.54 kernel, 300.81 user); 602160k resident

Git version is same on both systems: 2.13.1

I did not investigate the issue more throughoutly, but I suspect that git will 
end up doing something resembling listing the contents of the directory of refs 
for each “new ref” it is creating.

S.
