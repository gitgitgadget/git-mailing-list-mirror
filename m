Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38E9C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 05:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8912073D
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 05:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="1KjeJJ5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfLLFC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 00:02:56 -0500
Received: from mr85p00im-ztdg06021701.me.com ([17.58.23.196]:36787 "EHLO
        mr85p00im-ztdg06021701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbfLLFC4 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Dec 2019 00:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1576126975;
        bh=izHNdI9sWrClH7sjbByXAyUHukp+TxxoaO2uaaja43I=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=1KjeJJ5eQJvVjtuD4HcGzOuMav31xV3PLHSGAzUA9DKWN7Wi2w6ZYGvLFx7zvMo+w
         2JjtAVVfIzcdEy7rg2dlKMiDLu/QHEPxSij+3l4sje4KTte7pjm8ufPwIT6Nk9rUK4
         vuMOZje0AXI2IQOIllKKD4osO6XH85oEI91VfJOqwrn3oYCgPqPftjZYY6/h8u80nq
         bkITGa7wP6G5nGbBso/bfJcNDg8NMajp6rL3E5LdKdxD1FVNUKMhz3WCChmdH2ChWi
         d9zTchgS+TebwZdiZN7Cp7/UmqNcxN3mUVCb9E8RYbZYFlREGlSpVq4j67nhNaLk3/
         dl/GUjVi9Emxw==
Received: from [10.100.6.188] (unknown [49.255.65.138])
        by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id EF954A0148C;
        Thu, 12 Dec 2019 05:02:53 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
From:   Tom Clarkson <tqclarkson@icloud.com>
In-Reply-To: <038c72f0349174bb92e1dd9c3b38f02543ba1d95.camel@swri.org>
Date:   Thu, 12 Dec 2019 16:02:50 +1100
Cc:     "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "marc@msys.ch" <marc@msys.ch>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C8CA727-370E-4CEE-BBF9-F336C5921D98@icloud.com>
References: <nycvar.QRO.7.76.6.1912091615200.31080@tvgsbejvaqbjf.bet>
 <7E95BE86-BD96-482F-9ECA-DBDD9C10D114@msys.ch>
 <nycvar.QRO.7.76.6.1912092037540.31080@tvgsbejvaqbjf.bet>
 <D99ED706-EC49-4A52-8186-5C9B0B5BC744@icloud.com>
 <038c72f0349174bb92e1dd9c3b38f02543ba1d95.camel@swri.org>
To:     "Strain, Roger L." <roger.strain@swri.org>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=875 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912120029
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> This makes me wonder if the problem is perhaps related to the hardware
> involved; maybe the algorithm is doing exactly what it should, but the
> available RAM isn't sufficient. If that's the problem, perhaps we =
could
> find a way to perform the recursive work without using actual
> recursion, reducing the number of instances on the stack.

It=E2=80=99s not so much hardware as OS I think - After adding stack =
depth (the indent parameter on check_parents) to the log, I have been =
able to get different results with ulimit settings.

With the default stack size on macOS of 8MB, It falls over at depth 445. =
Being less than the shortest path to the root commit, that matches my =
initial count, which was just the number of lines in the log.

Reducing the stack size with ulimit -s 4096 makes it fall over at 225

Increasing to the hard limit of 64MB should allow a depth of around =
4000, and as it turns out that did allow the script to complete, =
reaching a maximum depth of 1148.

I=E2=80=99m not seeing any issues with the hashes being wrong (all show =
no parents or subtree) but processing all those commits that resolve to =
nothing does take forever.

The mainline commit test seems to work ok on my repo, but it=E2=80=99s =
fairly easy to see scenarios where it would break, such as having a  =
subfolder with the same name within the subtree.

So while part of the fix will be a more reliable test, it also needs to =
work before parent commits are processed to mitigate the recursion =
issues.

The rules I have  come up with so far are below. There are still =
scenarios where the recursion is unavoidable such as running an initial =
split on a large repo, but that should be much less common than using a =
small subtree with a more complex existing repo.

In the initial setup of cmd_split, collect some extra information:

	- Add rev-list of all git-subtree-split values to the cache. =
I=E2=80=99d expect subtrees to usually be smaller than mainline, but =
since we can do that non-recursively we may as well.

	- Find the git-subtree-mainline value from subtree add/rejoin. =
Anything in its rev list should only be reachable by mainline commits. =
If not (which probably requires doing something convoluted like having =
subtree include mainline as its own subtree), this is a good place to =
check that and fall back to the existing behavior.=20


When processing each commit:

If no prior splits were found, we only have mainline commits.

 	- If $dir exists, it is a mainline commit needing copy - use =
existing process.
	- If $dir does not exist, it is a mainline commit that will map =
to nothing - no need to process further.

If we do have some known subtree commits:

	- If it is in the cache, it is a subtree commit we don=E2=80=99t =
need to process further.
	- If subtree root is not reachable (rev-list or merge-base), =
must be mainline pre subtree add. Map to nothing and skip further =
processing.
	- If any subtree root is reachable, could be either mainline =
commit with subtree merged in, or subtree commit newer than the last =
add/squash (subtree pull/merge without squash does not use a custom =
commit message)
		- If $dir does not exist, must be subtree - add to the =
cache as mapped to self, no need to process parents.
		- If the folder does exist, it is  either a mainline =
commit to be processed normally, or a subtree that happens to contain a =
folder with the same name.  Check if mainline root is reachable.



