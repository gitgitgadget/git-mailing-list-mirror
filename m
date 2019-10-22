Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D761F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 11:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbfJVLr4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 07:47:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47758 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbfJVLr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 07:47:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MBd6SS084765;
        Tue, 22 Oct 2019 11:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=xfmGuIp9pKAfHA9jjndbE4tfsKdFPpvxcdShsE+VFYw=;
 b=jCFAdM+yP9Qa0i6Mgu28wN86I/W2nfDLRQHfz/QGUtcTHogB4kgv/Jy5eAOgl6QOYkjs
 lrb2Vg/MmHMp0HVr9iBYYhnGkFrXDmvToDZbNiokUikevQo9cVah0yONLt1Ula4QKG3N
 H94fqCgQHdUl08nfSE4qE7z28QC7LGyqsxoULtDnWJpxHdF4gck8gcZNuCX7a1CHo21/
 Lqw08r1hMdSFr+G8hIIne2fSHB0Kebf4JWwOVk9GCTNVL+zLRbfiVPo4v5SNZ7KQ7f+d
 xfeE2YfxWlMmFEG7GxI8eSu2DvBaezjPDO6Bg2lBrJ7tDX53BSxm6FJQwUBKxO8JRHoB tA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vqu4qnutp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 11:47:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MBcB1X092692;
        Tue, 22 Oct 2019 11:47:46 GMT
Received: from t460.home (dhcp-10-175-28-77.vpn.oracle.com [10.175.28.77])
        by aserp3030.oracle.com with ESMTP id 2vsx22jmx3-1;
        Tue, 22 Oct 2019 11:47:45 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 0/3] format-patch --complete / am --exact
Date:   Tue, 22 Oct 2019 13:45:15 +0200
Message-Id: <20191022114518.32055-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.24.0.rc0.3.g4ba423c3c2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220107
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[I'm intentionally keeping the recipient list short to avoid hitting
the Oracle spam filter on outgoing email, hopefully everybody on the
git side who is interested will receive this via the mailing list and
I will link this submission from the workflows list too.]

Background:

There seems to be a consensus in the Linux kernel development community
that tracking patches, patchsets, reviews, and discussion of said patches
is too difficult. One big problem is that there is often no reference to
the email discussion in git history once the patch has been merged.

In order to simplify the tracking of patches, I proposed in [1] that we
include enough metadata about a patch to reconstruct the commit SHA1s
when emailing patches; this means that, assuming a patchset is based on
a publicly available parent SHA1, we can track email patches in git and
use the git SHA1 as a stable reference to a particular submission or its
corresponding discussion. I basically view this as a foundation on which
we can build a richer kernel development experience without sacrificing
the current email-based workflow.

Since I started working on this feature, I also realised that 'git am'
already has a mechanism to amend changelogs with a reference to the
"Message-Id" of the email of a patch using the --message-id flag, and
while this should IMHO be used a lot more for the kernel, it does not
completely offset the utility of these patches.

I'm sending out an early v2 to get more feedback on the implementation,
exact choice of flags and terminology (--exact, --complete, "metadata",
etc.), changelogs.

Changes since v1:
 - moved metadata to the bottom of the diff
 - fixes to pass existing tests (0023, 3403, 4150, 4256, 5100)
 - handles format=flowed (best effort)
 - better changelogs
 - documentation
 - new tests

Todo:
 - 'git am --no-exact' _with_ known metadata could append the original
   sha1 (and/or mail reference) to the changelog
 - UTF-8/non-ASCII encodings
 - 'git am' error handling (e.g. wrong base)
 - more tests: --range-diff, --base=auto, 'am -s', etc.
 - GPG-signed commits [2]

Out of scope for now:
 - Ted's suggestion of a new flag for the base [3]
 - in-transit mangling
 - minisigs
 - empty commits and/or merge commits [4]

[1] https://lore.kernel.org/workflows/b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com/
[2] https://lore.kernel.org/workflows/56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com/
[3] https://lore.kernel.org/workflows/20191017144708.GI25548@mit.edu/
[4] https://lore.kernel.org/workflows/xmqqeezc83i6.fsf@gitster-ct.c.googlers.com/


