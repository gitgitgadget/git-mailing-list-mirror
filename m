Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5182B1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 23:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbeKLJic (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 04:38:32 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:36856 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732153AbeKLJib (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 04:38:31 -0500
Received: by mail-ed1-f44.google.com with SMTP id a2-v6so5956123edt.3
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 15:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ThPuxpBOlSrZeZVaFovrudHS6x/CYrtWTNG3fJmG8NU=;
        b=JCBQigQncr7UjoD3qG23lgPW+JXSKNN7ST5IiWjurK8byKZx0fLqwWmN+NtCVrU9ve
         LrlMaRAdnW8iWyQZAhMKtH9k0GBDldRn2n8CZatjyTiK4PCZkoFlvK74ur2L0M6UVaFI
         6RYjuX7KQ26Skd0RDNwfrpMTIStKDAqe2Lqmi4NMVoaOExggqXsukx0KwHhVxUo+mgyo
         59YeHSauP9K3UDpzkf1owIZBfCENWpRupk4mrvsUSqUdMbTpJm1BwsIUlFyQaleaUsVj
         OaqofWFhDuaUoFb1z7Ws5nonj+1pEuMxUHUFNgCehdTFczdJ48J8gX36wAuNfpDaAGgh
         Rhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ThPuxpBOlSrZeZVaFovrudHS6x/CYrtWTNG3fJmG8NU=;
        b=KTmgpGnC6KIzzpBD67EUTUp4duIr8Vq/m26tMNxiyHMlqUWAHUo18HkOWGs5OKd8C4
         y641aiRsM4hi/WGbDTmL++BI5z02S0czhpOG4Nr7nKUIa7uNlJDSpeRCq0y5kzJYUqK/
         x55tzuI9439zZw2nGbfHtoFyMzXR9p8PwVs6g+XYLGgGM+zLjM1OJUfum5EdS0UDzf1O
         BYkWBpInCMKjUwJ6n8g//3fzxWLbyO0YB6ENMx3X/YjnwtSngcFS1OO2KkHSrCNPNy3Q
         A8vgPXwYzW6TkCGdblnKfJQJWVSC8tAP1L1PlFfaE0hBzH4rqtkdcpLmuZomlQ6bFSi9
         raDw==
X-Gm-Message-State: AGRZ1gIX1LbDL3xUmZ0IRIGFnvt+vxLosjxtcYWCngCaK/18TTQJucEr
        z5Pcy8/P+kH2V/loJzec/Yt9MD2rWh5GrGlnftLPIXZYAUPksDho
X-Google-Smtp-Source: AJdET5eKj5WoS7cGCk+5VBJxSBbII5/BfK1+So0jngkLgo9/u+wUyEPyM68nVcMFRg7J0qO7mdzhZ6Cn2hzBs5jzsKU=
X-Received: by 2002:a17:906:7087:: with SMTP id b7-v6mr7786493ejk.194.1541980089045;
 Sun, 11 Nov 2018 15:48:09 -0800 (PST)
MIME-Version: 1.0
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Mon, 12 Nov 2018 00:47:42 +0100
Message-ID: <CABUeae-Bk5hxEsLuDi=MytzN-kBG0D4psLbc_1=B+=70D=JKCQ@mail.gmail.com>
Subject: Migration to Git LFS inflates repository multiple times
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm posting here for the first time and I hope it's the right place to ask
questions about Git LFS.

TL;TR: Is this normal a repository migrated to Git LFS inflates multiple times
and how to deal with it?

I'm migrating a big SVN repository to Git.
In SVN, a collection of third-party SDKs is maintained along with codebase.
Many of the third-party libraries come in binary form.
So, I'm migrating binary files of those to Git LFS.

I'm following the Git LFS tutorial,
section "Migrating existing repository data to LFS"
https://github.com/git-lfs/git-lfs/wiki/Tutorial

First, I run initial translation of the SVN reoi into Git..
The new repository is a Git bare repository.
There are 5 branches and 10+ tags in the proj.git repo.

It is quite large:

proj.git (BARE:master) $ du -sh
19G

Next, I performed the following sequence of steps to optimise it
and migrate to Git LFS:

1. Optimise the repo

proj.git (BARE:master) $ git gc
Enumerating objects: 1432599, done.
Counting objects: 100% (1432599/1432599), done.
Delta compression using up to 48 threads
Compressing objects: 100% (864524/864524), done.
Writing objects: 100% (1432599/1432599), done.
Total 1432599 (delta 541698), reused 1405922 (delta 525738)
Removing duplicate objects: 100% (256/256), done.
Checking connectivity: 1432599, done.

proj.git (BARE:master) $ du -sh
11G

2. List the file types taking up the most space in the repo

proj.git (BARE:master) $ git lfs migrate info --everything
migrate: Sorting commits: ..., done
migrate: Examining commits: 100% (29412/29412), done
*.lib   27 GB       3524/3524 files(s)  100%
*.pdb   5.6 GB      1412/1412 files(s)  100%
*.cpp   4.8 GB  131848/131854 files(s)  100%
*.exe   2.3 GB        798/798 files(s)  100%
*.dll   2.0 GB      1000/1000 files(s)  100%

3. Migrate the repo to Git LFS

proj.git (BARE:master) $ git lfs migrate import
--include="*.exe,*.dll,*.lib,*.pdb,*.zip" --everything

4. Check size of the repo after migration to Git LFS

proj.git (BARE:master) $ du -sh
47G

5. Cleaning up the `.git` directory after migration to Git LFS

proj.git (BARE:master) $ git reflog expire --expire-unreachable=now --all

proj.git (BARE:master) $ git gc --prune=now --aggressive
Enumerating objects: 1462310, done.
Counting objects: 100% (1462310/1462310), done.
Delta compression using up to 48 threads
Compressing objects: 100% (1422322/1422322), done.
Writing objects: 100% (1462310/1462310), done.
Total 1462310 (delta 577640), reused 845097 (delta 0)
Removing duplicate objects: 100% (256/256), done.
Checking connectivity: 1462310, done.

6. Check final disk size of the repo

proj.git (BARE:master) $ du -sh
39G

7. List the file types taking up the most space in the repository
after migration to Git LFS

proj.git (BARE:master) $ git lfs migrate info --everything
migrate: Sorting commits: ..., done
migrate: Examining commits: 100% (29412/29412), done
*.cpp   4.8 GB  131848/131854 files(s)  100%
*.png   1.1 GB  696499/696499 files(s)  100%
*.h     828 MB    86386/86471 files(s)  100%
*.csv   820 MB        939/939 files(s)  100%
*.html  686 MB    34126/34126 files(s)  100%


Now, I'm looking for anaswers to the following questions:

1. Is the procedure presented above correct to migrate (SVN ->) Git -> Git LFS?

2. Given the initial translation to Git generated 19 GB repo
(optimised to 11 GB)
is this normal Git LFS migration inflates the repository
to 47 GB (optimised ot 39 GB)?

3. Why the inflation happens? Is this a function of number of branches?
   How to understand the jump from 11 GB to 39 GB?

4. How to optimise the repository to cut the size down further?

My next step is to somehow push the fat pig into GitHub, Bitbucket or
Azure DevOps ;-)

I've used Git for a few years, but I'm pretty newbie regarding low-level
or administration tasks, so I might have made basic errors.
I'll be thankful for any feedback.

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
