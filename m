Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573401F461
	for <e@80x24.org>; Wed, 17 Jul 2019 17:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfGQRMZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 13:12:25 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:17460 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfGQRMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 13:12:25 -0400
Date:   Wed, 17 Jul 2019 17:12:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1563383542;
        bh=EtVT6dor07tT9RsS0YopWSI3Jxz+U6FAsHwSz3teY1k=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=enJZL/rrQpupz+9tCXarLzOhe0+9zvX/GX80deG5ju6M9csL+ZJDoElvqAeJwVncQ
         ViT+dshQ5WjBr/XEpV2RZHgBlQA1VKGAPSNW4/L73MYPfC0gQxHLc6fqg9FbdjBMay
         Tsydn5jlyuJ8heYyJlr/4njtEIH1jnWL+p/G90sE=
To:     Junio C Hamano <gitster@pobox.com>
From:   Thurston Stone <tstone2077@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitgitgadget@gmail.com" <gitgitgadget@gmail.com>
Reply-To: Thurston Stone <tstone2077@protonmail.com>
Subject: Re: [gitgitgadget/git] Adding git-ignore command, tests, and documentation. (#264)
Message-ID: <YmOpqT5Q4a9QdU5RJmIbisRhQMnkcZt7GFT7E0xH4cqAWr0mEiHlYzLmpI8eKSPPQDZmQRmfUzdzqxDSb-iBwYhFHtJ6edCFb8I05ld0vFM=@protonmail.com>
In-Reply-To: <gitgitgadget/git/pull/264/c512358757@github.com>
References: <gitgitgadget/git/pull/264@github.com>
 <gitgitgadget/git/pull/264/c512358757@github.com>
Feedback-ID: GoF1_tGGzdAOfV85Q8wDmQNHA892t-4YSi-EkNmyVQICfrmBYcOej3w15ghxke-rA__wGaGMu4zRpxPIzpb40w==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Wouldn't this simpler to type and less error prone, as you do
> have to
>=09$ cd path/to/the
>=09... work in that deep
>=09... realize that file.txt in that directory needs ignoring ...
>=09$ echo file.txt > .gitignore
that would have "path/to/the/.gitignore" which contains "file.txt".
Whereas that does work fine, it can be cumbersome to manage a multitude
gitignore files (it can get out of hand). If a policy is in place to
consolidate this management into the root gitignore, they'd have to run:

$ cd path/to/the
=09... work in that deep directory ...
=09... realize that file.txt in that directory needs ignoring ...
=09... know relative path of both desired ignore file and cwd ...
$ echo path/to/the/file.txt > ../../../.gitignore
=09... or with this script ...
$ git ignore path/to/the/file.txt

Another example might be when the code is deeper embeded, like a
java library path.
$ cd code/src/com/mylib
=09... work under that directory ...
=09... realize subclass/helpers/testdata.json needs ignoring ...
 =09... need to know the full path of ignore file, cwd, and
=09=09the relative path to root gitignore ...
$ echo code/src/com/mylib/subclass/helpers/testdata.json > ../../../../.git=
ignore
- or the more intuitive: -
$ git ignore subclass/helpers/testdata.json
- both ending in the same result
$ cat ${REPO_ROOT}/.gitignore
code/src/com/mylib/subclass/helpers/testdata.json


