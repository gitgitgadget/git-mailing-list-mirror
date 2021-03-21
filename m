Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88BDC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0B16157E
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 17:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCURlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:41:02 -0400
Received: from mail.aegee.org ([144.76.142.78]:56544 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230401AbhCURkr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 13:40:47 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2021 13:40:47 EDT
Authentication-Results: mail.aegee.org/12LHVF2H1882123; auth=pass (LOGIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1616347890; i=dkim+MSA-tls@aegee.org;
        bh=dWC+MKr0m0puC8zC+QCOTzEtmM/kCpYo3L/ucO1vXoM=;
        h=Subject:From:To:Date;
        b=MONg/Irln8o3/zvJRoEohEBZtsLdek6Kde3NG/M97ktUVcJbvNTiAPDLmknDf4d6N
         +DiMVCjjdMnMH534GuIgqYCJYlJQkQHBnEJ5HjkyyblDFRYGNIlPfBLMnxP1HEm/L0
         YjOyRPJ6Si/sCZ3YF0niozJFtOchTU31yKOLVzgl20ijtS2wPpd+PEzX2rg6WmLcRy
         +Du+kaznXebqH8Di00g/+xRtasgGNi12J2GnpEOSkQuAbGxNwFTujAfcMw9cROzQcv
         HRgM3HJk0/jhBxOASzFtSu/Wf5Yj3h7uJ29+DM1JC8gnjQ3jVb2qeGbEjAAgS7DRaC
         1z0ziO9CTYNmetAvHcsbNvzOyqA//cTDXUn25BtiYLIIjgHGBxXsH8afguwchtzAAK
         wZXEOlg+Pz6DDmHiJeL2EtESAMO7GtA7KxO2r3n+kSiiCNT4h24TsHSltUN4XG+auO
         8yXdHEDba/Q8fvRQACNnRmLcuuljwvBybqAWmUPrnRlGktKAvrvAh5xBhDT6+tFJhn
         ieF4D8DyAsE27ft5EexjoO3vXmng6QYuDcAiqE9HFVC6wqE0UFb8/orhdLu1R83m1X
         7fJe4jFfMWZmhtrqYFnL6SnKHkDcKo27KalKJhN+ibkftuwTV2mSaR2tkYYV2TurLx
         bg2UPSo9w1Un5n7+dE1Pa0/o=
Authentication-Results: mail.aegee.org/12LHVF2H1882123; dkim=none
Received: from [192.168.0.125] (87.118.146.153.topnet.bg [87.118.146.153] (may be forged))
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id 12LHVF2H1882123
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 17:31:27 GMT
Message-ID: <6afc8f1365627f08247f73da7e7e362c0b8ea560.camel@aegee.org>
Subject: git diff --text does not work during rebase for binary files
From:   =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
         =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?= 
        <dilyan.palauzov@aegee.org>
To:     git@vger.kernel.org
Date:   Sun, 21 Mar 2021 19:30:57 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I create a small text file ending with \0 and add it to git:

In .gitattributes I specify:

*.txt diff merge=text text

I create several commits by changing the small text file.

The result is at https://github.com/dilyanpalauzov/git-diff-biinary .

I do now

  git rebase -i HEAD~2
and before the “second commit” type E to edit that commit.

I change the small file.

git add a.txt && git rebase --continue

git says:

[detached HEAD bc00e34] second commit
 Date: Sun Mar 21 19:16:15 2021 +0200
 1 file changed, 2 insertions(+), 1 deletion(-)
warning: Cannot merge binary files: a.txt (HEAD vs. 04c77de (third
commit))
Auto-merging a.txt
CONFLICT (content): Merge conflict in a.txt
error: could not apply 04c77de... third commit
Resolve all conflicts manually, mark them as resolved with
"git add/rm <conflicted_files>", then run "git rebase --continue".
You can instead skip this commit: run "git rebase --skip".
To abort and get back to the state before "git rebase", run "git rebase
--abort".
Could not apply 04c77de... third commit


'git diff' and 'git diff --text' show:

diff --cc a.txt
index 7a61015,dc817ec..0000000
--- a/a.txt
+++ b/a.txt

The file does not contain <<HEAD===>>> markers, despite having
merge=text attribute.

HOW CAN I force git diff to show the differences and git merge to
include the <<<===>>> markers?

I have to say, that at different occassions git diff --text does work
ass expected (e.g. when I call git diff --cached --text).

I call now 
git rebase --abort
git log -p

git shows the differences in the small text file ending with \0.  So
apparently log reads the option, but diff does not.

Using git 2.30.2.

Greetings
  Дилян

