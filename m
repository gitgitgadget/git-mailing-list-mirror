Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB25B1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 12:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeJSUtN (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 16:49:13 -0400
Received: from emailsecure.uni-linz.ac.at ([140.78.3.66]:57251 "EHLO
        emailsecure.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727187AbeJSUtN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Oct 2018 16:49:13 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 16:49:12 EDT
Received: from [140.78.116.84] (unknown [140.78.116.84])
        by emailsecure.uni-linz.ac.at (Postfix) with ESMTPSA id CDC40FEB95;
        Fri, 19 Oct 2018 14:33:54 +0200 (CEST)
From:   Juergen Vogl <juergen.vogl@jku.at>
Subject: Bug with "git mv" and submodules, and with "git submodule add
 something --force"
Organization: Institute of Applied Geometry
To:     git@vger.kernel.org
Message-ID: <c4792c95-9a19-fd0e-9171-fded095b78a6@jku.at>
Date:   Fri, 19 Oct 2018 14:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

tested on both, git 2.18 and git 2.19.1:

moving a file with `git mv` from a project to a submodule results in an
**undefined state** of the local repository.

It breaks up the submodule (it's still in .gitmodules, but not
accessable via `git submodule`), and is not reversible on local repository.

Either `git mv submodule/file .` nor deleting the folder works. For the
locale repo the submodule is gone. But: trying to add it with `git
submodule add` also do not work and results in an error message (with
and without `--force` flag):

$ git submodule add git@github.com:-----------/wiki-public.git public
--force
A git directory for 'public' is found locally with remote(s):
  origin        git@github.com:-----------/wiki-public.git
If you want to reuse this local git directory instead of cloning again from
  git@github.com:-----------/wiki-public.git
use the '--force' option. If the local git directory is not the correct repo
or you are unsure what this means choose another name with the '--name'
option.

Therefore, it's in a undefined, broken state.


Another bug I've got by testing upper line:
* --force will be used as folder name * when used in `git submodule add
git@github.com:someone/some.git --force`:

$ git submodule add git@github.com:---/wiki-public.git --force
Cloning into '/home/---/---/---/---/wiki-internal.wiki/--force'...
remote: Enumerating objects: 29, done.
remote: Counting objects: 100% (29/29), done.
remote: Compressing objects: 100% (25/25), done.
remote: Total 29 (delta 5), reused 20 (delta 2), pack-reused 0
Receiving objects: 100% (29/29), 37.03 KiB | 421.00 KiB/s, done.
Resolving deltas: 100% (5/5), done.
/usr/libexec/git-core/git-submodule: line 273: cd: --: invalid option
cd: usage: cd [-L|-P] [dir]
Unable to checkout submodule '--force'

but it creates the `--force` folder:

$ tree
.
├── --force

Best,

Jürgen Vogl

