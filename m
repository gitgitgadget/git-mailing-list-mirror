Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3111F461
	for <e@80x24.org>; Tue, 16 Jul 2019 21:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfGPVtu (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 17:49:50 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58539 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPVtu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 17:49:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190716214948euoutp0142c8e9b53e7ea026cd0fc707a09c8da9~yAZujdjzs1369613696euoutp01n
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 21:49:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190716214948euoutp0142c8e9b53e7ea026cd0fc707a09c8da9~yAZujdjzs1369613696euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563313788;
        bh=qbKNko5nNNKSDHrlnLx1PMILp24coWnW673c0iKIRVY=;
        h=To:Cc:From:Subject:Date:References:From;
        b=uoCJWlo8mAmolPXoxtuWdHR2rAWeY54ayoibcyde9251MyaqzTvsU9A7oF4dcdURS
         1+005f1R2b+oUk0KWs6/X89+rp+DUZiTfZBXtoB5S+VOUoHzla8qSX2wHHCkepf59D
         itkbn1B1gYWRRsIkWFrscv1SxFbrcSlhuK8N/TRQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190716214947eucas1p1a433b297eed97f54988cd54c5c1fbd83~yAZtQjEoS2498924989eucas1p1u;
        Tue, 16 Jul 2019 21:49:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EC.9E.04377.A764E2D5; Tue, 16
        Jul 2019 22:49:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190716214945eucas1p299e23651b7bc1738d0c3bf2d227d4e46~yAZruVKI_0741507415eucas1p2u;
        Tue, 16 Jul 2019 21:49:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716214945eusmtrp265378d5cf4c8f288f794f6bfa95091c2~yAZrgXYJK2373123731eusmtrp2c;
        Tue, 16 Jul 2019 21:49:45 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-a3-5d2e467adb1a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 96.45.04146.9764E2D5; Tue, 16
        Jul 2019 22:49:45 +0100 (BST)
Received: from [192.168.56.1] (unknown [106.210.237.40]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716214944eusmtip226d2a3bf5bb30b7462461e5557778cdc~yAZq_z5jd2427624276eusmtip25;
        Tue, 16 Jul 2019 21:49:44 +0000 (GMT)
To:     git@vger.kernel.org
Cc:     cedric.ollivier@orange.com,
        DEBEAU Eric IMT/OLN <eric.debeau@orange.com>
From:   Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: [BUG] Recursive submodules fails to track branch correctly if . is
 used
Message-ID: <08844c07-5192-0645-9bfc-62e1b16e39a8@samsung.com>
Date:   Tue, 16 Jul 2019 23:49:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzned0qN71Yg67DFhYfF81gsth98yuj
        RdeVbiYHZo+WZyfZPD5vkgtgiuKySUnNySxLLdK3S+DKeHb5KlPBBdGKHa1L2BsYJwh2MXJy
        SAiYSEztPc7cxcjFISSwglHi+sK3jBDOF0aJEwcfskA4nxklHvWtZodpOdZ2kBHEFhJYziix
        YI4vRNFbRomZm7vAikQExCXeHp8JZjML+Ehc+dwM1MDBwSagLzFvlyhIWFggSOLk2XNgJbwC
        dhJN058yg9gsAqoS2xYfBpsvKhAhcerIPBaIGkGJkzOfsECMFJe49WQ+E4QtL7H97RywFyQE
        HrNJHJk3mRHiUBeJ2XuOQh0tLPHq+BYoW0bi/06QZpCGZkaJr0dPsEE4PYwSu95AXCohYC3x
        booNiMksoCmxfpc+RK+jxOmHx1kgKvgkbrwVhLiBT2LStunMEGFeiY42IYhqZYn77Q9YIWxJ
        ie+rd0Nd4CGxZeZNxgmMirOQfDYLyWezkHw2C+GGBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz
        0vWS83M3MQJTx+l/x7/sYNz1J+kQowAHoxIPr8dh3Vgh1sSy4srcQ4wSHMxKIry2X7VjhXhT
        EiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTDuODjrbVaynnDx
        5OMT3c9z6h6of+XO7rkqIcXtawnjdxEzpsy1H5oFPdqlCxf/2HDhzlmbazsrZ22/b/FMzpev
        1OB20BErhf2tcie2OqVJ5202MHhzmUlJruvz79wkyb/9Z1bXnzCrc9+R2ndk/hlBdt8ot0/P
        n27XbJlgsXhv66KzRczd32YrsRRnJBpqMRcVJwIAovnr8RkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e/4Pd1KN71YgzNrmC0+LprBZLH75ldG
        i64r3UwOzB4tz06yeXzeJBfAFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSq
        pG9nk5Kak1mWWqRvl6CX8ezyVaaCC6IVO1qXsDcwThDsYuTkkBAwkTjWdpCxi5GLQ0hgKaNE
        x+5uFoiEpMT0FyeYIWxhiT/Xutggil4zSnxZfYsRJCEiIC7x9vhMdhCbWcBH4srnZqA4Bweb
        gL7EvF2iIGFhgSCJk2fPgZXwCthJNE1/CjaTRUBVYtviw2BjRAUiJCZd28kCUSMocXLmExaI
        kWYS8zY/ZIawxSVuPZnPBGHLS2x/O4d5AqPALCQts5C0zELSMgtJywJGllWMIqmlxbnpucWG
        esWJucWleel6yfm5mxiBwb/t2M/NOxgvbQw+xCjAwajEw+txWDdWiDWxrLgy9xCjBAezkgiv
        7VftWCHelMTKqtSi/Pii0pzU4kOMpkAPTWSWEk3OB0ZmXkm8oamhuYWlobmxubGZhZI4b4fA
        wRghgfTEktTs1NSC1CKYPiYOTqkGxoQEaf7TDs6tq9PLXk/frJ382urpaUn3yTUOgnbrP6be
        ltwnMsHV+OhhN/k9rL+PCOgtntAXmLvHSt6srEAlIcgn4Qi7N9OWuql3Ju2VYXr5Kyr0ysw7
        TXrNF2JPba/el33mibHwDAG1pS3G4ToX0gPvPE25sVl2kab+/fcNnreM277wnF8zWYmlOCPR
        UIu5qDgRAMilCdiUAgAA
X-CMS-MailID: 20190716214945eucas1p299e23651b7bc1738d0c3bf2d227d4e46
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190716214945eucas1p299e23651b7bc1738d0c3bf2d227d4e46
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190716214945eucas1p299e23651b7bc1738d0c3bf2d227d4e46
References: <CGME20190716214945eucas1p299e23651b7bc1738d0c3bf2d227d4e46@eucas1p2.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git community,

I'd like to report you a potential bug in git submodule implementation.

* Problem statement

According to doc a special value of "." can be used as a branch name to 
track. This means that git should trace the same branch as is currently 
in use in superproject. This works perfectly fine as long as you don't 
try to add superproject (SUP1) with such configuration as a submodule to 
another superproject (SUP2). The nesting structure would look like this:

SUP2
     - SUP1
         - SUB_PROJECT

If you try to do this you won't be able to execute any of the following 
commands:

$ git clone --recursive SUP2

$ git clone SUP2 & git submodule update --init --recursive --remote

$ git submodule update --init --recursive --remote

as every time you will get an error message similar to this one:

fatal: Submodule (SUB_PROJECT) branch configured to inherit branch from 
superproject, but the superproject is not on any branch
fatal: Needed a single revision
Unable to find current origin/ revision in submodule path 'SUB_PROJECT'

* Initial investigation results

The error message comes from remote_submodule_branch():1938 in 
submodule--helper.c and it is generated called from SUP1 dir (due to 
--recursive flag). Actually this function behaves correctly. If you go 
to SUP1 dir and check the branch info you will notice that the repo is 
in detached head state.

* Probable root cause

The root cause is that the traced branch information is never propagated 
to the submodules. All the submodules are always initialized in a 
detached head state and there is no way to change this behavior nor to 
propagate the traced branch information to submodules.

* Workaround script

I managed to workaround this bug by dropping the recursive option and 
after the top level project has been cloned I go through every 
submodule, set local branch to point to current head and then just do 
git checkout and I do this recursively in all modules. After this I'm 
able to successfully execute:

$ git submodule update --rebase --recursive --remote

The script (to be executed in SUP2 right after clone):

#!/bin/bash

function prepare_submodules {
	git submodule update --init
	local SUBMODULE_LIST=`git submodule--helper status | awk '{print $2}'`
	while read -r submod; do
		local PARENT_DIR=`pwd`
		local BRANCH=`git submodule--helper remote-branch ${submod}`

		cd ${submod}
		git branch -f ${BRANCH} HEAD;
		git checkout ${BRANCH}
		if [ ! -z "`git submodule status`" ]; then
			prepare_submodules;
		fi
		cd ${PARENT_DIR}
	done <<< "$SUBMODULE_LIST"
}

prepare_submodules

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
