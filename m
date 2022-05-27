Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E860C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 14:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiE0Oyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 10:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353254AbiE0Oye (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 10:54:34 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD81129EEB
        for <git@vger.kernel.org>; Fri, 27 May 2022 07:54:32 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4L8nrg630Pz9sQk
        for <git@vger.kernel.org>; Fri, 27 May 2022 16:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m-reimer.de; s=MBO0001;
        t=1653663267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uo+V63vO7pn26PNURjIecK/yQUYJGIwOyY7IJXH8f9M=;
        b=XTYwmdFtbN5hrclF4lV7lYgsFVy2r+yZ7ov2bQAh4rYBAby1y+h9W7meJqKLyq7wF+ImBW
        CxM5zrPspLhh4jbhhmWf8ao6MLv0VQpBKJAg0sGL2lurKdg1KMijasFUKEgPhS9OXU3OOk
        V65ukDHjDdj1LWVwnxTNBNTpNW7ncu7To2tqdWY99deUZ+11ZL3zOfiAr5NISGCCdpDUsO
        GhnMtU+KY1D4d015HuNXGzy8PAQOtpkx2Epb8Av0zAhUPxqnfNLIhS96J1ypRHbYVr4JnZ
        EOr2/oSwuy+B4cODCDKfxlWQLc0sHqKErR2HGH8+c8RAqphmD0E0XuWKFiHOOA==
Date:   Fri, 27 May 2022 16:54:25 +0200
From:   Manuel Reimer <mail+git@m-reimer.de>
To:     git@vger.kernel.org
Subject: =?US-ASCII?Q?How_to_properly_use_git-subtree_=28and_?= =?US-ASCII?Q?prevent_it_from_adding_merge_commits=29=3F?=
Message-ID: <3DEED6A1-6344-472C-9E03-39ADF3076B2D@m-reimer.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

maybe it's a bug in later GIT versions (2=2E36=2E1 here) but I kind of str=
uggle to get git-subtree to work properly=2E

I even recreated the repo, I use for the subtree, from scratch to get sure=
 there are no backreferences to the repo I've added the subtree to=2E

This is the repo, I want to have as "subtree" in other repos:

https://github=2Ecom/M-Reimer/webext-utils

I now pulled this into two projects as subtree using the command

https://github=2Ecom/M-Reimer/undoclosetab
https://github=2Ecom/M-Reimer/savescreenshot

For both projects I used the command:

git subtree add --prefix utils git@github=2Ecom:M-Reimer/webext-utils=2Egi=
t master

In the first project (undoclosetab) I then added a new commit ("Add manage=
d preference support") and pushed this back to the "subtree repo" using:

git subtree push --prefix utils git@github=2Ecom:M-Reimer/webext-utils=2Eg=
it master

If I now try to pull this into my second project (savescreenshot), then gi=
t creates a merge commit for no reason=2E


git subtree pull --prefix utils "git@github=2Ecom:M-Reimer/webext-utils=2E=
git" master
remote: Enumerating objects: 5, done=2E
remote: Counting objects: 100% (5/5), done=2E
remote: Compressing objects: 100% (2/2), done=2E
Unpacking objects: 100% (3/3), 1=2E94 KiB | 497=2E00 KiB/s, done=2E
remote: Total 3 (delta 1), reused 3 (delta 1), pack-reused 0
From=20github=2Ecom:M-Reimer/webext-utils
=C2=A0* branch=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 master=C2=A0=C2=A0=C2=A0=C2=A0 -> FETCH_HEAD
Merge made by the 'ort' strategy=2E
=C2=A0utils/storage=2Ejs | 57 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++-
=C2=A01 file changed, 56 insertions(+), 1 deletion(-)


Why does this happen? As soon as I have this merge commit a following "sub=
tree push" also pushes this merge commit to the subtree repo and also pushe=
s tags that are not relevant there=2E

I'm out of ideas now=2E

What I want to do: I want to be able to develop on modules, I have in the =
"subtree repo" in every project I want and then push the changes to the sub=
tree repo for pulling into the other projects=2E That's why I don't want to=
 use "squash" as I don't want to do development only in the subtree repo di=
rectly=2E

Thanks for any hints=2E

Manuel
