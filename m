Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 974171F859
	for <e@80x24.org>; Sat, 20 Aug 2016 01:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755916AbcHTBIv (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 21:08:51 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:36262 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755880AbcHTBIu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 21:08:50 -0400
Received: by mail-ua0-f177.google.com with SMTP id 97so107295030uav.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 18:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nowaker-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ggFaxN2MmqhdxVhVof3XovfniPID6X6LpkH0A1DBe7c=;
        b=zFlHAzfU+aOoEkkJJ/TPXoNyp23NOdv/hM6r0a+DbhIs+x1CfQ7+JaByrJ440//LuX
         28YbkCeR2r3XO/2tqfR1JTQz/ZXBNRhaZCi9e5z7Pdlc3PnbyQWVXrCcBM+ZbdRK2j8n
         UUw4Pd0fFPGLkXXc468vdA6+1bmJOyh0lbVjinTm/ld3UGCrsc0yu1khn1XWC9Zs9IlK
         249stOwHigq+TtKuAicZD2yxHeeF8WsqwSWT+0KgHzmNeO7SKWuIC6v7A4YFF39NmxZ6
         QDodQXk3Y49vpMyfUxZLFNDG+6QXxtENIn3mwOCk++jwWpEmpYKHxcRzzA8MZaZoEcsV
         aETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ggFaxN2MmqhdxVhVof3XovfniPID6X6LpkH0A1DBe7c=;
        b=f+ZdHChwga70g8yM5LeB2d542gbvLQxRa4FGs7R8DqIzSQLcH2PIR4iaNxTRJgcyNQ
         gDYbCW9RpNQg241DMoK1ltYKtjrXvXfTfVFgABNucrvtvP8b7W5OCMY+eT6KhQEdpt/R
         h4MgR81JZRToZUOEcFl+B+hJzr2/Mo+xT13b7PoWZUg6FLuEZhQYehBMdVp8A+i/cjGL
         J9yKUSoDh9kRRBHEhmtXXUCZ5c1Ck0sBSV7i2GwsmEK6goOFi4r5qbQ43VNvNe7nmPzF
         Z/TssOTtZhnJkMv87BebQCBbN9hdG0l/YZALUUpy/jbxbN70UBfh+EzKsDRz1I77xFvY
         gNnQ==
X-Gm-Message-State: AEkoouuy2Gl5mXGq8r6JXPtnwMJiOK6SYns4Yd7jrSP0/XEBNNKDk5pZHqUP8thIWKSuNp5CL6p0nkbKWdtZtQ==
X-Received: by 10.31.81.134 with SMTP id f128mr4502338vkb.139.1471654932278;
 Fri, 19 Aug 2016 18:02:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.80.21 with HTTP; Fri, 19 Aug 2016 18:02:11 -0700 (PDT)
X-Originating-IP: [148.59.236.7]
From:   Damian Nowak <spam@nowaker.net>
Date:   Fri, 19 Aug 2016 20:02:11 -0500
Message-ID: <CAOmGACJqhGgme9Zy7C8TuA7npsmj1E2=SBptDc5_ar3vCb2tPg@mail.gmail.com>
Subject: BUG: Use GNU Short Option Style "clumping" rules not obeyed for `git stash`
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

```
% git stash -ku
error: unknown option for 'stash save': -ku
(...)
% git stash -k -u
Saved working directory and index state WIP on master: (...)
(...)
```

In other parts of git, clumping (as defined by [GNU Short Option Style
guide](https://www.gnu.org/software/tar/manual/html_node/Short-Options.html#SEC37))
works, for example:


-v for verbose, -m for message:
```
% git commit -vm 'xd'
[master a560195] xd
 1 file changed, 91 insertions(+), 51 deletions(-)
 rewrite spec/actions/hosting/meta_machine/upgrade_plan_spec.rb (96%)
```
-q for quiet, -m for message
```
% git commit -qm 'xd'
(no output)
```

-- 
Kind regards
Damian Nowak
