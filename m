Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35AA020372
	for <e@80x24.org>; Mon,  9 Oct 2017 21:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbdJIV3E (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 17:29:04 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:34870 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751156AbdJIV3D (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Oct 2017 17:29:03 -0400
Received: from app10-neu.ox.hosteurope.de ([92.51.170.144] helo=null); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1e1fbh-0001l0-Mx; Mon, 09 Oct 2017 23:29:01 +0200
Date:   Mon, 9 Oct 2017 23:29:01 +0200 (CEST)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Message-ID: <788230417.115707.1507584541605@ox.hosteurope.de>
Subject: Branch switching with submodules where the submodule replaces a
 folder aborts unexpectedly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev10
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1507584543;14416229;
X-HE-SMSGID: 1e1fbh-0001l0-Mx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm currently in the progress of pulling some subprojects in a git repository of mine into their own repositories and adding these subprojects back as submodules.

While doing this I enountered a potential bug as checkout complains on branch switching that a file already exists.

I've reproduced it on debian stretch with the following git versions:

master:
git version 2.15.0.rc0.39.g2f0e14e649
pu:
git version 2.15.0.rc0.245.g6d586db062

A script to trigger it is

mkdir -p test/subproject
cd test
git init
touch subproject/1
git add subproject
git commit -m "blah"
cd ..
mkdir subproject
cd subproject
git init
touch 1
git add 1
git commit -m "blubb"
cd ../test
git branch old
git rm -rf subproject
git commit -m "remove blah"
git submodule add ../subproject
git add -A
git commit -m "added subproject"
git branch new
git checkout old

and this fails with 

$LANG=C ./run.sh 
Initialized empty Git repository in /home/XXX/devel/test/.git/
[master (root-commit) 33e6607] blah
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 subproject/1
Initialized empty Git repository in /home/XXX/devel/subproject/.git/
[master (root-commit) e817644] blubb
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 1
rm 'subproject/1'
[master 9cbfd57] remove blah
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 subproject/1
Cloning into '/home/XXX/devel/test/subproject'...
done.
[master 1c67e23] added subproject
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 subproject
error: The following untracked working tree files would be overwritten by checkout:
        subproject/1
Please move or remove them before you switch branches.
Aborting

If I'm misusing git here I'm glad for any advice.

Thanks,
Thomas
