Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A61C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 21:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3F220409
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 21:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeVyGhkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLKViu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:38:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39872 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfLKViu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 16:38:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so102751plk.6
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 13:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VsxbzYLhDZRSZ+Fo3WOQrsR4CSpk1RxBNFeG9cLOFB0=;
        b=qeVyGhkVeV2rE5uB4h5i94NANdzOYucqaFoeT0ztBRdzdqWRxIRT7KxzOr21NlaBt1
         u0phw2DNPjXdd0i3PlSihDDy5Vzcdyl0VoPiRE3pqoc9PohB88oxNbdH/5/FFLhakZxi
         mjEZM/wGXMuCiwW/WJiqTHUE7vYLOZsLcN5zjWSWtyt0v5qi5YmENp5U5qOrrsFKbk6K
         E4nzDrSuVcumT5nNVKaM0ozRzlWFL24rkruS6MECOWyTryt7pB53KiI90h7ufkoXANJ8
         1f5eVk/Db3anUMT0Syc94aiI65JqrFYgcJKhjt+ZNtCs1hnn4xb1nZbzS4r75PyYz+n/
         7eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VsxbzYLhDZRSZ+Fo3WOQrsR4CSpk1RxBNFeG9cLOFB0=;
        b=KzokeR9gFNUSLR9AzWUXkDRizfmuKKnlNFNdGbg3uN18tswnoP/mpY2NdYLes0VAX1
         FagNt7wbPj8qyrsyeJlZ47YAJUoaoBayWvu+qiDOMWMdn5f3Q6z1PyFRgBFl8/kaC1nd
         vslMPZikwSWp/OfhDQovfIFzxfLqRaIl9Iwr6xdKx9IyJYp8IrbUv3337O6x317rFqNS
         F6R+E+ngjKi5jf0flj30M2+OtNp3wXlEZAgxW1l3wCRXN4s5W/8td4S0UWzZCuQpditF
         mWvJgUDHP8R/U4Hw7lJRLBDIKmb+5lgg/mmRKs08dhoJkyWcR5b13wdosg3NoKT3v5Cg
         HqGw==
X-Gm-Message-State: APjAAAXpKRH0UFQdytLN1KAVc+yKNLetZaEMhviEr8UxzUxdQNDqXcOk
        lvLdYUvGRMnM9scPwvqQP+geLebK
X-Google-Smtp-Source: APXvYqyHfTbMKsTpX9Ps5dpjUSkYt2E3okCJSbI2T8+YpUJ30PAuSCTIiCsI0G81XR+c/nDwh433iA==
X-Received: by 2002:a17:902:d883:: with SMTP id b3mr5369497plz.231.1576100328842;
        Wed, 11 Dec 2019 13:38:48 -0800 (PST)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id o184sm3815024pgo.62.2019.12.11.13.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 13:38:47 -0800 (PST)
Date:   Wed, 11 Dec 2019 13:39:50 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH] gitk: use --pretty=reference for copysummary
Message-ID: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an earlier commit[1], git learned the 'reference' pretty format.
Update copysummary to use this pretty format instead of manually
reimplementing it as a format string.

With this change, we lose the double-quotes surrounding the commit
subject but it seems the consensus is that the unquoted form is used
more often anyway[2] so this change should be acceptable.

Since gitk and git are usually packaged and distributed together, their
versions should be in sync so we should not have to worry a newer gitk
running on top of an older version of git that doesn't support the
'reference' pretty format.

[1]: 1f0fc1db85 (pretty: implement 'reference' format, 2019-11-19)
[2]: fb2ffa77a6 (SubmittingPatches: remove dq from commit reference, 2019-11-19)

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Beat Bolli sent a series out earlier that did the exact same thing[3].
Since they haven't replied yet, I'll send out the version that I've been
cooking for a while now since I think the commit message looks a bit
better too and also it's based on top of Paul's tree.

[3]: https://lore.kernel.org/git/20191209182534.309884-1-dev+git@drbeat.li/

 gitk | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/gitk b/gitk
index abe4805ade..8bf198e338 100755
--- a/gitk
+++ b/gitk
@@ -9429,8 +9429,7 @@ proc mktaggo {} {
 proc copysummary {} {
     global rowmenuid autosellen
 
-    set format "%h (\"%s\", %ad)"
-    set cmd [list git show -s --pretty=format:$format --date=short]
+    set cmd [list git show -s --pretty=reference]
     if {$autosellen < 40} {
         lappend cmd --abbrev=$autosellen
     }
-- 
2.24.0.627.geba02921db

