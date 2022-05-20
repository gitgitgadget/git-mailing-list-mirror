Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A21C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 04:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345308AbiETEhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 00:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbiETEhg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 00:37:36 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 21:37:35 PDT
Received: from sender4-of-o53.zoho.com (sender4-of-o53.zoho.com [136.143.188.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F008CCC8
        for <git@vger.kernel.org>; Thu, 19 May 2022 21:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653020549; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IC3/Sqk3iNu2j9gUDbuDmY5Y4/efLv1Q76t69q+M3CerwSzZZ/nWPb/nkiZxgPYoEEJ83fFB8+7uDFH39ALBcfZ+7/LKBuvvXDfHc0fJHA8RvYyzfGcDh2ukiuUSufUZdj5aHpLc7w4CrYwVqubxdWeDIKB5O1DAjF3KCVaZbh0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653020549; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=YJpD9loUgRDREcN9EJPPWFd4ZftW8hHTyAyIRrk3+u8=; 
        b=RhyOJucis5x+Iu41AkON3SK6c+7PMBB/52zgVQ0D3mv6pw5ueXhADcqV7IzdiwMev6Px88nIpPaJBcd61/9Spc2KwRS86PmigMdawW1HKjKqEuRNP3/xK3oto8+EHcSLecePvinLtmSL8zfYx5qL5zkwjqVVS7USN65GWz73tsI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=allejo.io;
        spf=pass  smtp.mailfrom=me@allejo.io;
        dmarc=pass header.from=<me@allejo.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653020549;
        s=zoho; d=allejo.io; i=me@allejo.io;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=YJpD9loUgRDREcN9EJPPWFd4ZftW8hHTyAyIRrk3+u8=;
        b=CzgCN1rj4KR2C4Kl4J1dabecOVQDBkvj3Hl4sMtjrheVIJ2QRpjDgvEhT3qTKW5C
        CFcYv2vsuaa8eElEBe+q+SWQNvBDxNCe8aPsMxTzTf5uxDQG2Dczn0pR+J8lZdpitYV
        w+mqK2s4ovvit/tuCum3Gmre8jNv8H1USRgT/PfY=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653020547301331.45592430893544; Thu, 19 May 2022 21:22:27 -0700 (PDT)
Date:   Thu, 19 May 2022 21:22:27 -0700
From:   allejo <me@allejo.io>
To:     "git" <git@vger.kernel.org>
Message-ID: <180dfb3d8d3.12352a818142651.7062268074453572353@allejo.io>
In-Reply-To: 
Subject: =?UTF-8?Q?bug:_`git_diff`_implies_folder_isn=E2=80=99t_a_git_repo?=
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Change ownership of a Git repo to require `safe.directory` behavior.

What did you expect to happen? (Expected behavior)

If you run `git diff --exit-code` on a non-`safe.directory`, you should get the standard error.

    Error: fatal: unsafe repository ('/path/to/repo' is owned by someone else)

What happened instead? (Actual behavior)

I get an error message saying it's not actually a git repository even though it is, it's just not safe to work in.

    warning: Not a git repository. Use --no-index to compare two paths outside a working tree
    usage: git diff --no-index [<options>] <path> <path>

    Diff output format options
        -p, --patch           generate patch
        -s, --no-patch        suppress diff output
        -u                    generate patch
        -U, --unified[=<n>]   generate diffs with <n> lines context
        -W, --function-context
                              generate diffs with <n> lines context
        --raw                 generate the diff in raw format
        --patch-with-raw      synonym for '-p --raw'
        --patch-with-stat     synonym for '-p --stat'
        --numstat             machine friendly --stat
        --shortstat           output only the last line of --stat
        -X, --dirstat[=<param1,param2>...]
                              output the distribution of relative amount of changes for each sub-directory
    ...

What's different between what you expected and what actually happened?

One error message implies the folder isn't a Git repo while the other explicitly says it's not safe to work in and how to fix it.

Anything else you want to add:

I am installing git on Ubuntu 20.04.4 from its default repositories inside of a GitHub Actions runner.

[System Info]
git version:
git version 2.25.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show

