Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450FF1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 21:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756460AbeAHVIv (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 16:08:51 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33151 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932763AbeAHVIu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 16:08:50 -0500
Received: by mail-qk0-f176.google.com with SMTP id i17so11579033qke.0
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 13:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CHeV7CQeTooijun7XwK//6FAO4Liua9odL0HXelIcrg=;
        b=RANkYsCWySmXx/w1g2I8Waxcmd9K9t43freSsKDM28zlKFKPKa0MAspbVzOZZu0HbU
         oIEMXZoa81XkEr88NkTTltz4yC1NBmZAVOGyyUAzK2vJtwjLPbPHa7ehxPkgya4DnirH
         b07gWmrIg+SALsNNUYiHMi/nIwY3nOoguWvgV5p2jijcTwT9Q+zBxgSwjP621rtn2YQE
         qy7sKQPDrUcdVuGqeqoIFrRQuXKZ7ubDTliulINR5lOZiGjZCm+Kc3xTt4I4Jlqs48tw
         eGhb5Ar+gSwSgcoh3Yz6zvLSUxeq6duu/MB34xH3Z1rDMpaLz8bs2fDQTcwRR/Qher6T
         /HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CHeV7CQeTooijun7XwK//6FAO4Liua9odL0HXelIcrg=;
        b=c1RL79nAj73jy27W7aLz5rXmvXwDN/WaP0a681H65UzXACln0Ll6jgQbvZH8wrCtDT
         UI8XrI46Y5wE1hLF0vRuwoLRzGxzSiOlXhXY89AfHjbaMk1fAd4iH4R6fdUPwaeD4Byl
         9iS6fvIYhHnfkLm2WFaxOZmlo8bsy43ICVOu7PkrmWAhfUKNgtPgjRnOkE9f4+Y3b62O
         PNhVpFYd73eWFSX2L+0mbQ3zXT2DOcxpj9aZQvhmenZvd4Ppl7BsgKMaemkYY3gIwqmO
         BStqBb0AkxqNPNn+YnI9/BJNIuzkJrQKbNwMfAf9VuFYBoHtE4mPLL02IMC0RdU6Pl6d
         SxaA==
X-Gm-Message-State: AKwxytehirGD2cV42Bu0KS4XSrLYuWyGzClWMUVEMIjHswidg1ByAV5O
        1XsJPp9kgybMzxJEqaLql/QDbJSXlRnaLOBdroACHQ5Um4w=
X-Google-Smtp-Source: ACJfBosV5UW2rpPFc6muTkApsqRdIqikfLR09g10myINY3KY7GeTaZfPlHupz1kJEI22n1DGGmOTFrJ3v1D0F1zVMrA=
X-Received: by 10.55.207.86 with SMTP id e83mr10728441qkj.157.1515445726875;
 Mon, 08 Jan 2018 13:08:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.55.53.65 with HTTP; Mon, 8 Jan 2018 13:08:46 -0800 (PST)
From:   Per Cederqvist <cederp@opera.com>
Date:   Mon, 8 Jan 2018 22:08:46 +0100
Message-ID: <CAP=KgsSQOG=mmUDfSFDw0HJYvJWVPFU7M5T+k4VhfuRC_v9dww@mail.gmail.com>
Subject: cherry-picking fails after making a directory a submodule
To:     git@vger.kernel.org
Cc:     Per Cederqvist <cederp@opera.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a situation where I have switched a directory from being a
subdirectory to being a submodule.  I then try to cherry-pick a commit
from a taskbranch that was made before the switch to the master
branch.  The commit touches a file outside the subdirectory/submodule.
Yet "git cherry-pick" fails with this error message:

> error: could not apply 78c403e... Add a project feature
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'

I can resolve the situation by running "git add libfoo && git
cherry-pick --continue".  The generated commit contains no changes to
"libfoo".

I don't understand why I need to manually add libfoo, as the commit
I'm cherry-picking doesn't touch anything in libfoo.

The script below can reproduce the issue.  Tested with git 2.15.1,
2.14.0 and 2.8.0, all with the same result.

Is this a bug in "git cherry-pick"?

-- cut here for cherry-across-submodule --
#!/bin/sh
#
# This script creates a simple repo, where the "libfoo" directory
# initially is a normal directory, but later becomes a git submodule.
# It then tries to cherry-pick a commit (that doesn't touch libfoo)
# that was created before the conversion to master (after the
# conversion).  This fails for unclear reasons.

# I've tested this with the following git versions:
#  - 2.8.0
#  - 2.14.0
#  - 2.15.1
#
# They all behave the same

# export PATH=/usr/local/git-2.15.1/bin:$PATH

set -e -x

git --version

# Refuse to run if this directory already exists, to prevent data loss.
mkdir cherry-across-submodule-root
cd cherry-across-submodule-root

mkdir root
(cd root && git init --bare libfoo.git)
(cd root && git init --bare project.git)

mkdir workspace
(cd workspace && git clone ../root/libfoo)
(cd workspace && git clone ../root/project)

proj_commit ()
{
    (cd workspace/project &&
printf "$1\n" >> $2 &&
git add $2 &&
git commit -m"$3")
}

foo_commit ()
{
    (cd workspace/libfoo &&
printf "$1\n" >> $2 &&
git add $2 &&
git commit -m"$3")
}

both_commit ()
{
    foo_commit "$1" $2 "$3"
    proj_commit "$1" libfoo/$2 "Imported libfoo: $3"
}

proj_commit "This is a project" README "Started the project"
mkdir workspace/project/libfoo
both_commit "This is a library" README "Started the library"
both_commit "all:\n\ttouch libfoo.a" Makefile "Build something"
proj_commit "all:\n\tmake -C libfoo" Makefile "Build libfoo"
proj_commit "ceder" AUTHORS "I made this"
both_commit "GPL" "COPYING" "Add license info"
(cd workspace/libfoo && git push)
(cd workspace/project && git push)
(cd workspace/project && git checkout -b task-1)
proj_commit "int feature() { return 17; }" feature.c "Add a project feature"
(cd workspace/project && git push -u origin task-1)

assert_clean()
{
    (cd workspace/project &&
[ -z "`git status --porcelain`" ] )
}

# Cherrypicking task-1 to task-2 works fine.
(cd workspace/project && git checkout -b task-2 master && git
cherry-pick task-1)
assert_clean

(cd workspace/project &&
     git checkout master &&
     git rm -r libfoo &&
     git submodule add -b master ../libfoo.git libfoo &&
     git commit -m"Made libfoo a submodule")
assert_clean


# Now suddenly cherrypicking fails?  I get this message from the
# cherry-pick command:

# error: could not apply 78c403e... Add a project feature
# hint: after resolving the conflicts, mark the corrected paths
# hint: with 'git add <paths>' or 'git rm <paths>'
# hint: and commit the result with 'git commit'

(cd workspace/project && git checkout -b task-3 master && git
cherry-pick task-1)

# At this point, "git status --porcelain" prints two lines:
# A  feature.c
# AU libfoo

assert_clean
-- cut here for cherry-across-submodule --

    /ceder
