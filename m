Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F651FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 10:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753506AbdBHKRL (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 05:17:11 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:34104 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753391AbdBHKQz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 05:16:55 -0500
Received: by mail-ot0-f169.google.com with SMTP id f9so109089881otd.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 02:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enterprisedb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=u53LTxCRzLNWyC8HZzHiLCFOtv5WirbRMdqfvbhdoeY=;
        b=Vx36zt11Pxw43UqTzBzqr4z0Gzv4NinExQCNQzxWXFs1jcEM7wYtw0w8bRStuFC5mZ
         BQ9MQg0CWEWuuw+/YdyTE/wS89goh/jOqeOrWlYRa/cmy0IeyFBhcIp+JTP6ElWO4hOh
         JY7QWO1E4oB5Xl//HVQ+FUcZW8wy67uH7N0JTu36JqVIu6PcDx4QbGPxSTz8Ou+gWXfi
         sviZxd/bHaXQ0Gc1lIk+y0svZYWxeHeMprmjGTsKFTv/7atAIcJ9MDS+t3Uaa7z2WO68
         tkGTysjNyKau2cKKPBr4k1NvzEZEc2k9am88wgNk4A/HuVJH/T/DrGAA+3Kyzj3ps/nb
         XGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u53LTxCRzLNWyC8HZzHiLCFOtv5WirbRMdqfvbhdoeY=;
        b=DdOo2UIs71DDmHP59vp8Gjk8N7GaPtTygWscB6fFlFdVJ3TDxfb4lkbLewpPOkcgnN
         8uP/DBJ5aa45ZLVfbn87GnyQhnwOrn4vINmxcmpGofGF9uYedWkAMObyoXEprdoxX8+M
         yI1Hc2S5AXfkHPqLcgQ10+VMsbWQU9jWjJPJE+EJ5EgdBMdZGNOnY1MdiUZewzJo5PpI
         RMjaxFUxYEN/vHvIR18YNvjAVXiMCwS/VQhatL0YxGQjx3RxoE3G1V3fBJLD2voGK0aD
         laAWcIvju4TGKpViUG/couz0+9eVSGj/d4PAj0OdC8LdVqOX2GmF2Xx8HSkWl5LcD25I
         F5WQ==
X-Gm-Message-State: AMke39k8WBig0p1umPs6usa9Okvvy4F6uQEV5HhCAD70tyHRB7sabogMc73Q67IepF9ZMZGgIZbPSw3ihWY9PZzP
X-Received: by 10.157.9.214 with SMTP id 22mr10206153otz.128.1486548607865;
 Wed, 08 Feb 2017 02:10:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.226.168 with HTTP; Wed, 8 Feb 2017 02:10:07 -0800 (PST)
From:   Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>
Date:   Wed, 8 Feb 2017 15:40:07 +0530
Message-ID: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com>
Subject: Bug with fixup and autosquash
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git-developers,
First of all thanks for developing this wonderful scm tool. It's sooo versatile.

I have been using git rebase heavily these days and seem to have found a bug.

If there are two commit messages which have same prefix e.g.
yyyyyy This is prefix
xxxxxx This is prefix and message

xxxxxx comitted before yyyyyy

Now I commit a fixup to yyyyyy using git commit --fixup yyyyyy
zzzzzz fixup! This is prefix

When I run git rebase -i --autosquash, the script it shows me looks like
pick xxxxxx This is prefix and message
fixup zzzzzz fixup! This is prefix
pick yyyyyy This is prefix

I think the correct order is
pick xxxxxx This is prefix and message
pick yyyyyy This is prefix
fixup zzzzzz fixup! This is prefix

Is that right?

I am using
[ubuntu]git --version
git version 1.7.9.5

--
Best Wishes,
Ashutosh Bapat
EnterpriseDB Corporation
The Postgres Database Company
