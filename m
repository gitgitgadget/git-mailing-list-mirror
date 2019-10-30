Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA4A1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 09:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfJ3JQA (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 05:16:00 -0400
Received: from forward104j.mail.yandex.net ([5.45.198.247]:41131 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfJ3JP7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Oct 2019 05:15:59 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2019 05:15:59 EDT
Received: from mxback11j.mail.yandex.net (mxback11j.mail.yandex.net [IPv6:2a02:6b8:0:1619::84])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id EB7D14A184F
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 12:10:22 +0300 (MSK)
Received: from iva4-994a9845f60e.qloud-c.yandex.net (iva4-994a9845f60e.qloud-c.yandex.net [2a02:6b8:c0c:152e:0:640:994a:9845])
        by mxback11j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 3VpER6Coj6-AMoOI1ql;
        Wed, 30 Oct 2019 12:10:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1572426622;
        bh=+3/R2HgiRHSmGgS1yrlhsKB49nDWM8K3v2tQYyWEqrA=;
        h=To:Subject:From:Date:Message-Id;
        b=noKC6F56SqEn27DhgSrW9VMyLckFn2NdspPyXBUcGYtjCJDmgrHR9fNHGHfit1S3T
         x2ELbq+lyz0aBdM6GksKXMzpPcjj8rpTotTs0NdVjQ3KGAU/BgssdIU1sxjc/Yd7a1
         TOyoPi4vw4f27U3u4wqNmX96crLhN7NUi6ZYfpZg=
Authentication-Results: mxback11j.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by iva4-994a9845f60e.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id NZNCcs3Mg1-AMVukRfr;
        Wed, 30 Oct 2019 12:10:22 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   =?utf-8?B?0J7Qu9C10LMg0KHQsNC80L7QudC70L7Qsg==?= <splarv@ya.ru>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Fix and addition to git-diff
Message-Id: <232BC77E-F22E-469A-8839-6A1553A75B55@ya.ru>
Date:   Wed, 30 Oct 2019 12:10:21 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all.

This is a small patch with fix and addition to the man git-diff. This =
fix is obvious mistyping in man, there must be "..." instead of "..".

And I added an example about how this can be used. The reason is:

First, I don't know another reason to use a tree-ish with git diff.=20
Second, the diff with empty tree is a real problem on what some people =
looking for solution (for various reasons):

=
https://stackoverflow.com/questions/14564034/creating-a-git-diff-from-noth=
ing/54946189#54946189
=
https://stackoverflow.com/questions/9765453/is-gits-semi-secret-empty-tree=
-object-reliable-and-why-is-there-not-a-symbolic/54945479#54945479

And the solutions are not simple nor obvious. So I think it will be =
helpful to mention it.

--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -77,8 +77,16 @@ two blob objects, or changes between two files on =
disk.

 Just in case you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
-in the last two forms that use ".." notations, can be any
-<tree>.
+in the last form, that use the "\..." notation, can be any
+<tree>. For instance, if you want to make diffs against an empty
+tree, you can create a tag pointing to the empty tree:
+
+'git tag' empty $('git hash-object' -t tree /dev/null)
+
+And use it for the 'git diff', for instance, to check a working tree
+for whitespaces:
+
+'git diff' --check empty

 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].=
