Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43B61F424
	for <e@80x24.org>; Mon, 18 Dec 2017 23:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935170AbdLRXSq (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 18:18:46 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:39558 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759793AbdLRXSp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 18:18:45 -0500
Received: by mail-pf0-f178.google.com with SMTP id l24so10338543pfj.6
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 15:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BA/zoADm+beGQgSEFg9iuVNHEviecOxKh3B4PifACfg=;
        b=pl6JlI1s6gLqXULq3Eq5FmO6yrjU2pDJUsRBWRew6SItcl3cj6dzdIuLWrn1wKOXhX
         dRgUDyaHC+pDKQf4vrTzwReywbvokvUAMn9CCuFiF6IW7Ld4RfJQhwAGlGY1xAilSHIx
         l2fNgGKfXOsvzS4SMlHVNrXmSnSuR/krnP+3RbFQ02y+TAa5qhH74RVfJKbJvbPoHc9K
         /ilCCNBEBJ1OQNcvdHAHOAEhrn4DAFagTxLl96oGKdw6NGfKPrqUUAepx+li1gbrHDMu
         fvzutB8RToH4JmO4qtwB1NTrAkEFRg2plNJ3lriVB5Vk9XG/zrTYzkXfPWgg/j25z5RY
         NZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BA/zoADm+beGQgSEFg9iuVNHEviecOxKh3B4PifACfg=;
        b=dRD8NvyaTD3F4ncK+lluZSThtI2ynpUe3R+tv/0fbaV3ZkAe8JYJ6+JL66sFaMUWkp
         duhcOfgDVM79s63EBHey7mnzQwq2R5eBvi1ES1ei63/9uz247fQRXkKiuBYqb06Zh8z7
         E39/Ks0NHBlCJvEIbVKoO9aV1V/oAZQ7kFH+ZJRFWtZHnQOaolRJn3zggqO16k00IcOi
         rhruNTHxdtIyk8d7zMZ6VvdzUnLHuvMP6I5mrupuG1sJhKADD08S02Ur+LHJU2CxoXFX
         CSoyvKqm5fAzec8KJjEQn8nipEFvtYFDIHofOvoPZvZjtjnJR6b2e1KVa6QbBOKcdXZd
         AgmA==
X-Gm-Message-State: AKGB3mJRF0KbritIzVhs7l8G1FjsUwKPtFP64vODyYiw+6DQnQ8oCuJd
        tEx1sNIJmI8kuhT806Dnt+gO6FPQyUijE5mIGPyyPFcx
X-Google-Smtp-Source: ACJfBosdowtQsZE9SX0pR7biHI7sJVoJ/LTsNBNB6QCT7n82EZgvXve83WAgivitt3MPF2OQK6X8h1Q8iP1KGAKtPMQ=
X-Received: by 10.99.115.26 with SMTP id o26mr1096949pgc.233.1513639125037;
 Mon, 18 Dec 2017 15:18:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.129.8 with HTTP; Mon, 18 Dec 2017 15:18:24 -0800 (PST)
From:   Andreas Urke <arurke@gmail.com>
Date:   Tue, 19 Dec 2017 00:18:24 +0100
Message-ID: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
Subject: Bug with "git submodule update" + subrepo with differing path/name?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a repo with two submodules. I regularly use "git submodule
update", which works fine for one subrepo, but not for the other. The
only relevant difference I can think of between these two subrepos is
that the latter one does not have a matching path and name:

$ cat .gitmodules
[submodule "subrepo1"]
    path = subrepo1
    url = git@gitlab.com:subrepo1.git
[submodule "name_subrepo2"]
    path = subrepo2
    url = git@gitlab.com:name_subrepo2.git

And a reproduction looks like this:

$ git --version
git version 2.15.1

$ git status
HEAD detached at 05412d4
Changes not staged for commit:

modified:   subrepo1 (new commits)
modified:   subrepo2 (new commits)

$ git submodule update
Submodule path 'subrepo1': checked out
'e4785498130ec4188bb1745f27e311bff08ed4c8'

$ git status
HEAD detached at 05412d4
Changes not staged for commit:

modified:   subrepo2  (new commits)

Checking out the relevant commit manually in subrepo2 works fine (and
is what I end up doing).

Regards,
Andreas Urke
